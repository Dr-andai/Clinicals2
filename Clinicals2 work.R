setwd("C:/Users/user/Documents/R/Clinicals2")

Kenya <- xmlToDataFrame("ICTRP-Results Kenya.xml")

#install.packages("XML")
library("XML")
library(ggplot2)
library(dbplyr)
library(tidyverse)
library(lubridate)
library(ggthemes)
# library(scales)

# get the Phase column
Phase <- Kenya$Phase
#set to lower case
Phase <- tolower(Phase)
#Remove hyphens
Phase <- gsub("-/@#$:", "", Phase )
#Remove \n
Phase <- gsub("\n", "", Phase)


##Phase 4
Phase <- gsub('phase-4','phase 4', Phase)
Phase <- gsub('phase iv','phase 4', Phase)
Phase <- gsub('phase 1v','phase 4', Phase)
Phase <- gsub('iv','phase 4', Phase)

##Phase3
Phase <- gsub('phase-3','phase 3', Phase)
Phase <- gsub('phase iii','phase 3', Phase)


#Phase2
Phase <- gsub('phase-2','phase 2', Phase)
Phase <- gsub('phase ii','phase 2', Phase)
Phase <- gsub('ii','phase 2', Phase)
Phase <- gsub('phase 2i','phase 2', Phase)
Phase <- gsub('phase2/phase 2i','phase 2', Phase)
Phase <- gsub ('phase 2/phase 2','phase 2', Phase)

#Phase1
Phase <- gsub('phase-1','phase 1', Phase)
Phase <- gsub('phase i','phase 1', Phase)


#Phase0
Phase <- gsub('phase-0','phase 0', Phase)
Phase <- gsub('0','phase 0', Phase)
Phase <- gsub('phase phase 0','phase 0', Phase)

#Phase2/3
Phase <- gsub('phase 2/ phase 3','phase 2 / phase 3', Phase)
Phase <- gsub('phase 2/phase 3','phase 2 / phase 3', Phase)

#Phase1/2
Phase <- gsub('phase 1/phase 2','phase 1 / phase 2', Phase)
Phase <- gsub('phase 1/ phase 2','phase 1 / phase 2', Phase)

#Replace the long texts to empty strings
Phase <- gsub('explanatory', '', Phase)
Phase <- gsub('trials','', Phase)
Phase <- gsub('[()]', '', Phase)
Phase <- gsub('human', '', Phase)
Phase <- gsub('pharmacology', '', Phase)
Phase <- gsub('confirmatory', '', Phase)
Phase <- gsub('exploratory', '', Phase)
Phase <- gsub('therapeutic', '', Phase)
Phase <- gsub('use', '', Phase)
Phase <- gsub('no', '', Phase)
Phase <- gsub('n/a', '', Phase)

#Substitute the remaining patterns
Phase <- gsub('phase 1: yes', 'yes1', Phase)
Phase <- gsub('phase 2: yes', 'yes2', Phase)
Phase <- gsub('phase 3: yes', 'yes3', Phase)
Phase <- gsub('phase 4: yes', 'yes4', Phase)

Phase <- gsub('phase 1:', '', Phase)
Phase <- gsub('phase 2:', '', Phase)
Phase <- gsub('phase 3:', '', Phase)
Phase <- gsub('phase 4:', '', Phase)

Phase <- gsub("-","", Phase)
Phase <- gsub("[[:space:]]", "", Phase)

Phase <- gsub("yes1", "phase1", Phase)
Phase <- gsub("yes2", "phase2", Phase)
Phase <- gsub("yes3", "phase3", Phase)
Phase <- gsub("yes4", "phase4", Phase)

Phase <- gsub("/","", Phase)
Phase <- gsub("[[:space:]]", "", Phase)

Phase <- gsub('postmarketingsurveillance', 'phase4', Phase)
Phase <- gsub('tspecified','', Phase)
Phase <- gsub('tapplicable','Not_App', Phase)#not_applicable

Phase <- gsub('3','phase3', Phase)
Phase <- gsub('2','phase2', Phase)

Phase <- gsub('phasephase','phase', Phase)
Phase <- gsub('phase', 'p', Phase)

Kenya["fix_Phase"] <- Phase


###
Burundi <- xmlToDataFrame("ICTRP-Results Burundi.xml")

count_a <- rep(1,times =42)
Burundi <- cbind(Burundi, count_a)

ggplot(data = Burundi,
       aes(x = count_a, y = Primary_sponsor))+
  geom_bar(stat = "identity")

###


#Transform Date Column from character to Date variable
class(Kenya$Date_registration) ##'character'
#using the lubridate library
Kenya <- Kenya %>%
  mutate(Date_registration = lubridate::dmy(Date_registration))
class(Kenya$Date_registration)##'Date'

this_year <- Kenya[Kenya$Date_registration >= "2022-01-01" & Kenya$Date_registration <= "2022-10-31", ]
this_year <- this_year[-c(96,97,98),]

#create count column
count_a <- rep(1,times =95)
this_year <- cbind(this_year, count_a)

#Create A Table for sponsors
Sponsors <- this_year[ , c("fix_Phase","Primary_sponsor", 
                           "Countries","Scientific_title","Target_size", "Public_title")]

###

#Change all empty cells to NA
Sponsors [Sponsors == ""] <- NA
Sponsors <- drop_na(Sponsors)

#Obtain Only Phase 3 Clinical trials
p3 <- Sponsors[Sponsors$fix_Phase =='p3',]
##Change Target size column into numeric data type
p3$Target_size = as.numeric(as.character(p3$Target_size))
class(p3$Target_size)

#Add ID column
#p3 <- tibble::rowid_to_column(p3, "ID")

#Drop duplicate Clinical trials that have been duplicated.
## Drop "Serum Institute of India" Duplicate 
rownames(p3) <- 1:nrow(p3)
p3 <- p3[-c(5),]
rownames(p3) <- 1:nrow(p3)

#ID 7 Primary_sponsor has a long value
p3[7, ]
p3[7, 2]= 'Hoffmann-La Roche'
#Change ID 12 Primary sponsor value
p3[12, 2]= 'Hoffmann-La Roche 2'

## Drop "Academic Medical Center" Duplicate 
p3 <- p3[-c(9),]
rownames(p3) <- 1:nrow(p3)

# Rename MSD
p3[9, 2]= 'Merck Sharp & Dohme LLC'

#Data Visualization: Primary Sponsors of on going Phase 3 Clinical Trials
ggplot(data = p3,
       aes((y = reorder(Primary_sponsor, -Target_size)), x = Target_size, fill = Target_size))+
  geom_bar(stat = "identity", show.legend = FALSE)+
  labs (title = "Phase 3 Clinical Trials",
        subtitle = "In 01-01-2022 to 31-10-2022",
        y = "Primary Sponsors",
        x = "Population Target size")+
  theme_few()


