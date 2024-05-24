# Test suite

# We create a fake input and check the outputs are what we expect

Opioid_Medication_Task <- data.frame()

# NB Make sure all dates are between 2010-01-01 and 2021-09-30

# Test 1 - Patient 1 has one off dose 15mg of codeine solution and a 24 hour patch
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('1','codeine (15mg/5ml) linctus sugar free','Oral','TaskStatusCode',NA,'Three Times a Day','2021-01-01 15:00:00','',15,15,15,'mg',NA))
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('1','fentanyl patch','Topical','TaskStatusCode',NA,'Daily (6pm)','2021-01-11 18:00:00','Fentanyl;TaskNameis10microgramhr',10,10,10,'microgram/hr',NA))

# Test 2 - Patient 2 has one two doses of oral codeine on the same day
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('2','codeine tablets','Oral','TaskStatusCode',NA,'As Often as Necessary','2021-01-01 12:00:00','',15,15,15,'mg',NA))
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('2','codeine tablets','Oral','TaskStatusCode',NA,'As Often as Necessary','2021-01-01 15:00:00','',15,15,15,'mg',NA))

# Test 3 - Patient 3 has one two doses of oral morphine, and morphine injection crossing midnight
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('3','morphine m/r tablets [mst]','Oral','TaskStatusCode',NA,'As Often as Necessary','2021-01-01 12:00:00','',10,10,10,'mg',NA))
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('3','morphine m/r tablets [mst]','Oral','TaskStatusCode',NA,'As Often as Necessary','2021-01-01 15:00:00','',10,10,10,'mg',NA))
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('3','morphine (30mg/30ml) infusion','IV Infusion','TaskStatusCode',NA,'Every 6 Hours','2021-01-01 20:00:00','',5,5,5,'ml/hour',NA))

# Test 4 - Patient with a 24 hour injection
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('4','oxycodone injection','SC Continuous Infusion','Performed',NA,'Morning','2021-01-01 19:00:00','',15,15,NA,'mg/24hours',NA))

# Test 5 - Patient with 2 PCAs, one of which spans midnight
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('5','fentanyl (20micrograms/ml) pca','IV Infusion','Performed',NA,'Every 6 Hours','2021-01-01 15:00:00','Fentanyl20microgramsmlPCABolus20microgram;LOCKOUT5minutesIVInfusionCONTROLLEDDRUG-LOADINGDOSEUpto200microgramshourly-titratedbyapprovedstaffasperSRFTprotocol',NA,20,NA,'microgram',NA))
Opioid_Medication_Task <- rbind(Opioid_Medication_Task,c('5','fentanyl (20micrograms/ml) pca','IV Infusion','Performed',NA,'Every 6 Hours','2021-01-01 21:00:00','Fentanyl20microgramsmlPCABolus20microgram;LOCKOUT5minutesIVInfusionCONTROLLEDDRUG-LOADINGDOSEUpto200microgramshourly-titratedbyapprovedstaffasperSRFTprotocol',NA,20,NA,'microgram',NA))

colnames(Opioid_Medication_Task) <- c("PseudonymisedID","MedicationName","TaskRouteCode", "TaskStatusCode", "OrderRouteCode","FrequencyCode","PerformedFromDtm","TaskName","TaskDose","DosageLow","DosageHigh","TaskUom","Uom")

Opioid_Medication_Task$PerformedFromDtm <- as.POSIXct(Opioid_Medication_Task$PerformedFromDtm)
Opioid_Medication_Task$TaskDose <- as.numeric(Opioid_Medication_Task$TaskDose)
Opioid_Medication_Task$DosageLow <- as.numeric(Opioid_Medication_Task$DosageLow)
Opioid_Medication_Task$DosageHigh <- as.numeric(Opioid_Medication_Task$DosageHigh)

### SPLIT HERE ###

%run ./library/_wrapper

### SPLIT HERE ###

# Checks

