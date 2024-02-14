# This processes all single doses. That includes
# any oral medication as well as one off injections

# We identify these records by looking for the following
# units: 'mg', 'microgram', 'Tablet/s'

SingleDoseRows <- FilteredData %>%
  filter((UNITS == 'mg' | UNITS == 'microgram' | UNITS == 'Tablet/s' ) & !IsPCA)

# Check how many of these have NA for TaskDose
TaskDoseIsNA <- SingleDoseRows %>%
  filter(is.na(TaskDose))

NumberOfSingleDoseRows = nrow(SingleDoseRows)
NumberWhereTaskDoseIsNA = nrow(TaskDoseIsNA)

message(paste('There are',NumberOfSingleDoseRows,'records that look like a single dose.'))
message(paste(' - of these,', NumberWhereTaskDoseIsNA, 'do not have a TaskDose field.'))
message('As long as this is a very small percentage we can ignore as we are using the DosageLow and DosageHigh fields as the alternative.\n')

RowsWithTaskDoseLikelyDosageLow <- SingleDoseRows %>%
  filter(TaskDose==1 & TaskDose < DosageLow & UNITS != 'Tablet/s' & RouteCategory=='oral')
RowsWithTaskDoseLikelyDosageHigh <- SingleDoseRows %>% 
  filter(TaskDose==2 & TaskDose < DosageLow & DosageHigh == 2*DosageLow & UNITS != 'Tablet/s' & RouteCategory=='oral')

SingleDoseRows$DOSAGE = if_else(
  SingleDoseRows$TaskDose==1 & SingleDoseRows$TaskDose < SingleDoseRows$DosageLow & SingleDoseRows$UNITS != 'Tablet/s' & SingleDoseRows$RouteCategory=='oral',
  SingleDoseRows$DosageLow,
  if_else(
    SingleDoseRows$TaskDose==2 & SingleDoseRows$TaskDose < SingleDoseRows$DosageLow & SingleDoseRows$DosageHigh == 2*SingleDoseRows$DosageLow & SingleDoseRows$UNITS != 'Tablet/s' & SingleDoseRows$RouteCategory=='oral',
    SingleDoseRows$DosageHigh,
    SingleDoseRows$DOSAGE,
  )
)
message(paste0('There are ', nrow(RowsWithTaskDoseLikelyDosageLow), ' rows where the TaskDose is 1, the Units is "mg", and the TaskDose is below DosageLow. These are most likely actually "1 dose" rather than "1 mg" so adjusting the DOSAGE accordingly to equal the DosageLow field.'))
message(paste0('There are ', nrow(RowsWithTaskDoseLikelyDosageHigh), ' rows where the TaskDose is 2, the Units is "mg", and the TaskDose is below DosageLow, and the DosageHigh is double the DosageLow. These are most likely actually "2 doses" rather than "2 mg" so adjusting the DOSAGE accordingly to equal the DosageHigh field.\n'))

# Now let's fix the 42 co-codamol rows (either 8/500 or 30/500 i.e. 8 or 30mg of codeine and 500mg of paracetamol)
# where the TaskUom is "Tablet/s" but there are more than 10. Usually it's 30 or 60, so seems a lot more likely
# that this is in fact the "mg" the patient received, rather than they were given 30 or 60 tablets!
SingleDoseRows$CocodamolTabletToMG = SingleDoseRows$TaskDose > 4 & SingleDoseRows$TaskUom == 'Tablet/s' & grepl("co-codamol", SingleDoseRows$MedicationName)
SingleDoseRows$DOSAGE = if_else(
  SingleDoseRows$CocodamolTabletToMG & SingleDoseRows$TaskDose < 500,
  SingleDoseRows$TaskDose / SingleDoseRows$StrengthInMilligrams, # TaskDose between 5 and 499, to convert mg to Tablets divide by Strength
  if_else(
    SingleDoseRows$CocodamolTabletToMG, 
    1, # >=500 so it's either garbage or the paracetamol bit. Either way let's assume a single tablet
    SingleDoseRows$DOSAGE # For most rows we just set the DOSAGE to the existing value
  )
)

