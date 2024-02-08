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

message('Loaded libs: sparklyr, stringr, dplyr')
message('Functions available: read_datalake')