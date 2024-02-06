%md

# Dosage lookup

Creates a dataframe `DoseLookup` with columns:

- **FrequencyCode** - instruction e.g. "Take 2 a day"
- **MinFrequencyGap** - minimum gap between doses in hours
- **MaxFrequencyGap** - maximum gap between doses in hours
- **IsOneOff** - indicates whether a one off, or a recurring item

## Example output

| FrequencyCode     | MinFrequencyGap | MaxFrequencyGap | IsOneOff |
| ----------------- | --------------- | --------------- | -------- |
| Twice a day       | 12              | 12              | FALSE    |
| Every 6 - 8 hours | 6               | 8               | FALSE    |
| Once only         | 24              | 24              | TRUE     |
