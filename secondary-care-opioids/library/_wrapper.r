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

%run ./process-injections-pca

### SPLIT HERE ###

%run ./data-checks

### SPLIT HERE ###

# Group the non-PCA data together
NonPCAData <- rbind(SingleDoseMME, PatchMME, InjectionMME, Injection24HoursMME) %>% 
  group_by(PseudonymisedID, OpioidName, Date) %>%
  summarise(Dose = sum(Dose), MME = sum(MME), .groups="drop") %>%
  filter(MME > 0 & Date >= '2010-01-01' & Date <= '2021-09-30')
NonPCAData$IsPCA = FALSE

# Group the PCA data together
PCAData <- PCAInjectionMME %>% 
  group_by(PseudonymisedID, OpioidName, Date) %>%
  summarise(Dose = sum(Dose), MME = sum(MME), .groups="drop") %>%
  filter(MME > 0 & Date >= '2010-01-01' & Date <= '2021-09-30')
PCAData$IsPCA = TRUE

# Combine to final data set
Data <- rbind(PCAData, NonPCAData)