##################################################################################
# organize_data.R
# Your Name Here
# This script will be used to construct an analytical dataset of metro areas from 
# the raw data sources. The final metro area dataset will be saved to the output 
# directory as "met_area.csv". 
##################################################################################

#read in the CSV files created from read_raw_data.R
ipums <- read.csv("output/ipums_data.csv")
tracts <- read.csv("output/tract_data.csv")

# Organize IPUMS data -----------------------------------------------------

#create combined race variable

#check yourself before you wreck yourself

#Now calculate the difference in white-black mean SEI by metro area. Also count the number of
#black and white respondents by metro area. Put all of these variables into a new data.frame. 


# Organize tract data -----------------------------------------------------

#aggregate tracts by metro area

#now calculate metro area summary statistics

#get rid of extra variables


# Calculate Dissimilarity Index -------------------------------------------

#create a function that will calculate black/white dissimiliarity from a set of tracts
calculateDissimilarity <- function(city) {
  #your function here
}

#for-loop through each metro area and calculate dissimilarity

#put results in a data.frame


# Merge data --------------------------------------------------------------

#merge the aggregated IPUMS data with the aggregated tract data to get full metro area data

#remove metro areas where the sample from IPUMS contained less than 50 black respondents
#and if there was no data from the tract-level data

#merge in the dissimilarity index 


# Save final dataset ------------------------------------------------------

#save full metro area data as CSV mamed "met_area.csv" in output directory
