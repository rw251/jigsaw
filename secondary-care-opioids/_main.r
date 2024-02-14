%run ./library/data-transformation

### SPLIT HERE ###

%run ./library/process-single-dose

### SPLIT HERE ###

%run ./library/process-patches

### SPLIT HERE ###

%run ./library/process-injections

### SPLIT HERE ###

%run ./library/process-injections-24hours

### SPLIT HERE ###

%run ./library/process-injections-pca

### SPLIT HERE ###

%run ./library/data-checks

### SPLIT HERE ###

# Group the non-PCA data together
NonPCAData <- rbind(SingleDoseMME, PatchMME, InjectionMME, Injection24HoursMME) %>% 
  group_by(PseudonymisedID, OpioidName, Date) %>%
  summarise(DailyDose = sum(DailyDose), DailyMME = sum(DailyMME), .groups="drop") %>%
  filter(DailyMME > 0 & Date >= '2010-01-01' & Date <= '2021-09-30')
NonPCAData$IsPCA = FALSE

# Group the PCA data together
PCAData <- PCAInjectionMME %>% 
  group_by(PseudonymisedID, OpioidName, Date) %>%
  summarise(DailyDose = sum(DailyDose), DailyMME = sum(DailyMME), .groups="drop") %>%
  filter(DailyMME > 0 & Date >= '2010-01-01' & Date <= '2021-09-30')
PCAData$IsPCA = TRUE

# Combine to final data set
Data <- rbind(PCAData, NonPCAData)

### SPLIT HERE ###

# Write to file
write_to_file(Data, 'secondary-care-opioids-tidied.csv', 'analysis-outputs')