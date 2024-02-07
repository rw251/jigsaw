# This processes all single doses. That includes
# any oral medication as well as one off injections

# We identify these records by looking for the following
# units: 'mg', 'microgram', 'Tablet/s'

SingleDoseRows <- FilteredData %>%
  filter(UNITS == 'mg' | UNITS == 'microgram' | UNITS == 'Tablet/s' )

# Check how many of these have NA for TaskDose
TaskDoseIsNA <- SingleDoseRows %>%
  filter(is.na(TaskDose))

NumberOfSingleDoseRows = nrow(SingleDoseRows)
NumberWhereTaskDoseIsNA = nrow(TaskDoseIsNA)

message(paste('There are',NumberOfSingleDoseRows,'records that look like a single dose.'))
message(paste(' - of these,', NumberWhereTaskDoseIsNA, 'do not have a TaskDose field.'))
message('As long as this is a very small percentage we can ignore as we are using the DosageLow and DosageHigh fields as the alternative.')

# Now calculate the DailyDose and DailyMME for each opioid. The TabletDosage (mg)
# field has already been calculated based on the Units and the Strength
SingleDoseMME <- SingleDoseRows %>%
  group_by(PseudonymisedID, Date, OpioidName) %>% 
  summarise(DailyDose = sum(TabletDosage), DailyMME = sum(MMEFactor * TabletDosage), .groups='drop')

message('The following data frames are now available:')
message(' - SingleDoseRows - the data filtered to those records that look like a single dose')
message(' - SingleDoseMME - the daily dose and daily MME grouped by opioid, person and date')