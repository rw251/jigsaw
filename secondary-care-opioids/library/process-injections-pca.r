# This processes all injections that are given as PCA

# We identify these records by looking the IsPCA flag

# Create data frame with just the PCA injection opioids and extract
# the max hourly dose from either the bolus (amount each time you press) 
# x12 (lock out of 5 minutes means 12 times an hour is the max), or the
# "up to x" loading dose per hour, whichever is smaller.
PCAInjectionRows <- FilteredData %>% filter(IsPCA) %>% mutate(
  BolusMcg = suppressWarnings(as.numeric(gsub("^.*Bolus(?:[0-9.]*-)?([0-9]+\\.?[0-9]?)micro.*$","\\1",TaskName))),
  BolusMg = suppressWarnings(as.numeric(gsub("^.*Bolus(?:[0-9.]*-)?([0-9]+\\.?[0-9]?)mg.*$","\\1",TaskName))),
  UpToMcg = suppressWarnings(as.numeric(gsub("^.*Upto([0-9]+)microgramshourly.*$","\\1",TaskName))),
  UpToMg = suppressWarnings(as.numeric(gsub("^.*Upto([0-9]+)mghourly.*$","\\1",TaskName))),
  Bolus = if_else(!is.na(BolusMcg), BolusMcg/1000, BolusMg),
  MaxHourlyFromLoadingDose = if_else(!is.na(UpToMcg), UpToMcg/1000, UpToMg),
  MaxPerHourFromBolus = 12 * Bolus,
  MaxHourlyDose = if_else(is.na(MaxHourlyFromLoadingDose), MaxPerHourFromBolus, pmin(MaxHourlyFromLoadingDose, MaxPerHourFromBolus))
)

# We group on ID and medication name. For each administration we check when the subsequent
# administration occurred. If within 24 hours then we assume the IV continued until the next
# administration. If more than 24 hours, then we assume the IV was stopped and we assume
# it was stopped after the MaxFrequencyGap. E.g. if the administration is every 6-8 hours
# then we assume it stopped 8 hours after the last administration.
Injections <- PCAInjectionRows %>% 
  arrange(PseudonymisedID, PerformedFromDtm) %>% 
	group_by(PseudonymisedID, MedicationName) %>%
	mutate(
		NextPerformedDtm = lead(PerformedFromDtm),
		HoursUntilNext = as.numeric(difftime(NextPerformedDtm, PerformedFromDtm, units="hours")), 
		AdminInterval = if_else(!is.na(HoursUntilNext) & HoursUntilNext < 24, HoursUntilNext, MaxFrequencyGap),
		AdminDose = AdminInterval * MaxHourlyDose,
		AdminMME = AdminDose * MMEFactor
	) %>%
  ungroup %>%
	select(PseudonymisedID, PerformedFromDtm,AdminInterval,AdminDose,AdminMME,OpioidName)


# Finally to get the daily dose and MME we need to consider administrations that span
# midnight. For each administration we first duplicate the record - one with "Date"
# equal to the date of admin, and the second with "Date" as the day after. We then
# work out how many hours the dose applied to each day
PCAInjectionMME <- as.data.frame(lapply(Injections, rep, 2)) %>% 
  arrange(PseudonymisedID,PerformedFromDtm) %>%
  group_by(PseudonymisedID,PerformedFromDtm,OpioidName) %>%
  mutate(
    Date = as.Date(PerformedFromDtm + (row_number() - 1)*60*60*24),
    HoursOnDay = if_else(row_number()==1,pmin(AdminInterval,24-as.numeric(format(PerformedFromDtm,"%H"))),pmax(0,AdminInterval-24+as.numeric(format(PerformedFromDtm,"%H")))),
    DoseOnDayMG = AdminDose * HoursOnDay / AdminInterval,
    MMEOnDay = AdminMME * HoursOnDay / AdminInterval
  ) %>%
  filter(DoseOnDayMG > 0) %>%
  group_by(PseudonymisedID, Date, OpioidName) %>%
  summarise(Dose = sum(DoseOnDayMG), MME = sum(MMEOnDay), .groups='drop')

message('The following data frames are now available:')
message(' - PCAInjectionRows - the data filtered to those records that look like a continuous injection')
message(' - PCAInjectionMME - the daily dose and daily MME grouped by opioid, person and date')