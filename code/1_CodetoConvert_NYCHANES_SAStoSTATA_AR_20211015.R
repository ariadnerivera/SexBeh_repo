
setwd("C:/Users/rivera30/OneDrive - NYU Langone Health/NYC Sexual Behavior/Ariadne/SexBeh_repo/raw_data")


library(haven)

nyc_hanes<- read_sas("nyc-hanes-datasets-and-resources-analytic-data-sets-sas-file.sas7bdat", 
                                                                         NULL)

write_dta(nyc_hanes,"C:/Users/rivera30/OneDrive - NYU Langone Health/NYC Sexual Behavior/Ariadne/SexBeh_repo/raw_data/nyc-hanes-datasets-and-resources-analytic-data-sets-sas-file.dta")
