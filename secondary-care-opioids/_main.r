%run ./library/wrapper

### SPLIT HERE ###

# Write to file
write_to_file(Data, 'secondary-care-opioids-tidied.csv', 'analysis-outputs')

### SPLIT HERE ###

# Read top 10 lines to check it looks ok
readLines(file.path('/dbfs/mnt/', 'analysis-outputs', 'secondary-care-opioids-tidied.csv'), n=20)
