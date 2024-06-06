message('# Medication lookup')
message('Creates a dataframe `MedicationLookup` with columns:')
message('  - ClinicalCode - the clinical code')
message('  - MedicationName - the full medication description')
message('  - Frequency - the number of occurrences in the original dataset')
message('  - Active ingredient - the opioid name (e.g. codeine, morphine, fentanyl etc) or "" if not an opioid')
message('  - StrengthInMilligrams - if in tablet form, or mg/millilitre if in liquid form, or mcg per hour for patches')
message('  - Form - e.g. tablet/suppository/injection etc.')
message('  - Route - e.g. oral/injection/topical etc.')
message('  - MMEFactor - morphine milligram equivalent (MME) conversion factors\n')
# create the dose lookup
MedicationLookup <- data.frame()

# Codeine
# medicationname == "codeine" & route == "oral" ~ "0.15"

rbind(MedicationLookup,c("dj42.","CODEINE PHOSPHATE 30mg tablets",12974,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("COTA3334","Codeine Phosphate  Tablets  30 mg",4392,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dj41.","CODEINE PHOSPHATE 15mg tablets",4166,"codeine",15,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("COTA3333","Codeine Phosphate  Tablets  15 mg",1206,"codeine",15,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dj43.","CODEINE PHOSPHATE 60mg tablets",675,"codeine",60,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dj44.","CODEINE PHOSPHATE 25mg/5mL syrup",223,"codeine",5,"oral solution","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("COTA3335","Codeine Phosphate  Tablets  60 mg",51,"codeine",60,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("COSY3337","Codeine Phosphate  Syrup  25 mg/5 ml",9,"codeine",5,"oral solution","oral",0.15))->MedicationLookup

# morphine (set the MME factor to 1 - then need to change some to 3 later on)
# IGNORING injections so no need to update some to 3 later on
# medicationname == "morphine" & route == "iv_infusion" ~ "3.0"
# medicationname == "morphine" & route == "iv_slow_injection" ~ "3.0"
# medicationname == "morphine" & route == "iv_continuous_infusion" ~ "3.0"
# medicationname == "morphine" & route == "sc" ~ "1.0"
# medicationname == "morphine" & route == "im" ~ "1.0"
# medicationname == "morphine" & route == "sc_continuous_infusion" ~ "1.0"
# medicationname == "morphine" & route == "oral" ~ "1.0"

rbind(MedicationLookup,c("djzl.","ZOMORPH 60mg m/r capsules",1830,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djz4.","MORPHINE SULFATE 10mg m/r tablets",884,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djz1.","MORPHINE SULFATE 10mg tablets",809,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djz6.","MORPHINE SULFATE 30mg m/r tablets",605,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djz3.","MORPHINE SULFATE 5mg m/r tabs",348,"morphine",5,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djz2.","MORPHINE SULFATE 20mg tablets",230,"morphine",20,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/24687EMIS","Morphine Sulfate  M/R tablets  5 mg",227,"morphine",5,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/18037EMIS","Morphine Sulfate  M/R tablets  10 mg",170,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djz7.","MORPHINE SULFATE 60mg m/r tablets",133,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzL.","MORPHINE SULFATE 50mg tablets",96,"morphine",50,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djz5.","MORPHINE SULFATE 15mg m/r tablets",55,"morphine",15,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/20361EMIS","Morphine Sulfate  M/R tablets  15 mg",53,"morphine",15,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOTA1894","Morphine Sulfate  M/R tablets  30 mg",35,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOTA1892","Morphine Sulfate  Tablets  10 mg",28,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOTA1895","Morphine Sulfate  M/R tablets  60 mg",18,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djz8.","MORPHINE SULFATE 100mg m/r tablets",12,"morphine",100,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOTA9216EMIS","Morphine Sulfate  Tablets  20 mg",12,"morphine",20,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOS/9215EMIS","Morphine Sulfate  M/R tablets  200 mg",1,"morphine",200,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djyA.","MORPHGESIC SR 10mg m/r tablets",520,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/15327NEMIS","Morphgesic Sr  M/R tablets  10 mg",430,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djyC.","MORPHGESIC SR 60mg m/r tablets",376,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djyB.","MORPHGESIC SR 30mg m/r tablets",163,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/15328NEMIS","Morphgesic Sr  M/R tablets  30 mg",156,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/15329NEMIS","Morphgesic Sr  M/R tablets  60 mg",89,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djyD.","MORPHGESIC SR 100mg m/r tabs",44,"morphine",100,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/15330NEMIS","Morphgesic Sr  M/R tablets  100 mg",4,"morphine",100,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MSTA1904","Mst Continus  M/R tablets  30 mg",124,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MSM/24685EMIS","Mst Continus  M/R tablets  5 mg",119,"morphine",5,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MSTA1902","Mst Continus  M/R tablets  10 mg",80,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MSM/20359EMIS","Mst Continus  M/R tablets  15 mg",66,"morphine",15,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MSTA1905","Mst Continus  M/R tablets  60 mg",15,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzm.","ZOMORPH 100mg m/r capsules",470,"morphine",100,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzM.","SEVREDOL 50mg tablets",18,"morphine",50,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("SETA9219EMIS","Sevredol  Tablets  10 mg",8,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("SETA9220EMIS","Sevredol  Tablets  20 mg",2,"morphine",20,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzD.","MORPHINE SULFATE 10mg m/r capsules",1299,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzE.","MORPHINE SULFATE 30mg m/r capsules",589,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/2011NEMIS","Morphine Sulfate  M/R capsules  30 mg",185,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzF.","MORPHINE SULFATE 60mg m/r capsules",137,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/2010NEMIS","Morphine Sulfate  M/R capsules  10 mg",104,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzO.","MORPHINE SULFATE 90mg m/r capsules",22,"morphine",90,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzG.","MORPHINE SULFATE 100mg m/r capsules",6,"morphine",100,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/2012NEMIS","Morphine Sulfate  M/R capsules  60 mg",4,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOM/2013NEMIS","Morphine Sulfate  M/R capsules  100 mg",1,"morphine",100,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("ZOM/31466EMIS","Zomorph  M/R capsules  10 mg",1141,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("ZOM/31469EMIS","Zomorph  M/R capsules  30 mg",384,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("ZOM/31470EMIS","Zomorph  M/R capsules  60 mg",91,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzn.","ZOMORPH 200mg m/r capsules",74,"morphine",200,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("ZOM/31468EMIS","Zomorph  M/R capsules  200 mg",2,"morphine",200,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("ZOM/31467EMIS","Zomorph  M/R capsules  100 mg",1,"morphine",100,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MXM/28909EMIS","Mxl  M/R capsules  120 mg",21,"morphine",120,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MXM/28913EMIS","Mxl  M/R capsules  60 mg",21,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzT.","MXL 60mg m/r capsules",15,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzS.","MXL 30mg m/r capsules",10,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzU.","MXL 90mg m/r capsules",5,"morphine",90,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzW.","MXL 150mg m/r capsules",4,"morphine",150,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MXM/28910EMIS","Mxl  M/R capsules  150 mg",3,"morphine",150,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzX.","MXL 200mg m/r capsules",2,"morphine",200,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MXM/28911EMIS","Mxl  M/R capsules  200 mg",1,"morphine",200,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzj.","ZOMORPH 10mg m/r capsules",9687,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzk.","ZOMORPH 30mg m/r capsules",4767,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1z.","MST CONTINUS 15mg m/r tablets",550,"morphine",15,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1g.","MST CONTINUS 30mg m/r tablets",1753,"morphine",30,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1i.","MST CONTINUS 100mg m/r tablets",263,"morphine",100,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1f.","MST CONTINUS 10mg m/r tablets",2369,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1h.","MST CONTINUS 60mg m/r tablets",139,"morphine",60,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1s.","SEVREDOL 20mg tablets",753,"morphine",20,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1t.","MST CONTINUS 200mg m/r tablets",22,"morphine",200,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1r.","SEVREDOL 10mg tablets",1695,"morphine",10,"tablet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1y.","MST CONTINUS 5mg m/r tablets",869,"morphine",5,"tablet","oral",1))->MedicationLookup

rbind(MedicationLookup,c("djzs.","MORPHINE SULPHATE 20mg/mL oral solution",8,"morphine",20,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1l.","ORAMORPH 10mg/5mL liquid 100mL",7861,"morphine",2,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1L.","MORPHINE SULFATE 10mg/5mL oral solution",1072,"morphine",2,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1Z.","ORAMORPH 10mg/5mL soln 300mL",1280,"morphine",2,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOOR18040EMIS","Morphine Sulfate  Oral solution  10 mg/5 ml",786,"morphine",2,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("MOOR18041EMIS","Morphine Sulfate  Concentrated Oral Solution  20mg/ml (100mg/5ml) sugar free",5,"morphine",20,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("OROR9268BRIDL","Oramorph  Oral solution  10 mg/5 ml",1427,"morphine",2,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1F.","ORAMORPH 10mg/5mL oral unit dose vial",2,"morphine",2,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("OROR9270BRIDL","Oramorph Concentrated  Oral solution  20 mg/ml (100 mg/5 ml)",2,"morphine",20,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1o.","ORAMORPH CONCENTRATED 20mg/mL liquid 120mL",245,"morphine",20,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1..","MORPHINE SALTS(1) [CNS]",1118,"morphine",2,"oral solution","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1p.","ORAMORPH 10mg/5mL liquid 250mL",4,"morphine",2,"oral solution","oral",1))->MedicationLookup

rbind(MedicationLookup,c("dj1Q.","MORPHNE SULF 20mg/sch m/r gran",35,"morphine",20,"sachet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("djzA.","MORPHNE SULF 60mg/sch m/r gran",27,"morphine",60,"sachet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1R.","MORPHNE SULF 30mg/sch m/r gran",12,"morphine",30,"sachet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1X.","MST CONTINUS 100mg/sachet suspension",3,"morphine",100,"sachet","oral",1))->MedicationLookup
rbind(MedicationLookup,c("dj1P.","MST CONTINUS 30mg/sachet suspension",2,"morphine",30,"sachet","oral",1))->MedicationLookup

rbind(MedicationLookup,c("djzh.","MORPHINE SULFATE 50mg/50mL injection",1,"morphine",1,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("o451.","Morphine sulfate 10mg/1ml solution for injection ampoules",1825,"morphine",10,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("o453.","MORPHINE SULFATE 20mg/1mL injection",36,"morphine",20,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("dj14.","MORPHINE SULFATE [CNS] 30mg/1mL injection",32,"morphine",30,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("djyL.","MORPHINE SULFATE 10mg/10mL solution for injection",16,"morphine",1,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("djyK.","MORPHINE SULFATE 5mg/5mL solution for injection",5,"morphine",1,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("dj18.","MORPHINE SULFATE [CNS] 60mg/2mL injection",4,"morphine",30,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("djyJ.","MORPHINE SULFATE 1mg/1mL solution for injection",2,"morphine",1,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("o452.","Morphine sulfate 15mg/1ml solution for injection ampoules",1,"morphine",15,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("dj1O.","MORPHINE SULFATE 10mg/1mL prefilled syringe",24,"morphine",10,"injection","injection",NA))->MedicationLookup

# oxycodone (set the MME factor to 1.5 - then need to change some to 3 later on)
# IGNORING injections so no need to update some to 3 later on
# medicationname == "oxycodone" & route == "sc" ~ "3.0"
# medicationname == "oxycodone" & route == "sc_continuous_infusion" ~ "3.0"
# medicationname == "oxycodone" & route == "im" ~ "3.0",
# medicationname == "oxycodone" & route == "iv_slow_injection" ~ "1.5"
# medicationname == "oxycodone" & route == "iv_continuous_infusion" ~ "1.5"
# medicationname == "oxycodone" & route == "oral" ~ "1.5"
# medicationname == "oxycodone" & route == "enteral_feeding_tube" ~ "1.5"
rbind(MedicationLookup,c("OXCA2718NEMIS","Oxycodone Hydrochloride  Capsules  5 mg",43,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkt.","OXYCODONE HYDROCHLORIDE 5mg capsules",731,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkV.","LYNLOR 5mg capsules",2,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkY.","SHORTEC 5mg capsules",167,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("SHCA88043NEMIS","Shortec  Capsules  5 mg",17,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djk1.","OXYNORM 5mg capsules",620,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXCA2728NEMIS","OxyNorm  Capsules  5 mg",4,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/13063NEMIS","Oxycodone Hydrochloride  M/R tablets  5 mg",432,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/38379NEMIS","Oxycodone And Naloxone  M/R tablets  5 mg + 2.5 mg",1,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkj.","OXYCODONE HCL+NALOXONE HCL 5mg/2.5mg m/r tablets",2,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkq.","OXYCODONE HYDROCHLORIDE 5mg m/r tablets",2332,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkQ.","OXYLAN 5mg m/r tablets",5,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkp.","OXYCONTIN 5mg m/r tablets",1180,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/13064NEMIS","Oxycontin  M/R tablets  5 mg",104,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkL.","LONGTEC 5mg m/r tablets",1091,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LOM/74258NEMIS","Longtec  M/R tablets  5 mg",95,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkF.","TARGINACT 5mg/2.5mg m/r tabs",4,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmM.","ABTARD 5mg m/r tablets",35,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/101964NEMIS","Oxeltra  M/R tablets  5 mg",1,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmA.","OXELTRA 5mg m/r tablets",20,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkb.","RELTEBON 5mg m/r tablets",83,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("REM/89433NEMIS","Reltebon  M/R tablets  5 mg",126,"oxycodone",5,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/34441NEMIS","Oxycodone And Naloxone  M/R tablets  10 mg + 5 mg",4,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("TAM/34445NEMIS","Targinact  M/R tablets  10 mg + 5 mg",1,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXCA2719NEMIS","Oxycodone Hydrochloride  Capsules  10 mg",8,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djku.","OXYCODONE HYDROCHLORIDE 10mg capsules",489,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LYCA82073NEMIS","Lynlor  Capsules  10 mg",1,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkZ.","SHORTEC 10mg capsules",23,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("SHCA88044NEMIS","Shortec  Capsules  10 mg",1,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djk2.","OXYNORM 10mg capsules",354,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXCA2729NEMIS","OxyNorm  Capsules  10 mg",1,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/2665NEMIS","Oxycodone Hydrochloride  M/R tablets  10 mg",711,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkm.","OXYCODONE HYDROCHLORIDE+NALOXONE HYDROCHLORIDE 10mg/5mg m/r tablets",17,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkw.","OXYCODONE HYDROCHLORIDE 10mg m/r tablets",4136,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkR.","OXYLAN 10mg m/r tablets",2,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djk4.","OXYCONTIN 10mg m/r tablets",1964,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/2724NEMIS","Oxycontin  M/R tablets  10 mg",246,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkM.","LONGTEC 10mg m/r tablets",1183,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LOM/74259NEMIS","Longtec  M/R tablets  10 mg",288,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkC.","TARGINACT 10mg/5mg m/r tablets",11,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmN.","ABTARD 10mg m/r tablets",47,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/101965NEMIS","Oxeltra  M/R tablets  10 mg",1,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmB.","OXELTRA 10mg m/r tablets",9,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkc.","RELTEBON 10mg m/r tablets",15,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("REM/89436NEMIS","Reltebon  M/R tablets  10 mg",1,"oxycodone",10,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/48279NEMIS","Oxycodone Hydrochloride  M/R tablets  15 mg",65,"oxycodone",15,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkh.","OXYCODONE HYDROCHLORIDE 15mg m/r tablets",568,"oxycodone",15,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkH.","OXYCONTIN 15mg m/r tablets",343,"oxycodone",15,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/48283NEMIS","Oxycontin  M/R tablets  15 mg",2,"oxycodone",15,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmI.","LONGTEC 15mg m/r tablets",141,"oxycodone",15,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LOM/103629NEMIS","Longtec  M/R tablets  15 mg",114,"oxycodone",15,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/101966NEMIS","Oxeltra  M/R tablets  15 mg",37,"oxycodone",15,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djm7.","RELTEBON 15mg m/r tablets",5,"oxycodone",15,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("TAM/34444NEMIS","Targinact  M/R tablets  20 mg + 10 mg",1,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXCA2720NEMIS","Oxycodone Hydrochloride  Capsules  20 mg",25,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkv.","OXYCODONE HYDROCHLORIDE 20mg capsules",126,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djka.","SHORTEC 20mg capsules",2,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djk3.","OXYNORM 20mg capsules",736,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/2667NEMIS","Oxycodone Hydrochloride  M/R tablets  20 mg",226,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkl.","OXYCODONE HYDROCHLORIDE+NALOXONE HYDROCHLORIDE 20mg/10mg m/r tablets",3,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkx.","OXYCODONE HYDROCHLORIDE 20mg m/r tablets",2565,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djk5.","OXYCONTIN 20mg m/r tablets",692,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/2725NEMIS","Oxycontin  M/R tablets  20 mg",435,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkN.","LONGTEC 20mg m/r tablets",438,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LOM/74260NEMIS","Longtec  M/R tablets  20 mg",127,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkD.","TARGINACT 20mg/10mg m/r tabs",14,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmP.","ABTARD 20mg m/r tablets",23,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmD.","OXELTRA 20mg m/r tablets",5,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkd.","RELTEBON 20mg m/r tablets",44,"oxycodone",20,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/48280NEMIS","Oxycodone Hydrochloride  M/R tablets  30 mg",162,"oxycodone",30,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkg.","OXYCODONE HYDROCHLORIDE 30mg m/r tablets",628,"oxycodone",30,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkI.","OXYCONTIN 30mg m/r tablets",210,"oxycodone",30,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/48284NEMIS","Oxycontin  M/R tablets  30 mg",9,"oxycodone",30,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmJ.","LONGTEC 30mg m/r tablets",163,"oxycodone",30,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LOM/103635NEMIS","Longtec  M/R tablets  30 mg",30,"oxycodone",30,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmE.","OXELTRA 30mg m/r tablets",6,"oxycodone",30,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djm8.","RELTEBON 30mg m/r tablets",35,"oxycodone",30,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("TAM/38382NEMIS","Targinact  M/R tablets  40 mg + 20 mg",1,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/2668NEMIS","Oxycodone Hydrochloride  M/R tablets  40 mg",168,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djki.","OXYCODONE HCL+NALOXONE HCL 40mg/20mg m/r tablets",3,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djky.","OXYCODONE HYDROCHLORIDE 40mg m/r tablets",1033,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djk6.","OXYCONTIN 40mg m/r tablets",823,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/2726NEMIS","Oxycontin  M/R tablets  40 mg",13,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkO.","LONGTEC 40mg m/r tablets",105,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LOM/74261NEMIS","Longtec  M/R tablets  40 mg",2,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkG.","TARGINACT 40mg/20mg m/r tabs",15,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmF.","OXELTRA 40mg m/r tablets",13,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djm1.","RELTEBON 40mg m/r tablets",7,"oxycodone",40,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/48281NEMIS","Oxycodone Hydrochloride  M/R tablets  60 mg",12,"oxycodone",60,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkf.","OXYCODONE HYDROCHLORIDE 60mg m/r tablets",58,"oxycodone",60,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkJ.","OXYCONTIN 60mg m/r tablets",175,"oxycodone",60,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmK.","LONGTEC 60mg m/r tablets",17,"oxycodone",60,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LOM/103643NEMIS","Longtec  M/R tablets  60 mg",6,"oxycodone",60,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/2672NEMIS","Oxycodone Hydrochloride  M/R tablets  80 mg",4,"oxycodone",80,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkz.","OXYCODONE HYDROCHLORIDE 80mg m/r tablets",251,"oxycodone",80,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djk7.","OXYCONTIN 80mg m/r tablets",315,"oxycodone",80,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/2727NEMIS","Oxycontin  M/R tablets  80 mg",1,"oxycodone",80,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkP.","LONGTEC 80mg m/r tablets",24,"oxycodone",80,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LOM/74262NEMIS","Longtec  M/R tablets  80 mg",3,"oxycodone",80,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djke.","OXYCODONE HYDROCHLORIDE 120mg m/r tablets",140,"oxycodone",120,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkK.","OXYCONTIN 120mg m/r tablets",3,"oxycodone",120,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXM/48286NEMIS","Oxycontin  M/R tablets  120 mg",4,"oxycodone",120,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djmL.","LONGTEC 120mg m/r tablets",6,"oxycodone",120,"tablet","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("LOM/103644NEMIS","Longtec  M/R tablets  120 mg",6,"oxycodone",120,"tablet","oral",1.5))->MedicationLookup

rbind(MedicationLookup,c("OXIN15522NEMIS","Oxycodone Hydrochloride  Injection  10 mg/ml, 1 ml ampoule",83,"oxycodone",10,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("OXIN15523NEMIS","Oxycodone Hydrochloride  Injection  10 mg/ml, 2 ml ampoule",16,"oxycodone",10,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("djkn.","OXYCODONE HYDROCHLORIDE 10mg/mL injection solution 2mL ampoule",57,"oxycodone",10,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("djko.","OXYCODONE HYDROCHLORIDE 10mg/mL injection solution 1mL ampoule",417,"oxycodone",10,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("djkA.","OXYNORM 10mg/mL injection solution 1mL ampoule",42,"oxycodone",10,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("OXIN15524NEMIS","OxyNorm  Injection  10 mg/ml, 1 ml ampoule",2,"oxycodone",10,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("OXSO37221NEMIS","Oxycodone Hydrochloride  Solution for injection  50 mg/ml, 1 ml ampoule",20,"oxycodone",50,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("djkk.","OXYCODONE HYDROCHLORIDE 50mg/1mL soln for injection ampoules",19,"oxycodone",50,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("djkE.","OXYNORM 50mg/1mL solution for injection ampoules",4,"oxycodone",50,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("OXSO37222NEMIS","OxyNorm  Solution for injection  50 mg/ml, 1 ml ampoule",1,"oxycodone",50,"injection","injection",NA))->MedicationLookup

rbind(MedicationLookup,c("OXSO2721NEMIS","Oxycodone Hydrochloride  Solution  Sugar Free 5 mg/5 ml",1410,"oxycodone",1,"oral solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djkr.","OXYCODONE HYDROCHLORIDE 5mg/5mL sugar free liquid",4379,"oxycodone",1,"oral solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXSO2732NEMIS","OxyNorm  Oral solution  5 mg/5 ml (1 mg/1 ml)",53,"oxycodone",1,"oral solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("OXSO2722NEMIS","Oxycodone Hydrochloride  Concentrated Oral Solution  Sugar Free 10 mg/ml",8,"oxycodone",10,"oral solution","oral",1.5))->MedicationLookup

# djks. seems to correspond to two different formulations - 5mg/5ml, or 10mg/ml. The Codeunits suggest that this is correct. E.g. 
# - for the 5mg/5ml the dosages given are often small e.g. 1-5mg which would be <= 0.5ml if it was the stronger formulation
# - for the 5mg/5ml you sometimes get instructions like "TAKE 10mg (10ml)"
# - for the 10mg/ml most dosages say something like "15mg (1.5ml)"
# - so we link this ReadCode to the most frequent rubric (5mg/5ml) but later on correct the other Rubrics by changing their readcode to
#   the made up "djks.ALTERNATIVE"
rbind(MedicationLookup,c("djks.","Oxycodone 5mg/5ml oral solution sugar free",3273,"oxycodone",1,"oral solution","oral",1.5))->MedicationLookup
rbind(MedicationLookup,c("djks.ALTERNATIVE","Oxycodone 10mg/ml oral solution sugar free",1,"oxycodone",10,"oral solution","oral",1.5))->MedicationLookup

rbind(MedicationLookup,c("OXSO2731NEMIS","OxyNorm Concentrate  Solution  10 mg/ml",5,"oxycodone",10,"oral solution","oral",1.5))->MedicationLookup

# fentanyl
# medicationname == "fentanyl" & route == "sc" ~ "130.0"
# medicationname == "fentanyl" & route == "iv_infusion" ~ "130.0"
# medicationname == "fentanyl" & route == "iv_continuous_infusion" ~ "130.0"
# medicationname == "fentanyl" & route == "iv_slow_injection" ~ "130.0"
# medicationname == "fentanyl" & route == "sc_continuous_infusion" ~ "130.0"
# medicationname == "fentanyl" & route == "oral" ~ "130.0"
# medicationname == "fentanyl" & route == "sublingual" ~ "130.0"
# medicationname == "fentanyl" & route == "topical" ~ "100.0"

rbind(MedicationLookup,c("o42..","FENTANYL",1,"fentanyl",0.05,"oral solution","oral",130))->MedicationLookup                      #All have Rubric of Fentanyl 2.5mg/50ml solution for infusion vials

# medicationname == "fentanyl" & route == "topical" ~ "100.0"
rbind(MedicationLookup,c("o42R.","FENTANYL 12micrograms/hr patches",452,"fentanyl",0.012,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42S.","MATRIFEN 12micrograms/hr patches",2924,"fentanyl",0.012,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42Q.","DUROGESIC DTRANS 12micrograms/hr patches",95,"fentanyl",0.012,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o4dB.","FENCINO 12micrograms/hr patches",29,"fentanyl",0.012,"patch","topical",100))->MedicationLookup

rbind(MedicationLookup,c("o424.","FENTANYL 25micrograms/hr patches",437,"fentanyl",0.025,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42T.","MATRIFEN 25micrograms/hr patches",2971,"fentanyl",0.025,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42I.","DUROGESIC DTRANS 25micrograms/hr patches",195,"fentanyl",0.025,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42i.","FENTALIS RESERVOIR 25micrograms/hr patches",9,"fentanyl",0.025,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o4dC.","FENCINO 25micrograms/hr patches",47,"fentanyl",0.025,"patch","topical",100))->MedicationLookup

rbind(MedicationLookup,c("o4e3.","FENTANYL 37.5micrograms/hour transdermal patches",361,"fentanyl",0.0375,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o4e2.","MEZOLAR MATRIX 37.5micrograms/hour patches",1,"fentanyl",0.0375,"patch","topical",100))->MedicationLookup

rbind(MedicationLookup,c("o425.","FENTANYL 50micrograms/hr patches",448,"fentanyl",0.05,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42U.","MATRIFEN 50micrograms/hr patches",1534,"fentanyl",0.05,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42J.","DUROGESIC DTRANS 50micrograms/hr patches",222,"fentanyl",0.05,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42Z.","MEZOLAR MATRIX 50micrograms/hour patches",1,"fentanyl",0.05,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o4dD.","FENCINO 50micrograms/hr patches",16,"fentanyl",0.05,"patch","topical",100))->MedicationLookup

rbind(MedicationLookup,c("o426.","FENTANYL 75micrograms/hr patches",182,"fentanyl",0.075,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42V.","MATRIFEN 75micrograms/hr patches",768,"fentanyl",0.075,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42K.","DUROGESIC DTRANS 75micrograms/hr patches",42,"fentanyl",0.075,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42k.","FENTALIS RESERVOIR 75micrograms/hr patches",1,"fentanyl",0.075,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o4dE.","FENCINO 75micrograms/hr patches",28,"fentanyl",0.075,"patch","topical",100))->MedicationLookup

rbind(MedicationLookup,c("o427.","FENTANYL 100micrograms/hr patches",87,"fentanyl",0.1,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42W.","MATRIFEN 100micrograms/hr patches",804,"fentanyl",0.1,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o42L.","DUROGESIC DTRANS 100micrograms/hr patches",123,"fentanyl",0.1,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o4dF.","FENCINO 100micrograms/hr patches",51,"fentanyl",0.1,"patch","topical",100))->MedicationLookup
rbind(MedicationLookup,c("o4dm.","OSMANIL 100micrograms/hr patches",2,"fentanyl",0.1,"patch","topical",100))->MedicationLookup



rbind(MedicationLookup,c("o4d7.","ABSTRAL 100micrograms sublingual tablets",33,"fentanyl",0.1,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o42n.","EFFENTORA 200micrograms buccal tablets",2,"fentanyl",0.2,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o4d9.","ABSTRAL 200micrograms sublingual tablets",2,"fentanyl",0.2,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o42v.","FENTANYL 200micrograms lozenges",7,"fentanyl",0.2,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o42C.","ACTIQ 200micrograms lozenges",1,"fentanyl",0.2,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o4db.","ABSTRAL 300micrograms sublingual tablets",7,"fentanyl",0.3,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o4de.","FENTANYL 400micrograms sublingual tablets",1,"fentanyl",0.4,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o4d1.","EFFENTORA 400micrograms buccal tablets",33,"fentanyl",0.4,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o4dd.","ABSTRAL 400micrograms sublingual tablets",4,"fentanyl",0.4,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o42u.","FENTANYL 400micrograms lozenges",13,"fentanyl",0.4,"tablet","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o42D.","ACTIQ 400micrograms lozenges",4,"fentanyl",0.4,"tablet","oral",130))->MedicationLookup

rbind(MedicationLookup,c("o42x.","FENTANYL 100microgram/2mL injection",146,"fentanyl",0.05,"injection","injection",130))->MedicationLookup
rbind(MedicationLookup,c("o42y.","FENTANYL 500microgram/10mL injection",10,"fentanyl",0.05,"injection","injection",130))->MedicationLookup
rbind(MedicationLookup,c("o42z.","FENTANYL inj 100micrograms/2ml",2,"fentanyl",0.05,"injection","injection",130))->MedicationLookup

rbind(MedicationLookup,c("o4dA.","FENTANYL 400micrograms nasal spray",2,"fentanyl",0.4,"nasal spray","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o4dv.","FENTANYL 100micrograms/dose nasal spray",5,"fentanyl",0.1,"nasal spray","oral",130))->MedicationLookup
rbind(MedicationLookup,c("o4dy.","PECFENT 100micrograms/dose nasal spray",8,"fentanyl",0.1,"nasal spray","oral",130))->MedicationLookup

# tramadol
#medicationname == "tramadol" & route == "oral" ~ "0.1"
rbind(MedicationLookup,c("dicO.","TRAMACET 325mg/37.5mg tablets",115,"tramadol",37.5,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("dicY.","TRAMACET 325mg/37.5mg effervescent tablets",14,"tramadol",37.5,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("dicz.","PARACETAMOL+TRAMADOL HYDROCHLORIDE 325mg/37.5mg tablets",89,"tramadol",37.5,"tablet","oral",0.1))->MedicationLookup

rbind(MedicationLookup,c("dji2.","TRAMADOL HCL 50mg capsules",36673,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("dji4.","ZYDOL 50mg capsules",48,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djiE.","ZAMADOL 50mg capsules",56,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djiF.","TRAMADOL HYDROCHLORIDE 50mg m/r capsules",2079,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("TRCA24798EMIS","Tramadol Hydrochloride  Capsules  50 mg",6071,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("TRM/31613EMIS","Tramadol Hydrochloride  M/R capsules  50 mg",237,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("ZYCA24794EMIS","Zydol  Capsules  50 mg",20,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("ZAM/31605EMIS","Zamadol Sr  M/R capsules  50 mg",63,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djAb.","MAXITRAM SR 50mg m/r capsules",7,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djiC.","TRAMADOL HYDROCHLORIDE 50mg soluble tablets",116,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djiv.","TRAMADOL HYDROCHLORIDE 50mg m/r tablets",50,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djiw.","TRAMADOL HYDROCHLORIDE 50mg oro-dispersible tablets",125,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("TRM/26871NEMIS","Tramadol Hydrochloride  M/R tablets  50 mg",1,"tramadol",50,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("TROR16282NEMIS","Tramadol Hydrochloride  Orodispersible Tablets (Sugar Free)  50 mg",2,"tramadol",50,"tablet","oral",0.1))->MedicationLookup

rbind(MedicationLookup,c("djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",4895,"tramadol",100,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djiK.","ZAMADOL SR 100mg m/r capsules",4,"tramadol",100,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("TRM/31610EMIS","Tramadol Hydrochloride  M/R capsules  100 mg",536,"tramadol",100,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djAc.","MAXITRAM SR 100mg m/r capsules",101,"tramadol",100,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("dji5.","TRAMADOL HCL 100mg m/r tablets",779,"tramadol",100,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djim.","TRADOREC XL 100mg m/r tablets",1,"tramadol",100,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("TRM/27117EMIS","Tramadol Hydrochloride  M/R tablets  100 mg",188,"tramadol",100,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djAf.","MAROL 100mg m/r tablets",2,"tramadol",100,"tablet","oral",0.1))->MedicationLookup

rbind(MedicationLookup,c("djiH.","TRAMADOL HYDROCHLORIDE 150mg m/r capsules",906,"tramadol",150,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djir.","TRAMQUEL SR 150mg m/r capsules",1,"tramadol",150,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("dji6.","TRAMADOL HCL 150mg m/r tablets",3,"tramadol",150,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("TRM/27118EMIS","Tramadol Hydrochloride  M/R tablets  150 mg",19,"tramadol",150,"tablet","oral",0.1))->MedicationLookup

rbind(MedicationLookup,c("djiI.","TRAMADOL HYDROCHLORIDE 200mg m/r capsules",1015,"tramadol",200,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djiM.","ZAMADOL SR 200mg m/r capsules",7,"tramadol",200,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("TRM/31612EMIS","Tramadol Hydrochloride  M/R capsules  200 mg",11,"tramadol",200,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djAe.","MAXITRAM SR 200mg m/r capsules",99,"tramadol",200,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("dji7.","TRAMADOL HCL 200mg m/r tablets",6,"tramadol",200,"tablet","oral",0.1))->MedicationLookup
rbind(MedicationLookup,c("djiA.","ZYDOL SR 200mg m/r tablets",19,"tramadol",200,"tablet","oral",0.1))->MedicationLookup

rbind(MedicationLookup,c("djAi.","TRAMADOL 100mg/1mL oral drops solution",2,"tramadol",100,"oral solution","oral",0.1))->MedicationLookup

# co-codamol
#medicationname == "co-codamol" & route == "sc" ~ "0.15"
#medicationname == "co-codamol" & route == "oral" ~ "0.15"
rbind(MedicationLookup,c("dia2.","CO-CODAMOL 8mg/500mg tablets",12876,"codeine",8,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("diap.","CO-CODAMOL 8mg/500mg effervescent tablets",2939,"codeine",8,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("diaq.","CO-CODAMOL 8mg/500mg capsules",4295,"codeine",8,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("diaO.","CO-CODAPRIN 8mg/500mg dispersible tablets",1,"codeine",8,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dibn.","SOLPADEINE SOLUBLE effervescent tablets",10,"codeine",8,"tablet","oral",0.15))->MedicationLookup

rbind(MedicationLookup,c("dibQ.","PARACETAMOL+CODEINE PHOSPHATE 500mg/12.8mg tablets",10,"codeine",12.8,"tablet","oral",0.15))->MedicationLookup

rbind(MedicationLookup,c("diaT.","CODIPAR caplets 500mg + 15mg",491,"codeine",15,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dica.","CODIPAR 15mg/500mg effervescent tablets",21,"codeine",15,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dicv.","PARACETAMOL+CODEINE PHOSPHATE 500mg/15mg effervescent tablet",67,"codeine",15,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("diaU.","PARACETAMOL+CODEINE PHOSPHATE 500mg/15mg tablets",3345,"codeine",15,"tablet","oral",0.15))->MedicationLookup

rbind(MedicationLookup,c("dibv.","REMEDEINE tabs 20mg + 500mg",106,"codeine",20,"tablet","oral",0.15))->MedicationLookup

rbind(MedicationLookup,c("diam.","KAPAKE tabs 30mg + 500mg",162,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("diao.","KAPAKE caps 30mg + 500mg",287,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dibB.","PARACETAMOL+CODEINE PHOSPHATE 500mg/30mg effervescent tabs",3181,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dian.","PARACETAMOL+CODEINE PHOSPHATE 500mg/30mg tablets",1851,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dibD.","PARACETAMOL+CODEINE PHOSPHATE 500mg/30mg capsules",2500,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dibG.","TYLEX eff tab 500mg + 30mg",33,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dibt.","TYLEX caps 500mg + 30mg",547,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dibS.","SOLPADOL caps 500mg + 30mg",129,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dibu.","SOLPADOL eff tab 500mg + 30mg",671,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dibz.","SOLPADOL caplets 500mg + 30mg",108,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dibw.","REMEDEINE FORTE tabs 30mg + 500mg",262,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dic3.","ZAPAIN caplets 30mg + 500mg",29469,"codeine",30,"tablet","oral",0.15))->MedicationLookup
rbind(MedicationLookup,c("dic4.","Zapain Capsules 30 mg + 500 mg",12240,"codeine",30,"tablet","oral",0.15))->MedicationLookup

# buprenorphine
# medicationname == "buprenorphine" & route == "topical" ~ "75.0"
rbind(MedicationLookup,c("dj3A.","BUTRANS 5micrograms/hour patches",2675,"buprenorphine",0.005,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3W.","BUTEC 5micrograms/hour patches",901,"buprenorphine",0.005,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3o.","BUPRENORPHINE 5micrograms/hour patches",1317,"buprenorphine",0.005,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR21096NEMIS","Buprenorphine  Transdermal patches  5 micrograms/hour",212,"buprenorphine",0.005,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR21100NEMIS","Butrans  Transdermal patches  5 micrograms/hour",142,"buprenorphine",0.005,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR109530NEMIS","Butec  Transdermal patches  5 micrograms/hour",168,"buprenorphine",0.005,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3B.","BUTRANS 10micrograms/hour patches",1969,"buprenorphine",0.01,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3X.","BUTEC 10micrograms/hour patches",594,"buprenorphine",0.01,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3p.","BUPRENORPHINE 10micrograms/hour patches",764,"buprenorphine",0.01,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR21097NEMIS","Buprenorphine  Transdermal patches  10 micrograms/hour",98,"buprenorphine",0.01,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR21101NEMIS","Butrans  Transdermal patches  10 micrograms/hour",206,"buprenorphine",0.01,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR109531NEMIS","Butec  Transdermal patches  10 micrograms/hour",110,"buprenorphine",0.01,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3..","BUPRENORPHINE",257,"buprenorphine",0.015,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR110085NEMIS","Buprenorphine  Transdermal patches  15 micrograms/hour",11,"buprenorphine",0.015,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR121227NEMIS","Butec  Transdermal patches  15 micrograms/hour",29,"buprenorphine",0.015,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3C.","BUTRANS 20micrograms/hour patches",663,"buprenorphine",0.02,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3Y.","BUTEC 20micrograms/hour patches",170,"buprenorphine",0.02,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3q.","BUPRENORPHINE 20micrograms/hour patches",325,"buprenorphine",0.02,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR21098NEMIS","Buprenorphine  Transdermal patches  20 micrograms/hour",45,"buprenorphine",0.02,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR21102NEMIS","Butrans  Transdermal patches  20 micrograms/hour",172,"buprenorphine",0.02,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR109532NEMIS","Butec  Transdermal patches  20 micrograms/hour",45,"buprenorphine",0.02,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj39.","TRANSTEC 35micrograms/hour patches",117,"buprenorphine",0.035,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3t.","BUPRENORPHINE 35micrograms/hour patches",56,"buprenorphine",0.035,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("BUTR12901NEMIS","Buprenorphine  Transdermal patches  35 micrograms/hour",5,"buprenorphine",0.035,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("TRTR12905NEMIS","Transtec  Transdermal patches  35 micrograms/hour",23,"buprenorphine",0.035,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3a.","TRANSTEC 52.5micrograms/hour patches",87,"buprenorphine",0.0525,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3s.","BUPRENORPHINE 52.5micrograms/hour patches",56,"buprenorphine",0.0525,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("TRTR12906NEMIS","Transtec  Transdermal patches  52.5 micrograms/hour",11,"buprenorphine",0.0525,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3b.","TRANSTEC 70micrograms/hour patches",32,"buprenorphine",0.07,"patch","topical",75))->MedicationLookup
rbind(MedicationLookup,c("dj3r.","BUPRENORPHINE 70micrograms/hour patches",2,"buprenorphine",0.07,"patch","topical",75))->MedicationLookup

# medicationname == "buprenorphine" & route == "sublingual" ~ "30.0"
rbind(MedicationLookup,c("dj31.","TEMGESIC 200microgram sublingual tablets",41,"buprenorphine",0.2,"tablet","oral",30))->MedicationLookup
rbind(MedicationLookup,c("dj35.","BUPRENORPHINE 400microgram sublingual tablets",2,"buprenorphine",0.4,"tablet","oral",30))->MedicationLookup
rbind(MedicationLookup,c("dj3x.","BUPRENORPHINE 200microgram sublingual tablets",286,"buprenorphine",0.2,"tablet","oral",30))->MedicationLookup
rbind(MedicationLookup,c("BUTA437","Buprenorphine  Sublingual tablets  Sugar Free 200 micrograms",4,"buprenorphine",0.2,"tablet","oral",30))->MedicationLookup
rbind(MedicationLookup,c("SUSU23704NEMIS","Suboxone  Sublingual tablets  8 mg/2 mg",1,"buprenorphine",0.008,"tablet","oral",30))->MedicationLookup

# dihydrocodeine
# medicationname == "dihydrocodeine" & route == "oral" ~ "0.25"
# medicationname == "dihydrocodeine" & route == "enteral_feeding_tube" ~ "0.25"
rbind(MedicationLookup,c("dj81.","DIHYDROCODEINE 30mg tablets",4991,"dihydrocodeine",30,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("DITA909","Dihydrocodeine  Tablets  30 mg",1504,"dihydrocodeine",30,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dj88.","DIHYDROCODEINE 60mg m/r tabs",493,"dihydrocodeine",60,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dj8b.","DIHYDROCODEINE 90mg m/r tabs",183,"dihydrocodeine",90,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dj8c.","DIHYDROCODEINE 120mg m/r tabs",148,"dihydrocodeine",120,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dj8e.","DIHYDROCODEINE 40mg tablets",136,"dihydrocodeine",40,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("DITA912","Dihydrocodeine Tartrate  M/R tablets  60 mg",123,"dihydrocodeine",60,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dj82.","DIHYDROCODEINE 10mg/5mL elixir",9,"dihydrocodeine",2,"oral solution","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("DITA24211EMIS","Dihydrocodeine Tartrate  Tablets  40 mg",9,"dihydrocodeine",40,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dia6.","CO-DYDRAMOL (dihydrocodeine & paracetamol) tabs 10mg+500mg",7924,"dihydrocodeine",10,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dj8d.","DF118 FORTE 40mg tablets",249,"dihydrocodeine",40,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dj8a.","DHC CONTINUS 120mg m/r tablets",122,"dihydrocodeine",120,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dj87.","DHC CONTINUS 60mg m/r tablets",24,"dihydrocodeine",60,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("DHTA855","Dhc Continus  M/R tablets  60 mg",1,"dihydrocodeine",60,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dibF.","PARACETAMOL+DIHYDROCOCEINE TARTRATE 500mg/30mg tablets",158,"dihydrocodeine",30,"tablet","oral",0.25))->MedicationLookup
rbind(MedicationLookup,c("dibE.","PARACETAMOL+DIHYDROCODEINE TARTRATE 500mg/20mg tablets",88,"dihydrocodeine",20,"tablet","oral",0.25))->MedicationLookup

# diamorphine
# medicationname == "diamorphine" & route == "iv_slow_injection" ~ "3.0"
# medicationname == "diamorphine" & route == "sc" ~ "3.0"
# medicationname == "diamorphine" & route == "sc_continuous_infusion" ~ "3.0"
# medicationname == "diamorphine" & route == "im" ~ "3.0"
rbind(MedicationLookup,c("dj72.","DIAMORPHINE 5mg injection",2,"diamorphine",5,"injection-oneoff","injection",3))->MedicationLookup
rbind(MedicationLookup,c("dj73.","DIAMORPHINE 10mg injection",2,"diamorphine",10,"injection-oneoff","injection",3))->MedicationLookup
rbind(MedicationLookup,c("DIIN3418","Diamorphine Hydrochloride  Injection  100mg/amp",1,"diamorphine",100,"injection-oneoff","injection",3))->MedicationLookup
rbind(MedicationLookup,c("DIIN3419","Diamorphine Hydrochloride  Injection  10mg/amp",1,"diamorphine",10,"injection-oneoff","injection",3))->MedicationLookup
rbind(MedicationLookup,c("DIIN3420","Diamorphine Hydrochloride  Injection  30mg/amp",1,"diamorphine",30,"injection-oneoff","injection",3))->MedicationLookup

# hydromorphone
#medicationname == "hydromorphone" & route == "oral" ~ "4.0"
rbind(MedicationLookup,c("djj1.","HYDROMORPHONE HYDROCHLORIDE 1.3mg capsules",24,"hydromorphone",1.3,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djj3.","HYDROMORPHONE HYDROCHLORIDE 2.6mg capsules",79,"hydromorphone",2.6,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djj5.","HYDROMORPHONE HYDROCHLORIDE 2mg m/r capsules",16,"hydromorphone",2,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djj6.","HYDROMORPHONE HYDROCHLORIDE 4mg m/r capsules",43,"hydromorphone",4,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djj7.","HYDROMORPHONE HYDROCHLORIDE 8mg m/r capsules",1,"hydromorphone",8,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djj8.","HYDROMORPHONE HYDROCHLORIDE 16mg m/r capsules",23,"hydromorphone",16,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djj2.","PALLADONE 1.3mg capsules",38,"hydromorphone",1.3,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djj4.","PALLADONE 2.6mg capsules",2,"hydromorphone",2.6,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djjA.","PALLADONE-SR 2mg m/r capsules",21,"hydromorphone",2,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djjB.","PALLADONE-SR 4mg m/r capsules",6,"hydromorphone",4,"tablet","oral",4))->MedicationLookup
rbind(MedicationLookup,c("djjC.","PALLADONE-SR 8mg m/r capsules",50,"hydromorphone",8,"tablet","oral",4))->MedicationLookup

# meptazinol
# medicationname == "meptazinol" & route == "oral" ~ "0.02"
# medicationname == "meptazinol" & route == "enteral_feeding_tube" ~ "0.02"
rbind(MedicationLookup,c("djb3.","MEPTAZINOL 200mg tablets",628,"meptazinol",200,"tablet","oral",0.02))->MedicationLookup
rbind(MedicationLookup,c("o441.","MEPTID 200mg tablets",42,"meptazinol",200,"tablet","oral",0.02))->MedicationLookup

# pethidine
#medicationname == "pethidine" & route == "oral" ~ "0.1"
rbind(MedicationLookup,c("djg2.","PETHIDINE 50mg tablets",43,"pethidine",50,"tablet","oral",0.1))->MedicationLookup

# -- extra ones not in secondary

# medicationname == "alfentanil" & route == "iv continuous infusion" ~ "30"
# medicationname == "alfentanil" & route == "iv infusion" ~ "30"
# medicationname == "alfentanil" & route == "iv slow injection" ~ "30"
# medicationname == "alfentanil" & route == "sc" ~ "30"
# medicationname == "alfentanil" & route == "sc continuous infusion" ~ "30"
rbind(MedicationLookup,c("o415.","ALFENTANIL 5mg/1mL injection",26,"alfentanil",5,"injection","injection",30))->MedicationLookup
rbind(MedicationLookup,c("o41x.","ALFENTANIL 1mg/2mL injection",22,"alfentanil",0.5,"injection","injection",30))->MedicationLookup
rbind(MedicationLookup,c("o41y.","ALFENTANIL 5mg/10mL injection",2,"alfentanil",0.5,"injection","injection",30))->MedicationLookup

# medicationname == "tapentadol" & route == "oral" ~ "0.4"
rbind(MedicationLookup,c("djBU.","TAPENTADOL 50mg tablets",3,"tapentadol",50,"tablet","oral",0.4))->MedicationLookup
rbind(MedicationLookup,c("djBZ.","TAPENTADOL 50mg m/r tablets",77,"tapentadol",50,"tablet","oral",0.4))->MedicationLookup

# Methadone
# Sliding scale based on dosage
# medicationname == "methadone" & route == "oral" & dose <= 20 mg/day ~ "4"
# medicationname == "methadone" & route == "oral" & dose <= 40 mg/day ~ "8"
# medicationname == "methadone" & route == "oral" & dose <= 60 mg/day ~ "10"
# medicationname == "methadone" & route == "oral" & dose > 60 mg/day ~ "12"
rbind(MedicationLookup,c("djc3.","METHADONE 1mg/1mL mixture",2,"methadone",1,"oral solution","oral",NA))->MedicationLookup
rbind(MedicationLookup,c("djc4.","METHADONE HYDROCHLORIDE 50mg/5mL sugar free liquid",2,"methadone",10,"oral solution","oral",NA))->MedicationLookup
rbind(MedicationLookup,c("djcC.","METHADONE 1mg/1mL sugar free mixture",412,"methadone",1,"oral solution","oral",NA))->MedicationLookup
rbind(MedicationLookup,c("djcq.","METHADONE 60mg/60mL oral solution unit dose",12,"methadone",1,"oral solution","oral",NA))->MedicationLookup
rbind(MedicationLookup,c("djcy.","METHADONE HYDROCHLORIDE 5mg tablets",106,"methadone",5,"tablet","oral",NA))->MedicationLookup
rbind(MedicationLookup,c("djcz.","METHADONE HYDROCHLORIDE 10mg/1mL injection",2,"methadone",10,"injection","injection",NA))->MedicationLookup
rbind(MedicationLookup,c("MEMI9399BRIDL","Methadone 1 Mg/Ml  Oral solution  ",39,"methadone",1,"oral solution","oral",NA))->MedicationLookup

# medicationname == "pentazocine" & route == "oral" ~ "0.37"
rbind(MedicationLookup,c("djf1.","PENTAZOCINE 50mg capsules",22,"pentazocine",50,"tablet","oral",0.37))->MedicationLookup


colnames(MedicationLookup) <- c("ClinicalCode", "MedicationName", "Frequency", "OpioidName", "StrengthInMilligrams", "Form", "Route", "MMEFactor")
MedicationLookup$StrengthInMilligrams <- as.numeric(MedicationLookup$StrengthInMilligrams)
MedicationLookup$MMEFactor <- as.numeric(MedicationLookup$MMEFactor)
MedicationLookup$Frequency <- as.numeric(MedicationLookup$Frequency)
MedicationLookup$OpioidName <- as.factor(MedicationLookup$OpioidName)
MedicationLookup$Form <- as.factor(MedicationLookup$Form)
MedicationLookup$Route <- as.factor(MedicationLookup$Route)