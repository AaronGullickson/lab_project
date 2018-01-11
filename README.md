**Table of Contents**
[Introduction](#Introduction)

## Introduction

The rest of the lab assignments for the term are going to work towards doing a full statistical analysis. We will use the same git repository for each component of this project and you will "tag" your repository at various points to indicate completion of a particular assignment.

### Background

For this project, we are going to look at two theories about how the macro-level demographic context of a city might affect the level of racial inequality in that city.

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

For this assignment, you will calculate another measure of segregation called the Information Theory Index or sometimes just Theil's *H*, after its creator. The advantage of the Information Theory Index is that it can be calculated for multiple groups, whereas the dissimilarity index can only be calculated for two groups. Theil's *H* provides a measure of the diversity in areas within a region (e.g. tracts within a city, counties within a state), relative to the overall diversity of the region. When Theil's *H* equals one, there is no diversity in the subregions of a region, and when Theil's *H* equals zero, the diversity in each subregion is equal to the overall diversity of the region. You can read the first seven pages of this manuscript to learn more about the relationship between different measures of segregation.

In order to measure Theil's H, one has to first calculate a measure of diversity for each sub-region and the total region. This measure of diversity is called *entropy* and is based on the proportions of different groups within the area. If $p_j$ is the proportion of group $j$ in the region and there are $J$ total groups, then the formula for entropy ($E$) is given by:

$$E=\sum_{j=1}^{J}(p_j)\log(1/p_j)$$

Entropy will be at its maximum value when the proportion $p_j$ is the same for each group, and entropy will be at its minimum value of zero when the area is made up entirely of one group.^[The actual maximum value of entropy depends on the base one uses for the log. The standard approach is to use a log-base of 2, but segregation researchers more commonly use a natural log. I personally prefer to use a log base equal to the number of groups ($J$) because then the maximum value will be one. However, this scale issue will be factored out in the actual calculation of Theil's H, so it doesn't really matter what we use so long as we are consistent. For this exercise, we will use the natural log, given by the function `log`.] Lets take a simple example where we have three groups and the first group is 60% of the population of an area and the remaining two groups are 20% each. Entropy would be:

$$E=(0.6)*\log(1/0.6)+0.2*\log(1/0.2)+0.2*\log(1/0.2)=0.95$$

With the natural log used here for three groups, the maximum value of entropy is `r log(3)`, so this area would be considered fairly diverse.

In order to calculate Theil's *H*, one has to first calculate entropy for each sub-region ($E_i$) as well as the overall entropy for the whole region ($E$). One also needs the population totals for each sub-region ($t_i$) as well as the total population of the region ($T$). Theil's H is then given by:

$$H=1-\sum_{i=1}^n\frac{t_i*E_i}{T*E}$$

Theil's H is a weighted average of of how much the diversity of each sub-region varies from the total region. Higher values of *H* indicate more segregation in the sense that the diversity of the sub-regions is low relatively to the overall diversity of the region.

### The Assignment

For the assignment, please download this data which gives the count of individuals by race for every tract in the US, except for Washington DC and Puerto Rico. I have already calculated entropy for each of these tracts. In an R script, you should do the following:

1) Create a function that calculates Theil's *H* for a dataset of tracts from a single state.
2) Use this function in a for-loop to create a dataset of Theil's *H* for each state.
3) Plot a histogram of Theil's *H* across all states.
3) Load in my version of the final state-level data from last week's exercise and merge it with this dataset. Write out the fully merged dataset as a CSV file.

Submit your R script here to complete the assignment.

## R Markdown Assignment

In this assignment, we will answer the research question that we began with for our mini-project: How does the relative size of the black population in a state affect the difference in occupational status between whites and blacks?

In your previous assignment, you already produced the models necessary to answer this question. In this assignment, I want you to to use R Markdown to report your findings, including the results of those models as well as some graphical displays of univariate distributions and bivariate relationships.

You can use the provided R Markdown Template file to get started. This file will give you some basic instructions about the structure of the report and what content should go into each section. The full data to analyze are available here.

When completed, you can upload your R Markdown (*.Rmd) file here.

## References

Blalock, Hubert M. 1967. *Toward a Theory of Minority-Group Relations.* New York: John Wiley and Sons.

Massey, Douglas S. and Nancy A. Denton. 1993. *American Apartheid: Segregation and the Making of the Underclass.* Cambridge: Harvard University Press.
