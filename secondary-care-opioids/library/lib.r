# Initial setup scripts

# Load libraries
suppressMessages({
  library(sparklyr)
  library(stringr)
  library(dplyr)
})

# Make helper method "read_datalake" to load csv files
sc <- spark_connect(method = 'databricks')
opts <- list(multiline = TRUE)
read_datalake <- function(filename, folder)
  spark_read_csv(sc, path = file.path('dbfs:/mnt/raw-data/', folder, filename), opt = opts) %>% collect

write_to_csv_file <- function(df, filename, folder)
  write.csv(df, file.path('/dbfs/mnt/', folder, filename), row.names=FALSE)

write_to_file <- function(text, filename, folder)
  cat(text, file=file.path('/dbfs/mnt/', folder, filename), sep='\n')

message('Loaded libs: sparklyr, stringr, dplyr')
message('Functions available: read_datalake, write_to_csv_file, write_to_file')