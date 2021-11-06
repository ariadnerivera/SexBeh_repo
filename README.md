This repository is to keep code and files needed to create the descriptive
analysis of Sexual Behaviors in NYC and at the National level using NYC HANES
and NHANES data.

All data files used in this analysis are publicly available.

**NHANES**
From NHANES We will need the files for: demographic data, reproductive health,
sexual health, and BMI.

* NHANES data for 2011-2012 can be downloaded from https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx?BeginYear=2011

* NHANES data for 2013-2014 can be downloaded from https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx?BeginYear=2013

**NYCHANES**
* NYC HANES for 2013-2014 can be downloaded from https://med.nyu.edu/departments-institutes/population-health/divisions-sections-centers/epidemiology/center-innovation-measuring-population-health/new-york-city-health-nutrition-examination-survey/datasets-resources


All analysis was conducted in STATA, graphs were made in R. The order to run
the files is:
1. [Convert NYC HANES SAS file to STATA](code/1_CodetoConvert_NYCHANES_SAStoSTATA_AR_20211015.R)
2. [Create analytic files for NHANES and NYCHANES](code/2_NYCHANES_NHANES_AnalyticFiles_AR_20211015.do)
- These files restrict analysis to those who answered the ACASI portion of the questionnaire and those aged between 20-69.
3. [Code to get outcomes by characteristic](code/3_Outcomes_NYCHANES_NHANES_AR_20211005.do)
- This code creates tabulations needed for graphs and sample sizes and puts results in an excel file.
4. [Code to create Table 1 tabulations](code/4_DescriptiveCharacteristics_NYCHANES_NHANES_Table1_AR.do)
- This code is to create tabulations included in Table 1 of the manuscript
5. [Code for graphs](code/5_Graphs_NYCHANES_NHANES_SEXBEH_AR_20210921.R)
- This code is to create the graphs included.

The outputs of the code used are as follows:
- The **raw files** are [here](/raw_data)
- The **intermediate files** are [here](/intermediate_data)
- The **analytic files** are [here](/analytic_data)
- **Results** and **graphs** included in this study are [here](/results)
