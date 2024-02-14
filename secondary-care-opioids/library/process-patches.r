# This processes all patches.

# We identify these records by looking for a RouteCategory of 'topical'

# Create data frame with just the topical opioids
PatchRows <- FilteredData %>% filter(RouteCategory == 'topical')

# Update the patch interval by defaulting to 3 days for fentanyl and 1 week for buprenorphine
# if there is no other information provided. Also change it to 24 hours for any where it is 
# a "check" code. Most "check" codes appear within the time frame of a previous administration.
# But sometimes they appear at the end e.g. a 7 day patch with checks on the 8th and 9th day.
# By setting the "check" interval to 24 hours, this means that we capture the checks outside
# of the patch administration.
PatchRows$PatchInterval <- if_else(PatchRows$MinFrequencyGap <= 1, if_else(PatchRows$OpioidName == 'fentanyl',72,168), PatchRows$MinFrequencyGap)
PatchRows$PatchInterval <- if_else(grepl('Check',PatchRows$TaskName),24,PatchRows$PatchInterval)

# For any row that is now a check, we populate the DosageFromTaskName field by using a regex
# on the TaskName field. Regular expression explainer:  
#   ^[^0-9.]*           - matches any characters that aren't a number or a '.' from the start of the field
#   ([0-9]+\\.?[0-9]?)  - matches a number, or a number with a decimal e.g. '50' or '37.5'
#   microgramhr         - matches the unit
#   .*$                 - matches the rest of the field
message('Checking for records where the TaskDose is different to the value in the TaskName field...')
PatchRows$DosageFromTaskName <- if_else(
  grepl('Check',PatchRows$TaskName),
  0,
  suppressWarnings(as.numeric(gsub("^[^0-9]*([0-9]+\\.?[0-9]?)microgramhr.*$","\\1",PatchRows$TaskName)))
)

# Check that the regex actually matches everything
NumberOfRowsWithoutMatchingRegex <- nrow(PatchRows %>% filter(!grepl('Check',TaskName) & is.na(DosageFromTaskName)))
if(NumberOfRowsWithoutMatchingRegex > 0) {
  message(paste0('There are ', NumberOfRowsWithoutMatchingRegex, " rows that don't match the DosageFromTaskName regex. You need to fix that."))
} else {
  message('All non-check records match the regex. No further work required.')
}

RowsWithTaskDoseNotEqualToTaskName <- PatchRows %>% filter(DosageFromTaskName > 0 & DosageFromTaskName != TaskDose)
RowsWithTaskDoseFarFromTaskName <- PatchRows %>% filter(DosageFromTaskName > 0 & abs(DosageFromTaskName - TaskDose)/TaskDose > 0.1)

if(nrow(RowsWithTaskDoseNotEqualToTaskName) > 0) {
  message(paste0('There are ', nrow(RowsWithTaskDoseNotEqualToTaskName), " rows where the TaskDose is different to the TaskName value."))
  message(paste0(' - of which ', nrow(RowsWithTaskDoseFarFromTaskName), " have a TaskDose more than 10% away from the TaskName value:"))

  message((RowsWithTaskDoseFarFromTaskName %>% mutate(msg = paste0('    > ',str_split(TaskName, ";", simplify=TRUE)[, 1], ' = ', DosageFromTaskName, ' but TaskDose = ',TaskDose,'\n')) %>% arrange(msg))$msg)

  PatchRows$DOSAGE = if_else(
    PatchRows$DosageFromTaskName > 0 & abs(PatchRows$DosageFromTaskName - PatchRows$TaskDose)/PatchRows$TaskDose > 0.1,
    PatchRows$DosageFromTaskName,
    PatchRows$DOSAGE
  )
  message(paste0('These ', nrow(RowsWithTaskDoseFarFromTaskName), ' rows have had their DOSAGE adjusted. Please check the above all look ok.\n'))
} else {
  message('All records have a TaskDose which matches the free text in the TaskName. No further action required.')
}

# Patches are usually given for 3 or 7 days, so we first create duplicate rows
# for each patch administration. A patch for n days will actually deliver some
# for opioid on n+1 calendar days (24 hours a day, except on the first and last
# day). So we duplicate each row n+1 times where n is the number of days for 
# the patch.
PatchMME <- as.data.frame(lapply(PatchRows, rep, 1+PatchRows$PatchInterval/24)) %>% 
  # There are now multiple rows for each PseudonymisedID, MedicationName and PerformedFromDtm
  # By grouping on them we can set a new field StartDate so that each day of the patch is recorded.
  # We also calculate the TimeToMidnight and the TimeFromMidnight e.g. a patch given at 6pm would
  # have 6 hours to midnight and 18 hours. Unless it's the first day in which case the time from 
  # midnight is 0. Similarly on the last day the time to midnight is 0.
  group_by(PseudonymisedID, MedicationName, PerformedFromDtm) %>% 
  mutate(daycount = row_number(), TimeToMidnight = if_else(daycount==n(),0,24 - as.numeric(format(PerformedFromDtm,"%H"))), TimeFromMidnight= if_else(daycount==1, 0,  as.numeric(format(PerformedFromDtm,"%H"))) , StartDate = as.Date(PerformedFromDtm + (daycount - 1)*60*60*24), DOSAGE = max(DOSAGE)) %>% 
  ungroup() %>%
  select(PseudonymisedID, MedicationName,OpioidName, TimeToMidnight, TimeFromMidnight,StartDate,DOSAGE) %>%
  # Now we can regroup on PseudonymisedID, OpioidName and StartDate. By summing the TimeToMidnight
  # and the TimeFromMidnight we can get the total number of hours that the patch was worn that day
  group_by(PseudonymisedID, OpioidName,StartDate) %>%
  summarise(PatchWornForHours = pmin(24, max(TimeToMidnight) + max(TimeFromMidnight)),DOSAGE=max(DOSAGE), .groups='drop') %>%
  # Finally we calculate the DailyDose and the DailyMME
  mutate(DailyDose = PatchWornForHours * DOSAGE / 1000, DailyMME = if_else(OpioidName == 'buprenorphine', 75*DailyDose, 100*DailyDose), Date = StartDate) %>%
  select(PseudonymisedID, Date, OpioidName, DailyDose, DailyMME) %>%
  arrange(PseudonymisedID, Date)

message('The following data frames are now available:')
message(' - PatchRows - the data filtered to those records that look like a patch')
message(' - PatchMME - the daily dose and daily MME grouped by opioid, person and date')