# This processes all sachets

SachetRows <- FilteredData %>% filter(Form=='sachet')%>%
  # I can't remember why I need to select a subset of columns and then re-join the MedicationLookup
  # but the code doesn't work if I take it out
  select(PseudonymisedID, ReadCode, MedicationName, Date, CodeValueNumber, Codeunits) %>%
  left_join(MedicationLookup, by = c("ReadCode" = "ClinicalCode", "MedicationName" = "MedicationName")) %>%   
  select(-Frequency, -Form, -Route) %>% left_join(InstructionLookup, by = c("Codeunits" = "Instruction")) %>%
  mutate(
    LowestDailyMilligrams = if_else(
      Optional==1,
      0, # med is as required, so technically they could take 0 each day
      if_else(
        is.na(Unit), 
        DailyLow * StrengthInMilligrams, # no units so assume sachets
        if_else(
          Unit=='milligram',
          DailyLow, # we already have mgs so don't need to multiple
          DailyLow * StrengthInMilligrams # presumed sachets
        )
      )
    ),
    HighestDailyMilligrams =  if_else(
      is.na(Unit), 
      DailyHigh * StrengthInMilligrams, 
      if_else(Unit=='milligram', DailyHigh, DailyHigh * StrengthInMilligrams)
    ),
  ) %>%
  group_by(PseudonymisedID, ReadCode, MedicationName, Date, OpioidName) %>% 

  # There are sometimes duplicate rows but for sachets they always have the same
  # instruction (or null and an instruction). They also always have the same 
  # CovdeValueNumber, so can safely max everything to deduplicate.
  summarise(
    LowestDailyMilligrams = ifelse( !all(is.na(LowestDailyMilligrams)), max(LowestDailyMilligrams, na.rm=T), NA), 
    HighestDailyMilligrams = ifelse( !all(is.na(HighestDailyMilligrams)), max(HighestDailyMilligrams, na.rm=T), NA), 
    CodeValueNumber = max(CodeValueNumber),
    StrengthInMilligrams = max(StrengthInMilligrams),
    MMEFactor = max(MMEFactor),
    .groups="drop"
  ) %>% 

  # PrescribedMilligrams, and therefore the minimum and maximum length of the prescription can then be calculated
  mutate(PrescribedMilligrams = CodeValueNumber * StrengthInMilligrams, MinRxLength = PrescribedMilligrams / HighestDailyMilligrams, MaxRxLength = PrescribedMilligrams / LowestDailyMilligrams) %>%

  # Now arrange in order of patient id, medication and date
  arrange(PseudonymisedID, MedicationName, Date) %>%
  group_by(PseudonymisedID, MedicationName) %>% 
  mutate(
    NextRx = lead(Date), # Calculate the next prescription of this particular drug for this patient
    Diff = as.numeric(difftime(NextRx, Date, units="days")), # How many days until next prescriptions

    # dmTemp: The amount of milligrams (rounded to the nearest whole tablet) taken per day to use up the opioid
    #         completely by the time of the next prescription
    dmTemp = StrengthInMilligrams * round((PrescribedMilligrams/(Diff*StrengthInMilligrams)), digits=0),

    # dmIf28DayRxTemp: The amount of milligrams (rounded to the nearest whole tablet) taken per day to use up 
    #                  the opioid over a 28 day period
    dmIf28DayRxTemp = StrengthInMilligrams * round((PrescribedMilligrams/(28*StrengthInMilligrams)), digits=0),

    # Likely daily milligrams =
    #   - if dmTemp is > 0, use dmTemp
    #   - else if the previous Rx's dmTemp is >0 then use the smaller of that and the HighestDailyMilligrams
    #   - else if we have a highest and lowest daily milligrams take the average
    #   - else if dmIf28DayRxTemp > 0, use dmIf28DayRxTemp
    #   - else assume 1 tablet per day
    DailyMilligrams = if_else(
      is.na(dmTemp) | dmTemp==0, 
      if_else(
        is.na(lag(dmTemp)) | lag(dmTemp)==0,
        if_else(
          is.na(HighestDailyMilligrams) | is.na(LowestDailyMilligrams) | HighestDailyMilligrams == 0,
          if_else(dmIf28DayRxTemp==0, StrengthInMilligrams, dmIf28DayRxTemp),
          (HighestDailyMilligrams + LowestDailyMilligrams)/2
        ),        
        if_else(
          is.na(HighestDailyMilligrams) | HighestDailyMilligrams == 0,
          lag(dmTemp),
          pmin(HighestDailyMilligrams,lag(dmTemp))
        )
      ), 
      dmTemp
    )
  ) %>%
  ungroup()

SachetRowsNarrow <- SachetRows %>%

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
              (LowestDailyMilligrams + HighestDailyMilligrams)/2, # No future Rx, but have a known length of current Rx
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
    Duration = if_else(
      !is.na(Diff) & !is.na(MinRxLength) & Diff <= MaxRxLength & Diff >= MinRxLength,
      Diff, # In range
      if_else(
        !is.na(Diff) & !is.na(MinRxLength) & Diff > MaxRxLength & Diff >= MinRxLength,
        round(PrescribedMilligrams/FinalDailyMilligram, digits=0), # Next Rx too far in future
        if_else(
          !is.na(Diff) & !is.na(MinRxLength) & Diff < MinRxLength,
          Diff, # Next Rx too soon
          if_else(
            !is.na(Diff) & is.na(MinRxLength),
            round(PrescribedMilligrams/FinalDailyMilligram, digits=0), # Next Rx exists but unknown length of current Rx
            if_else(
              is.na(Diff) & !is.na(MinRxLength),
              round(PrescribedMilligrams/FinalDailyMilligram, digits=0), # No future Rx, but have a known length of current Rx
              if_else(
                is.na(Diff) & is.na(MinRxLength),
                round(PrescribedMilligrams/FinalDailyMilligram, digits=0), # No future Rx, and unknown length of current Rx
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
  select(PseudonymisedID, Date, MedicationName, OpioidName, MMEFactor, Duration, PrescribedMilligrams, FinalDailyMilligram, Category)

SachetMME <- as.data.frame(lapply(SachetRowsNarrow, rep, SachetRowsNarrow$Duration)) %>%
  # There are now multiple rows for each PseudonymisedID, MedicationName and Date
  # By grouping on them we can set a new field StartDate so that each day of the tablet prescription is recorded.
  group_by(PseudonymisedID, MedicationName, Date) %>% 
  mutate(daycount = row_number(), StartDate = as.Date(Date + daycount)) %>% 
  ungroup() %>% 
  select(PseudonymisedID, MedicationName, OpioidName, FinalDailyMilligram, MMEFactor, StartDate ) %>%   
  # Calculate the daily MME
  mutate(Dose = FinalDailyMilligram, MME = MMEFactor * Dose, Date = StartDate) %>%
  # Now group and sum to get daily dose and daily mme per person and opioid
  group_by(PseudonymisedID, Date, OpioidName) %>%
  summarise(Dose = sum(Dose), MME = sum(MME), .groups='drop') %>%
  arrange(PseudonymisedID, Date)


message('The following data frames are now available:')
message(' - SachetRows - the data filtered to those records that look like a sachet')
message(' - SachetRowsNarrow - the sachet rows processed')
message(' - SachetMME - the daily dose and daily MME grouped by opioid, person and date')
