message('# Patch instruction lookup');
message('Creates a dataframe `PatchInstructionLookup` with columns:');
message('  - Instruction - instruction e.g. "APPLY ONE EVERY 3 DAYS"')
message('  - PatchInterval - e.g. 24 means every 24 hours, 96 means every 96 hours')
message('  - NumberOfPatchesPerUse - number of patches to use - normally 1')
message('Example output')
message('  | Instruction            | PatchInterval   | NumberOfPatchesPerUse |')
message('  | ---------------------- | --------------- | --------------- |')
message('  | APPLY ONE EVERY 3 DAYS | 72              | 1               |')
message('  | APPLY 1 WEEKLY         | 168             | 1               |')
message('  | APPLY Two EVERY 72 HRS | 72              | 2               |')


# create the dose lookup
PatchInstructionLookup <- data.frame()

# Things where we will have to use the opioid to determine the duration (e.g. fentanyl=3 and bupre = 7 days)
rbind(PatchInstructionLookup,c(NA,NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("patch",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("AS DIRECTED",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("patch(es)",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("pat",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY HALF AS DIRECTED ",NA,0.5))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY AS DIRECTED",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ASD",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY AS DIRECTED ",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY AS DIRECTED ALONGSIDE 25MCG PATCH (TOTAL DOSE 75MCG )",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED.  APPLY ON SAME DAY AS 25MCG PATCH.  FOR PAIN RELIEF",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH IN ADDITION TO THE 75MCG PATCH",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TODAY",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("PLEASE USE BUTEC BRAND",NA,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("as directed",NA,1))->PatchInstructionLookup


# These have an interval and a patch number (or assumed to be just one)
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO DRY - NON IRRITATED -  NON HAIRY SKIN ON UPPER TORSO. REMOVE AFTER SEVEN DA",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO A CLEAN -  DRY -   HAIRLESS PART OF UPPER BODY OR UPPER ARM EVERY 72 HOURS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 every 72 hours",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE  EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY THREE DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE FRESH PATCH EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH TO BE APPLIED EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY  ONE WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PAT1CH ONCE EVERY 7 DAYS (REMOVE THE OLD ONE)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH PER 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH CHANGE EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO PATCHES EVERY 3 DAYS",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. APPLY WITH OTHER 10MCG PATCH. TOTAL DOSE 15MCG",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH APPLED EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY THREE PATCHES EXACTLY AS DIRECTED. REMOVE AFTER 72 HOURS AND REPLACE WITH THREE NEW ",72,3))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH APPLIED EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("one every 72 hours",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERT 3 DAYS (8AM)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE FRESH PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 3 DAYS TOPICALLY",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH TO BE APPLIED EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EXACTLY AS DIRECTED TO CONTROLPAIN.  REMOVE AFTER 7 DAYS AND REPLACE WITH ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE EVERY 72 HOURS -  ROTATING THE SITE",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY THREE DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH ONCE A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE EVERY 3 DAYS USE WITH THE 25 MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EXACTLY AS DIRECTED. REMOVE AFTER 72 HOURS AND REPLACE WITH A NEW PATCH ON",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. AVOID EXPOSING PATCH TO HEAT ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 3 DAYS TTS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (15MCG IN TOTAL)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE  WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TOTAL DOSE IS 30MCG/HR)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS THEN BOOK REVIEW  WITH G.P. TO DISCUSS INCREASING STRENG",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 FRESH PATCH EVERY 72 HOURS FOR PAIN",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 4 DAYS ",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE FRESH PATCH ONCE A WEEK ( REMOVE OLD PATCH)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ON A MONDAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY THREE PATCHES TO A CLEAN -  DRY -   HAIRLESS PART OF UPPER BODY OR UPPER ARM EVERY 72 HO",72,3))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TO BODY EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (PLESE REMOVE THE OLD ONE)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS TOPICALLY",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO A CLEAN AREA OF SKIN AND CHANGE EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO EVERY 3 DAYS",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 patch every 3 days",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 WEEKLY WITH 10MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONCE WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE FRESH PATCH EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS  (TOTAL DOSE 15MCG)  (IP  FEB 15)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TOTAL DOSE 15MCG)  (IP  FEB 15)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS AT 6PM",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE WEEKLY (TOTAL DOSE IS 30MCG/HR)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TO BODY EVERY 3 DAYS.( TOTAL DOSE WILL BE 37 mCG/HOUR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE WEEKLY  ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONCE WEEKLY (FRIDAY)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE ON FRIDAY ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO PATCHES ONCE EVERY 7 DAYS",168,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY PATCH ONCE A WEEK (AFTER REMOVED 4 DAY PATCH)- THIS LASTS 3 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY PATCH ONCE A WEEK (LAST FOR 4 DAYS)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("every 72 hours",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 72 HOUR",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE NEW PATCH EVERY 4 DAYS (THIS IS 4 WEEKS SUPPLY OF BUPRENORPHINE)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH  WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED EVERY 3 DAYS FOR PAIN",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 2 PATCHES EVERY 3 DAYS",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 EVERY 72 HOURS TOPICALLY",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. DISCARD DAMAGED PATCHES -  DO NOT APPLY HEAT TO SITE OF P",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH ONCE A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 (SEVENTY-TWO) HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 HRS. ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH/72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 2 PATCHES TOGETHER EACH WEEK",168,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EXACTLY AS DIRECTED. REMOVE AFTER 72 HOURS AND REPLACE WITH A NEW PATCH AT",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO CHEST OR UPPER ARM CHANGE EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY  WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (6PM)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS -  ON SUNDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY THREE EVERY 3 DAYS",72,3))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TOTAL DOSE 15MCG) (IP FEB 15) ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ALONG WITH 10MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 WEEKLY  /  FOUR PATCHES",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TO BODY EVERY 3 DAYS.( TOTAL DOSE WILL BE 37 MCG/HOUR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH PER SEVENTY TWO HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY FRESH PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 HOURS.   REMOVE PREVIOUS PATCH BEFORE APPLYING A NEW ONE AND USE ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 6 DAYS ( AS PER SPECIALIST )",144,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ON A TUESDAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS AT 6PM",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS IN CONJUNCTION WITH THE 75MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 72 HOURS AS DIRECTED",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (IP JUNE 15)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ON A THURSDAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("2 PATCHES EVERY 3 DAYS",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 72 HOURS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS  (OPC  FEB 16)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE WEEKLY-WITH 10MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH APPLIED TO THE SKIN EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EACH WEEK AS DIRECTED",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1PER 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("25MICROGRAM/HR - EVERY THREE DAYS (MORNING)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY   1    WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ( TOTAL OF 62MCG HR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TOTAL 15MCG)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY NEW PATCH EVERY 72 HOUR AS DIRECTED",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED EVERY WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EACH WEEK (REMOVE THE OLD ONE)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 2 DAYS",48,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ON MONDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO A CLEAN DRY HAIRLESS PART OF UPPER BODY/ARM EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO SKIN AND REPLACE PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO UPPER ARM OR CHEST. CHANGE PATCH EVERY 72 HOURS USING A DIFFERENT SITE",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO PATCHES ONCE EVERY 7 DAYS (TOTAL DOSE IS 40MCG/HR)",168,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("apply to body every 3 days",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH TO BE APPLIED EVERY THREE DAYS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH TO BE APPLIED WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY  one patch WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY A NEW PATCH EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL DOSE 37MCGS)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS -  PLEASE SUPPLY 5 (FIVE ) PATCHES",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS AS DIRECTED",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 3 DAYS AT 6PM",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE ONE PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PER 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE  PATCH AND CHANGE EVERY 4 DAYS AT 6PM",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE  PATCH WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH /72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EACH  WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY THREE DAYS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS AT 6PM  (IP  MAR 16)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ON WEDNESDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS.DESTROY DAMAGED PATCHES -  DO NOT APPLY HEAT TO THE PATCH ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO THE SKIN CHANGE EVERY 7 DAYS ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH WEEKLY (ON A FRIDAY)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO NEW PATCH EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY  1   WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS AS DIR",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS FOR FOR PAIN",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH 12MCG PATCHES",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ON WEDNESDAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS AT 6PM ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TWICE A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("Apply once weekly (friday)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 72HOURS -  THEN REMOVE AND REPLACE WITH A NEW PATCH.  FOR FOR PAIN CONTROL",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 EVRY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY  1    WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS TOPICALLY ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 2 NEW PATCHES EVERY 72 HOURS",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 3 DAYS WITH 12 PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 3 DAYS WITH 50 PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 96 HOURS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE  EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED EVERY 3 DAYS PAIN",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (62.5MG)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TO HELP CONTROL FOR FOR PAIN",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TO HELP PAIN AND SOB",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY TWO DAYS",48,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH /48 HOURS",48,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY THREE DAY",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE A WEEK -  ON SUNDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS  (IP  AUG 16)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ALONG WITH A 10MCG/HR PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ALONG WITH A 5MCG/HR PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS SAT",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO DRY NON HAIRY SKIN ON UPER TORSO. REPLACE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE EVERY 7 DAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("USE ONE PATCH EVERY FOUR DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 48 HOURS",48,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE  EVERY 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE  PATCH TO CHEST OR UPPER ARM CHANGE PATCH EVERY 72 HOURS USING A DIFFERENT SITE",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH AND CHANGE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 HRS. PLEASE CALL FOR A REVIEW OF THIS MEDICATION JAN 2017  Notes ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE A WEEK ON WEDNESDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS WITH 10MCG PATCH(TOTAL DOSE 15MCG) ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. DO NOT TAKE CODEINE WITH THIS MEDICATION",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TO BODY EVERY 3 DAYS FOR SEVERE BACK PAINS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("one patch every 72 hours",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 EVERY 3 DAYS FOR PAIN",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 every 72 hrs",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 every 72hrs",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1PER 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY   1       WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED. CHANGING PATCH EVERY 3 DAYS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL 62 MICROGRAMS)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH THE 25CMG TO MAKE A TOTAL OF 37MCG",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH  EACH WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS WITH A 20MCG PATCH. BOTH PATCHES TO BE APPLIED ON THE SA",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. AVOID SAME AREA FOR THREE WEEKS. AVOID HEAT TO THE AREA",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO SKIN AND REPLACE PATCH EVERY 72 HOURS (6PM)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO SKIN CHANGE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE WEEKLY ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE PATCH EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY THREE DAYS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("apply one patch /72 hours",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c(" 1EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH CHANGE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS TOPICALLY IN ADDITION TO THE 25MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH WITH 75 PATCH  EVERY 3 DAYS TOPICALLY",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1/2 PATCH EVERY 3 DAYS",72,0.5))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY  72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL DOSE 37MCG/HR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL DOSE 62 MICROGRAMS/HOUR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL DOSE= 37MCG)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS BUT CAN INCREASE TO 2 PATCHES EVERY 3 DAYS IF NEEDED",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY SEVENTY TWO HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS  ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TRIAL UNTIL REVIEW)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS -  ON TUESDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS WITH 5MCG PATCH (TOTAL DOSE 15MCG)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("Apply One Patch Each Week As Directed",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("Apply one patch every 72 hrs",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY THREE DAYS AT 6PM",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 7 DAYS AS DIRECTED BY FOR PAIN CLINIC -  ALONG WITH 10 MCH/HR PATCH.",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH PER 72 HOURS ( FIVE PATCHES )",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH TO BE APPLIED EVERY THREE DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PER 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 every 3 days",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH ONCE EVERY 7 DAYS WITH 10MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH ONCE EVERY 7DAYS ON TORSO",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY AS DIRECTED EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECT -  EVERY 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED EVERY 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS  (IP  JAN 16)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS  (TOTAL DAILY DOSE 37MCG)  (IP  DEC 14)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS  STOP ALL OXYCODONE MEDICATION",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ( TOTAL OF 37MCG/HR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (ALONG WITH 12MICROGRAM PATCH MAKING TOTAL DOSE 37MCG EVERY 3 DAYS)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (PRESCRIPTION FOR WEEK 2)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL DAILY DOSE 37MCG)  (IP  DEC 14)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ALONG WITH THE 25MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS AS PER FOR PAIN CLINIC (THIS IS INSTEAD OF OXYCONTIN)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TOTAL DOSE =37",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH 25MCG PATCH ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS |(TOTAL 37 MCG HR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS. PLEASE REMOVE THE OLD PATCH BEFORE REPLACING A NEW ONE",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE FRESH PATCH EVERY 3 DAYS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE OR  2  PATCH ONCE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY (3) THREE DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 3 DAYS (TOTAL 37MCG) (DOSE INCREASED) (OP MAY 18)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY FOUR DAYS AT 6PM",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EXACTLY AS DIRECTED FOR PAIN. REMOVE AFTER EXACTLY  7  FULL DAYS AND REPLA",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (DOSE INCREASED OP FEB 18)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TOTAL DOSE 15MCG) (IP DEC 12)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TOTAL DOSE 15MCH WEEKLY) (IP DEC 12)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS.  DISCARD DAMAGED PATCHES -  DO NOT APPLY HEAT TO SITE OF ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. (TOTAL DOSE IS 15MCG/HOUR",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. ROTATING SITE",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO SKIN AND REPLACE EVERY 72 HOURS (6 PM)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE RVERY THREE DAYS AT 6 PM",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE WEEKLY -  TO BE CHANGED EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 3 DAYS (6 P.M.)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONCE WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONCE WEEKLY ON A FRIDAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 72 HOURS -  THEN REMOVE AND REPLACE WITH A NEW PATCH. FOR FOR PAIN CONTROL  ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH PER WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PER WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1PER 3DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1PER 3DAYS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 WEEKLY WITH 5MCG",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY A FRESH PATCH EVERY 72 HOURS (FOR PAIN)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY AS DIRECTED EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY WEEK.",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY FRESH PATCH EVERY 72 HOURS TO BE USED WITH 12MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY FRESH PATCH EVERY 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY NEW PATCH EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS  (IP SEPT 14)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS  (OPC AUG 13)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS  Instalments: Not a weekly item",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (FENTANYL PATCH)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (PLUS A 12MCG PATCH)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (PRESCRIPTION FOR WEEK 1)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS -  PLEASE DON'T SUPPLY MATRIFEN PATCHES",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ALONG WITH THE 12MCG PATCH TO TOTAL 37MCG",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS AT 6PM (IP MAY 14)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TO REPLACE THE 25MG STRENGTH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TOTAL DOSE 37MCG",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TOTAL=37",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH 100MCG PATCH  (TOTAL DAILY DOSE 150MCG)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH 12MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH 50MCG PATCH (TOTAL DAILY DOSE 150MCG)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS. TO BE USED WITH 25MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH AND CHANGE WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 HOURS (3 DAYS) FOR FOR PAIN RELIEF",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 HOURS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY THREE DAY ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY THREE DAYS TOPICALLY WITH 50MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ( USE 30MCG IN TOTAL)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TOTAL DOSE IS 30MCG/HR) ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS AS PER MCMILLAN NURSE",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS WITH 10MCG PATCHES",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS WITH BUTEC 5CMG",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS {TOTAL 15MCG/HOUR}",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS( AS PER SPECIALIST )INCREASED FROM 5",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. AVOID EXPOSURE TO HEAT ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH WEEKLY FOR HIP PAIN",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE WEEKLY.  TOTAL 15MCG/HR",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY WEEKLY 1 PATCH EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("Apply One Patch Each Week As Directed. Remove Old Patch Before Applying New Patch",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE PATCH ONCE WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY THREE DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY SEVENTY TWO HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVRY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("apply topically every 72 hours",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c(" APPLY ONE PATCH EVERY THREE DAYS-WHEN WEARING THE PATCH DO NOT EXPOSE TO DIRECT HEAT AND ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH APPLIED EVERY 3 DAY FOR FOR PAIN",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EACH WEEK (15MCG IN TOTAL)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERY 72 HOURS : TOTAL DOSE 225 MICROGRAMMES/HOUR",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1PER 72HRS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS TOPICALLY IN ADDITION TO 25MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS TOPICALLY WITH 25MCG",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS TOPICALLY WITH 50 MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 72HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH ONCE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCHES EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 TOPICALLY EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 2 EVERY 3 DAYS",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 2 PATCHES EVERY 3 DAYS  Instalments: can only tolerate 50mcg patches x 2",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 2 WEEKLY",168,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY A FRESH PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONCE A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONCE A WEEK FOR FOR PAIN",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE  PATCH AND CHANGE EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE  PATCH CHANGE EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED CHANGE AFTER 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE CHANGE EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAY WITH 12MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS  (IP  FEB 15)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ( PLEASE REMOVE OLD PATCH BEFORE ADDING NEW PATCH)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (DISCONTINUE 12MCG PATCH AND REPLACE WITH THIS)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (IN ADDITION TO 12MCGT PATCH SO TOTAL DOSE IS 37MCG)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (IN ADDITION TO 25MCG PATCH SO TOTAL DOSE IS 37MCG)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL 37MCG- 2 PATCHES)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL 62MCG/HR) (OP APR 17)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL DOSE 37 MICROGRAMS/HOUR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL DOSE 62MCG)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL DOSE=62MCG/HOUR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL DOSE=62MCG/HR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ALONGSIDE 12MICROGRAM PATCH (TOTAL 37MICROGRAM)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ALONGSIDE 25MICROGRAM PATCH (TOTAL 37 MICROGRAM",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS AS PER FOR PAIN CLINIC",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS AS PER RECOMMENDATION BY CHRISTIE HOPSITAL",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS IN ADDITION TO 25MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS INSTEAD OF LONG ACTING OXYCODONE",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS OR BREAKTHROUGH ORAMORPH DOSE 30MG",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TO MAKE A TOTAL OF 62 MICROGRAMS PER HOUR",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TOTAL 37 MCG/HR",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH 100MCG",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS. PLEASE REPLACE OLD PATCH BEFORE ADDING A NEW ONE",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS. REMOVE PATCH IF FEVER OR TEMPERATURE",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 48 HOURS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 72 HOURS (3 DAYS)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 72HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY SEVEN DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY THREE DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EXACTLY AS DIRECTED FOR PAIN CONTROL. REMOVE AFTER 72 HOURS AND REPLACE WITH A N",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH  A WEEK 6PM",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH  EVERY 3 DAYS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EACH WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 1 WEEK (MON 18.00HR)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 3 DAYS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 7 DAYS (FOUR PATCHES)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 72 HOURS WITH 25MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY FOUR DAYS (8AM) AS DIRECTED",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EXACTLY AS DIRECTED FOR PAIN RELIEF. REMOVE EVERY 72 HOURS AND REPLACE WIT",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE  WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE A WEEK (6PM)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ( 2 PATCHES TO BRING IN LINE FOR DISPENSING)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ( IP JUNE14)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (15MCG IN TOTAL) ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (GP WILL REVIEW ON NEXT HOME ROUND)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (ON THURSDAYS)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TOTAL 15MCG/HOUR)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (TOTAL DOSE 25 MICROGRAMS)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS **REVIEW WITH GP**",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS -  ON MONDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS - THURSDAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS AS REQUIRED ALONG WITH 10 MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS IN ADDITION TO THE 10MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS TO MAKE DOSE OF 15 MCG WITH 5 MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS WITH 5MCG PATCH (TOTAL DOSE 15MCG) ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS.  TOTAL PATCH DOSE NOW 15MCG/HOUR",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. DO NOT EXPOSE PATCH TO HEAT ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH PER SEVENTY TWO HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO THE SKIN AND LEAVE IN  PLACE FOR 72 HURS AS DIRECTED",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE TO BODY EVERY 3 DAYS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY PATCH TO DRY SKIN ON UPPER BODY. ONE NEW PATCH 7 DAYS THEN REMOVE",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO  EVERY 3 DAYS",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO  PATCH TO CHEST OR UPPER ARM CHANGE PATCH EVERY 72 HOURS USING A DIFFERENT SITE",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO AS DIRECTED CHANGE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO PATCHES TO CHEST OR UPPER ARM CHANGE EVERY 72 HOURS- TOTAL 225",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY WEEKLY  MITTE ONCE A MONTH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPYL 1 AS DIRECTED -  CHANGE EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("Apply one patch every 72 hours",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE ONCE EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 3 DAYS AT 6PM",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 72 HOURS AS DIRECTED",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONCE A WEEK 6PM",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONCE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY 3  DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY 72 HOURS WITH 25MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH / 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 72 HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY SEVENTY TWO HOURS ( FIVE PATCHES)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH PER WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH PER WEEK (TAKING 15MCG WEEKLY)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("USE 1 PATCH FOR FOR PAIN EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("apply one (1) 100mcg patch every 72 hours",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c(" APPLY EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c(" APPLY ONE PATCH EVERY THREE DAYS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c(" ONE TO BE APPLIED EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH APPLEID EVERY 3 DAYS FOR PAIN",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERY 7 DAYS IN ADDITION TO 10MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERY 72 HOURS IN ADDITION TO 50MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERY 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH EVERY WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PATCH TO BE APPLIED EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PER 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1 PER 72HRS.OA",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("1PER   72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("2 PATCHES EVERY 7 DAYS  ",168,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY   1     WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY  1      WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY  1 PATCH WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY  ONE PATCH EVERY THREE DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 EACH WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS TOPICALLY (WITH 25 MICROGRAM PATCH)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS TOPICALLY IN ADDITION TO THE 25MCG PATCH ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 3 DAYS TOPICALLY WITH 50MCG MATRIFEN PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 7 DAYS (CHANGE EVERY WEDNESDAY)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 1 PATCH EVERY 7 DAYS (WEDNESDAY)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY 2 PATCH EVERY THREE DAYS",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY AS DIRECTED EVERY 72 HRS - please make an appointment to discuss your pain medicatio",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 3 DAYS AT 6PM",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY EVERY 7 DAYS- CHANGE EVERY DAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY FRESH PATCH EVERY 72 HOUR AS DIRECTED",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY FRESH PATCH EVERY 72 HOURS ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY FRESH PATCH EVERY 72HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY NEW PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY NEW PATHC EVERY 72HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONCE A WEEK FOR FOR PAIN RELIEF -  IN ADDITION TO 10MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE ADDITIONAL PATCH ONCE EVERY 7 DAYS IN THE 2 WEEKS LEADING UP TO INJECTIONS. SO T",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AND CHANGE EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED APPLY 1 A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED CHANGE EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE AS DIRECTED-1PER WEEK.",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAY S",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS  (IP  AUG 14)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS  (TOTAL 62MCG EVERY THREE DAYS)    (IP  JAN 16)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ( IN ADDITION TO THE 75MICROGRAM PATCH)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ( TOTAL OF 62.5MCG HR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ( TOTAL OF 62.5MCG? HR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (1 MONTH SUPPLY AT PHARMACY REQUEST)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (72 HOURS)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (CHANGE AT 6PM)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (FOR PAIN)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (IN PLACE OF MATRIFEN)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (INSTEAD OF USING OXYCONTIN MR) ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (IP MAR 13)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (NOT TO BE USED WITH 12MCG PATCH)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (PAIN CLINIC JUNE 15 -  TO REPLACE ZOMORPH)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (PRESCRIPTION FOR 1 WEEK)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL 62MCG EVERY THREE DAYS)  (IP  JAN 16)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (TOTAL 62MCG/HR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS (USE ALONGSIDE WITH 50MCG/HOUR PATCHES TO MAKE 75MCG/HOUR)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS -  DOSE CAN BE INCREASED AS NECESSARY (CAN USE 2 PATCHES IF NEEDED)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS -  SEE GP NEXT TIME AS THIS ITEM IS NOT ON REPEATS AS PRESCRIBED BY T",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS -  TOTAL DOSE 125MICROGRAMS -  PLEASE TAKE 1/2 DAILYT SUPPLY MATRIFEN P",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ALONG WITH 25MCG PATCH ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ALONG WITH 50MICROGRAM PATCH (TOTAL DAILY DOSE 62MICROGRAM)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS ALONGSIDE 25MICROGRAM PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS AS PER CHRISTIES",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS FOR 2 WEEKS AS PER HOSPITAL",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS FOR 3 WEEKS THEN STOP AS PER CHRISTIE HOSPITAL ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS FOR 4 WEEKS THEN REDUCE BY 25MCG",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS FOR PAIN (NOTE TOTAL STRENGTH IS 37MCG/HR SINCE WILL APPLY 25MCG PA",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS FOR PAIN RELIEF",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS IN ADDITION TO  50MCG PATCH (TEMPORARY INCREASE)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS IN ADDITION TO 12MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS OR NOTE INCREASED DOSE -  PLEASE ONLY USE ONE PATCH AT A TIME",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TO BODY FOR PAIN RELIEF",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TO DRY SKIN UPPER ARMS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TO GIVE A TOTAL OF 37MICROGRAMS/HOUR",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS TOGETHER WITH 50MCG AND 100MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH 100MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH ONE 20MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS WITH THE 75MCG PATCH TO MAKE A TOTAL OF 100MCG",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS--DOSE REDUCED ADVISED BY HOSPITAL",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS.  USE AS ADDITIONAL PATCH TO REGULAR ONES FOR A WEEK FOR EXTRA FOR ",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS. ANY DAMAGED PATCHES WILL N EED TO BE RETURNED TO THE PHARMACY IF R",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS. ANY DAMAGED PATCHES WILL NEED TO BE RETURNED TO THE PHARMACY IF RE",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS. PLEASE REMEMBER TO REMOVE OLD PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS.FENTANYL PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3 DAYS/72 HOURS. BRANDED FENTANYL PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 3.5 DAYS",84,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY 72 HORUS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EVERY FOUR DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE EXACTLY AS DIRECTED FOR FOR PAIN. REMOVE AFTER 72 HOURS AND REPLACE WITH A NEW P",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE NEW PATCH EVERY 4 DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE NEW PATCH EVERY 4 DAYS- THIS IS 4 WEEKS SUPPLY",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH  EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH  EVERY 3 DAYS AT 6PM",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 24 HOURS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 3 DAYS FOR FOR PAIN RELIEF",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 3DAYS -  SEE DR JEET IF WANT ANYMORE",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY 5 DAYS",120,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY NIGHT SKIN AND CHANGE EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY THREE DAYS ALTERNATE WITH 75 MCG PATCH",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EVERY WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EXACTLY AS DIRECTED FOR FOR PAIN CONTROL EVERY  72 HOURS .  REMOVE OLD PAT",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EXACTLY AS DIRECTED FOR PAIN CONTROL. REMOVE AFTER 72 HOURS AND REPLACE WI",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EXACTLY AS DIRECTED FOR PAIN CONTROL. REMOVE AFTER EXACTLY 7 DAYS AND REPL",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH EXACTLY AS DIRECTED FOR PAIN RELIEF. REMOVE AFTER 72 HOURS AND REPLACE WIT",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE  A WEEK -  ON TUESDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE A WEEK -  ON TUESDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE A WEEK ON SATURDAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS  (IP  JAN 18) ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ( APPLY FIRST PATCH ON WEDNESDAY 24/2/16 -  TAKE USUAL MOR",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (30MCG TOTAL AS PER MACMILLAN TEAM)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (6PM MONDAYS)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (6PM) ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (APPLY TO DRY -  HAIRLESS PATCH OF SKIN. ROTATE PATCH APPL",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (BRANDED VERSION OF BUPRENORPHINE PATCH)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (INSTEAD OF THE 10 MIICROGRAM PATCH)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (IP JAN 18)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (IP JUN 13)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (ON A WEDNESDAY)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (ONE PATCH ISSUED UNTIL GP REVIEW FRIDAY)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (PLEASE DISCUSS WITH GP IF YOU FOUND THIS PATCH HELPFUL)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS (SHORTFALL)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS -  CAN BE PLACED ON ARM OR THIGH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS -  IN ADDITION TO 20MCG PATCHES",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS - DO NOT TAKE CODEINE WITH THIS PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS AND CHANGE TO VERSATIS WHEN THESE ARE AVAILABLE",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS DO NOT TAKE CODEINE",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS FOR FOR PAIN",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS FOR NEXT 4 WEEKS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS FOR PAIN",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS FOR PAIN RELIEF.  YOU MUST AVOID HOT BATHS AND NOT DO NO",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS IN ADDITION TO BUTRANS 10 PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS ON TORSO",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS OR REMOVE THE OLD PATCH AND THEN APPLY THE NEW ONE OR NO",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS OR STOP LONGTEC",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS OR TRIAL",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS SO INTOTAL ON 15MCG",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS TO AREA ON UPPER TORSO",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS TOGETHER WITH 20MCG BUTRANS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS WITH 10MCG",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS WITH 10MCG PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS- NOTE BUTEC HAS NOW BEEN INCREASED TO 10 MICROGRAMS TO A",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS-AS DIRECTED",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS-INCREASED AS DIRECTED",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. AVOID PUTTING PATCH ON SAME AREA FOR 3 WEEKS.",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. AVOID SAME AREA FOR THREE WEEKS. AVOID HEAT TO AREA OF ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. CAN BE INCREASED TO 2 PATCHES AFTER A WEEK IF NEED.",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. PLEASE SUPPLY FOUR (4) PATCHES",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. REMOVE AND REPLACE EACH PATCH EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. REMOVE OLD PATCH BEFORE APPLYING A NEW ONE",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS. TOTAL DOSE 25MCG",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 DAYS.BUPRENORPHINE PATCH",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY 7 ON A TUESDAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH ONCE EVERY WEEK OR CHANGE ON MONDAY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH PER SEVENTY TWO HOURS (5PATCHES)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH TO CHEST OR UPPER ARM -  CHANGE EVERY 72 HOURS- TOTAL 225MCG/HR",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH WEEKLY ON MONDAYS AT 6PM",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCH WEEKLY ON THURSDAYS AT 6PM",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE PATCHE CHANGING EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY ONE WEEKLY  ADDITINAL",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY PATCH EVERY 3  DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY PATCH EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY PATCH TO DRY SKIN ON UPPER BODY. APPLY ONE NEW PATCH EVERY 7 DAYS THEN REMOVE.",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY THREE  PATCH TO CHEST OR UPPER ARM CHANGE PATCH EVERY 72 HOURS USING A DIFFERENT SIT",72,3))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TO SKIN REPLACE PATCH EVERY 72 HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO EVERY 3 DAYS NOTE NEW STRENTGH",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO PATCHES  EVERY 3 DAYS",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO PATCHES  ONCE EVERY 7 DAYS",168,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO PATCHES INITIALLY. WILL NEED CHANGING AFTER 72 HOURS. IF ALL OK REDUCE DOSE TO 1",72,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY TWO PATCHS ONCE EVERY 7 DAYS (TOTAL DOSE=40 MICROGRAMS/HR) ",168,2))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY WEEKLY. SEE ENCLOSED INTRUCTIONS EVERY NIGHT HOW TO APPLY.",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLY one patch weekly",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("APPLYone weekly",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("Apply ONE patch ONCE every 7 days",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("Apply One Patch Each Week As Directed. Remove Old Patch Before Applying New Patch Notes fo",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE EVERY 72HRS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE EVERY FOUR DAYS",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("CHANGE ONCE EVERY 3 DAYS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 4 DAYS OR NOT TO TAKE WITH ORAL MORPHINE",96,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("EVERY 7 DAYS APPLY TO NON HAIRY -  DRY SKIN ON UPPER TORSO AND REPLACE IN DIFFERENT AREA - A",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONCE A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONCE A WEEK (6PM)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONCE A WEEK (WEDNESDAYS)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY  7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE EVERY 72 HOUR",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH APPLIED EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 7 DAYS",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 7 DAYS ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 72HOURS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY 72HOURS.",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH EVERY SEVENTY TWO HOURS( FIVE  PATCHES)",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH PER WEEK FOLLOW MACMILAN NURSE INSTRUCTION ",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH TO BE APPLIED ONCE PER WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PATCH TO BE APPLIED ONCE WEEKLY BY THE DISTRICT NURSES",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("ONE PER WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("TAKE ONE EVERY 3 DAYS",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("USE ONE A WEEK",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("USE ONE PATCH ONCE AFTER USE OF 5MCG AFTER WEEK ONE",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("WEEKLY",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("WEEKLY ( FRIDAYS)",168,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("apply 1 patch every 3 days",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("change patch every 72 hours",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("every 3 days",72,1))->PatchInstructionLookup
rbind(PatchInstructionLookup,c("one patch every 72hrs",72,1))->PatchInstructionLookup

colnames(PatchInstructionLookup) <- c("Instruction","PatchInterval","NumberOfPatchesPerUse")
PatchInstructionLookup$PatchInterval = as.numeric(PatchInstructionLookup$PatchInterval)
PatchInstructionLookup$NumberOfPatchesPerUse = as.numeric(PatchInstructionLookup$NumberOfPatchesPerUse)
