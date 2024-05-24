# This processes all patches.
# We identify these records by looking for a Form of 'patch'

# Create data frame with just the topical opioids
PatchRows <- FilteredData %>% filter(Form == 'patch') %>% left_join(PatchInstructionLookup, by = c("Codeunits" = "Instruction"))

# Update the patch interval by defaulting to 3 days for fentanyl and 1 week for buprenorphine
# if there is no other information provided. 
PatchRows$PatchInterval <- if_else(is.na(PatchRows$PatchInterval), if_else(PatchRows$OpioidName == 'fentanyl',72,168), PatchRows$PatchInterval)

# Determine the number of patches
# 1. If cast to a number then assume that many patches
# 2. If matches "X patch" then assume that many
# 3. If matches "X pack" and drug is Fencino then assume 10 as they come in packs of 5
regexNPatches <- '^[^0-9]*([0-9]+)[^0-9]+pat.*$'
PatchRows$NumberPatchesPrescribed <- if_else(
  !is.na(suppressWarnings(as.numeric(PatchRows$CodeValue))),
  suppressWarnings(as.numeric(PatchRows$CodeValue)),
  if_else(
    grepl(regexNPatches, PatchRows$CodeValue),
    suppressWarnings(as.numeric(sub(regexNPatches,"\\1",PatchRows$CodeValue))),
    if_else(
      grepl('fencino', tolower(PatchRows$Rubric)) & PatchRows$CodeValue == '2 packs of',
      10,
      NA
    )
  )
)

UnmatchedCodeValues <- PatchRows %>% 
  filter(is.na(NumberPatchesPrescribed))

if(nrow(UnmatchedCodeValues) == 0) {
  cat("All values in the CodeValue field have been matched for patches.")
} else {
  cat("The following values in the CodeValue field have not been matched for patches. Please update the process-patches notebook.\n\n")
  cat(paste(UnmatchedCodeValues$CodeValue, collapse = '\n'))
}


# Patches are usually given for 3 or 7 days, so we first create duplicate rows
# for each patch administration. We assume the patch is worn for entire days
# starting with the day immediately after the prescription date
PatchMME <- as.data.frame(lapply(PatchRows, rep, (PatchRows$NumberPatchesPrescribed/PatchRows$NumberOfPatchesPerUse) * PatchRows$PatchInterval/24)) %>%
  # There are now multiple rows for each PseudonymisedID, MedicationName and Date
  # By grouping on them we can set a new field StartDate so that each day of the patch is recorded.
  group_by(PseudonymisedID, MedicationName, Date) %>% 
  mutate(daycount = row_number(), StartDate = as.Date(Date + daycount)) %>% 
  ungroup() %>% 
  select(PseudonymisedID, OpioidName, Rubric, StrengthInMilligrams, MMEFactor, StartDate ) %>% 
  # Calculate the daily dose and MME
  mutate(Dose = 24 * StrengthInMilligrams, MME = MMEFactor * Dose, Date = StartDate) %>%
  # If the Rubric is the same we assume a new prescription has taken precedence but
  # if it's a different Rubric then we assume they have concurrent prescriptions
  group_by(PseudonymisedID, Date, Rubric, OpioidName) %>%
  summarise(Dose = max(Dose), MME = max(MME), .groups='drop') %>%
  # Now regroup and sum to get daily dose and daily mme per person and opioid
  group_by(PseudonymisedID, Date, OpioidName) %>%
  summarise(Dose = sum(Dose), MME = sum(MME), .groups='drop') %>%
  arrange(PseudonymisedID, Date)


message('The following data frames are now available:')
message(' - PatchRows - the data filtered to those records that look like a patch')
message(' - PatchMME - the daily dose and daily MME grouped by opioid, person and date')