%md
# Primary care opioid cleaning script

This script calls the `./library/_wrapper` script, which in turn loads the data, transforms it, and combines into the desired output. The final output is saved to `/dbfs/mnt/analysis-outputs/primary-care-opioids-tidied.csv` and `/dbfs/mnt/analysis-outputs/primary-care-injections.csv`, and a README file explaining the cleaning in detail is created at `/dbfs/mnt/analysis-outputs/README-Primary-Care.md`.

### SPLIT HERE ###

%run ./library/_wrapper

### SPLIT HERE ###

# Write to file
write_to_csv_file(Data, 'primary-care-opioids-tidied.csv', 'analysis-outputs')
write_to_csv_file(FirstLastInjections, 'primary-care-injections.csv', 'analysis-outputs')

### SPLIT HERE ###

# Read top 20 lines to check it looks ok
readLines(file.path('/dbfs/mnt/', 'analysis-outputs', 'primary-care-opioids-tidied.csv'), n=20)

### SPLIT HERE ###

# Read top 20 lines to check it looks ok
readLines(file.path('/dbfs/mnt/', 'analysis-outputs', 'primary-care-injections.csv'), n=20)

### SPLIT HERE ###

# Write readme file to explain the processing that has occurred

README <- c(
  "# Overview of cleaning",
  "",
  "## Summary",
  "",
  "The output file `primary-care-opioids-tidied.csv` is a csv with the following columns:",
  "",
  "- PseudonymisedID - the pseudonymised patient id",
  "- Date - the date of the opioid",
  "- OpioidName - the opiod name",
  "- DoseInMg - the total amount of opioid that day in mg",
  "- MME - the total MME of that opioid",
  "",
  "An example is as follows:",
  "",
  "| PseudonymisedID | Date       | OpioidName | DoseInMg | MME |",
  "| --------------- | ---------- | ---------- | -------- | --- |",
  "| 1001            | 2021-05-07 | codeine    | 40       | 6   |",
  "| 1001            | 2021-05-07 | morphine   | 10       | 10  |",
  "| 2886            | 2019-03-10 | morphine   | 20       | 20  |",
  "| 2886            | 2019-03-10 | fentanyl   | 0.5      | 65  |",
    "",
  "**NB1:** The total MME for a patient is calculated by adding up each MME for the patient on each day. E.g. patient 1001 has a total MME of 16 on 2021-05-07, and patient 2886 has a total MME of 85 on 2019-03-10.",
  ""
)

write_to_file(README, 'README-Primary-Care.md', 'analysis-outputs')

### SPLIT HERE ###

# Read the readme to check
file.show(file.path('/dbfs/mnt/', 'analysis-outputs', 'README-Primary-Care.md'))
