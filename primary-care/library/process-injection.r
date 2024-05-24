# There are < 3000 injections in the primary care data. Most have a reference to "over 24 hours",
# "syringe driver", or district/macmillan nurses. We assume therefore that they are mostly for
# palliative care and ignore. However we include for each patient their first and last injection
# prescription so that analysts can decide whether we should investigate anyone further.

InjectionRows <- FilteredData  %>% filter(Form=='injection' | Form=='injection-oneoff') %>%
  select(PseudonymisedID, ReadCode, MedicationName, Date, CodeValueNumber, CodeValueMillilitres, Codeunits) %>%
  left_join(MedicationLookup, by = c("ReadCode" = "ClinicalCode", "MedicationName" = "MedicationName")) %>%   
  select(-Frequency, -Form, -Route) %>%
  left_join(InstructionLookup, by = c("Codeunits" = "Instruction"))

FirstLastInjections <- InjectionRows %>%
  group_by(PseudonymisedID) %>%
  summarise(FirstInjectionPrescription=min(Date), LastInjectionPrescription=max(Date), NumberOfPrescriptions = n()) %>%
  mutate(DifferenceInDaysBetweenFirstAndLast = as.numeric(difftime(last, first, units="days")))

message('The following data frames are now available:')
message(' - InjectionRows - the data filtered to those records that look like an injection')
message(' - FirstLastInjections - the first and last prescription for injection for each patient')