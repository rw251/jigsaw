message('# Instruction lookup')
message('Creates a dataframe `InstructionLookup` with columns:')
message('  - Instruction - The instruction from the GP')
message('  - Frequency - how many times per interval')
message('  - Interval - how long is an interval in days (typically this is 1 unless its a per week thing)')
message('  - Dose - how many units')
message('  - Unit - what the unit is')

Instructions <- unique(FilteredData$Codeunits)
InstructionsWithDosages <- extract_from_prescription(Instructions)

# create the dose miner fix
InstructionFixLookup <- data.frame()

# Tablet things that were milligrams but incorrectly (either dosage, or milligram should be tablet)
rbind(InstructionFixLookup,c("2BD (20MG BD)","2","1","20","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("10MG IN THE MORNING -  20 MG (2 TABLETS) AT NIGHT","3","1","10","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY AS WEL AS YOUR OXYCONTIN 4OMG","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY. TAKES WITH OXYCONTIN 20MG. TOTAL DAILY DOSE 60MG","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TWO TWICE A DAY WITH THE 80MG CAPSULE TO MAKE A TOTAL OF 120MG TWICE DAILY","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 TWICE A DAY TO MAKE A TOTAL OF 120MG TWICE DAILY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TWICE A DAY (35MG BD)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("200MG MANE 200MG  AFTERNOON AND 400MG NOCTE","4","1","200","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("5MG EVENING","1","1","5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY IN ADDITION TO THE 15 MG TABLET TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY IN ADDITION TO THE 20 MG TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 IN THE MORNING 2 AT NIGHT IN ADDITION TO 20MG DOSE TWICE A DAY","3","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE IN THE MORNING IN ADDITION TO THE 20 MG","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY IN ADDITION TO PREEXISTING OXYCODONE 10 MG IN VENALINK","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 TWICE A DAY WITH 20MG (TOTAL DOSE= 30MGBD)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("10MG MORNING AND 10MG 12HRS LATER EVENING","2","1","10","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE AS DIRECTED -  MAXIMUMOF 60MG IN 24 HOURS)","1","1","60","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 BD (TOTAL 15MG BD)(IP OCT 17)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY (TOTAL 15MG BD) (IP OCT 17)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY TO INCREASE IT TO TOTAL OF 40 MG AS PER THE HOSPITAL INSTRUCTION(CLAIRE AR","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("PLEASE GIVE 10MG (TWO TABLETS) AT8AM -  PLEASE GIVE 5MG  ONE TABLET AT 8PM","3","1","5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("PLEASE GIVE 10MG (TWO TABLETS) AT 8AM -  PLEASE GIVE 5MG ONE TABLET AT 8PM","3","1","5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TWICE A DAY IN ADDITION 20MG TABLET UNTIL DOSETTE UPDATED WITH 30MG TABLET(S)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE 5MG TABLET TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TWICE DAILY INVENALINK WITH THE 10MG TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("20MG-30MG EVERY3 HOURS WHEN REQUIRED","8","1","20-30","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TWICE A DAY WITH 200MG TABS","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TWICE A DAY WITH 200MG TABS (AMENDED AMOUNT TO BRING MEDS IN TO LINE)","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TWICE A DAY WITH 200MG TABLET TO MAKE 300MG TWICE A DAY WITH ORAMORPH FOR BREAKTHROUGH","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TWICE A DAY (WITH 100MG TAB= TOTAL 160MG BD)","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE BD (TOTAL 40MG)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE EVERY TWELVE HOURS  (TOTAL 45MG)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE EVERY TWELVE HOURS  8AM AND 8PM (TOTAL 45MG)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE IN THE MORNING INSTEAD OF 15MG TABLET","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY (TAKING 40MG TWICE A DAY )","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("15MG - 30MG EVERY 4-6 HOURS","4-6","1","15-30","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("INCREASE AS DISCUSSED. BY 5MG INITIALLY TO 25MG TWICE A DAY","2","1","25","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("INCREASE AS DISCUSSED. BY 5MG INITIALLY TO 25MG TWICE A DAY ","2","1","25","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY TWELVE HOURS CAN INCREASE TO 3(30MG) EVERY 12 HOURS","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TO TAKE ONE 5MG TABLET IN THE MORNING AND 3 TABKETS  AT NIGHT","4","1","5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TWO EVERY 12 HRS (AS WELL AS A SINGLE 60MG DOSE TOTAL DOSE 80MG BD)","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TWO EVERY 12 HRS (720MG TWICE DAILY TOTAL DOSE)","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 12 HRS (420MG TWICE DAILY TOTAL DOSE)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TWO EVERY 12 HRS (980MG TWICE DAILY TOTAL DOSE)","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE THREE EVERY 12 HRS (980MG TWICE DAILY TOTAL DOSE)","2","1","3","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TWICE A DAY IN ADDITION TO THE 60MG DOSE MAKING THE TOTAL DOSE 90MG TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY ALONGSIDE YOUR 10 MG DOSE","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 AT NIGHT TOTAL 15MG","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 AT NIGHT AS DIRECTED AS WELL AS 10MG TABLET IN THE MORNING","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 TWICE A DAY (TAKING 50MG BD)","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE SIX EVERY TWELVE HOURS (ALTERNATIVE TO 30MG)","2","1","6","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE 5MG TABLET IN THE MORNING AND ONE 5MG TABLET AT NIGHT (ONE EVERY 12 HOURS)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 EVERY 12 HOURS WITH 60 MG TABLETS","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 EVERY 12 HOURS WITH 60 MG TABLETS","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 EVERY 12 HOURS WITH 30 MG TABLET","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c(" 1 BD  AT SAME TIME AS OXYCODONE 20MG ","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1OMG EVERY 12 HOURS","2","1","10","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE EVERY 12 HOURS ALONGSIDE 60MG TABLETS (TOTAL DOSE = 80MG","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 EVERY 12 HOURS ALONGSIDE 20MG","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY WITH 40MG TABLET","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE IN THE MORNING WITH THE 20MG TABLET","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY WITH THE 10MG TABLETS TO TOTAL 80MG TWICE A DAY AS PER WYTHENSHAWE HOSPITAL","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("15-20MG IF NEEDED FOR BREAKTHROUGH FOR PAIN OVERNIGHT. MAX 2 DOSES EACH NIGHT AND TO BE RE","0-2","1","15-20","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("10MG OXYCODONE 4-HOURLY IF NEEDED -  MAXIMUM 60MG IN 24 HOURS :- WEEKLY PRESCRIPTIONS DUE TO","6","1","10","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("10MG (2 CAPSULES) OXYCODONE 4-HOURLY IF NEEDED -  MAXIMUM 50MG IN 24 HOURS :- WEEKLY PRESCRI","6","1","10","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("10MG (2 CAPSULES) OXYCODONE 4-HOURLY IF NEEDED -  MAXIMUM 40MG IN 24 HOURS :- WEEKLY PRESCRI","6","1","10","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 DAILY REDUCE BY 10MG EVERY 2 WEEKS AS ABLE TO.","1","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE 5MG TABLET TWICE A DAY- 12 HOURS APART","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY WITH YOUR EXISTING 30MG CAPSULES MAKING A TOTAL DOSE OF 60MG TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY (TOTAL 40MG BD)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 3 (30MG) EVERY 4 HOUR FOR BTHRU FOR PAIN","6","1","3","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1TBL TWICE A DAY WITH 20MG TBL","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TO BE TAKEN TWICE A DAY (110MG BD)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TO BE TAKEN TWICE A DAY (120MG BD)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("100MG QDS","4","1","100","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 12 HOURS AM AND BEDTIME (WITH 5MGS TABLET TOTAL DOSE 35MGS TWICE DAILY)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY TWELVE HOURS  (WITH 5MG TABLETS TOTAL DOSE 35MGS BD)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY TWELVE HOURS (WITH 30MGS TOTAL DOSE 35MGS BD)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TWICE DAILY (WITH 40MG DOSE)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 TWICE A DAY (WITH 1X30MG TABLET)","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY (WITH 2X10MG TABLETS)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 2HOURS WHEN REQUIRED (TOTAL 15MG EVERY 2HOURS PRN)","12","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 TWICE A DAY WITH 30 MG","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE BD TO TAKE WITH A 30MG TABLET","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY TO TAKE WITH A 10MG MST TABLET","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY IN ADDITION TO OXYCONTIN 40 MG TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY IN ADDITION TO OXYCONTIN 80 MG TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE IN ADDITION TO THE 10MG CAPSULE IF NEEDED UP TO THREE TIMES A DAY","0-3","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY TWELVE HOURS (WITH 30MG CAPSULE)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY TWELVE HOURS WITH 30MG TABLET","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 EVERY 12 HOURS WITH 30MG","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY TWELVE HOURS WITH 10MG CAPSULE","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY TWELVE HOURS WITH 10MG TABLET","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 EVERY 12 HOURS WITH 10MG","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 EVERY 12 HOURS WITH 10MG ","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("IN ADDITION TO USUAL 10MG DOSE","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE BD -  ALONGSIDE THE 20MG","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY WITH 10MG MST TABLET","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1-2 ( 50-100MG ) CAPSULES   FOUR TIMES A DAY WHEN REQUIRED  -  ONE HUNDRED CAPSULES","4","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TWICE DAILY ON TOP OF 20MG UNTIL USED THEN MOVE ON TOP OF 30MG ONCE DAILY TABLETS","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 EVERY 12  HOURS / TAKE WITH YOUR 60MG TABLET","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1MORNING AND ONE AT NIGHT -  (TOTAL 30MG)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 AT NIGHT (TOTAL 30MG)","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 EXTRA  FOUR TIMES A DAY WHEN REQUIRED (HAS 10MG MORPHINE FOUR TIMES A DAY IN DOSETTE","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TWO FOUR TIMES A DAY WHEN REQUIRED FOR PAIN. MAXIMUM 240MG IN 24 HOURS (IP APR 13)","4","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("3 TWICE A DAY REDUYCING BY 10MG EACH WEEK","2","1","3","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY WITH THE 20 MG TOTALK OF 30 MG FOR FOR PAIN","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 BD ( TOTAL OF 50 MG BD )","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY ( TOTAL OF 50 MG TWICE A DAY )","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 BD ( TOTAL OF 6-0 MG BD AS PER SPECIALIST )","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 IN THE MORNING (ALONG WITH 30MG TABLET) AND 2 IN EVENING","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 IN THE MORNING (ALONG WITH 30MG TABLET - TOTAL 40MG)","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 IN MORNING AND 2 AT NIGHT(IN ADDITION TO THE 30MG)","3","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TWICE A DAY ( TOTALLING 15MG BD)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE IN THE MORNING WITH 15MG TO MAKE TOTAL MORNING DOSE 20MG","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 30MG OR 60MG EVERY 4 TO 6 HOURS WHEN REQUIRED","4-6","1","30-60","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c(" 30-60MG 4-6HRS MAXIMUM 240MG IN 24HRS","4-6","1","30-60","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TWICE DAILY ALONG WITH THE 20MG TABLET(S)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 12 HRS IN ADDITION TO 30MG TABLET IF REQUIRED","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TWO EVERY 12 HRS IN ADDITION TO 30MG CAPSULE","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY IN ADDITION TO THE 150MG CAPSULE WHEN REQUIRED FOR PAIN","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY WITH 30MG TABLETS","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY (30MG TWICE DAILY)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 BD (15MG BD IN TOTAL)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 FOUR TIMES A DAY  SUPPLY FIFTY SIX X FIFTY MILLIGRAM CAPS","4","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TWICE A DAY FOR 2 WEEKS IN ADDITION TO 30MG TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY (TOTAL 30MG)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY (40MG BD) -ACUTE RX TO COVER ALIGNING NEXT 4 WEEKS OF DOSETTES -THANKS  3/5/","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TWICE A DAY -  IN ADDITION TO 40MG TABLETS","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TWO EVERY 12 HRS (TOTAL WITH PREVIOUS PRESCRIPTION OF 80 MG BD)","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY TWELVE HOURS WITH 10 MG TABLET(S)","2","1","1","tablet"))->InstructionFixLookup

# Tablet things that were micrograms but incorrectly (either dosage, or microgram should be tablet)
rbind(InstructionFixLookup,c("1  TWICE DAILY AS REQUIRED  FOR BREAKTHROUGH PAIN","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1  TWICE DAILY AS REQUIRED  FOR BREAKTHROUGH PAIN ","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY (USE OXYCODONE WHEN REQUIRED -  FOR BREAKTHROUGH  PAIN AND PLEASE LEAVE AT LEA","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY (USE OXYCODONE WHEN REQUIRED -  FOR BREAKTHROUGH FOR PAIN AND PLEASE LEAVE AT ","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 TWICE A DAY IF NEEDED FOR BREAKTHROUGH FOR PAIN AS PER HOSPITAL(CHRISTIE)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE BD PRN (IP AUG 12)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY TWELVE HOURS AS SUGGESTED BY HOSPITAL","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TWICE A DAY WHEN REQUIRED FOR BREAKTHROUGH PAIN","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TWICE A DAY - REVIEW IF STILL NEEDED AUGUST 2015","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TWICE DAILY FOR COUGH","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1  FOUR TIMES A DAY WHEN REQUIRED FOR BREAKTHROUGH FOR PAIN","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 FOUR TIMES A DAY FOR PAIN WHEN REQUIRED WHEN NORMAL PAIN KILLERS NOT ENOUGH.   Instalmen","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 FOUR TIMES A DAY IF NEEDED FOR BREAKTHROUGH FOR PAIN AND CHART USE","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 FOUR TIMES A DAY WHEN REQUIRED FOR PAIN WHEN NORMAL PAINKILLERS NOT ENOUGH","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 PRN UPTO 4 TIMES A DAY FOR BREAKTHROUGH PAIN","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 FOUR TIMES A DAY FOR PAIN WHEN REQUIRED WHEN NORMAL PAIN KILLERS NOT ENOUGH.   Instalmen","4","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 FOUR TIMES A DAY WHEN REQUIRED FOR BREAKTHROUGH FOR PAIN","4","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 FOUR TIMES A DAY WHEN REQUIRED FOR BREAKTHROUGH PAIN -- ONLY TAKE WHEN NEEDED","4","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE 4 TIMES/DAY WHEN REQUIRED FOR BREAKTHROUGH FOR PAIN","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE FOUR TIMES DAILY (IP AUG 11)","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE FOUR TIMES DAILY (IP AUG 12)","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE OR TWO FOUR TIMES DAILY TO RELIEVE COUGH","4","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("FOR BREAKTHROUGH PAIN EVERY 4 HOUR -  IF NEEDED MORE FREQUENT THAN THIS SEEK GP ADVICE","6","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE FOUR HOURLY WHEN REQUIRED FOR BREAKTHROUGH FOR PAIN","6","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 4 HRS FOR BREAKTHOUGH FOR PAIN","6","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 4 HRS if needed for breakthrough pain","6","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE FOR BREAK THROUGH FOR PAIN -  CAN BE EVERY FOUR HOURS","6","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE OR TWO EVERY 4 HRS FOR BREAKTHOUGH FOR PAIN","6","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE OR TWO EVERY FOUR HOURS FOR BREAKTHROUGH  PAIN","6","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE or two EVERY 4 HRS FOR BREAKTHOUGH FOR PAIN","6","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE UP TO 4 TIMES A DAY FOR BREAKTHROUGH PAIN","0-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE UP TO FIVE TIMES A DAY FOR BREAKTHROUGH FOR PAIN","0-5","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE UP TO FIVE TIMES A DAY FOR BREAKTHROUGH FOR PAIN (TOTAL DOSE 15MG)","0-5","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 4- 6 HOURS FOR BREAKTHROUGH FOR PAIN","4-6","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 4-6 HRS AS REQUIRED FOR BREAKTHROUGH PAIN","4-6","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE OR TWO EVERY 4-6 HOURS WHEN REQUIRED FOR PAIN. MAXIMUM 8 A DAY (IP AUG 12)","4-6","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE OR TWO EVERY 4-6 HOURS WHEN REQUIRED. MAXIMUM 8 A DAY (IP AUG 12)","4-6","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 OR 2 PRN UP TO QDS TO MANAGE BREAKTHROUGH 'PAIN","0-4","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE OR TWO WHEN REQUIRED UP TO TWICE A DAY FOR BREAKTHROUGH PAIN","0-2","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("BREAKTHROUGH FOR PAIN (MAXIMUM OF 4 A DAY )ONLY FOR BREAKTHROUGH FOR PAIN AS DIRECTED BY T","0-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("FOR BREAKTHROUGH FOR PAIN MAXIMUM 4/DAY","0-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("IF NEEDED -  FOR BREAKTHROUGH FOR PAIN -  UP TO FOUR TIMES A DAY","0-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 OR 2 WHEN REQUIRED UP TO FOUR TIMES A DAY FOR COUGH","0-4","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("USE FOR BREAK THROUGH FOR PAIN -  UP TO 4 TIMES A DAY ( THIS IS A HIGHER STRENGTH MEDICATION","0-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("USE FOR BREAKTHROUGH FOR PAIN UP TO FOUR TIMES A DAY","0-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 AS NEEDED FOR BREAKTHROUGH",NA,NA,"1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("AS DIRECTED BY THE HOSPITAL -  INITIALLY 400MCG -  WITH 200MCG GIVEN IF NEEDED AFTER 15 MINS -  ","1","1","0.4-0.6","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("AS DIRECTED BY THE HOSPITAL -  INITIALLY 400MCG -  WITH 200MCG GIVEN IF NEEDED AFTER 15 MINS F","1","1","0.4-0.6","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE IF NEEDED FOR BREAK THROUGH PAIN TAKE INSTEAD OF ORAMORPH. PLEASE RECORD EACH TIME DAT",NA,NA,"1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE IF NEEDED FOR BREAKTHROUGH PAIN. DISTRICT NURSES TO TO RIGHT EYE ORDER MEDICATION IF S",NA,NA,"1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE  2-4 AS NEEDED FOR BREAKTRHOUGH FOR PAIN",NA,NA,"2-4","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 WITH 400MCG TABLETS. CAN TAKE ADDITIONAL DOSE AFTER ONE HOUR IF NEEDED",NA,NA,"1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1-2 AS NEEDED FOR BREAKTRHOUGH FOR PAIN",NA,NA,"1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 4 AS NEEDED FOR BREAKTHROUGH FOR PAIN",NA,NA,"4","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE FIVE TIMES DAY PRN FOR BREAKTHROUGH PAIN","5","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE FOR BREAKTHROUGH PAIN IF NEEDED",NA,NA,"1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE FOR BREAKTHROUGH PAIN MAX 2 IN A DAY","0-2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE WHEN NEEDED FOR BREAKTHROUGH PAIN",NA,NA,"1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("USE IN ADDITION TO USUAL MEDICATION -  FOR BREAKTHROUGH AS NECESSARY",NA,NA,NA,"tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("WHEN REQUIRED FOR BREAKTHROUGH FOR PAIN (NO MORE THAN 5-10MGS 4-6 HOURLY)","4-6","1","5-10","milligram"))->InstructionFixLookup

# Things with a 7 day interval that need changing
rbind(InstructionFixLookup,c("1 CAPSULE TWICE A DAY(INSTEAD OF 60 MG //GIVEN AS 3 DAYS AND 4 DAYS PER WEEK )","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1 EVERY 4-6HRS PRN (MONTHLY NOT WEEKLY)","4-6","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1-2 CAPSULE 4 HOURLY WHEN REQUIRED. ORDER WEEKLY BUT NOT TO GO IN VENALINK","6","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("1-2 TABLETS UP TO FOUR TIMES DAILY WHEN REQUIRED FOR PAIN   Instalments: NOT A WEEKLY","0-4","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("10MG (2 CAPSULES) OXYCODONE TWICE A DAY IF NEEDED -  MAXIMUM 20MG IN 24 HOURS :- WEEKLY PRES","2","1","10","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 CAPSULE 4 FOUR TIMES A DAY THEN REDUCE BY ONE CAPSULE EVERY WEEK","4","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("4 CAPSULES IN MORNING AND 3 AT NIGHT  FOR 1 WEEK THEN REDUCE AS ADVISED BY 50MG EVERY WEEK","7","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE CAPSULE 4 FOUR TIMES A DAY WEEKLY  SUPPLY TWENTY EIGHT","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE FOUR TIMES A DAY  2 WEEKLY","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 OR 2 EVERY FOUR TO TAKE SIX WEEKLY HOURS INSTEAD OF COPROXAMOL","4-6","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 OR 2 EVERY FOUR TO TAKE SIX WEEKLY HOURS-DO NOT TAKE PARACETAMOL WITH THIS","4-6","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 OR 2 EVERY FOUR TO TAKE TAKE SIX WEEKLY WEEKLY HOURS","4-6","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 UP TO 4 TIMES A DAY IF NEEDED  Instalments: not weekly issue","1-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 2 FOUR TIMES A DAY IN A WEEKLY VENALINK","4","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 2 FOUR TIMES A DAY PLEASE DISPENSE AS 4 TIMES 7 DAY WEEKLY VENOLINK","4","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 12 HRS (DISPENSED IN WEEKLY VENALINK)","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY FOUR TO TAKE TAKE SIX WEEKLY WEEKLY HOURS","4-6","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE IN THE MORNING (DISPENSED IN WEEKLY VENALINK)","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE TABLET TWICE A DAY  Instalments: weekly","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TWO AT NIGHT 5 DAYS PER WEEK AND TAKE ONE AT NIGHT TWO DAYS PER WEEK","1","1","2","tablet"))->InstructionFixLookup

# Misc things that can be fixed
rbind(InstructionFixLookup,c("1 UP TO 4 TIMES A DAY WHEN REQUIRED","0-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 NIGHT","1","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2 UP TO 4 TIMES A DAY ","0-4","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("3 IN MORNING AND 3 EVENING","2","1","3","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("I TABLET IN THE MORNING AND TWO AT NIGHT","3","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TABLET TWELVE HOURS APART","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("ONE TONIGHT AND ONE TOMORROW NIGHT. MEDICINE SHOULD THEN APPEAR IN NEW BLISTER PACK","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 2 IN MORNING AND 2 IN EVENING","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE I TWICE A DAY","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE  0NE OR TWO  QDS  DURING THE DAY FOR PAIN","4","1","1-2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE EVERY 12 HRS","2","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TW0 EVERY 12 HRS","2","1","2","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE TW0 IN THE MORNING AND 3 AT NIGHT - PLEASE MAKE AN APPOINTMENT WITH THE DR TO DISCUSS","5","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE UP TO -  BUT DO NOT EXCEED ONE MANE AND TWO NOCTE","3","1","0-1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 1 FOUR TIMES A DAY WHEN REQUIRED  -  MAX DOSE 8 CAPS IN 24 HRS","4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("0NE TABLET AT NIGHT","1","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE x 4 a day max  for pain","0-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE ONE X 4 A DAY MAX  FOR PAIN","0-4","1","1","tablet"))->InstructionFixLookup
rbind(InstructionFixLookup,c("0NE TABLET FOUR TIMES DAILY AS REQUIRED FOR PAIN","4","1","1","tablet"))->InstructionFixLookup


# Milligrams misspelt and so classed as "grams"
rbind(InstructionFixLookup,c("2.5 MILIGRAM  EVERY 3 HOURLY WHEN REQUIRED","8","1","2.5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("TAKE 2.5-5MILIGRAMS  IF REQUIRED UPTO QDS","0-4","1","2.5-5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("5-10 MILIGRAMS EVERY 3 HRS WHEN REQUIRED","8","1","5-10","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("10MILIGRAM -30MILIGRAM S/C OVER 24 HRS VIA SYRINGE DRIVER","1","1","10-30","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2.5 MILIGRAM -5 MILIGRAM  IMMEDIATELY DOSE S/C 2-4HRS WHEN REQUIRED","6-12","1","2.5-5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("15 MILIGRAM SUBCUTENOUS PRN EVERY 4 HOURS  PRN  AS PER MCMILLAN NURSE","6","1","15","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("60 MILIGRAM SUBCUTENOUS VUA SYRINGE DRIVER EVERY 24 HOURS AS PER MCMILLAN NURSE","1","1","60","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2.5-5 MILIGRAMS (=0.25-0.5ML) EVERY 2-4 HOURS WHEN REQUIRED PAIN/BREATHLESS SUBCUT","6-12","1","2.5-5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("10MILIGRAM TO 30 MG OVER 24 HRS SUBCUT VIA SYRINGE DRIVER","1","1","10-30","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2.5 MILIGRAM TO 5 MILIGRAM SUBCUT WHEN REQUIRED /4 HOURLY","6","1","2.5-5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("2.5-5MILIGRAMS EVERY 4 HOURS WHEN REQUIRED PAIN","6","1","2.5-5","milligram"))->InstructionFixLookup

# "Dose" should be milligram
rbind(InstructionFixLookup,c("TO BE GIVEN BY DISTRICT NURSE S/C OVER 24 HOURS -  DOSE AS OF 7.10.19 IS 20MG OVER 24 HOURS","1","1","20","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("FOR SUB CUT DOSES 2.5- 5MG EVERY 2-4 HRS","6-12","1","2.5-5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("DOSE AS PRESCRIBED ON AUTHORISATION SHEET TO BE GIVEN BY DISTRICT NURSES 2.5MG TO 5MG INIT","1","1","2.5-5","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("DOSE RANGE 15-40MG OVER 24 HOURS AND 2.5MG WHEN REQUIRED 4HLY","1","1","15-40","milligram"))->InstructionFixLookup
rbind(InstructionFixLookup,c("DOSE RANGE 10 -30MG OVER 24HRS SUBCUTANEOUSLY","1","1","10-30","milligram"))->InstructionFixLookup

colnames(InstructionFixLookup) <- c("Instruction", "FREQUENCY", "INTERVAL", "DOSAGE", "FORM")
InstructionLookup <- InstructionsWithDosages %>% 
  left_join(InstructionFixLookup, by = c("raw" = "Instruction")) %>% 
  mutate(
    Instruction = raw,
    Frequency = if_else(is.na(FREQUENCY), freq, FREQUENCY),
    Interval = if_else(is.na(INTERVAL), itvl, INTERVAL),
    Dose = if_else(is.na(DOSAGE), dose, DOSAGE),
    Unit = if_else(is.na(FORM), unit, FORM),
    Optional = optional
  ) %>% 
  select(Instruction,Frequency,Interval,Dose,Unit,Optional)

# Now split up
OnlyRegex = '^[0-9.]+$'
FirstRegex = '^([0-9.]+)-[0-9.]+$'
LastRegex = '^[0-9.]+-([0-9.]+)$'
InstructionLookup$FreqLow <- if_else(
  grepl(OnlyRegex,InstructionLookup$Frequency), 
  suppressWarnings(as.numeric(InstructionLookup$Frequency)), 
  if_else(
    grepl(FirstRegex,InstructionLookup$Frequency), 
    suppressWarnings(as.numeric(sub(FirstRegex,"\\1",InstructionLookup$Frequency))),
    NA
  )
)
InstructionLookup$FreqHigh <- if_else(
  grepl(OnlyRegex,InstructionLookup$Frequency), 
  suppressWarnings(as.numeric(InstructionLookup$Frequency)), 
  if_else(
    grepl(LastRegex,InstructionLookup$Frequency), 
    suppressWarnings(as.numeric(sub(LastRegex,"\\1",InstructionLookup$Frequency))),
    NA
  )
)
InstructionLookup$DoseLow <- if_else(
  grepl(OnlyRegex,InstructionLookup$Dose), 
  suppressWarnings(as.numeric(InstructionLookup$Dose)), 
  if_else(
    grepl(FirstRegex,InstructionLookup$Dose), 
    suppressWarnings(as.numeric(sub(FirstRegex,"\\1",InstructionLookup$Dose))),
    NA
  )
)
InstructionLookup$DoseHigh <- if_else(
  grepl(OnlyRegex,InstructionLookup$Dose), 
  suppressWarnings(as.numeric(InstructionLookup$Dose)), 
  if_else(
    grepl(LastRegex,InstructionLookup$Dose), 
    suppressWarnings(as.numeric(sub(LastRegex,"\\1",InstructionLookup$Dose))),
    NA
  )
)

InstructionLookup$DailyLow <- InstructionLookup$DoseLow * InstructionLookup$FreqLow
InstructionLookup$DailyHigh <- InstructionLookup$DoseHigh * InstructionLookup$FreqHigh