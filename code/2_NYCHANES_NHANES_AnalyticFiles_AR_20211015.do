
*****************************************************************
*							NYCHANES							*
*****************************************************************

use "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\raw_data\nyc-hanes-datasets-and-resources-analytic-data-sets-sas-file.dta" 

keep ACASI_WT AGEGROUP AGEGRP3C AGEGRP4C AGEGRP5C ASIAN BMI BMI3CAT BMI4CAT ///
 BORN US_BORN BOROSTRATUM CAPI_WT DMQ_1 DMQ_2 DMQ_5 DMQ_6 DMQ_12 DMQ_15 ///
 DMQ_13OTH DMQ_13_1 DMQ_13_2 DMQ_13_3 DMQ_14OTH DMQ_14_1 DMQ_14_2 ///
 DMQ_14_3 DMQ_16OTH DMQ_16_1 DMQ_16_2 DMQ_5A EDU EDU3CAT EDU4CAT ///
 EDUCATION GENDER HHNEST HIQ_1 IMQ_4 IMQ_5 IMQ_6 INC10K INC20K INC25K ///
 INC25KMOD INC5K INCOME KEY LAQ1 MARITAL MARITALMOD ORALSEX OSEXFEM ///
 OSEXMALE POVGROUP4_0812 POVGROUP4_0812CT POVGROUP6_0812 POVGROUP6_0812CT ///
 PREGNANT PSUNEST RACE RACECKDEPI RHQ_1 RHQ_2 RHQ_3 RHQ_4 RHQ_5 RHQ_6 ///
 RHQ_7 RHQ_8 RHQ_9 RHQ_10 RHQ_7OTH SEXORIENT SPAGE SXQ_21 SXQ_10F SXQ_10M ///
 SXQ_11F SXQ_11M SXQ_12F SXQ_12M SXQ_13F SXQ_13M SXQ_14F SXQ_14M SXQ_15F ///
 SXQ_15M SXQ_16F SXQ_16M SXQ_17F SXQ_17M SXQ_18F SXQ_18M SXQ_19M SXQ_1F ///
 SXQ_1M SXQ_20M SXQ_22M SXQ_23F SXQ_23M SXQ_2F SXQ_2M SXQ_3F SXQ_3M ///
 SXQ_4F SXQ_4M SXQ_5F SXQ_5M SXQ_6F SXQ_6M SXQ_7F SXQ_7M SXQ_8F ///
 SXQ_8M SXQ_9F SXQ_9M US_BORN US_MENST WT_ACASI


tab1 AGEGROUP AGEGRP3C AGEGRP4C AGEGRP5C

tab SPAGE AGEGRP5C, r

****Analysis limited to those who answered the main questions the ACASI portion of the interview****

gen included=0
replace included=1 if inlist(SXQ_1M, 1, 2) | inlist(SXQ_2M, 1, 2) | ///
	inlist(SXQ_3M, 1, 2) | inlist(SXQ_4M, 1, 2) | inlist(SXQ_1F, 1, 2) | ///
	inlist(SXQ_2F, 1, 2) | inlist(SXQ_3F, 1, 2) | inlist(SXQ_4F, 1, 2)

	
replace included=. if SXQ_1M==. & SXQ_2M==. & SXQ_3M==. & SXQ_4M==. & ///
	SXQ_1F==. & SXQ_2F==. & SXQ_3F==. & SXQ_4F==.

	
save "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\analytic_data\NYCHANES_2013_2014.dta", replace


*****************************************************************
*							NHANES								*
*****************************************************************
cd "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\raw_data"
*2013-2014 NHANES
* Demographic data
import sasxport "DEMO_H.XPT", clear
sort seqn
save DEMO_1314H, replace

* Reproductive health
import sasxport "RHQ_H.XPT", clear
sort seqn
save RHQ_1314H, replace

* Sexual health
import sasxport "SXQ_H.XPT", clear
sort seqn
save SXQ_1314H, replace

* BMI
import sasxport "BMX_H.XPT", clear
sort seqn
save BMX_1314H, replace

use DEMO_1314H, clear
merge seqn using  RHQ_1314H SXQ_1314H BMX_1314H
gen survey=1314
save "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\intermediate_data\NHANES1314", replace

*2011-2012 NHANES
* Demographic data
import sasxport "DEMO_G.XPT", clear
sort seqn
save DEMO_1112H, replace

* Reproductive health
import sasxport "RHQ_G.XPT", clear
sort seqn
save RHQ_1112H, replace

* Sexual health
import sasxport "SXQ_G.XPT", clear
sort seqn
save SXQ_1112H, replace

* BMI
import sasxport "BMX_G.XPT", clear
sort seqn
save BMX_1112H, replace

use DEMO_1112H, clear
merge seqn using  RHQ_1112H SXQ_1112H BMX_1112H
gen survey=1112	
save "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\intermediate_data\NHANES1112.dta", replace

*Append NHANES 2013-2014 and restrict to ages>=20
append using "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\intermediate_data\NHANES1314.dta"
keep if ridageyr>=20

gen mec4yr = 1/2 * wtmec2yr

****Analysis limited to those who answered the main questions the ACASI portion of the interview****;
gen included=.
replace included=1 if sxd021==1 | sxd021==2


save "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\analytic_data\NHANES_2011_2014.dta", replace
