##################################################################################
# organize_data.R
# Your Name Here
# This script will be used to construct an analytical dataset of metro areas from 
# the raw data sources. The final metro area dataset will be saved to the output 
# directory as "met_area.csv". 
##################################################################################

source("read_raw_data.R")

# Organize IPUMS data -----------------------------------------------------

#create combined race variable

#check yourself before you wreck yourself

#Aggregate mean SEI for each metro area and calculate the difference 
#in white-black mean SEI by metro area. 

#Count the number of black and white respondents by metro area

#Put aggregated metro area variables into a new data.frame.


# Organize tract data -----------------------------------------------------

#aggregate tracts by metro area

#now calculate metro area summary statistics

#get rid of extra variables


# Calculate Dissimilarity Index -------------------------------------------

#create a function that will calculate black/white dissimiliarity from a 
#set of tracts
calculateDissimilarity <- function(city) {
  #your function here
}

#for-loop or lapply through each metro area and calculate dissimilarity

#put results in a data.frame and merge this data.frame with combined 
#data.frame


# Merge data --------------------------------------------------------------

#merge the aggregated IPUMS data with the aggregated tract data to get full
#metro area data

#remove metro areas where the sample from IPUMS contained less than 50 black
#respondents or less than 50 white respondents and if there was no data from the
#tract-level data

#merge in the dissimilarity index 

#re-organize the ordering of variables as you see fit

# Save final dataset ------------------------------------------------------

#save full metro area data as an RData file named "met_area.RData" in output
#directory
