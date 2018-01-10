## Introduction

The rest of the lab assignments for term are going to work towards the goal of doing a full statistical analysis. We will use the same git repository for each component of this project and you will "tag" your repository at various points to indicate completion of a particular assignment.

### Background

Blalock (1967) argued that as the size of a minority group increases, it represents a greater perceived threat to the economic and political hegemony of the majority group, and will lead to greater efforts by the majority group to control and limit minority groups in order to maintain their power. Blalock's theory has been tested in many different ways. Most commonly, scholars look at the association between the relative size of a minority population and the level of racial inequality in an area (e.g. city, state). Numerous studies using this approach have shown that racial inequality between blacks and whites is higher in areas with a relatively larger black population (Beggs 1997; Blalock 1957; Burr et. al. 1991; Cohen 1998; Frisbie and Neidert 1977;  McCall 2001; Tienda and Lii 1987; Tomaskovic-Devey and Roscigno 1996).

On the other hand, Massey and Denton (1993) have argued that racial segregation is the "linchpin" of racial inequality in the US, because it concentrates disadvantage in minority neighborhoods and segregates the social networks that provide important access to resources.

### Our Project

We are going to test out Blalock's theory by looking at the association between percent black in a state and the difference in [Duncan's Socioeconomic Index](https://usa.ipums.org/usa-action/variables/SEI#description_section) (SEI) between whites and blacks in a state. To test Massey and Denton's theory, we will also examine the association between the black/white dissimilarity index (a measure of segregation) and this difference in SEI. SEI is a composite measure that assigns a score to a person's occupation based on a combination of the average income earned in that occupation and the average education of individuals who hold that occupation. It is the most well-known measure in a family of occupational scoring techniques common to stratification research, although there is [considerable debate](https://usa.ipums.org/usa/chapter4/sei_note.shtml) on their usefulness.

Its important to acknowledge up front that states are a pretty blocky unit for measuring these kinds of processes but for simplicity of an initial data analysis project, it is the unit that we will use.

For data, we will use the 2015 American Community Survey (ACS). The ACS is an annual 1% survey of the American population conducted by the US Census Bureau that collects a variety of demographic information. We will be downloading the ACS extract that we want from the [Integrated Public Use Microdata Series](https://usa.ipums.org/usa/) (IPUMS) at the Minnesota Population Center. The IPUMS is a great resource. The staff at IPUMS have compiled microdata samples of each US Census going back to 1850, as well as the recent ACS samples. They have cleaned these files and constructed a variety of variables that are consistently coded across multiple years of the Census in order to allow easier historical comparison. They also have full count data of some historical census data, and they have an international section where they are compiling data on census data from a variety of other countries.

We will also use aggregate census tract data to create some additional state-level measures and the dissimilarity index. This data is already provided in the repository

### Overall Plan

We will develop this project over multiple exercises. Here is an overview of the individual assignments that we will complete for the project:

1. Create a data extract from IPUMS, download, and read it in to R.
2. Recode the individual-level IPUMS data to get the necessary variables and subsets.
3. Aggregate individual-level and tract data to the state level and merge.
4. Calculate the dissimilarity index for each state and merge this into the state data from (3).
5. Conduct the analysis on the full state level data, and write up a report of your analysis in R Markdown with tables and figures.

Further instructions for each of these assignments are detailed below.

#### Tagging Releases for Assignment Completion

As you complete each assignment, you will indicate that you have completed it by "tagging" that commit. In git, you can tag any commit to keep track of important commits during the process.

In GitHub you can easily add a tag by creating a "release." in the Code tab, click on the "releases" link at the top, and then choose the button "create a new release." For the tag version, write "labX" where X is replaced by the number above (1 for the first assignment, 2 for the second and so on) and the name of the assignment is given as the title (e.g. "Reading and Writing Data Assignment"). I will then be able to tell that you have completed the assignment. If I see any issues with your code, I will correct those issues and make a new commit, so that your code is ready to go for the next assignment.

## Reading and Writing Data Assignment

For the first assignment, you will need to create a data extract from the IPUMS website and then write R code that will read this data extract into R.

### Download IPUMS Data

Here are the steps you should follow to define your own extract:

1. Register on the [IPUMS website](https://uma.pop.umn.edu/usa/user/new?return_url=https%3A%2F%2Fusa.ipums.org%2Fusa-action%2Fmenu). Remember to use it for Good and never for Evil!

2. From The [IPUMS-USA main page](https://usa.ipums.org/usa/), go to "[Browse and Select Data](https://usa.ipums.org/usa-action/variables/group)."

3. Choose "Select Samples". Uncheck the "Default sample from each year" to de-select all samples and then choose the 2015 ACS. Click "Submit Sample Selection" at the bottom.

4. IPUMS will include several technical variables automatically. The remaining variables can be browsed and selected by clicking on the "+" button. Here are the variables that we will need:
   * In Household > Geographic > STATEFIP, REGION
   * In Person > Race, Ethnicity, and Nativity > RACE, HISPAN, and BPL
   * In Person > Education > EDUC
   * In Person > Occupational Standing > SEI

5. Once you have all the variables that you need, select "View Cart" in upper right. Review your selections and then hit "Create Data Extract." On the next screen, you can write a description of your extract, and then hit "Submit Extract."

6. You will now be sent to a screen with all of your previous and pending extracts. You can also get to this page from the main page by hitting the "[Download or Revise Extract](https://usa.ipums.org/usa-action/extract_requests/download)" link. Your fixed-width data will not be immediately available. However, you will have access to some documentation, including some scripts in other software programs for reading in the data. You should save the basic codebook. This codebook will provide important information on the structure and coding of the data.

7. You will get an email when you data extract is ready. You can then go to the download page and download it. The data will download with the extension .gz. This is a g-zipped file. It should be unzippable in OSX just by double-clicking it. Windows users may have to download a decent unzipping program like [7-zip](http://www.7-zip.org/).

8. Once you have it unzipped, you will have a *.dat file that is just a raw ASCII text file with fixed-width data. You should put this file into the input directory of your cloned repository (you did clone this repository, didn't you?).

One nice feature of the IPUMS site, is that you can revise extracts on the download page. If you screw something up on your first try (probable), rather than starting from scratch, you can choose to revise an extract and just remove or add the variables and or samples you forgot.

### Read in the Raw Data

You will need to write code in the `read_raw_data.R` script that reads in the fixed-width data you just downloaded. This code should go under the "Read in raw data" section heading.

The codebook should provide you with the information you need to determine the widths necessary for the `read.fwf` command. Note that all of the IPUMS variables are coded as numeric values. You need to use the codebook to see which categories these numbers correspond to in case of categorical variables. There is no need to recode them as factors for this assignment as we will create our own categorical variables in the next assignment.

## Cleaning Data Assignment

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

Beggs, John J, Wayne J Villemez, and Ruth Arnold. 1997. “Black Population Concentration and Black-White Inequality: Expanding the Consideration of Place and Space Effects.” *Social Forces* 76(1):65–91.

Blalock, Hubert M. 1967. *Toward a Theory of Minority-Group Relations.* New York: John Wiley and Sons.

Blalock Jr, H M. 1957. “Per Cent Non-White and Discrimination in the South.” *American Sociological Review* 22(6):677–82.

Burr, Jeffrey A, Omer R Galle, and Mark A Fossett. 1991. “Racial Occupational Inequality in Southern Metropolitan Areas, 1940-1980: Revisiting the Visibility-Discrimination Hypothesis.” *Social Forces* 69(3):831–50.

Cohen, Philip N. 1998. “Black Concentration Effects on Black-White and Gender Inequality: Multilevel Analysis for Metropolitan Areas.” *Social Forces* 77(1):207–29.

Frisbie, W Parker, and Lisa Neidert. 1977. “Inequality and the Relative Size of Minority Populations: A Comparative Analysis.”  *American Journal of Sociology* 82(5):1007–30.

Massey, Douglas S. and Nancy A. Denton. 1993. *American Apartheid: Segregation and the Making of the Underclass.* Cambridge: Harvard University Press.

McCall, Leslie. 2001. “Sources of Racial Wage Inequality in Metropolitan Labor Markets: Racial, Ethnic, and Gender Differences.” *American Sociological Review* 66(4):520–41.

Tienda, Marta, and Ding-Tzann Lii. 1987. “Minority Concentration and Earnings Inequality: Blacks, Hispanics, and Asians Compared.” *American Journal of Sociology* 93(1):141–65.

Tomaskovic-Devey, Donald, and Vincent J Roscigno. 1996. “Racial Economic Subordination and White Gain in the U.S. South.” *American Sociological Review* 61(4):565–89.
