# README cleaning files

The primary care and secondary care directories contain README files. These files explain the cleaning process in detail. A version of them is created automatically when the `_main.r` script is executed inside the JigSaw datalake. Specifically the following 2 files are created:

- /dbfs/mnt/analysis-outputs/README-Primary-Care.md
- /dbfs/mnt/analysis-outputs/README-Secondary-Care.md

When the \_main.r script is executed, the final command loads the README file and displays it to screen. This can be copied from the DataBricks environment, into the relevant README file inside the correct folder (primary-care or secondary-care). The "Markdown PDF" VSCode extension is then used to create the PDF which can then be shared.

## Primary care code classification

- All clinical codes were taken from data extract and split into:
  - opioids.txt - all opioid codes. Includes read codes and EMIS codes
  - non-opioids.txt - any definitely not opioid codes (this is empty at the moment - not sure if needed)
  - unclassed-medications-emis.txt - and emis codes for medications not assigned to either the opioids.txt or the non-opioids.txt files
  - unclassed-medications-read.txt - same but for read v2 codes
  - diagnoses-emis.txt - any non-medication emis codes
  - diagnoses-read-codes.txt - and non-medication read v2 codes
