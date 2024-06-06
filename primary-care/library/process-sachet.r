# This processes all sachets

SachetRowsWithInstruction <- rowsByFormWithInstructions('sachet', 1)

# There are sometimes duplicate rows but for sachets they always have the same
# instruction (or null and an instruction). They also always have the same 
# CovdeValueNumber, so can safely max everything to deduplicate.
SachetRows <- makeRowsFromInstructionRows(SachetRowsWithInstruction, 'sachet')

SachetRowsNarrow <- makeFinalDailyMGsAndDuration(SachetRows)

# Now we categorise the most likely daily milligrams

# 57 records - nrow(SachetRows)
# - 48 have a subsequent Rx - nrow(SachetRows %>% filter(!is.na(Diff)))
#   - 30 have a Min/Max Rx length - nrow(SachetRows %>% filter(!is.na(Diff) & !is.na(MinRxLength)))
#     - 0 fall within the predicted range - nrow(SachetRows %>% filter(!is.na(Diff) & !is.na(MinRxLength) & Diff <= MaxRxLength & Diff >= MinRxLength)) 
#         > LIKELY DOSE = DailyMilligrams
#     - 17 next Rx is longer than max - nrow(SachetRows %>% filter(!is.na(Diff) & !is.na(MinRxLength) & Diff > MaxRxLength & Diff >= MinRxLength)) 
#         > LIKELY DOSE = average of low/high daily dose
#     - 13 next Rx is shorter than min - nrow(SachetRows %>% filter(!is.na(Diff) & !is.na(MinRxLength) & Diff < MinRxLength)) 
#         > LIKELY DOSE = high daily dose
#   - 18 do not have a Min/Max Rx length - nrow(SachetRows %>% filter(!is.na(Diff) & is.na(MinRxLength)))
#       > LIKELY DOSE = DailyMilligrams
# - 9 don't have a subsequent Rx - nrow(SachetRows %>% filter(is.na(Diff)))
#   - 7 have a min/max Rx length - nrow(SachetRows %>% filter(is.na(Diff) & !is.na(MinRxLength)))
#       > LIKELY DOSE = DailyMilligrams
#   - 2 do not have a min/max Rx length - nrow(SachetRows %>% filter(is.na(Diff) & is.na(MinRxLength)))
#       > LIKELY DOSE = DailyMilligrams

SachetMME <- makeMMEDataFrame(SachetRowsNarrow)

message('The following data frames are now available:')
message(' - SachetRows - the data filtered to those records that look like a sachet')
message(' - SachetRowsNarrow - the sachet rows processed')
message(' - SachetMME - the daily dose and daily MME grouped by opioid, person and date')
