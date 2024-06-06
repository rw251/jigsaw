# Test suite

# We create a fake input and check the outputs are what we expect

JournalData <- data.frame()

# Also make data frames for expected rows
RowCounts <- data.frame()
ExpectedRows <- data.frame()
UnExpectedRows <- data.frame()

# NB Make sure all dates are between 2010-01-01 and 2021-09-30

# Patient000 not needed for tests but to ensure code runs
# JournalData <- rbind(JournalData,c('0','dji2.','Tramadol 50mg capsules','20150315','60','ONE TABLET TWICE A DAY'))

## Tablets

## Just 1 prescription

# TEST001 - Patient with just one Rx, with clear instruction, just follow instruction
JournalData <- rbind(JournalData,c('Patient001',"dic3.","ZAPAIN caplets 30mg + 500mg","20150101","30","TAKE 1 TABLET 4 TIMES A DAY"))
# EXPECT 7 days of 120mg codeine and 8th day of 60mg
RowCounts <- rbind(RowCounts, c('001', 8))
ExpectedRows <- rbind(ExpectedRows, c())
ExpectedRows <- rbind(ExpectedRows, c('001', 'codeine', '2015-01-06', 120, 18))
ExpectedRows <- rbind(ExpectedRows, c('001', 'codeine', '2015-01-09', 60, 9))

# TEST002 - Patient with just one Rx, with clear instruction, but optional, just follow instruction
JournalData <- rbind(JournalData,c('Patient002',"dia6.","CO-DYDRAMOL (dihydrocodeine & paracetamol) tabs 10mg+500mg","20150101","30","TAKE 1 TABLET 4 TIMES A DAY AS REQUIRED"))
# EXPECT average dose e.g. 15 days of 20mg dihydrocodeine
RowCounts <- rbind(RowCounts, c('002', 15))
ExpectedRows <- rbind(ExpectedRows, c('002', 'dihydrocodeine', '2015-01-02', 20, 5))
ExpectedRows <- rbind(ExpectedRows, c('002', 'dihydrocodeine', '2015-01-16', 20, 5))

# TEST003 - Patient with just one Rx, no instruction
JournalData <- rbind(JournalData,c('Patient003',"djzj.","ZOMORPH 10mg m/r capsules","20150101","30",NA))
# EXPECT 30 days of 10mg morphine
RowCounts <- rbind(RowCounts, c('003', 30))
ExpectedRows <- rbind(ExpectedRows, c('003', 'morphine', '2015-01-02', 10, 10))
ExpectedRows <- rbind(ExpectedRows, c('003', 'morphine', '2015-01-31', 10, 10))

## 2 prescriptions too close together
# TEST011 - Patient011 has 2 large doses close together, both unknown dose
JournalData <- rbind(JournalData,c('Patient011','dji2.','Tramadol 50mg capsules','20150315','60','TAKE AS DIRECTED  WHEN REQUIRED.'))
JournalData <- rbind(JournalData,c('Patient011','dji2.','Tramadol 50mg capsules','20150319','60','TAKE AS DIRECTED  WHEN REQUIRED.'))
# EXPECT to use up first Rx to exhaust supply before second, and then second to continue at same dose
RowCounts <- rbind(RowCounts, c('011', 8))
ExpectedRows <- rbind(ExpectedRows, c('011', 'tramadol', '2015-03-16', 750, 75))
ExpectedRows <- rbind(ExpectedRows, c('011', 'tramadol', '2015-03-16', 750, 75))
ExpectedRows <- rbind(ExpectedRows, c('011', 'tramadol', '2015-03-23', 750, 75))

# TEST012 - Patient012 has 2 large doses close together, first unknown, second known dosage
JournalData <- rbind(JournalData,c('Patient012',"TRCA24798EMIS","Tramadol Hydrochloride  Capsules  50 mg",'20150315','60','TAKE AS DIRECTED  WHEN REQUIRED.'))
JournalData <- rbind(JournalData,c('Patient012',"TRCA24798EMIS","Tramadol Hydrochloride  Capsules  50 mg",'20150319','60','ONE TWICE A DAY'))
# EXPECT to use up first Rx to exhaust supply before second, and then second to be provided dose
RowCounts <- rbind(RowCounts, c('012', 34))
ExpectedRows <- rbind(ExpectedRows, c('012', 'tramadol', '2015-03-16', 750, 75))
ExpectedRows <- rbind(ExpectedRows, c('012', 'tramadol', '2015-03-20', 100, 10))
ExpectedRows <- rbind(ExpectedRows, c('012', 'tramadol', '2015-04-18', 100, 10))

