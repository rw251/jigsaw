message('# Data transformation')

### SPLIT HERE ###

%run ../../common/lib

### SPLIT HERE ###

# Check if data is loaded already
isDataLoaded <- tryCatch(nrow(Opioid_Medication_Task) >= 0,error = function(cond) {
  message("Opioid_Medication_Task does not seem to exist:")
  # return value
  FALSE
})
if(!isDataLoaded) {
  message("Loading secondary care opioid prescribing data from csv...");
  Opioid_Medication_Task<- read_datalake("Opioid_Medication_Task.csv", "Secondary Care") 
} else {
  message("Opioid_Medication_Task object already loaded so not reloading.")
}

### SPLIT HERE ###

%run ./lookup-medication

### SPLIT HERE ###

%run ./lookup-dosage

### SPLIT HERE ###

%run ./lookup-route

### SPLIT HERE ###

# Filter data
#  - Remove items without a date
#  - Remove items with a task code of "Not Performed"
#  - Remove non-opioids
#  - Make the MedicationName field lowercase for joining
#  - Join the lookups
#
FilteredData <- Opioid_Medication_Task %>% 
  filter(!is.na(PerformedFromDtm) & TaskStatusCode != "Not Performed") %>%
  mutate(MedicationName = tolower(MedicationName), Date = as.Date(format(PerformedFromDtm, "%Y/%m/%d"))) %>%
  left_join(MedicationLookup, by = join_by(MedicationName)) %>%
  left_join(DoseLookup, by = join_by(FrequencyCode)) %>%
  filter(IsOpioid)

### SPLIT HERE ###

# Compile complete list of units

# IF TaskUom has a value use that as that is what was actually administered
# ELSE Just use Uom
FilteredData$UNITS <- if_else(!is.na(FilteredData$TaskUom), FilteredData$TaskUom, FilteredData$Uom)

### SPLIT HERE ###

# Compile complete list of dosages

# IF TaskDose has a value use that as that is what was actually administered
# ELSE IF DosageLow and DosageHigh then take the average
# ELSE Just use DosageLow
FilteredData$DOSAGE <- if_else(!is.na(FilteredData$TaskDose), FilteredData$TaskDose, if_else(!is.na(FilteredData$DosageHigh), (FilteredData$DosageLow + FilteredData$DosageHigh)/2, FilteredData$DosageLow))

### SPLIT HERE ###

# Compile complete list of routes

# IF TaskRouteCode has a value use that as that is what was actually administered
# ELSE Just use OrderRouteCode
FilteredData$RouteDescription <- if_else(!is.na(FilteredData$TaskRouteCode), FilteredData$TaskRouteCode, FilteredData$OrderRouteCode)

# Remove epidural, intrathecal, and intranasal
FilteredData <- FilteredData %>% filter(!RouteDescription %in% c("EPIDURAL Infusion.","EPIDURAL Injection.","INTRATHECAL  Injection","Intrathecal"))

### SPLIT HERE ###

# Join the route lookup
FilteredData <- FilteredData %>%
  left_join(RouteLookup, by = join_by(RouteDescription))

### SPLIT HERE ###
  
# Find MedicationNames that we haven't mapped.

MissingMedicationNames <- FilteredData %>%
  filter(is.na(OpioidName)) %>%
  group_by(MedicationName) %>% 
  summarise(n = n()) %>%
  arrange(desc(n))

if(nrow(MissingMedicationNames) == 0) {
  cat("All values in the MedicationName field of the Opioid_Medication_Task.csv have been matched.")
} else {
  cat("The following values in the MedicationName field of the Opioid_Medication_Task.csv have not been matched. Please update the lookup-medication notebook.\n\n")
  cat(paste(MissingMedicationNames$MedicationName, collapse = '\n'))
}

### SPLIT HERE ###

# Find FrequencyCodes that we haven't mapped.

MissingFrequencyCodes <- FilteredData %>%
  filter(is.na(MinFrequencyGap)) %>%
  group_by(FrequencyCode) %>% 
  summarise(n = n()) %>%
  arrange(desc(n))

if(nrow(MissingFrequencyCodes) == 0) {
  cat("All values in the FrequencyCode field of the Opioid_Medication_Task.csv have been matched.")
} else {
  cat("The following values in the FrequencyCode field of the Opioid_Medication_Task.csv have not been matched. Please update the lookup-dose notebook.\n\n")
  cat(paste(MissingFrequencyCodes$FrequencyCode, collapse = '\n'))
}

### SPLIT HERE ###

# Find RouteDescriptions that we haven't mapped.

MissingRouteDescriptions <- FilteredData %>%
  filter(is.na(RouteCategory)) %>%
  group_by(RouteDescription) %>% 
  summarise(n = n()) %>%
  arrange(desc(n))

if(nrow(MissingRouteDescriptions) == 0) {
  cat("All values in the RouteDescription field of the Opioid_Medication_Task.csv have been matched.")
} else {
  cat("The following values in the RouteDescription field of the Opioid_Medication_Task.csv have not been matched. Please update the lookup-route notebook.\n")
  cat("NB. If any of the new ones are epidural, intrathecal, and intranasal, they should be excluded below.\n\n")
  cat(paste(MissingRouteDescriptions$RouteDescription, collapse = '\n'))
}

### SPLIT HERE ###

# Update MMEFactor for some oxycodone
FilteredData$MMEFactor <- if_else(FilteredData$OpioidName == 'oxycodone' & FilteredData$RouteDescription %in% c("SC","SC Continuous Infusion","IM"), 3, FilteredData$MMEFactor)

# Update MMEFactor for some morphine
FilteredData$MMEFactor <- if_else(FilteredData$OpioidName == 'morphine' & FilteredData$RouteDescription %in% c("IV Continuous Infusion","IV Slow Injection","IV Infusion"), 3, FilteredData$MMEFactor)