%run ./data-transformation

### SPLIT HERE ###

%run ./lookup-patch-instruction

### SPLIT HERE ###

%run ./functions

### SPLIT HERE ###

%run ./process-patches

### SPLIT HERE ###

%run ./process-dosage

### SPLIT HERE ###

%run ./process-tablets

### SPLIT HERE ###

%run ./process-oral-solution

### SPLIT HERE ###

%run ./process-injection

### SPLIT HERE ###

%run ./process-sachet

### SPLIT HERE ###

%run ./data-checks

### SPLIT HERE ###

# Group the data together
Data <- rbind(TabletMME, PatchMME, OralSolutionMME, SachetMME) %>% 
  group_by(PseudonymisedID, OpioidName, Date, Category) %>%
  summarise(Dose = sum(Dose), MME = sum(MME), ExhaustDose = sum(ExhaustDose), ExhaustMME = sum(ExhaustMME), .groups="drop") %>%
  filter(MME > 0 & Date >= '2010-01-01' & Date <= '2021-09-30')

# Make Dose column explicitly in milligrams, relocate columns and sort
Data <- Data %>%
  rename(DoseInMg = Dose, DoseToExhaustInMg = ExhaustDose) %>%
  relocate(Date, .before = OpioidName) %>%
  arrange(PseudonymisedID, Date, OpioidName)