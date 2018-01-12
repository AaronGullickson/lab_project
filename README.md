**Table of Contents**

- [Introduction](#introduction)
- [Reading and Writing Data Assignment](#reading-and-writing-data-assignment)
- [Cleaning Data Assignment](#cleaning-data-assignment)
- [Combining and Merging Data Assignment](#combining-and-merging-data-assignment)
- [Programming Assignment](#programming-assignment)
- [R Markdown Assignment](#r-markdown-assignment)
- [References](#references)

## Introduction

The rest of the lab assignments for the term are going to work towards doing a full statistical analysis. We will use the same git repository for each component of this project and you will "tag" your repository at various points to indicate completion of a particular assignment.

### Background

For this project, we are going to look at two theories about how the macro-level demographic context of a city might affect the level of racial inequality within that city.

Blalock (1967) argued that as the relative size of a minority group increases, it represents a greater perceived threat to the economic and political hegemony of the majority group, and will lead to greater efforts by the majority group to control and limit minority groups in order to maintain their power. On the other hand, Massey and Denton (1993) have argued that racial segregation is the "linchpin" of racial inequality in the US, because it concentrates disadvantage in minority neighborhoods and segregates the social networks that provide important access to resources.

### Our Project

We are going to test out Blalock's theory by looking at the association between percent black in a city and the difference in [Duncan's Socioeconomic Index](https://usa.ipums.org/usa-action/variables/SEI#description_section) (SEI) between whites and blacks in that city. To test Massey and Denton's theory, we will also examine the association between the black/white dissimilarity index (a measure of segregation) and this same racial difference in SEI. SEI is a composite measure that assigns a score to a person's occupation based on a combination of the average income earned in that occupation and the average education of individuals who hold that occupation. It is the most well-known measure in a family of occupational scoring techniques common to stratification research, although there is [considerable debate](https://usa.ipums.org/usa/chapter4/sei_note.shtml) on their usefulness.

#### Data Sources

We will use two primary data sources to construct our analytical dataset. first, we will use [Social Explorer](https://socialexplorer.com) to download census tract data for the entire US based on American Community Survey (ACS) data from 2012-2016. The ACS is an annual 1% survey of the American population conducted by the US Census Bureau that collects a variety of demographic information. Ultimately, we want data at the level of metropolitan statistical areas (i.e. cities). However, we need data at the tract level within cities in order to calculate the dissimilarity index of segregation. Therefore we will just download tract data and ultimately aggregate this up to the level of metropolitan areas.

Unfortunately, the census bureau does not publish aggregate data that will give us the mean difference in SEI between whites and blacks in a metropolitan area. In order to get this number, we will need to download the individual-level ACS data from 2014 and calculate the difference ourselves. We will be downloading the ACS extract from the [Integrated Public Use Microdata Series](https://usa.ipums.org/usa/) (IPUMS) at the Minnesota Population Center. Unfortunately, for reasons of confidentiality the metropolitan area of respondents is only available in larger metropolitan areas, so our analysis will be limited to the largest 150-200 cities in the US.

#### Overall Plan

We will develop this project over multiple exercises. Here is an overview of the individual assignments that we will complete for the project:

1. Create the necessary data extracts from Social Explorer and IPUMS and read this data into R.
2. Clean, recode, and aggregate the data up to the metro-level area.
3. Merge the dataset from social explorer with the dataset from IPUMS.
4. Calculate the dissimilarity index for each metro area and merge this into the data from (3). We now have a final analytical dataset.
5. Conduct the analysis on the analytical dataset, and write up a report of your analysis in R Markdown with tables and figures.

Further instructions for each of these assignments are provided below.

#### Tagging Releases for Assignment Completion

As you complete each assignment, you will indicate that you have completed it by "tagging" that commit. In git, you can tag any commit to keep track of important commits during the process.

In GitHub you can easily add a tag by creating a "release." in the Code tab, click on the "releases" link at the top, and then choose the button "create a new release." For the tag version, write "labX" where X is replaced by the number above (1 for the first assignment, 2 for the second and so on) and the name of the assignment is given as the title (e.g. "Reading and Writing Data Assignment"). I will then be able to tell that you have completed the assignment. If I see any issues with your code, I will correct those issues and make a new commit, so that your code is ready to go for the next assignment.

## Reading and Writing Data Assignment

For the first assignment, you will need to create a data extract from the Social Explorer dataset and the  IPUMS website and then write R code that will read these data extracts into R.

### Download Social Explorer Data

To access Social Explorer, you will need to be either on the campus network or operating through the [campus VPN](https://it.uoregon.edu/vpn). From the [Social Explorer main page](https://www.socialexplorer.com), follow these steps:

1. Choose the "Tables" option and then "American Community Survey (5 year estimates)" and then "Begin Report" for ACS 2012-2016.
2. For geography type, select Census Tract (140).
3. Do not select a state. Highlight "All census tracts" and click "Add" then "Proceed to tables."
4. Select the following variables and then "Show results":

    - T14. Hispanic or Latino by race
    - T25. Educational Attainment for Population 25 years or older.
    - T37. Unemployment Rate for Civilian Population in Labor Force 16 years and over.
    - T133. Nativity by Citizenship status.

5. Look over the tables and make sure it looks good, and then click "Data Download". Choose output options "Output column labels in the first row" and "Output ALL geographic identifiers" and then download the CSV file. This is your data file and should go in your `input` directory. You may also want to download the data dictionary for reference.

### Download IPUMS Data

Here are the steps you should follow to define your own extract:

1. Register on the [IPUMS website](https://uma.pop.umn.edu/usa/user/new?return_url=https%3A%2F%2Fusa.ipums.org%2Fusa-action%2Fmenu). Remember to use it for Good and never for Evil!

2. From The [IPUMS-USA main page](https://usa.ipums.org/usa/), go to "[Browse and Select Data](https://usa.ipums.org/usa-action/variables/group)."

3. Choose "Select Samples". Uncheck the "Default sample from each year" to de-select all samples and then choose the 2015 ACS. Click "Submit Sample Selection" at the bottom.

4. IPUMS will include several technical variables automatically. The remaining variables can be browsed and selected by clicking on the "+" button. Here are the variables that we will need:
   * In Household > Geographic > MET2013
   * In Person > Race, Ethnicity, and Nativity > RACE and HISPAN
   * In Person > Occupational Standing > SEI

5. Once you have all the variables that you need, select "View Cart" in upper right. Review your selections and then hit "Create Data Extract." On the next screen, you can write a description of your extract, and then hit "Submit Extract."

6. You will now be sent to a screen with all of your previous and pending extracts. You can also get to this page from the main page by hitting the "[Download or Revise Extract](https://usa.ipums.org/usa-action/extract_requests/download)" link. Your fixed-width data will not be immediately available. However, you will have access to some documentation, including some scripts in other software programs for reading in the data. You should save the basic codebook (its a plain text file). This codebook will provide important information on the structure and coding of the data. I would recommend saving it to your `input` directory so you have access to it from within RStudio.

7. You will get an email when you data extract is ready. You can then go to the download page and download it. The data will download with the extension .gz. This is a g-zipped file. Because R can read in gzipped files directly, we won't bother to unzip it. You should put this file into the input directory of your cloned repository (you did clone this repository, didn't you?).

One nice feature of the IPUMS site, is that you can revise extracts on the download page. If you screw something up on your first try (probable), rather than starting from scratch, you can choose to revise an extract and just remove or add the variables and or samples you forgot.

### Read in the Raw Data

You will need to write code in the `read_raw_data.R` script that reads in the fixed-width datasets you just downloaded. There is a section each for the IPUMS and tract data.

#### Reading in the IPUMS Data

The IPUMS data is in fixed-width format. The codebook should provide you with the information you need to determine the widths necessary for the `read.fwf` command. Also, because the data is g-zipped, you will want to access it with the `gzfile("input/name_of_data.dat.gz", open="r")` command. Fixed-width data can be slow to read in. On my laptop, this data took about five minutes to read. YRMV.

Note that all of the IPUMS variables are coded as numeric values. You need to use the codebook to see which categories these numbers correspond to in cases of categorical variables. There is no need to recode them as factors for this assignment as we will create our own categorical variables in the next assignment.

Be sure that all of your variables have good variable names. Furthermore, to shrink our dataset a little bit, I would like you to subset it so that only cases with a valid MET2013 and SEI (i.e. non-zero value) are kept. Once you are satisfied with your dataset, save it to the `output` directory as a CSV file with the name `ipums_data.csv`.

#### Reading in the Tract Data

The tract data is in CSV format so it should be easier to load into R. Keep in mind that if you did as I suggested above and added labels in the first row of the CSV, you will need to skip a row when you read in the CSV.

After you have read in the tract data, I would like you to run the code that is already present in the script to assign metropolitan area ids to each tract. These will not be provided in the data from social explorer, but can be determined by cross-referencing state and county ids with metropolitan statistical area ids, which is what this code does. You should then remove any tracts with a missing value on met2013 id, because these tracts do not belong to metropolitan statistical areas.

One annoying thing about the social explorer data is the non-intuitive nature of the variable names. There are also a lot of variables that we do not need. I would like you to keep only the following variables and to rename them to something more intuitive.

- `met2013` - keep this name as we will use it to merge datasets later.
- `met_name` - keep this name
- `SE_T014_001` - total population in the tract
- `SE_T014_003` - total population of non-Hispanic whites
- `SE_T014_004` - total population of non-Hispanic blacks
- `SE_T025_001` - total population over the age of 25. This is used as the denominator for the educational categories that follow
- `SE_T025_005` - total population over the age of 25 with bachelor's degree.
- `SE_T025_006` - total population over the age of 25 with master's degree.
- `SE_T025_007` - total population over the age of 25 with professional degree.
- `SE_T025_008` - total population over the age of 25 with doctoral degree.
- `SE_T037_001` - total labor force population
- `SE_T037_003` - total number of persons unemployed
- `SE_T133_033` - total number of persons foreign-born

Once you are satisfied with the tract-level data, save it as a CSV file in the `output` directory with the name "tract_data.csv".

## Cleaning Data Assignment

For this assignment, you will take the two datasets produced in the last assignment, code some variables and aggregate the data to the level of the metropolitan area. All of the code for this exercise should go in the `organize_data.R` script under the "Organize IPUMS data" and "Organize Tract data" headings.

### IPUMS Data

You should use the `race` and `hispan` variables to code a new factor variable called `racecombo`. This variable should have the following categories:

  - Non-Hispanic White
  - Non-Hispanic Black
  - non-Hispanic Asian or Pacific Islander
  - non-Hispanic American Indian or Alaska Native
  - non-Hispanic Other
  - non-Hispanic Multiple race
  - Hispanic

After creating this variable, you should run some diagnostic checks to make sure that all the observations are in the categories that you expected.

Once you are satisfied with the variable, it is time to aggregate the individual level data up to the metro-area level. Ultimately, we want to create a metro-area level dataset with the following four variables:

- `met2013`: the metro area id
- `seidiff`: the mean SEI of whites in each metro area minus the mean SEI of blacks in each metro area.
- `black_n`: the number of black respondents in the sample for the given metro area.
- `white_n`: the number of white respondents in the sample for the given metro area.

There are multiple ways you could go about this aggregation. Most likely the `tapply` function will come in handy. You do not need to save this dataset to the filesystem as we will continue to work on it in this same script in the next assignment.

### Tract Data

We want to sum up the numbers across tracts for each metro area and then use those raw counts to construct several variables. The first step will be to aggregate values up to the metro-area level. This can be done fairly easily with the `aggregate` command.

Once you have the data aggregated to the metro area, construct the following four variables:

- `pct_black`: The percent of the population that is non-Hispanic black.
- `unemployment`: The unemployment rate, which is the percent of the labor force that is unemployed.
- `pct_foreign_born`: The percent of the population that is foreign born.
- `pct_college`: The percent of the population over the age of 25 that has at least a Bachelor's degree.

Once you are satisfied with these four variables, you should drop all of the other variables in your dataset except for `met2013`. If you want a challenge, you can try to figure out how to get `met_name` back in your metro-area dataset. You do not need to save this dataset to the filesystem as we will continue to work on it in this same script in the next assignment.

## Combining and Merging Data Assignment

From the previous assignment, you should have two different metro-area level datasets. The first dataset was created by aggregating the individual-level IPUMS data and the second dataset was created by aggregating the tract-level data. In this assignment, you will merge those two datasets together into a single dataset. You should put this code in your `organize_data.R` script under the "Merge data" heading.

You should note that these two datasets do not contain the same number of observations. The IPUMS data has far fewer metro areas because only very large metro areas were identified in the individual-level data. There are also a couple of cases where the IPUMS data does not have a corresponding metro area from the tract data due to some discrepancies in identification between the two data sources. Your final dataset should contain only metro areas that had valid observations in both datasets.

Furthermore, some metro areas had very small samples of either white or black respondents. In these cases, there is likely to be a lot of statistical noise in our estimation of the SEI differences. To address this problem, I want you to remove all metro areas that had fewer than 50 black or white respondents. This is crude but fairly effective. We will learn a better way to handle this kind of issue next term (spoiler: multilevel models).

The final combined dataset should be named `met_area`. You do not need to save this dataset to the filesystem as we will continue working with this script in the next assignment.  

## Programming Assignment

For this assignment, you will calculate a measure of segregation called the Dissimilarity Index or *D* for short. The dissimilarity index compares the distribution of two groups across neighborhoods (typically operationalized as census tracts) within a city. If those two distributions are identical, then the dissimilarity index is 0. If the two groups never occupy the same neighborhoods, then you have a dissimilarity index of 100 and complete segregation. The dissimilarity index also has a very intuitive interpretation: *D* is the percent of either group that would have to move to different neighborhoods in order to create even distributions (i.e. no segregation).

The html document in this repository entitled "calculate_dissimilarity.pdf" gives the technical details of how *D* is calculated.

For this assignment, I want you to calculate *D* for each metropolitan area. You will need to use the tract-level dataset to calculate this measure. You should write most of this code in the `organize_data.R` script under the "Calculate Dissimilarity Index" section. You must do the following:

- Create a calculateDissimilarity function that when given a dataset of tracts, will compute the dissimilarity index and return the results.
- A for-loop or `lappy` command that uses the function above to actually calculate dissimilarity for each city.
- Merge this dissimilarity index into the `met_area` dataset produced in the previous assignment. This code should be done in the "Merge data" section.

## R Markdown Assignment

In this assignment, we will finally answer the research question: How does the relative size of the black population and the level of black/white segregation in a city affect the difference in occupational status between whites and blacks?

Ultimately, I want you to report your results in a short PDF report from an R Markdown file. I give you freedom in thinking about how to get there, but you will ultimately need some OLS regression models that consider controls for the percent foreign born, percent college-educated, and unemployment in a city. You will also want to give some thought to graphical displays of the univariate and bivariate distributions of key variables.

You can use the `report.Rmd` file in the repository as a skeleton for your report. This document contains some stub information about sectioning of the report and what should go into each section of the report. It also gives you templates for R code chunks that can produce figures and regression tables. You can do your initial analysis in the provided `analysis.R` script, create a separate `analysis.Rmd` file for the analysis, or just do the entire analysis in the `report.Rmd` document. I leave that choice up to you.

When your report is completed, be sure to commit the PDF file as well as the R Markdown file. Tag your release and you are done with this project!

## References

Blalock, Hubert M. 1967. *Toward a Theory of Minority-Group Relations.* New York: John Wiley and Sons.

Massey, Douglas S. and Nancy A. Denton. 1993. *American Apartheid: Segregation and the Making of the Underclass.* Cambridge: Harvard University Press.
