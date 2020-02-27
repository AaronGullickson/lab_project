##################################################################################
# read_raw_data.R
# Your Name Here
# This script will read in the raw data downloaded from IPUMS and Social Explorer
# and perform some initial cleaning and subsetting. 
##################################################################################

library(readr)

# IPUMS Data --------------------------------------------------------------

#read in the IPUMS fixed-width data from gzip file.
acs <- read_fwf("input/0001_census.data.gz",
                col_positions = fwf_positions(start=c(1, 5, 11, 19, 32, 55, 60, 72, 73, 77, 87, 88, 91, 92, 95),
                                              end=c(4, 10, 18, 31, 41, 59, 71, 72, 76, 86, 87, 90, 91, 94, 96),
                                              col_names =c("year","sample","serial","cbserial","hhwt","met2013",
                                                           "strata","gq","pernum","perwt","race","raced","hispan",
                                                           "hispand","sei")),
                col_types = cols(.default = "i"), #ensure that all variables are read in as integers
                progress = TRUE)

#drop cases that are missing on met2013 or SEI (i.e. have a zero value)
acs <- subset(acs, met2013>0 & sei>0)

# Tract Data --------------------------------------------------------------

#Read in the social explorer tract data from CSV. Name your object "tracts".

#After loading in the tract data, please run these lines of code. It will add
#the metro area identifier (met2013) based on the State and County ID of the tract. 
counties2cbsa <- read.csv("input/counties2cbsa.csv", header = TRUE)
tracts <- merge(tracts, counties2cbsa, all.x=TRUE, all.y=FALSE)

#Subset the data to remove any tracts with a missing met2013 id and drop variables
#we don't need

#provide better variable names
