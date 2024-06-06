# This processes all tablets.

TabletRowsWithInstruction <- rowsByFormWithInstructions('tablet', 1)

# There are sometimes duplicate rows but with different instructions. Usually the different
# instructions lead to the same low/high daily doses. However, in 163 tablet records (out 
# of 220,956 distinct records) have differing daily doses. So we simply take the min lowest
# and max highest daily dose as the range for these.
TabletRows <- makeRowsFromInstructionRows(TabletRowsWithInstruction, 'tablet')

TabletRowsNarrow <- makeFinalDailyMGsAndDuration(TabletRows)

# Now we categorise the most likely daily milligrams
# 220,956 records - nrow(TabletRowsNarrowWithNext)
# - 203,845 have a subsequent Rx - nrow(TabletRowsNarrowWithNext %>% filter(!is.na(Diff)))
#   - 150,823 have a Min/Max Rx length - nrow(TabletRowsNarrowWithNext %>% filter(!is.na(Diff) & !is.na(MinRxLength)))
#     - 85,095 fall within the predicted range - nrow(TabletRowsNarrowWithNext %>% filter(!is.na(Diff) & !is.na(MinRxLength) & Diff <= MaxRxLength & Diff >= MinRxLength)) 
#         > LIKELY DOSE = DailyMilligrams
#     - 31,628 next Rx is longer than max - nrow(TabletRowsNarrowWithNext %>% filter(!is.na(Diff) & !is.na(MinRxLength) & Diff > MaxRxLength & Diff >= MinRxLength)) 
#         > LIKELY DOSE = average of low/high daily dose
#     - 34,100 next Rx is shorter than min - nrow(TabletRowsNarrowWithNext %>% filter(!is.na(Diff) & !is.na(MinRxLength) & Diff < MinRxLength)) 
#         > LIKELY DOSE = high daily dose
#   - 53,022 do not have a Min/Max Rx length
#       > LIKELY DOSE = DailyMilligrams
# - 17,111 don't have a subsequent Rx
#   - 12,447 have a min/max Rx length
#       > LIKELY DOSE = DailyMilligrams
#   - 4,664 do not have a min/max Rx length
#       > LIKELY DOSE = DailyMilligrams

TabletMME <- makeMMEDataFrame(TabletRowsNarrow)

message('The following data frames are now available:')
message(' - TabletRows - the data filtered to those records that look like a tablet')
message(' - TabletRowsNarrow - the tablet rows processed')
message(' - TabletMME - the daily dose and daily MME grouped by opioid, person and date')