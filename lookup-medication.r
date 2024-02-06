# create the dose lookup
MedicationLookup <- data.frame()
 
# Build up the lookup. Columns are:
# - Medication description
# - Active ingredient
# - IsOpioid?
# - StrengthInMilligrams (in tablet form, or per millilitre if in liquid form)
# - Form (tablet/suppository/injection etc.)
# - Route (oral/injection/topical etc.)
# - MMEFactor - morphine milligram equivalent (MME) conversion factors

# codeine
# medicationname == "codeine" & route == "im" ~ "0.15"
# medicationname == "codeine" & route == "oral" ~ "0.15"
# medicationname == "codeine" & route == "oral/im" ~ "0.15"
# medicationname == "codeine" & route == "enteral_feeding_tube" ~ "0.15"
rbind(MedicationLookup,c("codeine (15mg/5ml) linctus sugar free","codeine",TRUE,3,"oral-solution","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("codeine (25mg/5ml) oral solution","codeine",TRUE,5,"oral-solution","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("codeine injection","codeine",TRUE,NA,"injection","injection",0.15))->MedicationLookup
rbind(MedicationLookup,c("codeine multi-route","codeine",TRUE,NA,"multi","unknown",0.15))->MedicationLookup
rbind(MedicationLookup,c("codeine tablets","codeine",TRUE,NA,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("codeine","codeine",TRUE,NA,"unknown","unknown",0.15))->MedicationLookup

# morphine (set the MME factor to 1 - then need to change some to 3 later on)
# medicationname == "morphine" & route == "iv_infusion" ~ "3.0"
# medicationname == "morphine" & route == "iv_slow_injection" ~ "3.0"
# medicationname == "morphine" & route == "iv_continuous_infusion" ~ "3.0"
# medicationname == "morphine" & route == "sc" ~ "1.0"
# medicationname == "morphine" & route == "im" ~ "1.0"
# medicationname == "morphine" & route == "sc_continuous_infusion" ~ "1.0"
# medicationname == "morphine" & route == "oral" ~ "1.0"
rbind(MedicationLookup,c("morphine  oral solution (10mg/5ml)","morphine",TRUE,2,"oral-solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine  tablets [sevredol]","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine (100mg/5ml) concentrate oral solution sugar free","morphine",TRUE,20,"oral-solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine (10mg/5ml) oral solution","morphine",TRUE,2,"oral-solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine (1mg/ml) preservative free injection","morphine",TRUE,1,"injection","injection",1))->MedicationLookup
rbind(MedicationLookup,c("morphine (30mg/30ml) infusion","morphine",TRUE,1,"injection","injection",1))->MedicationLookup
rbind(MedicationLookup,c("morphine (60mg/60ml) infusion","morphine",TRUE,1,"injection","injection",1))->MedicationLookup
rbind(MedicationLookup,c("morphine [mst continus] modified-release tablets","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine [mxl] modified-release capsules","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine [sevredol] tablets","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine [zomorph] modified-release capsules","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine conc. oral solution (100mg/5ml)","morphine",TRUE,20,"oral-solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine epidural injection [depodur]","morphine",TRUE,NA,"injection","injection",1))->MedicationLookup
rbind(MedicationLookup,c("morphine i/r tablets [sevredol]","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine injection","morphine",TRUE,NA,"injection","injection",1))->MedicationLookup
rbind(MedicationLookup,c("morphine m/r  capsules [zomorph]","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine m/r  tablets [mst]","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine m/r capsules [mxl]","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine m/r capsules [zomorph]","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine m/r tablets [mst]","morphine",TRUE,NA,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine oral unit dose vial (10mg/5ml)","morphine",TRUE,2,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("morphine preservative free injection","morphine",TRUE,NA,"injection","injection",1))->MedicationLookup
rbind(MedicationLookup,c("morphine sulfate (1mg/ml) infusion","morphine",TRUE,1,"injection","injection",1))->MedicationLookup
rbind(MedicationLookup,c("morphine sulphate (1mg/ml) infusion","morphine",TRUE,1,"injection","injection",1))->MedicationLookup
rbind(MedicationLookup,c("morphine suppositories","morphine",TRUE,NA,"suppository","rectal",1))->MedicationLookup

# oxycodone (set the MME factor to 1.5 - then need to change some to 3 later on)
# medicationname == "oxycodone" & route == "sc" ~ "3.0"
# medicationname == "oxycodone" & route == "sc_continuous_infusion" ~ "3.0"
# medicationname == "oxycodone" & route == "im" ~ "3.0",
# medicationname == "oxycodone" & route == "iv_slow_injection" ~ "1.5"
# medicationname == "oxycodone" & route == "iv_continuous_infusion" ~ "1.5"
# medicationname == "oxycodone" & route == "oral" ~ "1.5"
# medicationname == "oxycodone" & route == "enteral_feeding_tube" ~ "1.5"
rbind(MedicationLookup,c("oxycodone  liquid (5mg/5ml)","oxycodone",TRUE,1,"oral solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone (1mg/ml) infusion","oxycodone",TRUE,1,"injection","injection",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone (50mg/50ml) infusion","oxycodone",TRUE,1,"injection","injection",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone capsules [oxynorm]","oxycodone",TRUE,NA,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone concentrate liquid (50mg/5ml)","oxycodone",TRUE,10,"oral solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone immediate  release capsules","oxycodone",TRUE,NA,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone immediate  release concentrated liquid (50mg/5ml)","oxycodone",TRUE,10,"oral-solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone immediate  release liquid (5mg/5ml)","oxycodone",TRUE,1,"oral-solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone immediate release (50mg/5ml) concentrate oral solution sugar free","oxycodone",TRUE,10,"oral-solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone immediate release (5mg/5ml) oral solution sugar free","oxycodone",TRUE,1,"oral-solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone immediate release capsules","oxycodone",TRUE,NA,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone injection","oxycodone",TRUE,NA,"injection","injection",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone liquid (5mg/5ml)","oxycodone",TRUE,1,"oral solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone m/r tablets [oxycontin]","oxycodone",TRUE,NA,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone modified-release tablets","oxycodone",TRUE,NA,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone prolonged release tablets","oxycodone",TRUE,NA,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("~oxycodone  liquid (5mg/5ml)","oxycodone",TRUE,1,"oral solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("~oxycodone concentrate liquid (50mg/5ml)","oxycodone",TRUE,10,"injection","injection",1.5))->MedicationLookup
rbind(MedicationLookup,c("~oxycodone immediate release capsules","oxycodone",TRUE,NA,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("~oxycodone prolonged release tablets [reltebon]","oxycodone",TRUE,NA,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("oxycodone prolonged release tablets [reltebon]","oxycodone",TRUE,NA,"tablet","oral",1.5))->MedicationLookup

# fentanyl
# medicationname == "fentanyl" & route == "sc" ~ "130.0"
# medicationname == "fentanyl" & route == "iv_infusion" ~ "130.0"
# medicationname == "fentanyl" & route == "iv_continuous_infusion" ~ "130.0"
# medicationname == "fentanyl" & route == "iv_slow_injection" ~ "130.0"
# medicationname == "fentanyl" & route == "sc_continuous_infusion" ~ "130.0"
# medicationname == "fentanyl" & route == "oral" ~ "130.0"
# medicationname == "fentanyl" & route == "sublingual" ~ "130.0"
# medicationname == "fentanyl" & route == "topical" ~ "100.0"
rbind(MedicationLookup,c("fentanyl (20microgram/ml) infusion","fentanyl",TRUE,0.02,"injection","injection",130))->MedicationLookup
rbind(MedicationLookup,c("fentanyl injection","fentanyl",TRUE,NA,"injection","injection",130))->MedicationLookup
rbind(MedicationLookup,c("fentanyl lozenge [actiq]","fentanyl",TRUE,NA,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("fentanyl lozenges","fentanyl",TRUE,NA,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("fentanyl patch [durogesic]","fentanyl",TRUE,NA,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("fentanyl patch","fentanyl",TRUE,NA,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("fentanyl s/l tablet (abstral)","fentanyl",TRUE,NA,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("fentanyl sublingual tablets sugar free","fentanyl",TRUE,NA,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("fentanyl transdermal patches","fentanyl",TRUE,NA,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("levobupivacaine (0.125%) with fentanyl 2microgram/ml epidural infusion","fentanyl",TRUE,0.002,"injection","injection",130))->MedicationLookup
rbind(MedicationLookup,c("levobupivacaine (0.125%) with fentanyl 4microgram/ml epidural infusion","fentanyl",TRUE,0.004,"injection","injection",130))->MedicationLookup

# tramadol
#medicationname == "tramadol" & route == "oral" ~ "0.1"
rbind(MedicationLookup,c("tramadol capsules","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol m/r [dromadol sr]","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol m/r [zamadol sr]","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol m/r [zydol sr]","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol m/r [zydol xl]","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol m/r capsules","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol m/r tablets","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol modified-release capsules","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol modified-release tablets","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol modified-release tablets/capsules","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol soluble tablets","tramadol",TRUE,NA,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("tramadol","tramadol",TRUE,NA,"unknown","unknown",0.1))->MedicationLookup


# co-codamol
#medicationname == "co-codamol" & route == "sc" ~ "0.15"
#medicationname == "co-codamol" & route == "oral" ~ "0.15"
rbind(MedicationLookup,c("co-codamol (30/500mg) effervescent tablets","co-codamol",TRUE,30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("co-codamol (30/500mg) tablets","co-codamol",TRUE,30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("co-codamol (30/500mg)","co-codamol",TRUE,30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("co-codamol (8/500mg) effervescent tablets","co-codamol",TRUE,8,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("co-codamol (8/500mg) tablets","co-codamol",TRUE,8,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("co-codamol (8/500mg)","co-codamol",TRUE,8,"tablet","oral",0.15))->MedicationLookup

# buprenorphine
# medicationname == "buprenorphine" & route == "sublingual" ~ "30.0"
# medicationname == "buprenorphine" & route == "topical" ~ "75.0"
rbind(MedicationLookup,c("buprenorphine patch (butrans)","buprenorphine",TRUE,NA,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("buprenorphine patch [transtec]","buprenorphine",TRUE,NA,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("buprenorphine sublingual tablets sugar free","buprenorphine",TRUE,NA,"tablet","oral",30))->MedicationLookup
rbind(MedicationLookup,c("buprenorphine tablets","buprenorphine",TRUE,NA,"tablet","oral",30))->MedicationLookup
rbind(MedicationLookup,c("buprenorphine transdermal patches","buprenorphine",TRUE,NA,"patch","topical",75))->MedicationLookup

# dihydrocodeine
# medicationname == "dihydrocodeine" & route == "oral" ~ "0.25"
# medicationname == "dihydrocodeine" & route == "enteral_feeding_tube" ~ "0.25"
rbind(MedicationLookup,c("dihydrocodeine (10mg/5ml) oral solution","dihydrocodeine",TRUE,2,"oral-solution","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dihydrocodeine m/r","dihydrocodeine",TRUE,NA,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dihydrocodeine modified-release tablets","dihydrocodeine",TRUE,NA,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dihydrocodeine tablets","dihydrocodeine",TRUE,NA,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dihydrocodeine","dihydrocodeine",TRUE,NA,"unknown","unknown",0.25))->MedicationLookup

# diamorphine
# medicationname == "diamorphine" & route == "iv_slow_injection" ~ "3.0"
# medicationname == "diamorphine" & route == "sc" ~ "3.0"
# medicationname == "diamorphine" & route == "sc_continuous_infusion" ~ "3.0"
# medicationname == "diamorphine" & route == "im" ~ "3.0"
rbind(MedicationLookup,c("diamorphine injection","diamorphine",TRUE,NA,"injection","injection",3))->MedicationLookup
rbind(MedicationLookup,c("diamorphine intrathecal injection","diamorphine",TRUE,NA,"injection","injection",3))->MedicationLookup

# hydromorphone
#medicationname == "hydromorphone" & route == "oral" ~ "4.0"
rbind(MedicationLookup,c("hydromorphone capsules","hydromorphone",TRUE,NA,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("hydromorphone m/r capsules","hydromorphone",TRUE,NA,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("hydromorphone modified-release capsules","hydromorphone",TRUE,NA,"tablet","oral",4))->MedicationLookup

# meptazinol
# medicationname == "meptazinol" & route == "oral" ~ "0.02"
# medicationname == "meptazinol" & route == "enteral_feeding_tube" ~ "0.02"
rbind(MedicationLookup,c("meptazinol tablets","meptazinol",TRUE,NA,"tablet","oral",0.02))->MedicationLookup
rbind(MedicationLookup,c("meptazinol","meptazinol",TRUE,NA,"unknown","unknown",0.02))->MedicationLookup

# pethidine
#medicationname == "pethidine" & route == "oral" ~ "0.1"
rbind(MedicationLookup,c("pethidine injection","pethidine",TRUE,NA,"injection","injection",0.1))->MedicationLookup
rbind(MedicationLookup,c("pethidine tablets","pethidine",TRUE,NA,"tablet","oral",0.1))->MedicationLookup

# non opioids
rbind(MedicationLookup,c("17-hydroxyprogesterone","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("apomorphine (30mg/3ml) pre-filled syringe","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("apomorphine (50mg/10ml) pre-filled syringe","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("apomorphine (50mg/5ml) injection","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("apomorphine injection","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("apomorphine","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("braltus zonda inhaler (tiotropium 10microgram/capsule)","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("hydroxyproline (/creat.ratio - urine)","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium  autohaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium  inhaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium  inhaler:","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium  nebules","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium aerocaps","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium autohaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium bromide (20micrograms/dose) cfc free inhaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium bromide (20micrograms/dose) cfc free inhaler:","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium bromide (21micrograms/dose) nasal spray","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium bromide 20 micrograms/metered inhaler (paed)","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium bromide inhaler paed","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium bromide nebules (paed)","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium inhaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium nasal spray (0.03%)","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("ipratropium nebules","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("medroxyprogesterone acetate","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("medroxyprogesterone tablets","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("name","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("oxitropium autohaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("oxitropium inhaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("salbutamol 2.5mg / ipratropium 500micrograms nebules","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("salbutamol/ipratropium nebs (2.5/0.5mg)","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("tiotropium (18microgram/capsule) handihaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("tiotropium (2.5micrograms/dose) cfc free respimat inhaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("tiotropium 10microgram/capsule zonda inhaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("tiotropium [braltus] zonda (10micrograms/capsule) inhaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("tiotropium [spiriva] handihaler (18micrograms/capsule) inhaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("tiotropium [spiriva] respimat (2.5micrograms/dose) cfc free inhaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("tiotropium handihaler","",FALSE,NA,NA,NA,0))->MedicationLookup
rbind(MedicationLookup,c("tiotropium respimat","",FALSE,NA,NA,NA,0))->MedicationLookup

# Excluding PCA and "recovery only" codes - by setting the IsOpioid flag to FALSE
rbind(MedicationLookup,c("morphine sulphate (1mg/ml) pca","morphine",FALSE,1,"injection","injection",0))->MedicationLookup
rbind(MedicationLookup,c("morphine sulfate (1mg/ml) pca","morphine",FALSE,1,"injection","injection",0))->MedicationLookup
rbind(MedicationLookup,c("fentanyl (20micrograms/ml) pca","fentanyl",FALSE,0.02,"injection","injection",0))->MedicationLookup

rbind(MedicationLookup,c("morphine injection (recovery only)","morphine",FALSE,NA,"injection","injection",0))->MedicationLookup
rbind(MedicationLookup,c("oxycodone injection (recovery only)","oxycodone",FALSE,NA,"injection","injection",0))->MedicationLookup
rbind(MedicationLookup,c("fentanyl injection (recovery only)","fentanyl",FALSE,NA,"injection","injection",0))->MedicationLookup

colnames(MedicationLookup) <- c("MedicationName", "OpioidName", "IsOpioid", "StrengthInMilligrams", "Form", "Route", "MMEFactor")
MedicationLookup$StrengthInMilligrams <- as.numeric(MedicationLookup$StrengthInMilligrams)
MedicationLookup$MMEFactor <- as.numeric(MedicationLookup$MMEFactor)
MedicationLookup$IsOpioid <- MedicationLookup$IsOpioid == 'TRUE'
MedicationLookup$Form <- as.factor(MedicationLookup$Form)
MedicationLookup$Route <- as.factor(MedicationLookup$Route)
#summary(MedicationLookup)
#head(MedicationLookup)