# TEST013 - Patient013 has 2 large doses close together, first known dosage, second unknown
JournalData <- rbind(JournalData,c('Patient013',"dj81.","DIHYDROCODEINE 30mg tablets",'20150315','60','ONE TWICE A DAY'))
JournalData <- rbind(JournalData,c('Patient013',"dj81.","DIHYDROCODEINE 30mg tablets",'20150319','60','TAKE AS DIRECTED  WHEN REQUIRED.'))
# EXPECT to follow initial instruction for both
RowCounts <- rbind(RowCounts, c('013', 34))
ExpectedRows <- rbind(ExpectedRows, c('013', 'dihydrocodeine', '2015-03-16', 60, 15))
ExpectedRows <- rbind(ExpectedRows, c('013', 'dihydrocodeine', '2015-03-20', 60, 15))
ExpectedRows <- rbind(ExpectedRows, c('013', 'dihydrocodeine', '2015-04-18', 60, 15))

# TEST014 - Patient014 has 2 large doses close together, both known dose
JournalData <- rbind(JournalData,c('Patient014',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20150315','60','ONE TWICE A DAY'))
JournalData <- rbind(JournalData,c('Patient014',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20150319','60','ONE TWICE A DAY'))
# EXPECT to follow initial instruction for both
RowCounts <- rbind(RowCounts, c('014', 34))
ExpectedRows <- rbind(ExpectedRows, c('014', 'tramadol', '2015-03-16', 200, 20))
ExpectedRows <- rbind(ExpectedRows, c('014', 'tramadol', '2015-03-20', 200, 20))
ExpectedRows <- rbind(ExpectedRows, c('014', 'tramadol', '2015-04-18', 200, 20))

## 2 prescriptions too far apart

# TEST021 - Patient021 has 2 Rx too far apart, both unknown dose
JournalData <- rbind(JournalData,c('Patient021',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160305','12','TAKE AS DIRECTED  WHEN REQUIRED.'))
JournalData <- rbind(JournalData,c('Patient021',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160331','30','TAKE AS DIRECTED  WHEN REQUIRED.'))
# EXPECT take one a day
RowCounts <- rbind(RowCounts, c('021', 42))
ExpectedRows <- rbind(ExpectedRows, c('021', 'codeine', '2016-03-06', 15, 2.25))
ExpectedRows <- rbind(ExpectedRows, c('021', 'codeine', '2016-04-01', 15, 2.25))
UnExpectedRows <- rbind(UnExpectedRows, c('021', 'codeine', '2016-03-19'))

# TEST022 - Patient022 has 2 Rx too far apart, first unknown, second known dosage
JournalData <- rbind(JournalData,c('Patient022',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160305','12','TAKE AS DIRECTED  WHEN REQUIRED.'))
JournalData <- rbind(JournalData,c('Patient022',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160331','30','ONE 3 TIMES A DAY'))
# EXPECT take one a day, and then follow Rx
RowCounts <- rbind(RowCounts, c('022', 22))
UnExpectedRows <- rbind(UnExpectedRows, c('022', 'codeine', '2016-03-19'))
ExpectedRows <- rbind(ExpectedRows, c('022', 'codeine', '2016-03-06', 15, 2.25))
ExpectedRows <- rbind(ExpectedRows, c('022', 'codeine', '2016-04-01', 45, 6.75))

# TEST023 - Patient023 has 2 Rx too far apart, first known dosage, second unknown
JournalData <- rbind(JournalData,c('Patient023',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160305','12','ONE 3 TIMES A DAY'))
JournalData <- rbind(JournalData,c('Patient023',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160331','30','TAKE AS DIRECTED  WHEN REQUIRED.'))
# EXPECT follow first Rx, then go to 1 a day for second Rx
RowCounts <- rbind(RowCounts, c('023', 34))
UnExpectedRows <- rbind(UnExpectedRows, c('023', 'codeine', '2016-03-10'))
ExpectedRows <- rbind(ExpectedRows, c('023', 'codeine', '2016-03-06', 45, 6.75))
ExpectedRows <- rbind(ExpectedRows, c('023', 'codeine', '2016-04-01', 15, 2.25))

# TEST024 - Patient024 has 2 Rx too far apart, first known dosage (could span if reduced dose), second unknown
JournalData <- rbind(JournalData,c('Patient024',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160305','30','ONE TWICE A DAY AS REQUIRED'))
JournalData <- rbind(JournalData,c('Patient024',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160331','30','TAKE AS DIRECTED  WHEN REQUIRED.'))
RowCounts <- rbind(RowCounts, c('024', 56))
ExpectedRows <- rbind(ExpectedRows, c('024', 'codeine', '2016-03-06', 15, 2.25))
ExpectedRows <- rbind(ExpectedRows, c('024', 'codeine', '2016-03-10', 15, 2.25))
ExpectedRows <- rbind(ExpectedRows, c('024', 'codeine', '2016-04-01', 15, 2.25))

# TEST025 - Patient025 has 2 Rx too far apart, both known dose
JournalData <- rbind(JournalData,c('Patient025',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160305','12','ONE 3 TIMES A DAY'))
JournalData <- rbind(JournalData,c('Patient025',"dj41.","CODEINE PHOSPHATE 15mg tablets",'20160331','30','ONE 3 TIMES A DAY'))
RowCounts <- rbind(RowCounts, c('025', 14))
ExpectedRows <- rbind(ExpectedRows, c('025', 'codeine', '2016-03-06', 45, 6.75))
ExpectedRows <- rbind(ExpectedRows, c('025', 'codeine', '2016-03-09', 45, 6.75))
ExpectedRows <- rbind(ExpectedRows, c('025', 'codeine', '2016-04-01', 45, 6.75))

## 2 prescriptions just right

# TEST031 - Patient031 has 2 Rx just right, both unknown dose
JournalData <- rbind(JournalData,c('Patient031',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160305','12','TAKE AS DIRECTED  WHEN REQUIRED.'))
JournalData <- rbind(JournalData,c('Patient031',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160317','30','TAKE AS DIRECTED  WHEN REQUIRED.'))
# EXPECT take one a day
RowCounts <- rbind(RowCounts, c('031', 42))
ExpectedRows <- rbind(ExpectedRows, c('031', 'tramadol', '2016-03-06', 100, 10))
ExpectedRows <- rbind(ExpectedRows, c('031', 'tramadol', '2016-03-09', 100, 10))
ExpectedRows <- rbind(ExpectedRows, c('031', 'tramadol', '2016-04-16', 100, 10))

# TEST032 - Patient032 has 2 Rx just right, first unknown, second known dosage
JournalData <- rbind(JournalData,c('Patient032',"djzk.","ZOMORPH 30mg m/r capsules",'20160305','12','TAKE AS DIRECTED  WHEN REQUIRED.'))
JournalData <- rbind(JournalData,c('Patient032',"djzk.","ZOMORPH 30mg m/r capsules",'20160317','30','ONE 3 TIMES A DAY'))
# EXPECT take one a day, and then follow Rx
RowCounts <- rbind(RowCounts, c('032', 22))
ExpectedRows <- rbind(ExpectedRows, c('032', 'morphine', '2016-03-06', 30, 30))
ExpectedRows <- rbind(ExpectedRows, c('032', 'morphine', '2016-03-09', 30, 30))
ExpectedRows <- rbind(ExpectedRows, c('032', 'morphine', '2016-03-20', 90, 90))

# TEST033 - Patient033 has 2 Rx just right, first known dosage, second unknown
JournalData <- rbind(JournalData,c('Patient033',"COTA3334","Codeine Phosphate  Tablets  30 mg",'20160305','12','ONE 3 TIMES A DAY'))
JournalData <- rbind(JournalData,c('Patient033',"COTA3334","Codeine Phosphate  Tablets  30 mg",'20160309','30','TAKE AS DIRECTED  WHEN REQUIRED.'))
# EXPECT follow first Rx, then go to 1 a day for second Rx
RowCounts <- rbind(RowCounts, c('033', 14))
ExpectedRows <- rbind(ExpectedRows, c('033', 'codeine', '2016-03-06', 90, 13.5))
ExpectedRows <- rbind(ExpectedRows, c('033', 'codeine', '2016-03-09', 90, 13.5))
ExpectedRows <- rbind(ExpectedRows, c('033', 'codeine', '2016-03-17', 90, 13.5))

# TEST034 - Patient034 has 2 Rx just right, both known dose
JournalData <- rbind(JournalData,c('Patient034',"djkw.","OXYCODONE HYDROCHLORIDE 10mg m/r tablets",'20160305','12','ONE 3 TIMES A DAY'))
JournalData <- rbind(JournalData,c('Patient034',"djkw.","OXYCODONE HYDROCHLORIDE 10mg m/r tablets",'20160309','24','ONE 3 TIMES A DAY'))
RowCounts <- rbind(RowCounts, c('034', 12))
ExpectedRows <- rbind(ExpectedRows, c('034', 'oxycodone', '2016-03-06', 30, 45))
ExpectedRows <- rbind(ExpectedRows, c('034', 'oxycodone', '2016-03-09', 30, 45))
ExpectedRows <- rbind(ExpectedRows, c('034', 'oxycodone', '2016-03-17', 30, 45))


# oral solution
# codevalue 5ml / 10 millilitres etc.
## ml / dose / drop / milligram

JournalData <- rbind(JournalData, c('Patient041',"dj1L.","MORPHINE SULFATE 10mg/5mL oral solution","20171010",100,'ml')) #,1072,"morphine",2,"oral solution","oral",1))->MedicationLookup
RowCounts <- rbind(RowCounts, c('041', 20))
ExpectedRows <- rbind(ExpectedRows, c('041', 'morphine','2017-10-11',10,10))
ExpectedRows <- rbind(ExpectedRows, c('041', 'morphine','2017-10-21',10,10))

JournalData <- rbind(JournalData, c('Patient042',"dj1..","MORPHINE SALTS(1) [CNS]" ,"20171010",100,NA)) #,1118,"morphine",2,"oral solution","oral",1))->MedicationLookup
RowCounts <- rbind(RowCounts, c('042', 20))
ExpectedRows <- rbind(ExpectedRows, c('042', 'morphine','2017-10-11',10,10))
ExpectedRows <- rbind(ExpectedRows, c('042', 'morphine','2017-10-30',10,10))

JournalData <- rbind(JournalData, c('Patient043',"dj1Z.","ORAMORPH 10mg/5mL soln 300mL","20171010",100,'5ML FOUR TIMES A DAY WHEN REQUIRED')) #,1280,"morphine",2,"oral solution","oral",1))->MedicationLookup
RowCounts <- rbind(RowCounts, c('043', 10))
ExpectedRows <- rbind(ExpectedRows, c('043', 'morphine','2017-10-11',20,20))
ExpectedRows <- rbind(ExpectedRows, c('043', 'morphine','2017-10-20',20,20))

JournalData <- rbind(JournalData, c('Patient044',"OXSO2721NEMIS","Oxycodone Hydrochloride  Solution  Sugar Free 5 mg/5 ml","20171010",'100ml','5 MLS THREE TIMES A DAY WHEN REQUIRED')) #,1410,"oxycodone",1,"oral solution","oral",1.5))->MedicationLookup
RowCounts <- rbind(RowCounts, c('044', 14))
ExpectedRows <- rbind(ExpectedRows, c('044', 'oxycodone','2017-10-11',7.5,11.25))
ExpectedRows <- rbind(ExpectedRows, c('044', 'oxycodone','2017-10-24',2.5,3.75))

JournalData <- rbind(JournalData, c('Patient045',"OROR9268BRIDL","Oramorph  Oral solution  10 mg/5 ml","20171010",100,'5-10ML FOUR TIMES A DAY WHEN REQUIRED')) #,1427,"morphine",2,"oral solution","oral",1))->MedicationLookup
RowCounts <- rbind(RowCounts, c('045', 5))
ExpectedRows <- rbind(ExpectedRows, c('045', 'morphine','2017-10-11',40,40))
ExpectedRows <- rbind(ExpectedRows, c('045', 'morphine','2017-10-15',40,40))

JournalData <- rbind(JournalData, c('Patient046',"djks.","Oxycodone 5mg/5ml oral solution sugar free","20171010",100,'15MG IN 15ML TWICE A DAY DISPENSED IN INDIVIDUAL DOSES  Instalments: Via Venalink Dispense')) #,3273,"oxycodone",10,"oral solution","oral",1.5))->MedicationLookup
RowCounts <- rbind(RowCounts, c('046', 4))
ExpectedRows <- rbind(ExpectedRows, c('046', 'oxycodone','2017-10-11',30,45))
ExpectedRows <- rbind(ExpectedRows, c('046', 'oxycodone','2017-10-14',10,15))

JournalData <- rbind(JournalData, c('Patient047',"djks.","Oxycodone 10mg/ml oral solution sugar free","20171010",500,'10 MLS FOUR TIMES A DAY')) #,3273,"oxycodone",10,"oral solution","oral",1.5))->MedicationLookup
RowCounts <- rbind(RowCounts, c('047', 13))
ExpectedRows <- rbind(ExpectedRows, c('047', 'oxycodone','2017-10-11',400,600))
ExpectedRows <- rbind(ExpectedRows, c('047', 'oxycodone','2017-10-23',200,300))

JournalData <- rbind(JournalData, c('Patient048',"djkr.","OXYCODONE HYDROCHLORIDE 5mg/5mL sugar free liquid","20171010",100,'2.5-5ML FOUR TIMES A DAY WHEN REQUIRED')) #,4379,"oxycodone",1,"oral solution","oral",1.5))->MedicationLookup
RowCounts <- rbind(RowCounts, c('048', 10))
ExpectedRows <- rbind(ExpectedRows, c('048', 'oxycodone','2017-10-11',10,15))
ExpectedRows <- rbind(ExpectedRows, c('048', 'oxycodone','2017-10-20',10,15))

JournalData <- rbind(JournalData, c('Patient049',"dj1l.","ORAMORPH 10mg/5mL liquid 100mL","20171010",100,'2.5-5ML WHEN REQUIRED UP TO FOUR TIMES A DAY')) #,7861,"morphine",2,"oral solution","oral",1))->MedicationLookup
RowCounts <- rbind(RowCounts, c('049', 10))
ExpectedRows <- rbind(ExpectedRows, c('049', 'morphine','2017-10-11',20,20))
ExpectedRows <- rbind(ExpectedRows, c('049', 'morphine','2017-10-15',20,20))

JournalData <- rbind(JournalData, c('Patient050',"dj1l.","ORAMORPH 10mg/5mL liquid 100mL","20171010",120,'TWO DOSES FOUR TIMES A DAY'))
RowCounts <- rbind(RowCounts, c('050', 3))
ExpectedRows <- rbind(ExpectedRows, c('050', 'morphine','2017-10-11',80,80))
ExpectedRows <- rbind(ExpectedRows, c('050', 'morphine','2017-10-13',80,80))

JournalData <- rbind(JournalData, c('Patient051',"MOOR18040EMIS","Morphine Sulfate  Oral solution  10 mg/5 ml","20171010",4,'TWO DROPS FOUR TIMES A DAY'))
RowCounts <- rbind(RowCounts, c('051', 10))
ExpectedRows <- rbind(ExpectedRows, c('051', 'morphine','2017-10-11',0.8,0.8))
ExpectedRows <- rbind(ExpectedRows, c('051', 'morphine','2017-10-20',0.8,0.8))

JournalData <- rbind(JournalData, c('Patient052',"djcC.","METHADONE 1mg/1mL sugar free mixture","20171010",10,'ONE DROP FOUR TIMES A DAY'))
RowCounts <- rbind(RowCounts, c('052', 50))
UnExpectedRows <- rbind(UnExpectedRows, c('052', 'methadone', '2017-10-10'))
ExpectedRows <- rbind(ExpectedRows, c('052', 'methadone','2017-10-11',0.2,0.8))
ExpectedRows <- rbind(ExpectedRows, c('052', 'methadone','2017-11-28',0.2,0.8))

JournalData <- rbind(JournalData, c('Patient053',"djcC.","METHADONE 1mg/1mL sugar free mixture","20171010",100,'TWO DOSES THREE TIMES A DAY'))
RowCounts <- rbind(RowCounts, c('053', 4))
ExpectedRows <- rbind(ExpectedRows, c('053', 'methadone','2017-10-11',30,240))
ExpectedRows <- rbind(ExpectedRows, c('053', 'methadone','2017-10-14',10,40))

JournalData <- rbind(JournalData, c('Patient054',"djcq.","METHADONE 60mg/60mL oral solution unit dose","20171010",120,'TWO DOSES FIVE TIMES A DAY'))
RowCounts <- rbind(RowCounts, c('054', 3))
ExpectedRows <- rbind(ExpectedRows, c('054', 'methadone','2017-10-11',50,500))
ExpectedRows <- rbind(ExpectedRows, c('054', 'methadone','2017-10-13',20,80))

JournalData <- rbind(JournalData, c('Patient055',"djc4.","METHADONE HYDROCHLORIDE 50mg/5mL sugar free liquid","20171010",120,'5ml TWICE A DAY'))
RowCounts <- rbind(RowCounts, c('055', 12))
ExpectedRows <- rbind(ExpectedRows, c('055', 'methadone','2017-10-11',100,1200))
ExpectedRows <- rbind(ExpectedRows, c('055', 'methadone','2017-10-13',100,1200))


JournalData <- rbind(JournalData, c('Patient060',"dj3o.","BUPRENORPHINE 5micrograms/hour patches","20171010",4,'APPLY ONE PATCH ONCE EVERY 7 DAYS'))
RowCounts <- rbind(RowCounts, c('060', 28))
ExpectedRows <- rbind(ExpectedRows, c('060', 'buprenorphine','2017-10-11',0.12,9))
ExpectedRows <- rbind(ExpectedRows, c('060', 'buprenorphine','2017-11-07',0.12,9))

JournalData <- rbind(JournalData, c('Patient061',"dj3B.","BUTRANS 10micrograms/hour patches","20171010",2,'APPLY WEEKLY'))
RowCounts <- rbind(RowCounts, c('061', 14))
ExpectedRows <- rbind(ExpectedRows, c('061', 'buprenorphine','2017-10-11',0.24,18))
ExpectedRows <- rbind(ExpectedRows, c('061', 'buprenorphine','2017-10-24',0.24,18))

JournalData <- rbind(JournalData, c('Patient062',"dj3A.","BUTRANS 5micrograms/hour patches","20171010",4,NA))
RowCounts <- rbind(RowCounts, c('062', 28))
ExpectedRows <- rbind(ExpectedRows, c('062', 'buprenorphine','2017-10-11',0.12,9))
ExpectedRows <- rbind(ExpectedRows, c('062', 'buprenorphine','2017-11-07',0.12,9))

JournalData <- rbind(JournalData, c("Patient063","o42U.","MATRIFEN 50micrograms/hr patches","20180606",10,"APPLY ONE EVERY 3 DAYS"))
RowCounts <- rbind(RowCounts, c('063', 30))
ExpectedRows <- rbind(ExpectedRows, c('063', 'fentanyl','2018-06-07',1.2,120))
ExpectedRows <- rbind(ExpectedRows, c('063', 'fentanyl','2018-07-06',1.2,120))

JournalData <- rbind(JournalData, c("Patient064","o42S.","MATRIFEN 12micrograms/hr patches","20180606",5,"APPLY ONE EVERY 72 HRS"))
RowCounts <- rbind(RowCounts, c('064', 15))
ExpectedRows <- rbind(ExpectedRows, c('064', 'fentanyl','2018-06-07',0.288,28.8))
ExpectedRows <- rbind(ExpectedRows, c('064', 'fentanyl','2018-06-21',0.288,28.8))

JournalData <- rbind(JournalData, c("Patient065","o42T.","MATRIFEN 25micrograms/hr patches","20180606",10,NA))
RowCounts <- rbind(RowCounts, c('065', 30))
ExpectedRows <- rbind(ExpectedRows, c('065', 'fentanyl','2018-06-07',0.6,60))
ExpectedRows <- rbind(ExpectedRows, c('065', 'fentanyl','2018-07-06',0.6,60))

# Manual checks later for injections
JournalData <- rbind(JournalData, c("Patient070","o42x.","FENTANYL 100microgram/2mL injection","20190606",10,NA))
JournalData <- rbind(JournalData, c("Patient070","o42x.","FENTANYL 100microgram/2mL injection","20190806",10,NA))

JournalData <- rbind(JournalData, c("Patient071","djko.","OXYCODONE HYDROCHLORIDE 10mg/mL injection solution 1mL ampoule","20190606",10,NA))

JournalData <- rbind(JournalData, c("Patient072","o451.","Morphine sulfate 10mg/1ml solution for injection ampoules","20190606",10,NA))
JournalData <- rbind(JournalData, c("Patient072","o451.","Morphine sulfate 10mg/1ml solution for injection ampoules","20190706",10,NA))
JournalData <- rbind(JournalData, c("Patient072","o451.","Morphine sulfate 10mg/1ml solution for injection ampoules","20190806",10,NA))

# TEST080 - Patient080 Check last day partial dose logic if next rx too soon
JournalData <- rbind(JournalData,c('Patient080',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160305','30',"TAKE 1 TABLET 4 TIMES A DAY"))
JournalData <- rbind(JournalData,c('Patient080',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160311','30',"TAKE 1 TABLET 4 TIMES A DAY"))
# EXPECT take one a day
RowCounts <- rbind(RowCounts, c('080', 14))
ExpectedRows <- rbind(ExpectedRows, c('080', 'tramadol', '2016-03-06', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('080', 'tramadol', '2016-03-11', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('080', 'tramadol', '2016-03-18', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('080', 'tramadol', '2016-03-19', 200, 20))

# TEST081 - Patient081 Check last day partial dose logic if next rx too soon
JournalData <- rbind(JournalData,c('Patient081',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160305','30',"TAKE 1 TABLET 4 TIMES A DAY"))
JournalData <- rbind(JournalData,c('Patient081',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160312','30',"TAKE 1 TABLET 4 TIMES A DAY"))
# EXPECT take one a day
RowCounts <- rbind(RowCounts, c('081', 15))
ExpectedRows <- rbind(ExpectedRows, c('081', 'tramadol', '2016-03-06', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('081', 'tramadol', '2016-03-12', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('081', 'tramadol', '2016-03-19', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('081', 'tramadol', '2016-03-20', 200, 20))

# TEST082 - Patient082 Check last day partial dose logic if next rx correct
JournalData <- rbind(JournalData,c('Patient082',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160305','30',"TAKE 1 TABLET 4 TIMES A DAY"))
JournalData <- rbind(JournalData,c('Patient082',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160313','30',"TAKE 1 TABLET 4 TIMES A DAY"))
# EXPECT take one a day
RowCounts <- rbind(RowCounts, c('082', 16))
ExpectedRows <- rbind(ExpectedRows, c('082', 'tramadol', '2016-03-06', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('082', 'tramadol', '2016-03-13', 200, 20))
ExpectedRows <- rbind(ExpectedRows, c('082', 'tramadol', '2016-03-20', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('082', 'tramadol', '2016-03-21', 200, 20))

# TEST083 - Patient083 Check last day partial dose logic if next rx in future
JournalData <- rbind(JournalData,c('Patient083',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160305','30',"TAKE 1 TABLET 4 TIMES A DAY"))
JournalData <- rbind(JournalData,c('Patient083',"djiG.","TRAMADOL HYDROCHLORIDE 100mg m/r capsules",'20160314','30',"TAKE 1 TABLET 4 TIMES A DAY"))
# EXPECT take one a day
RowCounts <- rbind(RowCounts, c('083', 16))
ExpectedRows <- rbind(ExpectedRows, c('083', 'tramadol', '2016-03-06', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('083', 'tramadol', '2016-03-13', 200, 20))
UnExpectedRows <- rbind(UnExpectedRows, c('083', 'tramadol', '2016-03-14'))
ExpectedRows <- rbind(ExpectedRows, c('083', 'tramadol', '2016-03-21', 400, 40))
ExpectedRows <- rbind(ExpectedRows, c('083', 'tramadol', '2016-03-22', 200, 20))


#injection-oneoff	7
#nasal spray	15

#sachet	79



colnames(JournalData) <- c("PseudonymisedID","ReadCode","Rubric", "EntryDate", "CodeValue","Codeunits")
colnames(RowCounts) <- c("ID","ExpectedNumber")
colnames(ExpectedRows) <- c("ID","Opioid","Date","Dose","MME")
colnames(UnExpectedRows) <- c("ID","Opioid","Date")

rowNumberTest <- function(ID, numberExpectedRows){
  patientId <- paste0('Patient', ID)
  data <- Data %>% filter(PseudonymisedID==patientId)
  if(nrow(data) != numberExpectedRows) {
    message(paste0("❌ ",paste0('TEST', ID)," failed: Expecting ", numberExpectedRows, ' rows for ', patientId, ', but instead got ', nrow(data)))
    return(FALSE)
  }
  return(TRUE)
}

rowExistsTest <- function(ID, opioid, date, dose, mme) {
  patientId <- paste0('Patient', ID)
  data <- Data %>% 
    filter(PseudonymisedID==patientId & OpioidName == opioid & Date == date & DoseInMg == dose & MME == mme)
  if(nrow(data) != 1) {
    message(paste0("❌ ",paste0('TEST', ID)," failed: Expected row [",dose,"mg (MME = ",mme,") of ",opioid," on ",date,"] not found."))
    return(FALSE)
  }
  return(TRUE)
}

rowNotExistsTest <- function(ID, opioid, date) {
  patientId <- paste0('Patient', ID)
  data <- Data %>% filter(PseudonymisedID==patientId & OpioidName == opioid & Date == date)
  if(nrow(data) != 0) {
    message(paste0("❌ ",paste0('TEST', ID)," failed: Unexpected row [",opioid," on ",date,"] present."))
    return(FALSE)
  }
  return(TRUE)
}

checkIfPass <- function(isPassing, test) {
  if(isPassing) {
    message(paste0('✅ ',test,' passed'))
  }
  return(isPassing)
}

injectionTest <- function(ID, FirstDate, LastDate, Number, DayDifference){
  isInjectionTestPassing <- TRUE
  if((FirstLastInjections %>% filter(PseudonymisedID==paste0('Patient', ID)))$FirstInjectionPrescription != FirstDate) {
    message("❌ ",paste0('TEST', ID)," failed: Incorrect first injection date")
    isInjectionTestPassing <- FALSE
  }
  if((FirstLastInjections %>% filter(PseudonymisedID==paste0('Patient', ID)))$LastInjectionPrescription != LastDate) {
    message("❌ ",paste0('TEST', ID)," failed: Incorrect last injection date")
    isInjectionTestPassing <- FALSE
  }
  if((FirstLastInjections %>% filter(PseudonymisedID==paste0('Patient', ID)))$NumberOfPrescriptions != Number) {
    message("❌ ",paste0('TEST', ID)," failed: Incorrect number of prescriptions")
    isInjectionTestPassing <- FALSE
  }
  if((FirstLastInjections %>% filter(PseudonymisedID==paste0('Patient', ID)))$DifferenceInDaysBetweenFirstAndLast != DayDifference) {
    message("❌ ",paste0('TEST', ID)," failed: Incorrect day difference")
    isInjectionTestPassing <- FALSE
  }
  checkIfPass(isInjectionTestPassing, paste0('TEST', ID))
  return(isInjectionTestPassing)
}

injectionTests <- function() {
  allInjectionTestsPassing <- TRUE
  allInjectionTestsPassing <- allInjectionTestsPassing & injectionTest('070','2019-06-06','2019-08-06',2,61)
  allInjectionTestsPassing <- allInjectionTestsPassing & injectionTest('071','2019-06-06','2019-06-06',1,0)
  allInjectionTestsPassing <- allInjectionTestsPassing & injectionTest('072','2019-06-06','2019-08-06',3,61)
  return(allInjectionTestsPassing)
}

runTests <- function() {
  allIsPassing <- TRUE
  for (i in 1:nrow(RowCounts)) { 
    row = RowCounts[i, ]
    isPassing <- rowNumberTest(row$ID, row$ExpectedNumber)
    ExpectedPatientRows <- ExpectedRows %>% filter(ID == row$ID)
    if(nrow(ExpectedPatientRows) > 0) {
      for (j in 1:nrow(ExpectedPatientRows)) { 
        patientRow = ExpectedPatientRows[j, ]
        isPassing <- isPassing & rowExistsTest(
          row$ID,
          patientRow$Opioid,
          patientRow$Date,
          patientRow$Dose,
          patientRow$MME
        )
      }
    }
    UnexpectedPatientRows <- UnExpectedRows %>% filter(ID == row$ID)
    if(nrow(UnexpectedPatientRows) > 0) {
      for (j in 1:nrow(UnexpectedPatientRows)) { 
        patientRow = UnexpectedPatientRows[j, ]
        isPassing <- isPassing & rowNotExistsTest(row$ID, patientRow$Opioid, patientRow$Date)
      }
    }
    allIsPassing <- allIsPassing & checkIfPass(isPassing, paste0('TEST', row$ID))    
  } 
  allIsPassing <- allIsPassing & injectionTests()
  if(allIsPassing) {
    message('✅ ALL TESTS PASSED')
  } else {
    message('')
    message('❌❌❌ TESTS FAILED ❌❌❌')
  }
}
### SPLIT HERE ###

%run ./library/_wrapper

### SPLIT HERE ###

# Checks
runTests()