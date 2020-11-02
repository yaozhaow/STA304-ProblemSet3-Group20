#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from the Democracy Fund 
# + UCLA Nationscape ‘Full Data Set’:“ns20200102.dta”. 
# Author: Ying Tian 
# Data: 31 October 2020
# Contact: taryn.tian@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)

# Read in the raw data "ns20200625.dta"
raw_data <- read_dta("~/Desktop/ps3/ns20200625.dta")
# Add the labels to the data set
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables that seems to be reasonable to analyze later in the report
reduced_data <- 
  raw_data %>% 
  select(interest,
         registration,
         vote_2016,
         vote_intention,
         vote_2020,
         ideo5,
         employment,
         foreign_born,
         gender,
         census_region,
         hispanic,
         race_ethnicity,
         household_income,
         education,
         state,
         congress_district,
         age)


# The 2020 vote is binary,either Donald Trump or Joe Biden, so we are going to 
#clean the data by extracting the answers "would not vote" and " I am not sure/don't know"

reduced_data<-
  reduced_data %>%
  filter(vote_2020 != "I would not vote" ) %>% 
  filter(vote_2020 != "I am not sure/don't know")
reduced_data<-
  reduced_data %>%
  mutate(vote_2020_trump = 
           ifelse(vote_2020=="Donald Trump", 1, 0)) %>% 
  mutate(vote_2020_biden = 
           ifelse(vote_2020=="Joe Biden", 1, 0))


# Saving the survey/sample data as a csv file in my
# working directory
setwd("~/Desktop/ps3")
write_csv(reduced_data, "survey_data_group20.csv")

