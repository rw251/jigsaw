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