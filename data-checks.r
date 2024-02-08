# Check 1
message('# Check Levobupivacaine is always epidural and so can be ignored\n')

Levobupivacaine <- Opioid_Medication_Task %>% filter(grepl('Levobupivacaine',MedicationName ))
message(paste0('  There are ', nrow(Levobupivacaine), ' rows containing Levobupivacaine'))
LevobupivacaineNoRoute <- Levobupivacaine %>% filter(is.na(TaskRouteCode) & is.na(OrderRouteCode))
message(paste0("   - of which ",nrow(LevobupivacaineNoRoute)," don't have a TaskRouteCode or an OrderRouteCode"))
LevobupivacaineEpidural <- Levobupivacaine %>% filter(OrderRouteCode == "EPIDURAL Infusion." |TaskRouteCode == "EPIDURAL Infusion.")
message(paste0("   - of which ",nrow(LevobupivacaineEpidural)," have a TaskRouteCode or an OrderRouteCode of 'EPIDURAL Infusion.'"))
if(nrow(Levobupivacaine) == nrow(LevobupivacaineEpidural)) {
  message('  All Levobupivacaine administrations have a route of epidural and so can be safely ignored.')
  message('\nCHECK PASSED\n')
} else {
  message('  Some Levobupivacaine administrations do not have a route of epidural and so should be included elsewhere.')
  message('\n!!!!CHECK FAILED!!!!\n')
}

# Check 2
message('# Check the total number of rows in the sub data frames is equal to those in the original data.\n')
message (paste("  There are", nrow(FilteredData), "rows"))
message (paste("   -", nrow(SingleDoseRows ), "rows that are a single dose"))
message (paste("   -", nrow(Injection24HoursRows ), "rows for injections with mg or mcg / 24 hours"))
message (paste("   -", nrow(InjectionRows ), "rows for injections with ml/hour"))
message (paste("   -", nrow(PatchRows ), "rows for patches"))

if(nrow(FilteredData) == nrow(SingleDoseRows ) + nrow(Injection24HoursRows) + nrow(InjectionRows) + nrow(PatchRows)) {
  message('  The rows of the sub-data-frames = the original data frame.')
  message('\nCHECK PASSED\n')
} else {
  message('  The number of sub rows does not equal the original data frame.')
  message('\n!!!!CHECK FAILED!!!!\n')
}

# Check 3

# If the RouteCategory is "oral" then we adjust the mg based on the UNITS.
# We currently cope with the following:
knownUnits <- c("Tablet/s","microgram","mg")

message(paste0('# Check that if RouteCategory is "oral", then the only units are: "', paste(knownUnits, collapse='", "'),'"\n'))

# If the data ever had units that weren't these for the oral route we'd need to change our code
oralUnits <- FilteredData %>%  filter(RouteCategory == 'oral') %>% group_by(UNITS) %>% summarise(n = n())

unmatchedOralUnits <- (oralUnits %>% filter(!UNITS %in% knownUnits))
if(nrow(unmatchedOralUnits) > 0) {
  message(paste0('  Unmatched oral units: "', paste(unmatchedOralUnits$UNITS, collapse='", "'),'"'))
  message('\n!!!!CHECK FAILED!!!!\n')
} else {
	message('  There are no unmatched oral units')
  message('\nCHECK PASSED\n')
}

# Check 4

# If the RouteCategory is "topical" then we check that there is only fentanyl or buprenorphine  

knownOpioids <- c("fentanyl","buprenorphine")

message(paste0('# Check that if RouteCategory is "topical", then the only opioids are: "', paste(knownOpioids, collapse='", "'),'"\n'))

topicalOpioids <- FilteredData %>%  filter(RouteCategory == 'topical') %>% group_by(OpioidName) %>% summarise(n = n())

unmatchedTopicalOpioids <- (topicalOpioids %>% filter(!OpioidName %in% knownOpioids))
if(nrow(unmatchedTopicalOpioids) > 0) {
	message(paste0('  Unmatched opioid name: "', paste(unmatchedTopicalOpioids$OpioidName, collapse='", "'),'"'))
  message('\n!!!!CHECK FAILED!!!!\n')
} else {
	message('  There are no unmatched opioid names for topical administrations.')
  message('\nCHECK PASSED\n')
}

# Check 5

# If the RouteCategory is "topical" then we check the units for MinFrequencyGap <= 1 are in the list provided 

knownFrequencies <- c("<User Schedule>","As Often as Necessary","ONCE ONLY (ONE DOSE)")

message(paste0('# Check that if RouteCategory is "topical", and dosage gap is <= 1, then the only frequencies are: "', paste(knownFrequencies, collapse='", "'),'"\n'))

topicalFrequencies <- FilteredData %>%  filter(RouteCategory == 'topical' & MinFrequencyGap <=1) %>% group_by(FrequencyCode) %>% summarise(n = n())

unmatchedTopicalFrequencies <- (topicalFrequencies %>% filter(!FrequencyCode %in% knownFrequencies))
if(nrow(unmatchedTopicalFrequencies) > 0) {
	message(paste0('  Unmatched topical frequency: "', paste(unmatchedTopicalFrequencies$FrequencyCode, collapse='", "'),'"'))
  message('\n!!!!CHECK FAILED!!!!\n')
} else {
	message('  There are no unmatched frequencies for topical administrations.')
  message('\nCHECK PASSED\n')
}

# Check 6

message('# Check all "Tablet/s" have a StrengthInMilligrams\n')

TabletsWithoutStrengthInMilligrams <- FilteredData %>% filter(UNITS == 'Tablet/s' & (is.na(StrengthInMilligrams) | StrengthInMilligrams <= 0))

if(nrow(TabletsWithoutStrengthInMilligrams) > 0) {
	message(paste0('  There are ',nrow(TabletsWithoutStrengthInMilligrams), ' rows with a unit of "Tablet/s" and no StrengthInMilligrams.'))
  message('\n!!!!CHECK FAILED!!!!\n')
} else {
	message('  All rows with a unit of "Tablet/s" have a positive StrengthInMilligrams.')
  message('\nCHECK PASSED\n')
}