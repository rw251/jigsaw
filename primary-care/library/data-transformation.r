message('# Data transformation')

### SPLIT HERE ###

%run ../../common/lib

### SPLIT HERE ###

# Check if data is loaded already
isDataLoaded <- tryCatch(nrow(JournalData) >= 0,error = function(cond) {
  message("JournalData does not seem to exist:")
  # return value
  FALSE
})
if(!isDataLoaded) {
  message("Loading primary care journal data from csv...");
  JournalData <- read_datalake("Journal.csv", "Primary Care") 
} else {
  message("JournalData object already loaded so not reloading.")
}

### SPLIT HERE ###

%run ./lookup-medication-primary

### SPLIT HERE ###

# Filter data
#  - Remove non-opioids
#  - Make the MedicationName field lowercase for joining
#  - Join the lookups
#
JournalData$EntryDate <- as.character(JournalData$EntryDate)
FilteredData <- JournalData %>% 
  mutate(
    Date = as.Date(EntryDate, "%Y%m%d"),
    # Fix the ReadCode which has two different drugs
    ReadCode = if_else(
      ReadCode == 'djks.' & Rubric %in% c("Oxycodone 10mg/ml oral solution sugar free","OXYCODONE HCl oral liq conc 10mg/ml","OxyNorm 10mg/ml concentrate oral solution (Napp Pharmaceu..."),
      "djks.ALTERNATIVE",
      ReadCode
    )
  ) %>%
  left_join(MedicationLookup, by = c("ReadCode" = "ClinicalCode")) %>% 
  filter(!is.na(OpioidName))

### SPLIT HERE ###

# Process the CodeValue field (which is typically the number/amount of things prescribed)
# It is always one of the following 4:
#   1. Just a number: '^[0-9.]+$'
#   2. A number of tabs/caps/ampoul/patches: '[0-9]+ ?-? ?(?:tab|cap|pat|ampoule)[^0-9]*$'
#   3. Millilitres: '[0-9]+ ?(?:ml|millil)[^0-9]*$'
#   4. N packs of: '[0-9]+ ?pack[^0-9]*$'

# Create two extra columns
# - CodeValueNumber - if the things can be turned into a single number (e.g number of tabs, ampoules, patches etc)
# - CodeValueMillilitres - for things in millilitres

regexNumber <- '^[0-9.]+$'
regexNumberTabs <- '([0-9]+) ?-? ?(?:tab|cap|pat|ampoule)[^0-9]*$'
regexPacks <- '([0-9]+) ?(?:pack)[^0-9]*$' # < 20 like this in whole dataset so let's just assume 28 tabls per packet
FilteredData$CodeValueNumber <- if_else(
  grepl(regexNumber,FilteredData$CodeValue), #Just a number
  suppressWarnings(as.numeric(FilteredData$CodeValue)),
  if_else(
    grepl(regexNumberTabs,FilteredData$CodeValue), # number of tabs/ampoules
    suppressWarnings(as.numeric(sub(regexNumberTabs,"\\1",FilteredData$CodeValue))),
    if_else(
      grepl(regexPacks,FilteredData$CodeValue),
      suppressWarnings(as.numeric(sub(regexPacks,"\\1",FilteredData$CodeValue)) * 28),
      NA
    )
  )
)

regexMls <- '([0-9]+) ?(?:ml|millil)[^0-9]*$'
FilteredData$CodeValueMillilitres <- if_else(
  grepl(regexMls,FilteredData$CodeValue),
  suppressWarnings(as.numeric(sub(regexMls,"\\1",FilteredData$CodeValue))),
  NA
)

UnmatchedCodeValues <- FilteredData %>% 
  filter(is.na(CodeValueNumber) & is.na(CodeValueMillilitres))

if(nrow(UnmatchedCodeValues) == 0) {
  cat("All values in the CodeValue field have been matched.")
} else {
  cat("The following values in the CodeValue field have not been matched. Please update the data-transformation notebook.\n\n")
  cat(paste(UnmatchedCodeValues$CodeValue, collapse = '\n'))
}