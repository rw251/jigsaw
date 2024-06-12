# Overview of cleaning - secondary care data

## Summary

The output file `/dbfs/mnt/analysis-outputs/secondary-care-opioids-tidied.csv` is a csv with the following columns:

- PseudonymisedID - the pseudonymised patient id
- Date - the date of the opioid
- OpioidName - the opioid name
- DoseInMg - the total amount of opioid that day in mg
- MME - the total MME of that opioid
- IsPCA - a flag to indicate if this opioid was controlled by the patient

An example is as follows:

| PseudonymisedID | Date       | OpioidName | DoseInMg | MME | IsPCA |
| --------------- | ---------- | ---------- | -------- | --- | ----- |
| 1001            | 2021-05-07 | codeine    | 40       | 6   | FALSE |
| 1001            | 2021-05-07 | morphine   | 10       | 10  | FALSE |
| 2886            | 2019-03-10 | morphine   | 20       | 20  | FALSE |
| 2886            | 2019-03-10 | fentanyl   | 0.5      | 65  | FALSE |
| 2886            | 2019-03-10 | fentanyl   | 1        | 130 | TRUE  |

**NB1:** The total MME for a patient is calculated by adding up each MME for the patient on each day. E.g. patient 1001 has a total MME of 16 on 2021-05-07, and patient 2886 has a total MME of 215 on 2019-03-10.

**NB2:** It is possible to receive the same opioid as a PCA and a non-PCA. E.g. patient 2886 received 1.5mg of fentanyl in total on 2019-03-10, with 0.5mg given directly and 1mg under PCA

## Date range

The data is filtered to just administrations in the range '2010-01-01' to '2021-09-30' inclusive.

## PCA

The instructions for a PCA opioid include:

- an instruction (e.g. every 4 hours)
- a loading dose (e.g. 200 micrograms hourly)
- a bolus (e.g. 20 micrograms - the amount delievered every time the patient presses the button)
- a lockout (this is always 5 minutes i.e. after pressing the button it will not work again until 5 minutes have elapsed)

We calculate the dose as follows:

- The hourly dose is the minimum of:
  - Bolus value x 12 (i.e. with a 5 minute lockout the max dose is pressing the button 12 times in an hour)
  - The hourly loading dose (i.e. you can't take more than is loaded into the IV every hour)
- The duration is caculated as:
  - The number of hours until the next identical medication (if < 24 hours)
  - Or if that is >= 24 hours, then the value from the instruction (e.g. 4 if the instruction is 'every 4 hours')
- The daily dose is then the hourly dose multiplied by the duration in hours, and apportioned to the correct day for administrations that span midnight

The PCA dose therefore represents the likely maximum dose the patient could have administered. In practice it could be a lot less. By having the IsPCA flag, that allows the analyst to determine whether or not to include these values. If included there is the option to proportionaly reduce those values. This also allows for sensitivity analyses using vs not-using the data.

## Data

The underlying data is opioid administration data from SRFT. Each row represents an actual administration of an opioid.

## Cleaning method

### Single dose

If the units (field TaskUom, or Uom if unavailable) is one of 'mg', 'microgram' or 'Tablet/s', then we process it like a single dose. This includes any oral medication, but also some non-continuous injections.

- If the units are 'mg' we use as-is
- If the units are 'microgram' we divide by 1000
- If the units are 'Tablet/s' we multiple by the StrengthInMilligrams of a single tablet

We then group by PseudonymisedID, Date and OpioidName, and sum the dosage to get the daily dose.

Other cleaning:

- There are some records of co-codamol in tablets where the value is >10. These are therefore likely actually mg of codeine, rather than the patient received more than 10 tablets in a single dose. We reassign these appropriately
- There are some records where the unit is 'mg' or 'microgram', but where the TaskDose (the actually administered dose) is 1 or 2, but the DosageLow (the minimum prescribed dose) is a lot higher e.g. 30, 60. For these we assume that the TaskDose is in fact a number of tablets and adjust accordingly.
- Sometimes the TaskDose is a 4 digit number that looks like a time rather than a dose. For any TaskDose >= 1000, we look for any identical medications administered within 1 day. If there are any such medications we look at the max dosage of these, and use that as a more plausible value than the one that is >= 1000

### Injections

If the route is 'injection', the units are 'ml/hour', and the drug is not marked as a PCA, then we treat as a continuous infusion.

For each administration, we find the next identical administration, and calculate the time difference (T). We also look at the instruction (e.g. every 4 hours), and work out the minimum frequency gap (Gmin) and the maximum frequency gap (Gmax). We need the min and max to deal with instructions like 'every 4-6 hours'. We assume the length of each administration is T, unless T >= 24 (indicating either a pause, or the end of the medication), in which case we use Gmax instead.

The dose in mg for each administration is calculated by multiplying the dosage (which is in ml/hour), by the strength (in mg/ml), and the length of administration calculated above.

Finally we apportion dosages that span midnight into the appropriate date.

### Patches

If the route is 'topical' then we treat as a patch.

Patches are typically administered for a certain number of days, and so a single record will lead to many days of opioid doses. The data also frequently includes records with a TaskName that starts with 'Check'. These appear to be when an existing patch is checked, rather than a fresh administration. Almost all of the 'check' records have a date which falls within a previous patch administration. However there are a few records, where for example, a 7 day patch, has 'check' events on days 8, 9 or 10. Given it seems plausible that a 7 day patch could be worn for longer, we assume that whenever we see a check record, that the patch was at least worn for a further 24 hours.

We use the instruction (every 4 days) to determine the duration. However, for patches where the instruction is unclear, e.g. 'User schedule', then we assume that fentanyl patches are worn for 3 days, and buprenorphine patches are worn for 7 days.

The units are always 'microgram/hr', so to calculate the daily dose we:

- create n+1 rows for each patch administration, where n is the number of days the patch is worn (it is n+1 because a 7 day patch will be worn on 8 separate calendar days, but the first and last day will only be partial days)
- for the first day, we calculate the number of hours until midnight (H), and assign `H * DOSAGE / 1000` as the Dose (/1000 as the units is always micrograms)
- for the last day, we assign `(24 - H) * DOSAGE / 1000` as the Dose
- for all days in between, we assign `24 * DOSAGE / 1000` as the Dose

### PCA injections

If the drug is marked as PCA, then we treat as a PCA injection.

The method for deriving the daily dose is given in the PCA section above

### 24 hour injections

If the route is 'injection' and the units are 'mg/24hours' or 'micrograms/24hours', then we assume that the dose is to be spread out over the 24 hours following the administration. First we standardise the units to mg/24hours by dividing by 1000 the values with a unit of micrograms/24hours. Then we calculate the number of hours until midnight (H) following the administration. Finally we apportion H/24 of the dosage to the day of administration, and (24-H)/H of the dosage to the day after.
