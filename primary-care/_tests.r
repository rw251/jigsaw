# Test suite

# We create a fake input and check the outputs are what we expect

JournalData <- data.frame()

# NB Make sure all dates are between 2010-01-01 and 2021-09-30

# Patient 0 not needed for tests but to ensure code runs
JournalData <- rbind(JournalData,c('1','dji2.','Tramadol 50mg capsules','20150315','60','ONE TABLET TWICE A DAY','P87022'))

# Test 1 - Patient 1 has
JournalData <- rbind(JournalData,c('1','dji2.','Tramadol 50mg capsules','20150315','60','TAKE AS DIRECTED  WHEN REQUIRED.','P87022'))
JournalData <- rbind(JournalData,c('1','dji2.','Tramadol 50mg capsules','20150319','60','TAKE AS DIRECTED  WHEN REQUIRED.','P87022'))

  
colnames(JournalData) <- c("PseudonymisedID","ReadCode","Rubric", "EntryDate", "CodeValue","Codeunits","Source")

### SPLIT HERE ###

%run ./library/_wrapper

### SPLIT HERE ###

# Checks

# Test 1
isPassing <- TRUE
message('# Test 1\n')
Patient001 <- Data %>% filter(PseudonymisedID=='1')

if(nrow(Patient001) != 8) {
  message(paste0('  Expecting 8 rows for patient 1, but instead got ', nrow(Patient001)))
  isPassing = FALSE
}
if(nrow(Patient001 %>% filter(OpioidName == 'tramadol' & Date == '2015-03-16' & DoseInMg == 750 & MME == 75)) != 1) {
  message('  Expected row not found in test 1.1')
  isPassing = FALSE
}
if(nrow(Patient001 %>% filter(OpioidName == 'tramadol' & Date == '2015-03-16' & DoseInMg == 750 & MME == 75)) != 1) {
  message('  Expected row not found in test 1.2')
  isPassing = FALSE
}
if(nrow(Patient001 %>% filter(OpioidName == 'tramadol' & Date == '2015-03-23' & DoseInMg == 750 & MME == 75)) != 1) {
  message('  Expected row not found in test 1.3')
  isPassing = FALSE
}
if(isPassing) {
  message('  ✓ Test 1 passed')
}