message(paste0('There were ', sum(SingleDoseRows$CocodamolTabletToMG), ' rows with co-codamol, TaskUom of "Tablet/s", but TaskDose > 10.'))
message('These have now been adjusted to assume the TaskDose was actually the mg of codeine, rather than the number of tablets.')
message('The exception being the rows where the TaskDose was 500 or 30500. In these cases we assume 30mg of codeine.\n')

# Now let's fix any records with a TaskDose >= 1000 which is implausible. We aim to
# see if the patient had any identical administrations on the same day, but with a
# more plausible TaskDose. In which case we use that instead.

# First we get the ID, TaskName and Date for any records with a TaskDose >= 1000
LargeDosage <- SingleDoseRows %>% filter(TaskDose >= 1000) %>% select(PseudonymisedID, TaskName, Date)
# Then we populate a narrow table with all the TaskDoses < 1000
JustDosage <- SingleDoseRows %>% filter(TaskDose < 1000) %>% mutate(DayBefore = Date - 1, DayAfter = Date + 1) %>% select(PseudonymisedID, TaskName, DayBefore, DayAfter, TaskDose)

# Joining the above data frames to find any one with the same administration, but with
# one above 1000 and the rest below 1000. Take the MAX of the plausible TaskDoses
DosageFix <- LargeDosage %>% 
  left_join(JustDosage, by = join_by(PseudonymisedID, TaskName, between(Date, DayBefore, DayAfter)), multiple="all") %>% 
  group_by(PseudonymisedID, TaskName, Date) %>%
  summarise(MaxTaskDose=max(TaskDose), .groups="drop") %>%
  filter(!is.na(MaxTaskDose))

# Mutate the existing data. IF the row has a corresponding MaxTaskDose AND the existing
# TaskDose is >= 1000 then we replace the DOSAGE with the MaxTaskDose. Otherwise just
# preserve the existing DOSAGE
SingleDoseRows <- SingleDoseRows %>%
  left_join(DosageFix, by = join_by(PseudonymisedID, TaskName, Date)) %>%
  mutate(DOSAGE = if_else(is.na(MaxTaskDose) | TaskDose < 1000, DOSAGE, MaxTaskDose))

message(paste0('There were ', nrow(LargeDosage), ' rows with a TaskDose >= 1000.'))
message(paste0(' - of these, ', nrow(DosageFix), ' had an identical administration (TaskName) within 1 day either side, with a more plausible TaskDose'))
message('These have now been adjusted to assume the TaskDose was actually the TaskDose of the more plausible value.\n')

# Now we calculate the TotalDosage for each record
# IF UNITS == 'tablet' then multiply by StrengthInMilligrams
# ELSE IF UNITS == 'micrograms' then divide by 1000
# ELSE just use the dosage
SingleDoseRows$TotalDosage <- if_else(
  SingleDoseRows$UNITS == 'Tablet/s', 
  SingleDoseRows$DOSAGE * SingleDoseRows$StrengthInMilligrams, 
  if_else(
    SingleDoseRows$UNITS == 'microgram', 
    SingleDoseRows$DOSAGE / 1000,
    SingleDoseRows$DOSAGE
  ))

# Now calculate the DailyDose and DailyMME for each opioid. The TotalDosage (mg)
# field has already been calculated based on the Units and the Strength
SingleDoseMME <- SingleDoseRows %>%
  group_by(PseudonymisedID, Date, OpioidName) %>% 
  summarise(DailyDose = sum(TotalDosage), DailyMME = sum(MMEFactor * TotalDosage), .groups='drop')

message('The following data frames are now available:')
message(' - SingleDoseRows - the data filtered to those records that look like a single dose')
message(' - SingleDoseMME - the daily dose and daily MME grouped by opioid, person and date')