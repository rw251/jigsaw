# This processes all injections that are given as a per hourly figure

# We identify these records by looking for a RouteCategory of 'topical'

# Create data frame with just the topical opioids
InjectionRows <- FilteredData %>% filter(RouteCategory == 'injection' & UNITS == 'ml/hour')

# We group on ID and medication name. For each administration we check when the subsequent
# administration occurred. If within 24 hours then we assume the IV continued until the next
# administration. If more than 24 hours, then we assume the IV was stopped and we assume
# it was stopped after the MaxFrequencyGap. E.g. if the administration is every 6-8 hours
# then we assume it stopped 8 hours after the last administration.
Injections <- InjectionRows %>% 
  arrange(PseudonymisedID, PerformedFromDtm) %>% 
	group_by(PseudonymisedID, MedicationName, StrengthInMilligrams) %>%
	mutate(
		NextPerformedDtm = lead(PerformedFromDtm),
		HoursUntilNext = as.numeric(difftime(NextPerformedDtm, PerformedFromDtm, units="hours")), 
		AdminInterval = if_else(!is.na(HoursUntilNext) & HoursUntilNext < 24, HoursUntilNext, MaxFrequencyGap),
		AdminDose = AdminInterval * DOSAGE,
		AdminMME = AdminDose * MMEFactor
	) %>%
  ungroup %>%
	select(PseudonymisedID, PerformedFromDtm,AdminInterval,AdminDose,AdminMME,OpioidName,StrengthInMilligrams)

# Finally to get the daily dose and MME we need to consider administrations that span
# midnight. For each administration we first duplicate the record - one with "Date"
# equal to the date of admin, and the second with "Date" as the day after. We then
# work out how many hours the dose applied to each day
InjectionMME <- as.data.frame(lapply(Injections, rep, 2)) %>% 
  arrange(PseudonymisedID,PerformedFromDtm) %>%
  group_by(PseudonymisedID,PerformedFromDtm,OpioidName,StrengthInMilligrams) %>%
  mutate(
    Date = as.Date(PerformedFromDtm + (row_number() - 1)*60*60*24),
    HoursOnDay = if_else(row_number()==1,pmin(AdminInterval,24-as.numeric(format(PerformedFromDtm,"%H"))),pmax(0,AdminInterval-24+as.numeric(format(PerformedFromDtm,"%H")))),
    DoseOnDayML = AdminDose * HoursOnDay / AdminInterval,
    DoseOnDayMG = DoseOnDayML * StrengthInMilligrams,
    MMEOnDay = AdminMME * HoursOnDay * StrengthInMilligrams / AdminInterval
  ) %>%
  filter(DoseOnDayML > 0) %>%
  group_by(PseudonymisedID, Date, OpioidName) %>%
  summarise(DailyDose = sum(DoseOnDayMG), DailyMME = sum(MMEOnDay), .groups='drop')

message('The following data frames are now available:')
message(' - InjectionRows - the data filtered to those records that look like a continuous injection')
message(' - InjectionMME - the daily dose and daily MME grouped by opioid, person and date')