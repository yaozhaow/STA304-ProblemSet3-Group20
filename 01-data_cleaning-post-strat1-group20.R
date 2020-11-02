#### Preamble ####
# Purpose: Prepare and clean relevant post-stratification data from the survey data, 
# the 2018 5-year ACS(American Community Surveys) downloaded from IPUMS.
# Author: Ying Tian
# Data: 31 October 2020
# Contact: taryn.tian@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)
# Read in the raw data.
raw_data <- read_dta("~/Desktop/ps3/usa_00001.dta.gz")


# Add the labels to the data set
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that are of our interests of the study
reduced_data <- 
  raw_data %>% 
  select(sex,age, citizen,hispan)

#Split cells by the selected variables- age, sex, citizen, hispan
reduced_data <- 
  reduced_data %>%
  count(age,sex,citizen,hispan) %>%
  group_by(age,sex,citizen,hispan) 

#Clean the data by extracting those who are not eligible 
#to vote(less than 18 years old)
reduced_data <- 
  reduced_data %>% 
  filter(age !="less than 1 year old") %>% 
  filter(age != 1) %>% 
  filter(age != 2) %>% 
  filter(age != 3) %>% 
  filter(age != 4) %>% 
  filter(age != 5) %>% 
  filter(age != 6) %>% 
  filter(age != 7) %>% 
  filter(age != 8) %>% 
  filter(age != 9) %>% 
  filter(age != 10) %>%
  filter(age != 11) %>% 
  filter(age != 12) %>% 
  filter(age != 13) %>%
  filter(age != 14) %>% 
  filter(age != 15) %>% 
  filter(age != 16) %>% 
  filter(age != 17)  

#Make sure the values in the age column are all intergers
reduced_data$age <- as.integer(reduced_data$age)

#Clean the data by extracting those who are not eligible 
#to vote(non-citizen of USA)
reduced_data <- 
  reduced_data %>% filter(citizen != "n/a") %>% filter(citizen != "not a citizen")

# Saving the census data as a csv file in my
# working directory
setwd("~/Desktop/ps3")
write_csv(reduced_data, "census_data_group20.csv")



         