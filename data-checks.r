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

