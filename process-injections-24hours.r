# This processes all injections that are given as a per 24 hour

Injection24HoursRows <- FilteredData %>% filter(RouteCategory == 'injection' & (UNITS == 'mg/24hours' | UNITS == 'micrograms/24hours'))

# To get the daily dose and MME we need to consider that a 24 hour administration
# will definitely span midnight. For each administration we first duplicate the 
# record - one with "Date" equal to the date of admin, and the second with "Date"
# as the day after. We then work out how many hours the dose applied to each day
Injection24HoursMME <- as.data.frame(lapply(Injection24HoursRows, rep, 2)) %>% 
  arrange(PseudonymisedID,PerformedFromDtm) %>%
  group_by(PseudonymisedID,PerformedFromDtm,MedicationName) %>%
  mutate(
    Date = as.Date(PerformedFromDtm + (row_number() - 1)*60*60*24),
    HoursOnDay = if_else(row_number()==1,24-as.numeric(format(PerformedFromDtm,"%H")),as.numeric(format(PerformedFromDtm,"%H")))
  ) %>%
  ungroup() %>%
  filter(HoursOnDay > 0) %>%
  group_by(PseudonymisedID, Date, OpioidName) %>%
  summarise(
    TotalHours = pmin(24,sum(HoursOnDay)),
    DailyDose = if_else(
        max(UNITS) == 'micrograms/24hours',
        max(DOSAGE) * TotalHours / 24000,
        max(DOSAGE) * TotalHours/24),
    DailyMME = max(MMEFactor) * DailyDose,
    .groups='drop') %>%
  select(PseudonymisedID, Date, OpioidName, DailyDose, DailyMME)

message('The following data frames are now available:')
message(' - Injection24HoursRows - the data filtered to those records that look like a continuous 24 hour injection')
message(' - Injection24HoursMME - the daily dose and daily MME grouped by opioid, person and date')