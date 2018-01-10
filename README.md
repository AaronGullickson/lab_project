## Introduction

The rest of the lab assignments for term are going to work towards the goal of doing a full statistical analysis. We will use the same git repository for this project and you will "tag" your repository at various points to indicate completion of a particular assignment.

### Background

We are going to test Blalock's racial threat theory [@blalock_toward_1967]. Blalock argued that as the size of a minority group increases, it represents a greater perceived threat to the economic and political hegemony of the majority group, and will lead to greater efforts by the majority group to control and limit minority groups in order to maintain their power. Blalock's theory has been tested in many different ways. Most commonly, scholars look at the association between the relative size of a minority population and the level of racial inequality in an area (e.g. city, state). Numerous studies using this approach have shown that racial inequality between blacks and whites is higher in areas with a relatively larger black population [@blalock_jr_per_1957; @frisbie_inequality_1977; @tienda_minority_1987, @burr_racial_1991; @tomaskovic-devey_racial_1996; @beggs_black_1997; @cohen_black_1998; @mccall_sources_2001].

### Our Project

We are going to test out Blalock's theory by looking at the association between percent black by state and the difference in [Duncan's Socioeconomic Index](https://usa.ipums.org/usa-action/variables/SEI#description_section) (SEI) between whites and blacks in a state. SEI is a composite measure that assigns a score to a person's occupation based on a combination of the average income earned in that occupation and the average education of individuals who hold that occupation. It is the most well-known measure in a family of occupational scoring techniques common to stratification research, although there is [considerable debate](https://usa.ipums.org/usa/chapter4/sei_note.shtml) on their usefulness.

For data, we will use the 2015 American Community Survey (ACS). The ACS is an annual 1% survey of the American population conducted by the US Census Bureau that collects a variety of demographic information. We will be downloading the ACS extract that we want from the [Integrated Public Use Microdata Series](https://usa.ipums.org/usa/) (IPUMS) at the Minnesota Population Center. The IPUMS is a great resource. The staff at IPUMS have compiled microdata samples of each US Census going back to 1850, as well as the recent ACS samples. They have cleaned these files and constructed a variety of variables that are consistently coded across multiple years of the Census in order to allow easier historical comparison. They also have full count data of some historical census data, and they have an international section where they are compiling data on census data from a variety of other countries.

We will also use some data from the 2012 Economic Census of the US. This data is already provided in the repository.

### Overall Plan

We will develop this project over multiple exercises. Here is an overview of the individual assignments that we will complete for the project:


#### Tagging Releases for Assignment Completion

### Directory Structure

## Reading and Writing Data Assignment

### Download IPUMS Data

In order for everyone to become familiar with using online sources for data, I want you to try to download the data that we will use for our analysis, even though we all want the exact same datat set. Here are the steps you should follow to define your own extract:

1. Register on the [IPUMS website](https://uma.pop.umn.edu/usa/user/new?return_url=https%3A%2F%2Fusa.ipums.org%2Fusa-action%2Fmenu). Remember to use it for Good and never for Evil!

2. From The [IPUMS-USA main page](https://usa.ipums.org/usa/), go to "[Browse and Select Data](https://usa.ipums.org/usa-action/variables/group)."

3. Choose "Select Samples". Hit the "Default sample from each year" to de-select all samples and then choose the 2015 ACS. Click "Submit Sample Selection" at the bottom.

4. IPUMS will include several technical variables automatically. The remaining variables can be browsed and selected by clicking on the "+" button. Here are the variables that we will need:
   * In Household > Geographic > STATEFIP, REGION
   * In Person > Race, Ethnicity, and Nativity > RACE, HISPAN, and BPL
   * In Person > Education > EDUC
   * In Person > Occupational Standing > SEI

5. Once you have all the variables that you need, select "View Cart" in upper right. Review your selections and then hit "Create Data Extract." On the next screen, you can write a description of your extract, and then hit "Submit Extract."

6. You will now be sent to a screen with all of your previous and pending extracts. You can also get to this page from the main page by hitting the "[Download or Revise Extract](https://usa.ipums.org/usa-action/extract_requests/download)" link. Your fixed-width data will not be immediately available. However, you will have access to a Stata do-file that you can run once your have your data in order to load it into Stata. You should either save this do-file to your computer (using the "Save page as" option on your browser to save it as a do-file) or copy and paste its contents into an empty do-file editor.

7. You will get an email when you data extract is ready. You can then go to the download page and download it. The data will download with the extention .gz. This is a g-zipped file. It should be unzippable in OSX just by double-clicking it. Windows users may have to download a decent unzipping program like [7-zip](http://www.7-zip.org/).

8. Once you have it unzipped, you should be the final .dat file in the same directory as the do-file you downloaded earlier. You can now load the data into Stata by simply running that do-file from within Stata.

9. One nice feature of the IPUMS site, is that you can revise extracts on the download page. If you screw something up on your first try (probable), rather than starting from scratch, you can choose to revise an extract and just remove or add the variables and or samples you forgot.

Our goal in this exercise is to get this data loaded into R and Stata. You should follow the steps listed below. Unlike our previous exercises, you will not have to turn in a script, but you should keep one for later use.

1. Load the data into Stata using the do-file from the IPUMS download page. Use the `outsheet` and `save` commands to save the data as a CSV file and a binary file, respectively. Be sure to use the `comma` option with outsheet.
2. Load the data into R using three different techniques. After loading the data using each technique, run a `summary` command on the full dataset.
    a. Load the data from the original fixed-width data file (.dat) using `read.fwf`. You can figure out the width of each variable by looking at the indices from the Stata do-file or the codebook on the IPUMS download page. WARNING: this technique will be slow.
    b. Load the data from the CSV file you created in Step 1, using `read.csv`.
    c. Load the data from the binary Stata data file (.dta) you created in Step 1, using `read.dta13` from the `readstata13` library. Remember that you will need to install that library using the command `install.packages("readstata13")`.

## Cleaning Data Assignment

We are going to continue working with the data that we downloaded last week. To ensure that we are all working with the same base data, please download my version of this data in Stata 14 DTA format. You can use the `read.dta13` command in the `readstata13` library to read it into R or the `use` command to read it into Stata.

You will write a script in either R or Stata that cleans and organizes this data for our later analysis. First, you will assign missing values to all variables. Second, you will create the following new variables in the dataset:

- A categorical variable called `racecombo` that combines the `race` and `hispan` variables to create the following categories:
    - Non-Hispanic White
    - Non-Hispanic Black
    - non-Hispanic Asian or Pacific Islander
    - non-Hispanic American Indian or Alaska Native
    - non-Hispanic Other
    - non-Hispanic Multiple race
    - Hispanic
- A categorical variable for regions named `bigregion` with the following collapsed categories based on `region`:
    - Northeast: New England+Middle Atlantic+Delaware
    - South: South Atlantic (except Delaware) + East South Central + West South Central
    - Midwest: East North Central + West North Central
    - West: Mountain + Pacific
- A dichotomous categorical variable called `birthplace` with the categories:
    - Foreign-born
    - Native-born
- A dichotomous categorical variable named `college` with the categories:
    - Four year college degree or more
    - less than a four year college degree

When working with the data, you will likely find the [IPUMS documentation](https://usa.ipums.org/usa-action/variables/group) on variable codes to be helpful.

Once variables are coded, you should code some diagnostic tools to check and make sure the code did what you intended it to do (e.g. crosstabs, summaries, figures). Finally, you should output your re-coded data as a CSV file.

Once complete, upload your final R script or Stata do-file here.

## Combining and Merging Data Assignment

We are going to continue working with the data that we cleaned last week. Everyone should download my version of the cleaned data so that we are all working from the same base.^[You can also see my do-file for creating this cleaned up dataset here.] Be sure to use the option `na.strings=NA` in your `read.csv` command to read in missing values properly.

This week we are going to aggregate this data to the state level so that our units of analysis are individual states rather than individual respondents and we are going to merge this state aggregated data with some other data from the 2012 Economic Census of the US on the relative frequency of different types of industry at the state level.

1. The first step is to create the state aggregated data from the individual level data. You should be able to use the `tapply` command with the `fips` variable as the second command to produce vectors of the aggregated data listed below. For some of these you will have to think creatively about the most efficient way to get the aggregated data. Remember that boolean statements and `tapply` are your friend.
- The percent of each state's population that is non-Hispanic black, named `pctblack`.
- The percent of each state's population that is foreign-born, named `pctforeign`.
- The percent of each state's population with a college degree, named `pctcollege`.
- mean SEI for each state, named `meansei`.
- The big region of the country where each state is located, named `region`. (see footnote below for hint on how to do this)
- The difference in SEI between NH whites and NH blacks in a state, named `diffsei`.
- The difference in college completion percent between NH whites and NH blacks, named `diffcollege`.

2. Once you have created all of these variables, you will want to combine them together into a single `data.frame` along with the state FIPS code and name^[Extracting the FIPS code and state name can be a little tricky. The code `temp <- census[!duplicated(census$fips),c("fips","state_name","bigregion")]` should give you something useable. Note that this will also give you the region of each state.] using the `data.frame` command. Name this data.frame `states`.

3. Download the CSV data from the 2012 Economic Census of the US and `merge` this data with the `states` data.frame. Finally, you can remove the observation for Washington DC, because we have no data on this from the Economic Census data and it doesn't really fit here anyway because its a city and not a state. Finally use `write.csv` to write out your dataset to a file.

Be sure to run checks on your code. When done, upload your R script here to complete the assignment.


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
