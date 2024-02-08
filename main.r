%run ./data-transformation

### SPLIT HERE ###

%run ./data-checks

### SPLIT HERE ###

%run ./process-single-dose

### SPLIT HERE ###

%run ./process-patches

### SPLIT HERE ###

%run ./process-injections

### SPLIT HERE ###

%run ./process-injections-24hours

### SPLIT HERE ###

# Check
message (paste("There are", nrow(FilteredData), "rows"))
message (paste(" -", nrow(SingleDoseRows ), "rows that are a single dose"))
message (paste(" -", nrow(Injection24HoursRows ), "rows for injections with mg or mcg / 24 hours"))
message (paste(" -", nrow(InjectionRows ), "rows for injections with ml/hour"))
message (paste(" -", nrow(PatchRows ), "rows for patches"))

message(paste0('Check that the number of rows (', nrow(FilteredData), ') is equal to the sum of the components (', nrow(SingleDoseRows ) + nrow(Injection24HoursRows) + nrow(InjectionRows) + nrow(PatchRows),')'))

### SPLIT HERE ###
