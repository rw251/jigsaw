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

Data <- rbind(SingleDoseMME, PatchMME, InjectionMME, Injection24HoursMME) %>% 
  group_by(PseudonymisedID, OpioidName, Date) %>%
  summarise(DailyDose = sum(DailyDose), DailyMME = sum(DailyMME), .groups="drop") %>%
  filter(DailyMME > 0)
