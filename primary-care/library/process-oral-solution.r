# This processes all oral solutions

OralSolutionRowsWithInstruction <- rowsByFormWithInstructions('oral solution', 5)
  
# There are sometimes duplicate rows but with different instructions. Usually the different
# instructions lead to the same low/high daily doses. In the small number where the duplicate
# records have different doses we simply take the min lowest and max highest daily dose as the range for these.
OralSolutionRows <- makeRowsFromInstructionRows(OralSolutionRowsWithInstruction, 'oral solution')

OralSolutionRowsNarrow <- makeFinalDailyMGsAndDuration(OralSolutionRows)

# 23,041 records - nrow(OralSolutionRows)
# - 19,674 have a subsequent Rx - nrow(OralSolutionRows %>% filter(!is.na(Diff)))
#   - 12,109 have a Min/Max Rx length - nrow(OralSolutionRows %>% filter(!is.na(Diff) & !is.na(MinRxLength)))
#     - 7,381 fall within the predicted range - nrow(OralSolutionRows %>% filter(!is.na(Diff) & !is.na(MinRxLength) & Diff <= MaxRxLength & Diff >= MinRxLength)) 
#         > LIKELY DOSE = DailyMilligrams
#     - 871 next Rx is longer than max - nrow(OralSolutionRows %>% filter(!is.na(Diff) & !is.na(MinRxLength) & Diff > MaxRxLength & Diff >= MinRxLength))
#         > LIKELY DOSE = average of low/high daily dose
#     - 3,857 next Rx is shorter than min - nrow(OralSolutionRows %>% filter(!is.na(Diff) & !is.na(MinRxLength) & Diff < MinRxLength)) 
#         > LIKELY DOSE = high daily dose
#   - 7,565 do not have a Min/Max Rx length - nrow(OralSolutionRows %>% filter(!is.na(Diff) & is.na(MinRxLength)))
#       > LIKELY DOSE = DailyMilligrams
# - 3,367 don't have a subsequent Rx - nrow(OralSolutionRows %>% filter(is.na(Diff)))
#   - 2,357 have a min/max Rx length - nrow(OralSolutionRows %>% filter(is.na(Diff) & !is.na(MinRxLength)))
#       > LIKELY DOSE = DailyMilligrams
#   - 1,010 do not have a min/max Rx length - nrow(OralSolutionRows %>% filter(is.na(Diff) & is.na(MinRxLength)))
#       > LIKELY DOSE = DailyMilligrams

OralSolutionMME <- makeMMEDataFrame(OralSolutionRowsNarrow)

#dose	23 not many, assume 1 dose = 5ml
#drop	3 - only 2 are actual drops - should divide by 20 to get ml
#gram	4 - should all be milligram (now are)
#microgram	12 (can ignore as none of these are actual doses)
#milligram	2768
#ml	17569
#ml spoonful	148 - can just map this to ml
# TODO 1 drop = 0.05 ml

# Check CodeValue for duplicates
# 23,041 distinct Rx - nrow(OralSolutionRows %>% group_by(PseudonymisedID, MedicationName, Date) %>% summarise(n=n()))
# 588 duplicates - nrow(OralSolutionRows %>% group_by(PseudonymisedID, MedicationName, Date) %>% summarise(n=n()) %>% filter(n > 1))
# 541 have same CodeValueNumber - nrow(OralSolutionRows %>% group_by(PseudonymisedID, MedicationName, Date) %>% summarise(n=n(), maxcv=max(CodeValueNumber), mincv=min(CodeValueNumber)) %>% filter(n > 1 & maxcv==mincv))
# So just use max(CodeValueNumber) at some point
# None of the 71 rows with a CodeValueMillilitres have a duplicate, so again can use max(CodeValueMillilitres)

#nrow(OralSolutionRows %>% group_by(PseudonymisedID, MedicationName, Date) %>% summarise(n=n(), maxcv=max(Codeunits), mincv=min(Codeunits)) %>% filter(n > 1 & maxcv==mincv))

message('The following data frames are now available:')
message(' - OralSolutionRows - the data filtered to those records that look like an oral solution')
message(' - OralSolutionRowsNarrow - the oral solution rows processed')
message(' - OralSolutionMME - the daily dose and daily MME grouped by opioid, person and date')