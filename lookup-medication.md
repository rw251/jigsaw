%md

# Medication lookup

Creates a dataframe `MedicationLookup` with columns:

- **MedicationName** - the full medication description
- **Active** ingredient - the opioid name (e.g. codeine, morphine, fentanyl etc) or "" if not an opioid
- **IsOpioid** - TRUE/FALSE - to allow us to filter out non-opioids
- **StrengthInMilligrams** - if in tablet form, or mg/millilitre if in liquid form
- **Form** - e.g. tablet/suppository/injection etc.
- **Route** - e.g. oral/injection/topical etc.
