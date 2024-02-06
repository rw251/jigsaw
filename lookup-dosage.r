# create the dose lookup
DoseLookup <- data.frame()
 
# Build up the lookup. Columns are:
# - Dosing instruction
# - MinFrequencyGap
# - MaxFrequencyGap
# - IsOneOff? TRUE/FALSE - to account for things like "ONLY ONCE"

# TODO check 24 hour - is it "once per 24 hours", continuous e.g. 24/7, or just for 24 hours.
# depends on if it's a tablet or a drip

# Hard to classify
rbind(DoseLookup,c("As Often as Necessary",0,-1,FALSE))->DoseLookup
rbind(DoseLookup,c("ONCE ONLY (ONE DOSE)",1,1,TRUE))->DoseLookup
rbind(DoseLookup,c("<User Schedule>",0,-1,FALSE))->DoseLookup
rbind(DoseLookup,c("contimous SC infusion",0,-1,FALSE))->DoseLookup
rbind(DoseLookup,c(NA,0,-1,FALSE))->DoseLookup

# 1 a day
rbind(DoseLookup,c("Morning",24,24,FALSE))->DoseLookup
rbind(DoseLookup,c("Night",24,24,FALSE))->DoseLookup
rbind(DoseLookup,c("Daily (6pm)",24,24,FALSE))->DoseLookup
rbind(DoseLookup,c("Daily (10am)",24,24,FALSE))->DoseLookup
rbind(DoseLookup,c("Daily (6am)",24,24,FALSE))->DoseLookup
rbind(DoseLookup,c("Daily (12noon)",24,24,FALSE))->DoseLookup
rbind(DoseLookup,c("Daily (7am)",24,24,FALSE))->DoseLookup
rbind(DoseLookup,c("Daily (2pm)",24,24,FALSE))->DoseLookup
rbind(DoseLookup,c("24 hour",24,24,FALSE))->DoseLookup

# 2
rbind(DoseLookup,c("Every 12 Hours",12,12,FALSE))->DoseLookup
rbind(DoseLookup,c("Twice a Day",12,12,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 12 Hours (10am; 10pm)",12,12,FALSE))->DoseLookup
rbind(DoseLookup,c("Twice a Day (8am & 10pm)",12,12,FALSE))->DoseLookup
rbind(DoseLookup,c("Twice a Day (10am; 6pm)",12,12,FALSE))->DoseLookup
rbind(DoseLookup,c("Twice a Day (8am & 2pm)",12,12,FALSE))->DoseLookup
rbind(DoseLookup,c("Twice a Day (12noon & 6pm)",12,12,FALSE))->DoseLookup
rbind(DoseLookup,c("Twice a Day (8am & 8pm)",12,12,FALSE))->DoseLookup

# 3
rbind(DoseLookup,c("Three Times a Day",8,8,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 8 Hours",8,8,FALSE))->DoseLookup
rbind(DoseLookup,c("Three Times a Day (8; 2; 10)",8,8,FALSE))->DoseLookup
rbind(DoseLookup,c("Three Times a Day (8; 4; 10)",8,8,FALSE))->DoseLookup
rbind(DoseLookup,c("Three Times a Day (10; 2; 10)",8,8,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 6 - 8 Hours",6,8,FALSE))->DoseLookup

# 4
rbind(DoseLookup,c("Four Times a Day",6,6,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 6 Hours",6,6,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 4 - 6 Hours",4,6,FALSE))->DoseLookup

# 5-8
rbind(DoseLookup,c("Five Times a Day",4.8,4.8,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 4 Hours",4,4,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 3 - 4 Hours",3,4,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 2 - 4 Hours",2,4,FALSE))->DoseLookup
rbind(DoseLookup,c("Six Times a Day",4,4,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 3 Hours PRN",3,3,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 3 Hours",3,3,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 3 Hours if needed",3,3,FALSE))->DoseLookup

# 9+
rbind(DoseLookup,c("Every 2 - 3 Hours",2,3,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 1 - 2 Hours",1,2,FALSE))->DoseLookup
rbind(DoseLookup,c("Every 2 Hours",2,2,FALSE))->DoseLookup
rbind(DoseLookup,c("Every Hour",1,1,FALSE))->DoseLookup

# < 1
rbind(DoseLookup,c("Alternate Days (6pm)",48,48,FALSE))->DoseLookup
rbind(DoseLookup,c("Alternate Days (8am)",48,48,FALSE))->DoseLookup
rbind(DoseLookup,c("Every Three Days (6pm)",72,72,FALSE))->DoseLookup
rbind(DoseLookup,c("Every Three Days (8am)",72,72,FALSE))->DoseLookup
rbind(DoseLookup,c("Every Four Days (6pm)",96,96,FALSE))->DoseLookup
rbind(DoseLookup,c("Every Four Days (8am)",96,96,FALSE))->DoseLookup
rbind(DoseLookup,c("Once a Week (6pm)",168,168,FALSE))->DoseLookup
rbind(DoseLookup,c("Once a Week (7am)",168,168,FALSE))->DoseLookup
rbind(DoseLookup,c("Once a Week",168,168,FALSE))->DoseLookup
rbind(DoseLookup,c("Every Three Weeks (6pm)",504,504,FALSE))->DoseLookup
rbind(DoseLookup,c("Every Three Weeks",504,504,FALSE))->DoseLookup
rbind(DoseLookup,c("Once a Month (6pm)",730,730,FALSE))->DoseLookup

colnames(DoseLookup) <- c("FrequencyCode","MinFrequencyGap","MaxFrequencyGap","IsOneOff")
DoseLookup$IsOneOff = DoseLookup$IsOneOff == 'TRUE'
DoseLookup$MinFrequencyGap = as.numeric(DoseLookup$MinFrequencyGap)
DoseLookup$MaxFrequencyGap = as.numeric(DoseLookup$MaxFrequencyGap)
#summary(DoseLookup)
#head(DoseLookup)