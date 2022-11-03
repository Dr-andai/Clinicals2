setwd("C:/Users/user/Documents/R/Clinicals2")

#install.packages("XML")
library("XML")
library(ggplot2)
library(dbplyr)
library(tidyverse)
library(lubridate)
# library(scales)

Burundi <- xmlToDataFrame("ICTRP-Results Burundi.xml")

count_a <- rep(1,times =42)
Burundi <- cbind(Burundi, count_a)

ggplot(data = Burundi,
       aes(x = count_a, y = Primary_sponsor))+
  geom_bar(stat = "identity")

Kenya <- xmlToDataFrame("ICTRP-Results Kenya.xml")
#Transform Date Column from character to Date variable
class(Kenya$Date_registration) ##'character'
#using the lubridate library
Kenya <- Kenya %>%
  mutate(Date_registration = lubridate::dmy(Date_registration))
class(Kenya$Date_registration)##'Date'

this_year <- Kenya[Kenya$Date_registration >= "2020-01-01" & Kenya$Date_registration <= "2022-10-31", ]
this_year <- this_year[-c(409,410),]

count_a <- rep(1,times =408)
this_year <- cbind(this_year, count_a)


ggplot(data = this_year,
       aes(x = count_a, y = Primary_sponsor))+
  geom_bar(stat = "identity")

Sponsors <- this_year[ , c("Primary_sponsor", "count_a")]
