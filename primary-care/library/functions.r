
# For a given form (tablet/oral solution/sachet) we
# - filter the data to just prescriptions of that form
# - link the medication and dosage lookups
# - calculate the lowest and highest DailyMilligrams based on dosage
rowsByFormWithInstructions <- function(form, doseSize=1) {
  return(
    FilteredData %>% filter(Form == form) %>%
      # I can't remember why I need to select a subset of columns and then re-join the MedicationLookup
      # but the code doesn't work if I take it out
      select(PseudonymisedID, ReadCode, MedicationName, Date, CodeValueNumber, CodeValueMillilitres, Codeunits) %>%
      left_join(MedicationLookup, by = c("ReadCode" = "ClinicalCode", "MedicationName" = "MedicationName")) %>%   
      select(-Frequency, -Form, -Route) %>%

      # Join the instruction lookup so we can convert instructions into low/high daily mgs of opioid
      left_join(InstructionLookup, by = c("Codeunits" = "Instruction")) %>%
      mutate(
        LowestDailyMilligrams = if_else(
          Optional == 1,
          0, # med is as required, so technically they could take 0 each day
          if_else(
            is.na(Unit),
            DailyLow * StrengthInMilligrams, # no units so assume mls or tablet or sachet
            if_else(
              Unit=='dose',
              DailyLow * doseSize * StrengthInMilligrams, # assume 1 dose = 1 5ml tsp
              if_else(
                Unit=='drop',
                DailyLow * 0.05 * StrengthInMilligrams, # 1 drop = 0.05 ml
                if_else(
                  Unit=='milligram',
                  DailyLow, # we already have mgs so don't need to multiple
                  DailyLow * StrengthInMilligrams # presumed mls or tablet or sachet
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
            DailyHigh * doseSize * StrengthInMilligrams,
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
        )
      )
  )
}

# For each row with a lowest and highest daily milligrams we
# - deduplicate the records
# - calculate the amount of opioid in mgs
# - calculate the min and max length of the prescription before it runs out
# - calculate how long until the next prescription
# - based on all the above calculate a most likely daily dose

makeRowsFromInstructionRows <- function(RowsWithInstruction, form) {
  return(
    RowsWithInstruction %>%
      group_by(PseudonymisedID, ReadCode, MedicationName, Date, OpioidName) %>% 

      # There are sometimes duplicate rows but with different instructions. Usually the different
      # instructions lead to the same low/high daily doses. For the few records with differing daily
      # doses we simply take the min lowest and max highest daily dose as the range for these.
      summarise(
        LowestDailyMilligrams = if_else( !all(is.na(LowestDailyMilligrams)), max(LowestDailyMilligrams, na.rm=T), NA), 
        HighestDailyMilligrams = if_else( !all(is.na(HighestDailyMilligrams)), max(HighestDailyMilligrams, na.rm=T), NA),
        DoseSize = if_else(form == 'oral solution', if_else(is.na(min(DoseLow)), 5, min(DoseLow)), 1),
        CodeValueNumber = if_else(is.na(max(CodeValueNumber)),max(CodeValueMillilitres),max(CodeValueNumber)),
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

        # DailyMgToExhaustSupply: The amount of milligrams (rounded to the nearest DoseSize) taken per day to use up the opioid
        #         completely by the time of the next prescription
        DailyMgToExhaustSupply =  DoseSize * StrengthInMilligrams * round((PrescribedMilligrams/(Diff*DoseSize*StrengthInMilligrams)), digits=0),

        # dmIf28DayRxTemp: The amount of milligrams (rounded to the nearest DoseSize) taken per day to use up 
        #                  the opioid over a 28 day period
        dmIf28DayRxTemp =  DoseSize * StrengthInMilligrams * round((PrescribedMilligrams/(28*DoseSize*StrengthInMilligrams)), digits=0),

        # If one or both of lowest/highest is null, and the previous row has one, assume that - unless previous rx was too long ago
        LowestDailyMilligrams = if_else((is.na(LowestDailyMilligrams) | is.na(HighestDailyMilligrams)) & (!is.na(lag(DailyMgToExhaustSupply)) & lag(DailyMgToExhaustSupply)!=0) & !is.na(lag(LowestDailyMilligrams)), lag(LowestDailyMilligrams), LowestDailyMilligrams),
        HighestDailyMilligrams = if_else((is.na(LowestDailyMilligrams) | is.na(HighestDailyMilligrams)) & (!is.na(lag(DailyMgToExhaustSupply)) & lag(DailyMgToExhaustSupply)!=0) & !is.na(lag(HighestDailyMilligrams)), lag(HighestDailyMilligrams), HighestDailyMilligrams),

        # Likely daily milligrams =
        #   - if DailyMgToExhaustSupply is > 0, use DailyMgToExhaustSupply
        #   - else if the previous Rx's DailyMgToExhaustSupply is >0 then use the smaller of that and the HighestDailyMilligrams
        #   - else if we have a highest and lowest daily milligrams take the average
        #   - else if dmIf28DayRxTemp > 0, use dmIf28DayRxTemp
        #   - else assume 1 tablet/dose per day
        DailyMilligrams = if_else(
          is.na(DailyMgToExhaustSupply) | DailyMgToExhaustSupply==0, 
          if_else(
            is.na(lag(DailyMgToExhaustSupply)) | lag(DailyMgToExhaustSupply)==0,
            if_else(
              is.na(HighestDailyMilligrams) | is.na(LowestDailyMilligrams) | HighestDailyMilligrams == 0,
              if_else(dmIf28DayRxTemp==0, StrengthInMilligrams * DoseSize, dmIf28DayRxTemp),
              (HighestDailyMilligrams + LowestDailyMilligrams)/2
            ),        
            if_else(
              is.na(HighestDailyMilligrams) | HighestDailyMilligrams == 0,
              lag(DailyMgToExhaustSupply),
              pmin(HighestDailyMilligrams,lag(DailyMgToExhaustSupply))
            )
          ), 
          DailyMgToExhaustSupply
        )
      ) %>%
      ungroup()
  )
}

makeFinalDailyMGsAndDuration <- function(Rows) {
  return(
    Rows %>%
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
          ceiling(PrescribedMilligrams/FinalDailyMilligram), # Next Rx too far in future
          if_else(
            !is.na(Diff) & !is.na(MinRxLength) & Diff < MinRxLength,
            Diff, # Next Rx too soon
            if_else(
              !is.na(Diff) & is.na(MinRxLength),
              ceiling(PrescribedMilligrams/FinalDailyMilligram), # Next Rx exists but unknown length of current Rx
              if_else(
                is.na(Diff) & !is.na(MinRxLength),
                ceiling(PrescribedMilligrams/FinalDailyMilligram), # No future Rx, but have a known length of current Rx
                if_else(
                  is.na(Diff) & is.na(MinRxLength),
                  ceiling(PrescribedMilligrams/FinalDailyMilligram), # No future Rx, and unknown length of current Rx
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
    mutate(LastDayMilligram = if_else(PrescribedMilligrams %% FinalDailyMilligram == 0, FinalDailyMilligram, PrescribedMilligrams %% FinalDailyMilligram)) %>% #if prescription does not divide fully, then last day has a different amount
    select(PseudonymisedID, Date, MedicationName, OpioidName, MMEFactor, Duration, PrescribedMilligrams, FinalDailyMilligram, LastDayMilligram, Category)
  )
}

makeMMEDataFrame <- function(RowsNarrow) {
  return(
    as.data.frame(lapply(RowsNarrow, rep, RowsNarrow$Duration)) %>%
    # There are now multiple rows for each PseudonymisedID, MedicationName and Date
    # By grouping on them we can set a new field StartDate so that each day of the prescription is recorded.
    group_by(PseudonymisedID, MedicationName, Date) %>% 
    mutate(daycount = row_number(), StartDate = as.Date(Date + daycount), FinalDailyMilligram = if_else(row_number() < n(), FinalDailyMilligram, LastDayMilligram)) %>% 
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
  )
}