# Test 1
isPassing <- TRUE
message('# Test 1\n')
Patient001 <- Data %>% filter(PseudonymisedID=='1')
if(nrow(Patient001) != 3) {
  message(paste0('  Expecting 3 rows for patient 1, but instead got ', nrow(Patient001)))
  isPassing = FALSE
}
if(nrow(Patient001 %>% filter(OpioidName == 'codeine' & Date == '2021-01-01' & DoseInMg == 15 & MME == 2.25)) != 1) {
  message('  Expected row not found in test 1.1')
  isPassing = FALSE
}
if(nrow(Patient001 %>% filter(OpioidName == 'fentanyl' & Date == '2021-01-11' & DoseInMg == 0.06 & MME == 6)) != 1) {
  message('  Expected row not found in test 1.2')
  isPassing = FALSE
}
if(nrow(Patient001 %>% filter(OpioidName == 'fentanyl' & Date == '2021-01-12' & DoseInMg == 0.18 & MME == 18)) != 1) {
  message('  Expected row not found in test 1.3')
  isPassing = FALSE
}
if(isPassing) {
  message('  ✓ Test 1 passed')
}

# Test 2
isPassing <- TRUE
message('\n# Test 2\n')
Patient002 <- Data %>% filter(PseudonymisedID=='2')
if(nrow(Patient002) != 1) {
  message(paste0('  Expecting 1 row for patient 2, but instead got ', nrow(Patient002)))
  isPassing = FALSE
}
if(nrow(Patient002 %>% filter(OpioidName == 'codeine' & Date == '2021-01-01' & DoseInMg == 30 & MME == 4.5)) != 1) {
  message('  Expected row not found in test 2.1')
  isPassing = FALSE
}
if(isPassing) {
  message('  ✓ Test 2 passed')
}

# Test 3
isPassing <- TRUE
message('\n# Test 3\n')
Patient003 <- Data %>% filter(PseudonymisedID=='3')
if(nrow(Patient003) != 2) {
  message(paste0('  Expecting 2 rows for patient 3, but instead got ', nrow(Patient003)))
  isPassing = FALSE
}
if(nrow(Patient003 %>% filter(OpioidName == 'morphine' & Date == '2021-01-01' & DoseInMg == 40 & MME == 80)) != 1) {
  message('  Expected row not found in test 3.1')
  isPassing = FALSE
}
if(nrow(Patient003 %>% filter(OpioidName == 'morphine' & Date == '2021-01-02' & DoseInMg == 10 & MME == 30)) != 1) {
  message('  Expected row not found in test 3.2')
  isPassing = FALSE
}
if(isPassing) {
  message('  ✓ Test 3 passed')
}

# Test 4
isPassing <- TRUE
message('\n# Test 4\n')
Patient004 <- Data %>% filter(PseudonymisedID=='4')
if(nrow(Patient004) != 2) {
  message(paste0('  Expecting 2 rows for patient 4, but instead got ', nrow(Patient004)))
  isPassing = FALSE
}
if(nrow(Patient004 %>% filter(OpioidName == 'oxycodone' & Date == '2021-01-01' & DoseInMg == 5*15/24 & MME == 3*DoseInMg)) != 1) {
  message('  Expected row not found in test 4.1')
  isPassing = FALSE
}
if(nrow(Patient004 %>% filter(OpioidName == 'oxycodone' & Date == '2021-01-02' & DoseInMg == 19*15/24 & MME == 3*DoseInMg)) != 1) {
  message('  Expected row not found in test 4.2')
  isPassing = FALSE
}
if(isPassing) {
  message('  ✓ Test 4 passed')
}

# Test 5
isPassing <- TRUE
message('\n# Test 5\n')
Patient005 <- Data %>% filter(PseudonymisedID=='5')
if(nrow(Patient005) != 2) {
  message(paste0('  Expecting 2 rows for patient 5, but instead got ', nrow(Patient005)))
  isPassing = FALSE
}
if(nrow(Patient005 %>% filter(OpioidName == 'fentanyl' & Date == '2021-01-01' & abs(DoseInMg - 1.8) < 0.0001 & abs(MME - 130*DoseInMg) < 0.0001)) != 1) {
  message('  Expected row not found in test 5.1')
  isPassing = FALSE
}
if(nrow(Patient005 %>% filter(OpioidName == 'fentanyl' & Date == '2021-01-02' & abs(DoseInMg - 0.6) < 0.0001 & abs(MME - 130*DoseInMg) < 0.0001)) != 1) {
  message('  Expected row not found in test 5.2')
  isPassing = FALSE
}
if(isPassing) {
  message('  ✓ Test 5 passed')
}
