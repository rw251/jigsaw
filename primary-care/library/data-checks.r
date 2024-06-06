error_count <- 0
# Check 1
message('# Check that for tablets the millilitres is always null\n')
TabletWithNullMls <- FilteredData %>% filter(Form == 'tablet' & !is.na(CodeValueMillilitres))
message(paste0('  There are ', nrow(TabletWithNullMls), ' tablet rows with a non null CodeValueMillilitres'))
if(nrow(TabletWithNullMls) == 0) {
  message('  ✓ All tablet rows have a null value for CodeValueMillilitres.')
  message('  ✓ CHECK PASSED\n')
} else {
  message('  Some tablet rows have a null value for CodeValueMillilitres.')
  message('\n!!!!CHECK FAILED!!!!\n')
  error_count <- error_count + 1
}

# Check 2
message('# Check that for tablets StrengthInMilligrams is nevre null.\n')
TabletWithNullMls <- FilteredData %>% filter(Form == 'tablet' & is.na(StrengthInMilligrams))
message(paste0('  There are ', nrow(TabletWithNullMls), ' tablet rows with a null StrengthInMilligrams'))
if(nrow(TabletWithNullMls) == 0) {
  message('  ✓ All tablet rows have a value for StrengthInMilligrams.')
  message('  ✓ CHECK PASSED\n')
} else {
  message('  Some tablet rows have a null value for StrengthInMilligrams.')
  message('\n!!!!CHECK FAILED!!!!\n')
  error_count <- error_count + 1
}

# Check 3
message('# Check that ReadCode dj1.. is always 10mg/5ml oral solution.\n')
dj1Records <- JournalData %>% filter(ReadCode == 'dj1..')
message(paste0('  There are ', nrow(dj1Records), ' rows with ReadCode=="dj1.."'))
dj1RecordsWithout10mgOralSol <- dj1Records %>% filter(
  Rubric != 'Morphine sulfate 10mg/5ml oral solution' &
  Rubric != 'Morphine sulphate 10mg/5ml oral solution' &
  Rubric != 'MORPHINE SULPHATE oral soln 10mg/5ml' &
  Rubric != 'Morphine Sulfate Oral Solution 10 mg/5 ml' &
  Rubric != 'Morphine hydrochloride 10mg/5ml oral solution'
)
if(nrow(dj1RecordsWithout10mgOralSol) == 0) {
  message('  ✓ All rows with a ReadCode dj1.. have a rubric suggesting 10mg/5ml oral solution')
  message('  ✓ CHECK PASSED\n')
} else {
  message('  Some rows with a ReadCode dj1.. do not have a rubric suggesting 10mg/5ml oral solution.')
  message('\n!!!!CHECK FAILED!!!!\n')
  error_count <- error_count + 1
}

# Check 4
message('# Check that ReadCode o42.. is always 2.5mg/50ml solution.\n')
o42Records <- JournalData %>% filter(ReadCode == 'o42..')
message(paste0('  There are ', nrow(o42Records), ' rows with ReadCode=="o42.."'))
o42RecordsWithout10mgOralSol <- o42Records %>% filter(Rubric != 'Fentanyl 2.5mg/50ml solution for infusion vials')
if(nrow(o42RecordsWithout10mgOralSol) == 0) {
  message('  ✓ All rows with a ReadCode o42.. have a rubric suggesting 2.5mg/50ml solution')
  message('  ✓ CHECK PASSED\n')
} else {
  message('  Some rows with a ReadCode o42.. do not have a rubric suggesting 2.5mg/50ml solution.')
  message('\n!!!!CHECK FAILED!!!!\n')
  error_count <- error_count + 1
}

# Check 5
message('# Check that ReadCode dj3.. is always 15mcg/hour Buprenorphine patch.\n')
dj3Records <- JournalData %>% filter(ReadCode == 'dj3..')
message(paste0('  There are ', nrow(dj3Records), ' rows with ReadCode=="dj3.."'))
dj3RecordsWithout15mcgBuprenorphinePatch <- dj3Records %>% filter(
  Rubric != "Buprenorphine 15micrograms/hour transdermal patches" &
  Rubric != "Butec 15micrograms/hour transdermal patches (Qdem Pharmac..." &
  Rubric != "Butec 15micrograms/hour transdermal patches (Qdem Pharmaceuticals Ltd)" &
  Rubric != "BuTrans 15micrograms/hour transdermal patches (Napp Pharm..." &
  Rubric != "BuTrans 15micrograms/hour transdermal patches (Napp Pharmace"
)
if(nrow(dj3RecordsWithout15mcgBuprenorphinePatch) == 0) {
  message('  ✓ All rows with a ReadCode dj3.. have a rubric suggesting 15mcg/hour Buprenorphine patch')
  message('  ✓ CHECK PASSED\n')
} else {
  message('  Some rows with a ReadCode dj3.. do not have a rubric suggesting 15mcg/hour Buprenorphine patch.')
  message('\n!!!!CHECK FAILED!!!!\n')
  error_count <- error_count + 1
}

# Check 6
message('# Check that ReadCode djks. is always one of the listed Rubrics.\n')
djksRecords <- JournalData %>% filter(ReadCode == 'djks.')
message(paste0('  There are ', nrow(djksRecords), ' rows with ReadCode=="djks."'))
djksRecordsWithoutKnownRubric <- djksRecords %>% filter(
  Rubric != "OxyNorm liquid 5mg/5ml oral solution (Napp Pharmaceutical..." &
  Rubric != "Oxycodone 5mg/5ml oral solution sugar free" &
  Rubric != "OXYNORM liq 5mg/5ml" &
  Rubric != "OXYCODONE HCl oral liq 5mg/5ml" &
  Rubric != "OxyNorm liquid 1mg/ml oral solution (Napp Pharmaceuticals..." &
  Rubric != "OXYCODONE HCl sf oral soln 5mg/5ml" &
  Rubric != "OXYNORM oral soln 5mg/5ml" &
  Rubric != "Oxycodone Hydrochloride  Solution  Sugar Free 5 mg/5 ml" &
  Rubric != "OxyNorm liquid 1mg/ml oral solution (Napp Pharmaceuticals Ltd)" &
  Rubric != "OxyNorm  Oral Solution  5 mg/5 ml" &
  Rubric != "Oxycodone Hydrochloride Solution Sugar Free 5 mg/5 ml" &
  Rubric != "Oxycodone 10mg/ml oral solution sugar free" &
  Rubric != "OxyNorm 10mg/ml concentrate oral solution (Napp Pharmaceu..." &
  Rubric != "OXYCODONE HCl oral liq conc 10mg/ml"
)
if(nrow(djksRecordsWithoutKnownRubric) == 0) {
  message('  ✓ All rows with a ReadCode djks. have a known Rubric')
  message('  ✓ CHECK PASSED\n')
} else {
  message('  Some rows with a ReadCode djks. do not have a known rubric.')
  message('\n!!!!CHECK FAILED!!!!\n')
  error_count <- error_count + 1
}

# FINAL
if(error_count > 0) {
  message(paste0('\n!!!FAIL!!! There were ', error_count, ' failed checks.'))
} else {
  message('\n✓ ALL CHECKS PASSED\n')
}
