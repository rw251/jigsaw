%run ./data-transformation

### SPLIT HERE ###

%run ./process-single-dose

### SPLIT HERE ###

%run ./process-patches

### SPLIT HERE ###

%run ./process-injections

### SPLIT HERE ###

%run ./process-injections-24hours

### SPLIT HERE ###

%run ./data-checks

### SPLIT HERE ###

# Group the data together
Data <- rbind(SingleDoseMME, PatchMME, InjectionMME, Injection24HoursMME) %>% 
  group_by(PseudonymisedID, OpioidName, Date) %>%
  summarise(DailyDose = sum(DailyDose), DailyMME = sum(DailyMME), .groups="drop") %>%
  filter(DailyMME > 0 & Date >= '2010-01-01' & Date <= '2021-09-30')

  ### SPLIT HERE ###

# Write to file
write_to_file(Data, 'secondary-care-opioids-tidied.csv', 'analysis-outputs')