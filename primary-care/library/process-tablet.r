# This processes all tablets.

TabletRows <- FilteredData %>% filter(Form == 'tablet') %>%
  # I can't remember why I need to select a subset of columns and then re-join the MedicationLookup
  # but the code doesn't work if I take it out
  select(PseudonymisedID, ReadCode, MedicationName, Date, CodeValueNumber, Codeunits) %>%
  left_join(MedicationLookup, by = c("ReadCode" = "ClinicalCode", "MedicationName" = "MedicationName")) %>%   
  select(-Frequency, -Form, -Route) %>%

  # Join the instruction lookup so we can convert instructions into low/high daily mgs of opioid
  left_join(InstructionLookup, by = c("Codeunits" = "Instruction"))%>%   
  mutate(
    LowestDailyMilligrams = if_else(
      Optional == 1,
      0, # med is as required, so technically they could take 0 each day
      if_else(
        is.na(Unit), 
        DailyLow * StrengthInMilligrams, 
        if_else(Unit=='milligram', DailyLow, DailyLow * StrengthInMilligrams)
      )
    ),
    HighestDailyMilligrams =  if_else(
      is.na(Unit), 
      DailyHigh * StrengthInMilligrams, 
      if_else(Unit=='milligram', DailyHigh, DailyHigh * StrengthInMilligrams)
    )
  ) %>%
  group_by(PseudonymisedID, ReadCode, MedicationName, Date, OpioidName) %>% 

  # There are sometimes duplicate rows but with different instructions. Usually the different
  # instructions lead to the same low/high daily doses. However, in 163 tablet records (out 
  # of 220,956 distinct records) have differing daily doses. So we simply take the min lowest
  # and max highest daily dose as the range for these.
  summarise(
    LowestDailyMilligrams = min(LowestDailyMilligrams), 
    HighestDailyMilligrams = max(HighestDailyMilligrams), 
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

TabletRowsNarrow <- TabletRows %>%

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

TabletMME <- as.data.frame(lapply(TabletRowsNarrow, rep, TabletRowsNarrow$Duration)) %>%
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


message('The following data frames are now available:')
message(' - TabletRows - the data filtered to those records that look like a tablet')
message(' - TabletRowsNarrow - the tablet rows processed')
message(' - TabletMME - the daily dose and daily MME grouped by opioid, person and date')