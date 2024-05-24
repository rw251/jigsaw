# This processes all oral solutions

OralSolutionRows <- FilteredData  %>% filter(Form=='oral solution') %>%
  # I can't remember why I need to select a subset of columns and then re-join the MedicationLookup
  # but the code doesn't work if I take it out
  select(PseudonymisedID, ReadCode, MedicationName, Date, CodeValueNumber, CodeValueMillilitres, Codeunits) %>%
  left_join(MedicationLookup, by = c("ReadCode" = "ClinicalCode", "MedicationName" = "MedicationName")) %>%   
  select(-Frequency, -Form, -Route) %>%

  # Join the instruction lookup so we can convert instructions into low/high daily mgs of opioid
  left_join(InstructionLookup, by = c("Codeunits" = "Instruction")) %>%
  mutate(
    LowestDailyMilligrams = if_else(
      Optional==1,
      0, # med is as required, so technically they could take 0 each day
      if_else(
        is.na(Unit), 
        DailyLow * StrengthInMilligrams, # no units so assume mls
        if_else(
          Unit=='dose',
          DailyLow * 5 * StrengthInMilligrams, # assume 1 dose = 1 5ml tsp
          if_else(
            Unit=='drop',
            DailyLow * 0.05 * StrengthInMilligrams, # 1 drop = 0.05 ml
            if_else(
              Unit=='milligram',
              DailyLow, # we already have mgs so don't need to multiple
              DailyLow * StrengthInMilligrams # presumed mls
            )
          )
        )
      )
    ),
    HighestDailyMilligrams =  if_else(
      is.na(Unit), 
      DailyHigh * StrengthInMilligrams, 
      if_else(
        Unit=='dose',
        DailyHigh * 5 * StrengthInMilligrams,
        if_else(
          Unit=='drop',
          DailyHigh * 0.05 * StrengthInMilligrams,
          if_else(
            Unit=='milligram',
            DailyHigh,
            DailyHigh * StrengthInMilligrams
          )
        )
      )
    ),
  ) %>%
  group_by(PseudonymisedID, ReadCode, MedicationName, Date, OpioidName) %>% 

  # There are sometimes duplicate rows but with different instructions. Usually the different
  # instructions lead to the same low/high daily doses. In the small number where the duplicate
  # records have different doses we simply take the min lowest and max highest daily dose as the range for these.
  summarise(
    LowestDailyMilligrams = min(LowestDailyMilligrams), 
    DoseSize = if_else(is.na(min(DoseLow)), 5, min(DoseLow)),
    HighestDailyMilligrams = max(HighestDailyMilligrams), 
    CodeValueMillilitres = if_else(is.na(max(CodeValueNumber)),max(CodeValueMillilitres),max(CodeValueNumber)),
    StrengthInMilligrams = max(StrengthInMilligrams),
    MMEFactor = max(MMEFactor),
    .groups="drop"
  ) %>% 

  # PrescribedMilligrams, and therefore the minimum and maximum length of the prescription can then be calculated
  mutate(PrescribedMilligrams = CodeValueMillilitres * StrengthInMilligrams, MinRxLength = PrescribedMilligrams / HighestDailyMilligrams, MaxRxLength = PrescribedMilligrams / LowestDailyMilligrams) %>%

  # Now arrange in order of patient id, medication and date
  arrange(PseudonymisedID, MedicationName, Date) %>%
  group_by(PseudonymisedID, MedicationName) %>% 
  mutate(
    NextRx = lead(Date), # Calculate the next prescription of this particular drug for this patient
    Diff = as.numeric(difftime(NextRx, Date, units="days")), # How many days until next prescriptions

    # dmTemp: The amount of milligrams (rounded to the nearest DoseSize) taken per day to use up the opioid
    #         completely by the time of the next prescription
    dmTemp = DoseSize * StrengthInMilligrams * round((PrescribedMilligrams/(Diff*DoseSize*StrengthInMilligrams)), digits=0),

    # dmIf28DayRxTemp: The amount of milligrams (rounded to the nearest DoseSize) taken per day to use up 
    #                  the opioid over a 28 day period
    dmIf28DayRxTemp = DoseSize * StrengthInMilligrams * round((PrescribedMilligrams/(28*DoseSize*StrengthInMilligrams)), digits=0),

    # Likely daily milligrams =
    #   - if dmTemp is > 0, use dmTemp
    #   - else if the previous Rx's dmTemp is >0 then use the smaller of that and the HighestDailyMilligrams
    #   - else if we have a highest and lowest daily milligrams take the average
    #   - else if dmIf28DayRxTemp > 0, use dmIf28DayRxTemp
    #   - else assume 1 dose per day
    DailyMilligrams = if_else(
      is.na(dmTemp) | dmTemp==0, 
      if_else(
        is.na(lag(dmTemp)) | lag(dmTemp)==0,
        if_else(
          is.na(HighestDailyMilligrams) | is.na(LowestDailyMilligrams),
          if_else(dmIf28DayRxTemp==0, StrengthInMilligrams * DoseSize, dmIf28DayRxTemp),
          (HighestDailyMilligrams + LowestDailyMilligrams)/2
        ),        
        if_else(
          is.na(HighestDailyMilligrams),
          lag(dmTemp),
          pmin(HighestDailyMilligrams,lag(dmTemp))
        )
      ), 
      dmTemp
    )
  ) %>%
  ungroup()

