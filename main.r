%run ./data-transformation

### SPLIT HERE ###

### SPLIT HERE ###


### SPLIT HERE ###


### SPLIT HERE ###

# Dosage
# Focus on tablets. Find all possible combinations to get the quantity  of each dose.
Tablets <- FilteredData %>% filter(Form == 'tablet')

Tablet_DosHigh <- Tablets %>% filter(!is.na(DosageHigh))
Tablet_DosHighNA <- Tablets %>% filter(is.na(DosageHigh))

Tablet_DosHighNA_DosLowEQTaskDose <- Tablet_DosHighNA %>% filter(DosageLow == TaskDose)
Tablet_DosHighNA_DosLowNEQTaskDose <- Tablet_DosHighNA %>% filter(DosageLow != TaskDose)
Tablet_DosHighNA_TaskDoseNA <- Tablet_DosHighNA %>% filter(is.na(TaskDose))
Tablet_DosHighAndLow_DosLowEQTaskDose <- Tablet_DosHigh %>% filter(DosageLow == TaskDose)
Tablet_DosHighAndLow_DosHighEQTaskDose <- Tablet_DosHigh %>% filter(DosageHigh == TaskDose)
Tablet_DosHighAndLow_NeitherEQTaskDose <- Tablet_DosHigh %>% filter(DosageLow != TaskDose & DosageHigh != TaskDose)
Tablet_DosHighAndLow_TaskDoseNA <- Tablet_DosHigh %>% filter(is.na(TaskDose))

cat(paste("There are ",nrow(Tablets)," tablet rows.\n"))
cat(paste("> There are ",nrow(Tablet_DosHighNA)," tablet rows without a DosageHigh.\n"))
cat(paste(">> ",nrow(Tablet_DosHighNA_TaskDoseNA)," with TaskDose==NA rows.\n"))
cat(paste(">> ",nrow(Tablet_DosHighNA_DosLowEQTaskDose)," with DosageLow==TaskDose rows.\n"))
cat(paste(">> ",nrow(Tablet_DosHighNA_DosLowNEQTaskDose)," with DosageLow!=TaskDose rows.\n\n"))

cat(paste("> There are ",nrow(Tablet_DosHigh)," tablet rows with a DosageHigh.\n"))
cat(paste(">> ",nrow(Tablet_DosHighAndLow_TaskDoseNA)," with TaskDose==NA rows.\n"))
cat(paste(">> ",nrow(Tablet_DosHighAndLow_DosLowEQTaskDose)," with DosageLow==TaskDose rows.\n"))
cat(paste(">> ",nrow(Tablet_DosHighAndLow_DosHighEQTaskDose)," with DosageHigh==TaskDose rows.\n"))
cat(paste(">> ",nrow(Tablet_DosHighAndLow_NeitherEQTaskDose)," with Neither==TaskDose rows.\n\n"))

cat(paste("CHECK: Total number of tablets ", nrow(Tablets), " should equal sum of all components: ", nrow(Tablet_DosHighNA_DosLowEQTaskDose) + nrow(Tablet_DosHighNA_DosLowNEQTaskDose) + nrow(Tablet_DosHighNA_TaskDoseNA) + nrow(Tablet_DosHighAndLow_DosLowEQTaskDose) + nrow(Tablet_DosHighAndLow_DosHighEQTaskDose) + nrow(Tablet_DosHighAndLow_NeitherEQTaskDose) + nrow(Tablet_DosHighAndLow_TaskDoseNA)))

### SPLIT HERE ###

### SPLIT HERE ###

### SPLIT HERE ###

### SPLIT HERE ###

### SPLIT HERE ###

### SPLIT HERE ###