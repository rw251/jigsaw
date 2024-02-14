# Test suite

# We create a fake input and check the outputs are what we expect

Opioid_Medication_Task <- data.frame()

# NB Make sure all dates are between 2010-01-01 and 2021-09-30

# Test 1 - Patient 1 has one off dose 15mg of codeine solution and a 24 hour patch
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('1','codeine (15mg/5ml) linctus sugar free','Oral','TaskStatusCode',NA,'Three Times a Day','2021-01-01 15:00:00','',15,15,15,'mg',NA))
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('1','fentanyl patch','Topical','TaskStatusCode',NA,'Daily (6pm)','2021-01-11 18:00:00','Fentanyl;TaskNameis10microgramhr',10,10,10,'microgram/hr',NA))

colnames(Opioid_Medication_Task) <- c("PseudonymisedID","MedicationName","TaskRouteCode", "TaskStatusCode", "OrderRouteCode","FrequencyCode","PerformedFromDtm","TaskName","TaskDose","DosageLow","DosageHigh","TaskUom","Uom")

Opioid_Medication_Task$PerformedFromDtm <- as.POSIXct(Opioid_Medication_Task$PerformedFromDtm)
Opioid_Medication_Task$TaskDose <- as.numeric(Opioid_Medication_Task$TaskDose)
Opioid_Medication_Task$DosageLow <- as.numeric(Opioid_Medication_Task$DosageLow)
Opioid_Medication_Task$DosageHigh <- as.numeric(Opioid_Medication_Task$DosageHigh)

### SPLIT HERE ###

%run ./library/wrapper

### SPLIT HERE ###

# Checks
isPassing <- TRUE

# Test 1
message('# Test 1\n')
Patient001 <- Data %>% filter(PseudonymisedID=='1')
if(nrow(Patient001) != 3) {
  message(paste0('  Expecting 3 rows for patient 1, but instead got ', nrow(Patient001)))
  isPassing = FALSE
}
if(nrow(Patient001 %>% filter(OpioidName == 'codeine' & Date == '2021-01-01' & DailyDose == 15 & DailyMME == 2.25)) != 1) {
  message('  Expected row not found in test 1.1')
  isPassing = FALSE
}
if(nrow(Patient001 %>% filter(OpioidName == 'fentanyl' & Date == '2021-01-11' & DailyDose == 0.06 & DailyMME == 6)) != 1) {
  message('  Expected row not found in test 1.2')
  isPassing = FALSE
}
if(nrow(Patient001 %>% filter(OpioidName == 'fentanyl' & Date == '2021-01-12' & DailyDose == 0.18 & DailyMME == 18)) != 1) {
  message('  Expected row not found in test 1.3')
  isPassing = FALSE
}
if(isPassing) {
  message('  ✓ Test 1 passed')
}