OralSolutionRowsNarrow <- OralSolutionRows %>%


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

mutate(
    FinalDailyMilligram = if_else(
      !is.na(Diff) & !is.na(MinRxLength) & Diff <= MaxRxLength & Diff >= MinRxLength,
      DailyMilligrams, # In range
      if_else(
        !is.na(Diff) & !is.na(MinRxLength) & Diff > MaxRxLength & Diff >= MinRxLength,
        (LowestDailyMilligrams + HighestDailyMilligrams)/2, # Next Rx too far in future
        if_else(
          !is.na(Diff) & !is.na(MinRxLength) & Diff < MinRxLength,
          HighestDailyMilligrams, # Next Rx too soon
          if_else(
            !is.na(Diff) & is.na(MinRxLength),
            DailyMilligrams, # Next Rx exists but unknown length of current Rx
            if_else(
              is.na(Diff) & !is.na(MinRxLength),
              DailyMilligrams, # No future Rx, but have a known length of current Rx
              if_else(
                is.na(Diff) & is.na(MinRxLength),
                DailyMilligrams, # No future Rx, and unknown length of current Rx
                NA
              )
            )
          )
        )
      )
    ),
    Category = if_else(
      !is.na(Diff) & !is.na(MinRxLength) & Diff <= MaxRxLength & Diff >= MinRxLength,
      "Next Rx within range",
      if_else(
        !is.na(Diff) & !is.na(MinRxLength) & Diff > MaxRxLength & Diff >= MinRxLength,
        "Next Rx too far in future",
        if_else(
          !is.na(Diff) & !is.na(MinRxLength) & Diff < MinRxLength,
          "Next Rx too soon",
          if_else(
            !is.na(Diff) & is.na(MinRxLength),
            "Next Rx exists but unknown length of current Rx", # Might need to cap if e..g 6000mg prescribed on day 1 and again on day 2 - did they really take all 6000 on day 1
            if_else(
              is.na(Diff) & !is.na(MinRxLength),
              "No future Rx, but have a known length of current Rx",
              if_else(
                is.na(Diff) & is.na(MinRxLength),
                "No future Rx, and unknown length of current Rx",
                NA
              )
            )
          )
        )
      )
    )
  ) %>%
  select(PseudonymisedID, Date, MedicationName, OpioidName, MMEFactor, Diff, PrescribedMilligrams, FinalDailyMilligram, Category) %>%
  mutate(Duration = if_else(is.na(Diff), round(PrescribedMilligrams/FinalDailyMilligram, digits=0), Diff))

OralSolutionMME <- as.data.frame(lapply(OralSolutionRowsNarrow, rep, OralSolutionRowsNarrow$Duration)) %>%
  # There are now multiple rows for each PseudonymisedID, MedicationName and Date
  # By grouping on them we can set a new field StartDate so that each day of the oral solution prescription is recorded.
  group_by(PseudonymisedID, MedicationName, Date) %>% 
  mutate(daycount = row_number(), StartDate = as.Date(Date + daycount)) %>% 
  ungroup() %>% 
  select(PseudonymisedID, MedicationName, OpioidName, FinalDailyMilligram, MMEFactor, StartDate ) %>%   
  # Calculate the daily MME
  mutate(Dose = FinalDailyMilligram, MME = MMEFactor * Dose, Date = StartDate) %>%
  # Now group and sum to get daily dose and daily mme per person and opioid
  group_by(PseudonymisedID, Date, OpioidName) %>%
  summarise(Dose = sum(Dose), MME = sum(MME), .groups='drop') %>%
  mutate( # methadone MME is dependant on daily dose
    MME = if_else(
      OpioidName == 'methadone' & Dose <= 20,
      Dose * 4,
      if_else(
        OpioidName == 'methadone' & Dose <= 40,
        Dose * 8,
        if_else(
          OpioidName == 'methadone' & Dose <= 60,
          Dose * 10,
          if_else(
            OpioidName == 'methadone' & Dose > 60,
            Dose * 12,
            MME
          )
        )
      )
    )
  ) %>%
  arrange(PseudonymisedID, Date)

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