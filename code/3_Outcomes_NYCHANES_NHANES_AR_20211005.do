
*NYC Hanes, this is based on Priscillas cleaning

use "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\analytic_data\NYCHANES_2013_2014.dta", clear
cd "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\results"


****Have you had type of sexual intercourse****;
gen everhadvagsex=. 
replace everhadvagsex=1 if SXQ_1M == 1 | SXQ_1F == 1
replace everhadvagsex=10 if SXQ_1M == 2 | SXQ_1F == 2

gen everhadoralsex=. 
replace everhadoralsex=1 if SXQ_2M == 1 | SXQ_2F == 1
replace everhadoralsex=10 if SXQ_2M == 2 | SXQ_2F == 2

gen everhadanalsex=. 
replace everhadanalsex=1 if SXQ_3M == 1 | SXQ_3F == 1
replace everhadanalsex=10 if SXQ_3M == 2 | SXQ_3F == 2

gen everhadsamesexsex=. 
replace everhadsamesexsex=1 if SXQ_4M == 1 | SXQ_4F == 1
replace everhadsamesexsex=10 if SXQ_4M == 2 | SXQ_4F == 2

rename *, lower

gen agegrp4cat=.
replace agegrp4cat=1 if spage>=20 & spage<30
replace agegrp4cat=2 if spage>=30 & spage<40
replace agegrp4cat=3 if spage>=40 & spage<50
replace agegrp4cat=4 if spage>=50 & spage<60

gen agegrp6c=.
replace agegrp6c=1 if spage>=20 & spage<30
replace agegrp6c=2 if spage>=30 & spage<40
replace agegrp6c=3 if spage>=40 & spage<50
replace agegrp6c=4 if spage>=50 & spage<60
replace agegrp6c=5 if spage>=60 & spage<70
replace agegrp6c=6 if spage>=70 


* In SAS this is the svy design
* weight: acasi_wt;
* CLUSTER PSUNEST HHNEST;
* STRATA BOROSTRATUM;

egen cluster = group(psunest hhnest)

svyset cluster [pweight= acasi_wt], strata(borostratum) singleunit(certainty) || _n

svy: tab gender bmi3cat, se
svy: tab gender bmi3cat, se missing count cellwidth(15) format(%15.2g)


* Question how to get age standardized weights. 
* Standard weight for age groups
* STDVAR agegrp5c;
* STDWGT 0.180912 0.172873 0.189153 0.184935 0.272127;

* Past year, number of sex partners 

* Following this classification: https://link.springer.com/article/10.1007/s13178-021-00568-9/tables/2 

* Vaginal Sex *

* In the past 12 months, with how many men/women have you had vaginal sex? 

gen vagsexpartners=. 
replace vagsexpartners=0 if  sxq_8m==0 | sxq_8f==0
replace vagsexpartners=1 if  sxq_8m==1 | sxq_8f==1
replace vagsexpartners=2 if  (sxq_8m>1 & sxq_8m<.) 
replace vagsexpartners=2 if  (sxq_8f>1 & sxq_8f<.)


* Ever had vaginal sex
* Males 
tab sxq_8m sxq_1m if gender==1 , mi

* Females 
tab sxq_8f sxq_1f if gender==2 , mi

* Replace with 0 if never had vag sex in life 
* Males
replace vagsexpartners=0 if gender==1 & sxq_1m==2

* Females
replace vagsexpartners=0 if gender==2 & sxq_1f==2

* tab to check if the replacement was correct
tab vagsexpartners sxq_8m if gender==1 , mi
tab vagsexpartners sxq_8f if gender==2, mi


* Oral sex * 

* In the past 12 months, with how many men/women have you had oral sex? 
gen oralsexpartners=. 
replace oralsexpartners=0 if  sxq_9m==0 | sxq_9f==0
replace oralsexpartners=1 if  sxq_9m==1 | sxq_9f==1
replace oralsexpartners=2 if  (sxq_9m>1 & sxq_9m<.) 
replace oralsexpartners=2 if  (sxq_9f>1 & sxq_9f<.)

* Replace with 0 if never had vag sex in life 
replace oralsexpartners=0 if gender==1 & sxq_2m==2 
replace oralsexpartners=0 if gender==2 & sxq_2f==2

* tab to check if the replacement was correct
tab oralsexpartners sxq_2m if gender==1 , mi
tab oralsexpartners sxq_2f if gender==2, mi


* In the past 12 months, with how many men/women have you had same sex? 
gen samesexpartners=. 
replace samesexpartners=0 if  sxq_15m==0 | sxq_15f==0
replace samesexpartners=1 if  sxq_15m==1 | sxq_15f==1
replace samesexpartners=2 if  (sxq_15m>1 & sxq_15m<.) 
replace samesexpartners=2 if  (sxq_15f>1 & sxq_15f<.)

* Replace with 0 if never had vag sex in life 
replace samesexpartners=0 if gender==1 & sxq_4m==2 
replace samesexpartners=0 if gender==2 & sxq_4f==2

* tab to check if the replacement was correct
tab samesexpartners sxq_4m if gender==1 , mi r
tab samesexpartners sxq_4f if gender==2, mi r

* tab to check if the replacement was correct
tab samesexpartners sxq_4m if gender==1 , mi r
tab samesexpartners sxq_4f if gender==2, mi r


*Anal sex* 
gen analsexpartners=. 
replace analsexpartners=0 if sxq_10m==0 | sxq_10f==0
replace analsexpartners=1 if sxq_10m==1 | sxq_10f==1
replace analsexpartners=2 if  (sxq_10m>1 & sxq_10m<.) 
replace analsexpartners=2 if  (sxq_10f>1 & sxq_10f<.)

* Replace with 0 if never had anal sex in life 
replace analsexpartners=0 if gender==1 & sxq_3m==2 & analsexpartners==.
replace analsexpartners=0 if gender==2 & sxq_3f==2 & analsexpartners==.

replace analsexpartners=0 if gender==1 & sxq_4m==2 & analsexpartners==.
replace analsexpartners=0 if gender==2 & sxq_4f==2 & analsexpartners==.


* create weight to standardize by age, 5 groups
gen STDWGT4=.
replace STDWGT4=0.2535027 if agegrp4cat==1
replace STDWGT4=0.2383826 if agegrp4cat==2
replace STDWGT4=0.2589169 if agegrp4cat==3
replace STDWGT4=0.2491978 if agegrp4cat==4


* create weight to standardize by age, 5 groups
gen STDWGT5=.
replace STDWGT5=0.189322 if agegrp5c==1
replace STDWGT5=0.178030 if agegrp5c==2
replace STDWGT5=0.193365 if agegrp5c==3
replace STDWGT5=0.186107 if agegrp5c==4
replace STDWGT5=0.253177 if agegrp5c==5

*weights to standardize by age and sex
*gen STDWGTFEM=.
*replace STDWGTFEM=0.180912 if agegrp5c==1 & gender==2
*replace STDWGTFEM=0.172873 if agegrp5c==2 & gender==2
*replace STDWGTFEM=0.189153 if agegrp5c==3 & gender==2
*replace STDWGTFEM=0.184935 if agegrp5c==4 & gender==2
*replace STDWGTFEM=0.272127 if agegrp5c==5 & gender==2

*gen STDWGTMALE=.
*replace STDWGTMALE=0.198278 if agegrp5c==1 & gender==1
*replace STDWGTMALE=0.183522 if agegrp5c==2 & gender==1
*replace STDWGTMALE=0.197851 if agegrp5c==3 & gender==1
*replace STDWGTMALE=0.187354 if agegrp5c==4 & gender==1
*replace STDWGTMALE=0.232995 if agegrp5c==5 & gender==1


*AGEGRP6C	Population	Weight
*1: 20-29	42687848	0.189321581
*2: 30-39	40141741	0.178029538
*3: 40-49	43599555	0.193365022
*4: 50-59	41962930	0.186106553
*5: 60-69	29253187	0.129738552
*6: 70 and over	27832721	0.123438753
*Total	225477982	1


* create weight to standardize by age, 6 groups
gen STDWGT6=.
replace STDWGT6=0.189321581 if agegrp6c==1
replace STDWGT6=0.178029538 if agegrp6c==2
replace STDWGT6=0.193365022 if agegrp6c==3
replace STDWGT6=0.186106553 if agegrp6c==4
replace STDWGT6=0.129738552 if agegrp6c==5
replace STDWGT6=0.123438753 if agegrp6c==6



svy, over(bmi3cat): prop vagsexpartners
svy, over(race): prop vagsexpartners


*Sex 
putexcel set NYC_HANES_4cat_20211016.xlsx, sheet(ever_sex) modify

svy, over(gender): prop everhadvagsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix evervagsex_sex = r(table)
matrix sampleevervagsex_sex = e(N)
putexcel A1 = matrix(evervagsex_sex), names nformat(number_d4)
putexcel A12= matrix(sampleevervagsex_sex)

svy, over(gender): prop everhadoralsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix everoralsex_sex = r(table)
matrix sampleeveroralsex_sex = e(N)
putexcel A15 = matrix(everoralsex_sex), names nformat(number_d4)
putexcel A26= matrix(sampleeveroralsex_sex)

svy, over(gender): prop everhadsamesexsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix eversamesex_sex = r(table)
matrix sampleeversamesex_sex = e(N)
putexcel A30 = matrix(eversamesex_sex), names nformat(number_d4)
putexcel A41= matrix(sampleeversamesex_sex)

svy, over(gender): prop everhadanalsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix everhadanalsex_sex = r(table)
matrix sampleeveranalsex_sex = e(N)
putexcel A45 = matrix(everhadanalsex_sex), names nformat(number_d4)
putexcel A56= matrix(sampleeveranalsex_sex)


*Race 
putexcel set NYC_HANES_4cat_20211016.xlsx, sheet(ever_race) modify

svy, over(race): prop everhadvagsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix evervagsex_race = r(table)
matrix sampleevervagsex_race = e(N)
putexcel A1 = matrix(evervagsex_race), names nformat(number_d4)
putexcel A12= matrix(sampleevervagsex_race)

svy, over(race): prop everhadoralsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix everoralsex_race = r(table)
matrix sampleeveroralsex_race = e(N)
putexcel A15 = matrix(everoralsex_race), names nformat(number_d4)
putexcel A26= matrix(sampleeveroralsex_race)

svy, over(race): prop everhadsamesexsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix eversamesex_race = r(table)
matrix sampleeversamesex_race = e(N)
putexcel A30 = matrix(eversamesex_race), names nformat(number_d4)
putexcel A41= matrix(sampleeversamesex_race)

svy, over(race): prop everhadanalsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix everhadanalsex_sex = r(table)
matrix sampleeveranalsex_sex = e(N)
putexcel A45 = matrix(everhadanalsex_sex), names nformat(number_d4)
putexcel A56= matrix(sampleeveranalsex_sex)


*BMI 

putexcel set NYC_HANES_4cat_20211016.xlsx, sheet(ever_bmi) modify

svy, over(bmi3cat): prop everhadvagsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix evervagsex_bmi = r(table)
matrix sampleevervagsex_bmi = e(N)
putexcel A1 = matrix(evervagsex_bmi), names nformat(number_d4)
putexcel A12= matrix(sampleevervagsex_bmi)

svy, over(bmi3cat): prop everhadoralsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix everoralsex_bmi = r(table)
matrix sampleeveroralsex_bmi = e(N)
putexcel A15 = matrix(everoralsex_bmi), names nformat(number_d4)
putexcel A26= matrix(sampleeveroralsex_bmi)

svy, over(bmi3cat): prop everhadsamesexsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix eversamesex_bmi = r(table)
matrix sampleeversamesex_bmi = e(N)
putexcel A30 = matrix(eversamesex_bmi), names nformat(number_d4)
putexcel A41= matrix(sampleeversamesex_bmi)

svy, over(bmi3cat): prop everhadanalsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix everhadanalsex_sex = r(table)
matrix sampleeveranalsex_sex = e(N)
putexcel A45 = matrix(everhadanalsex_sex), names nformat(number_d4)
putexcel A56= matrix(sampleeveranalsex_sex)



**************
** Number of partners in the past year limited to those who ever had each type of sex
replace vagsexpartners =. if everhadvagsex==0 & vagsexpartners==0
replace oralsexpartners =. if everhadoralsex==0 & oralsexpartners==0
replace samesexpartners =. if everhadsamesexsex ==0 & samesexpartners==0
replace analsexpartners =. if everhadanalsex ==0 & analsexpartners==0

 

* gender
putexcel set NYC_HANES_4cat_20211016.xlsx, sheet(sexpartners_sex) modify

svy, over(gender): prop vagsexpartners, stdize(agegrp4cat) stdweight(STDWGT4) 
matrix partnersvagsex_sex = r(table)
matrix samplepartnersvagsex_sex = e(N)
putexcel A1 = matrix(partnersvagsex_sex), names nformat(number_d4)
putexcel A12= matrix(samplepartnersvagsex_sex)

svy, over(gender): prop oralsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersoralsex_sex = r(table)
matrix samplepartnersoralsex_sex = e(N)
putexcel A15 = matrix(partnersoralsex_sex), names nformat(number_d4)
putexcel A26= matrix(samplepartnersoralsex_sex)

svy, over(gender): prop samesexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnerssamesex_sex = r(table)
matrix samplepartnerssamesex_sex = e(N)
putexcel A30 = matrix(partnerssamesex_sex), names nformat(number_d4)
putexcel A41= matrix(samplepartnerssamesex_sex)

svy, over(gender): prop analsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix analsexpartners_sex = r(table)
matrix samplepartnersanalsex_sex = e(N)
putexcel A45 = matrix(analsexpartners_sex), names nformat(number_d4)
putexcel A56= matrix(samplepartnersanalsex_sex)

*Figure in the manuscript results section
gen samesexpartners1plus=samesexpartners
replace samesexpartners1plus=1 if samesexpartners1plus==2
svy, over(gender): prop samesexpartners1plus,  stdize(agegrp4cat) stdweight(STDWGT4)


svy, over(gender): prop samesexpartners if samesexpartners>=1 , stdize(agegrp5c) stdweight(STDWGT5)


svy, over(gender): prop samesexpartners, stdize(agegrp4cat) stdweight(STDWGT4)


* race
putexcel set NYC_HANES_4cat_20211016.xlsx, sheet(sexpartners_race) modify

svy, over(race): prop vagsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersvagsex_race = r(table)
matrix samplepartnersvagsex_race = e(N)
putexcel A1 = matrix(partnersvagsex_race), names nformat(number_d4)
putexcel A12= matrix(samplepartnersvagsex_race)

svy, over(race): prop oralsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersoralsex_race = r(table)
matrix samplepartnersoralsex_race = e(N)
putexcel A15 = matrix(partnersoralsex_race), names nformat(number_d4)
putexcel A26= matrix(samplepartnersoralsex_race)

svy, over(race): prop samesexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnerssamesex_race = r(table)
matrix samplepartnerssamesex_race = e(N)
putexcel A30 = matrix(partnerssamesex_race), names nformat(number_d4)
putexcel A41= matrix(samplepartnerssamesex_race)

svy, over(race): prop analsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix analsexpartners_sex = r(table)
matrix samplepartnersanalsex_sex = e(N)
putexcel A45 = matrix(analsexpartners_sex), names nformat(number_d4)
putexcel A56= matrix(samplepartnersanalsex_sex)

* bmi
putexcel set NYC_HANES_4cat_20211016.xlsx, sheet(sexpartners_bmi) modify

svy, over(bmi3cat): prop vagsexpartners, stdize(agegrp4cat) stdweight(STDWGT4) 
matrix partnersvagsex_bmi = r(table)
matrix samplepartnersvagsex_bmi = e(N)
putexcel A1 = matrix(partnersvagsex_bmi), names nformat(number_d4)
putexcel A12= matrix(samplepartnersvagsex_bmi)

svy, over(bmi3cat): prop oralsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersoralsex_bmi = r(table)
matrix samplepartnersoralsex_bmi = e(N)
putexcel A15 = matrix(partnersoralsex_bmi), names nformat(number_d4)
putexcel A26= matrix(samplepartnersoralsex_bmi)

svy, over(bmi3cat): prop samesexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnerssamesex_bmi = r(table)
matrix samplepartnerssamesex_bmi = e(N)
putexcel A30 = matrix(partnerssamesex_bmi), names nformat(number_d4)
putexcel A41= matrix(samplepartnerssamesex_bmi)

svy, over(bmi3cat): prop analsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix analsexpartners_sex = r(table)
matrix samplepartnersanalsex_sex = e(N)
putexcel A45 = matrix(analsexpartners_sex), names nformat(number_d4)
putexcel A56= matrix(samplepartnersanalsex_sex)

******Tabulations to obtain sample sizes

egen eversex=  rowmiss( everhadvagsex everhadoralsex everhadsamesexsex everhadanalsex)

*age
tab agegrp5c eversex if eversex!=3
tab2xl agegrp5c eversex if eversex!=3 using NYCtabs_20211016, col(1) row(1)

*gender
tab gender eversex if eversex!=3 & agegrp4cat!=.
tab2xl gender eversex if eversex!=3 & agegrp4cat!=. using NYCtabs_20211016, col(8) row(1)

*race
tab race eversex if eversex!=3 & agegrp4cat!=.
tab2xl race eversex if eversex!=3 & agegrp4cat!=. using NYCtabs_20211016, col(16) row(1)

*bmi3cat
tab bmi3cat eversex if eversex!=3 & agegrp4cat!=.
tab2xl bmi3cat eversex if eversex!=3 & agegrp4cat!=. using NYCtabs_20211016, col(24) row(1)

*** sex partners
egen anysexpart=  rowmiss( vagsexpartners oralsexpartners samesexpartners analsexpartners)

*age
*age/vag
tab agegrp5c vagsexpartners 
tab2xl agegrp5c vagsexpartners using NYCtabs_20211016, col(1) row(12)

*age/oral
tab agegrp5c oralsexpartners 
tab2xl agegrp5c oralsexpartners using NYCtabs_20211016, col(1) row(24)

*age/samesex
tab agegrp5c samesexpartners 
tab2xl agegrp5c samesexpartners using NYCtabs_20211016, col(1) row(36)


*age/analsex
tab agegrp5c analsexpartners 
tab2xl agegrp5c analsexpartners using NYCtabs_20211016, col(1) row(48)

*gender
*gender/vag
tab gender vagsexpartners if agegrp4cat!=.
tab2xl gender vagsexpartners if agegrp4cat!=. using NYCtabs_20211016, col(8) row(12)

*gender/oral
tab gender oralsexpartners if agegrp4cat!=.
tab2xl gender oralsexpartners if agegrp4cat!=. using NYCtabs_20211016, col(8) row(24)

*gender/samesex
tab gender samesexpartners if agegrp4cat!=.
tab2xl gender samesexpartners if agegrp4cat!=. using NYCtabs_20211016, col(8) row(36)

*gender/analsex
tab gender analsexpartners if agegrp4cat!=.
tab2xl gender analsexpartners if agegrp4cat!=. using NYCtabs_20211016, col(8) row(48)


*race
*race/vag
tab race vagsexpartners if agegrp4cat!=.
tab2xl race  vagsexpartners if agegrp4cat!=. using NYCtabs_20211016, col(16) row(12)

*race/oral
tab race oralsexpartners if agegrp4cat!=.
tab2xl race  oralsexpartners if agegrp4cat!=. using NYCtabs_20211016, col(16) row(24)

*race/samesex
tab race samesexpartners if agegrp4cat!=.
tab2xl race  samesexpartners if agegrp4cat!=. using NYCtabs_20211016, col(16) row(36)

*race/analsex
tab race analsexpartners if agegrp4cat!=.
tab2xl race  analsexpartners if agegrp4cat!=. using NYCtabs_20211016, col(16) row(48)


*bmi
*bmi/vag
tab bmi3cat vagsexpartners if agegrp4cat!=.
tab2xl bmi3cat vagsexpartners if agegrp4cat!=. using NYCtabs_20211016, col(24) row(12)

*bmi/oral
tab bmi3cat oralsexpartners if agegrp4cat!=.
tab2xl bmi3cat oralsexpartners if agegrp4cat!=. using NYCtabs_20211016, col(24) row(24)

*bmi/samesex
tab bmi3cat samesexpartners if agegrp4cat!=.
tab2xl bmi3cat samesexpartners if agegrp4cat!=. using NYCtabs_20211016, col(24) row(36)

*bmi/analsex
tab bmi3cat analsexpartners if agegrp4cat!=.
tab2xl bmi3cat analsexpartners if agegrp4cat!=. using NYCtabs_20211016, col(24) row(48)



************ NHANES

*In SAS 
*weight MEC4YR;
*CLUSTER SDMVPSU;
*STRATA SDMVSTRA;

*Codebook for NHANES 2013-14: https://wwwn.cdc.gov/Nchs/Nhanes/2013-2014/SXQ_H.htm

use "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\SexBeh_repo\analytic_data\NHANES_2011_2014.dta" , clear

*Restrict to only those who responded ACASI

svyset sdmvpsu [pweight= mec4yr], strata(sdmvstra) singleunit(certainty) || _n


* In the past 12 months, with how many men/women have you had vaginal sex? 
* Vaginal sex partners* 
gen vagsexpartners=. 
replace vagsexpartners=0 if  sxq827==0 | sxq727==0
replace vagsexpartners=1 if  sxq827==1 | sxq727==1
replace vagsexpartners=2 if  (sxq827>1 & sxq827<=200) 
replace vagsexpartners=2 if  (sxq727>1 & sxq727<=200)

* Replace with 0 if never had sex in life 
* Ever had any kind of sex sxd021, both males and females answer 
replace vagsexpartners=0 if sxd021==2 

* Ever had vaginal sex (men)
replace vagsexpartners=0 if sxq800==2 & riagendr==1

* Ever had vaginal sex (females)
replace vagsexpartners=0 if sxq700==2 & riagendr==2

gen everhadvagsex=.
replace everhadvagsex=0 if sxq700==2 | sxq800==2
replace everhadvagsex=1 if sxq700==1 | sxq800==1


* Check if no responses translates to 0 in # of sex partners
tab vagsexpartners sxq800 if riagendr==1, mi
tab vagsexpartners sxq700 if riagendr==2, mi
tab vagsexpartners sxd021, mi

* Oral sex partners*
gen oralsexpartners=. 
replace oralsexpartners=0 if  sxq639==0 | sxq627==0
replace oralsexpartners=1 if  sxq639==1 | sxq627==1
replace oralsexpartners=2 if  (sxq639>1 & sxq639<=200) 
replace oralsexpartners=2 if  (sxq627>1 & sxq627<=200)

* Replace with 0 if never had sex in life 
* Ever had any kind of sex sxd021, both males and females answer 
replace oralsexpartners=0 if sxd021==2

* Ever had oral sex (men)
replace oralsexpartners=0 if sxq803==2 & riagendr==1 & oralsexpartners==.

* Ever had oral sex (women)
replace oralsexpartners=0 if sxq703==2 & riagendr==2 & oralsexpartners==.

* Check if no responses translates to 0 in # of sex partners
tab oralsexpartners sxq803 if riagendr==1, mi
tab oralsexpartners sxq703 if riagendr==2, mi
tab oralsexpartners sxd021, mi

gen everhadoralsex=.
replace everhadoralsex=0 if sxq703==2 | sxq803==2
replace everhadoralsex=1 if sxq703==1 | sxq803==1


* Same sex partners*
gen samesexpartners=. 
replace samesexpartners=0 if  sxq550==0 | sxq490==0
replace samesexpartners=1 if  sxq550==1 | sxq490==1
replace samesexpartners=2 if  (sxq550>1 & sxq550<=200) 
replace samesexpartners=2 if  (sxq490>1 & sxq490<=200)

* Replace with 0 if never had sex in life 
* Ever had any kind of sex sxd021, both males and females answer 
replace samesexpartners=0 if sxd021==2

* Ever same sex (men)
replace samesexpartners=0 if sxq809==2 & riagendr==1 & samesexpartners==.

* Ever had oral sex (women)
replace samesexpartners=0 if sxq709==2 & riagendr==2 & samesexpartners==.

* Check if no responses translates to 0 in # of sex partners
tab samesexpartners sxq809 if riagendr==1, mi
tab samesexpartners sxq709 if riagendr==2, mi
tab samesexpartners sxd021, mi


gen everhadsamesexsex=.
replace everhadsamesexsex=0 if sxq709==2 | sxq809==2
replace everhadsamesexsex=1 if sxq709==1 | sxq809==1


* ridageyr
* In Priscilla's code 
*where RIDAGEYR >=20;
*if sddsrvyr in (7,8) then MEC4YR = 1/2 * WTMEC2YR;
*IF 20<=RIDAGEYR=<29 THEN agegroup5c=1;
*	ELSE IF 30<=RIDAGEYR=<39 THEN agegroup5c=2;
*	ELSE IF 40<=RIDAGEYR=<49 THEN agegroup5c=3;
*	ELSE IF 50<=RIDAGEYR=<59 THEN agegroup5c=4;
*	ELSE IF 60<=RIDAGEYR=<69 THEN agegroup5c=5;
*run;


gen agegrp4cat=.
replace agegrp4cat=1 if ridageyr>=20 & ridageyr<30
replace agegrp4cat=2 if ridageyr>=30 & ridageyr<40
replace agegrp4cat=3 if ridageyr>=40 & ridageyr<50
replace agegrp4cat=4 if ridageyr>=50 & ridageyr<60

gen agegrp5c=. 
replace agegrp5c=1 if ridageyr>=20 & ridageyr<30 
replace agegrp5c=2 if ridageyr>=30 & ridageyr<40 
replace agegrp5c=3 if ridageyr>=40 & ridageyr<50 
replace agegrp5c=4 if ridageyr>=50 & ridageyr<60 
replace agegrp5c=5 if ridageyr>=60 

gen agegrp6c=.
replace agegrp6c=1 if ridageyr>=20 & ridageyr<30
replace agegrp6c=2 if ridageyr>=30 & ridageyr<40
replace agegrp6c=3 if ridageyr>=40 & ridageyr<50
replace agegrp6c=4 if ridageyr>=50 & ridageyr<60
replace agegrp6c=5 if ridageyr>=60 & ridageyr<70
replace agegrp6c=6 if ridageyr>=70 


* To create BMI bmxbmi
gen bmi3cat=. 
replace bmi3cat=1 if bmxbmi<25
replace bmi3cat=2 if bmxbmi>=25 & bmxbmi<30 
replace bmi3cat=3 if bmxbmi>=30 & bmxbmi!=.


* Race/ethnicity ctegories ridreth1 ridreth3

* In NYC HANES
* 1: Non-Hispanic White | 424  34.47  34.47
* 2: Non-Hispanic Black | 293  23.82  58.29
* 3: Hispanic 			| 308  25.04  83.33
* 4: Asian 				| 138  11.22  94.55
* 5: Other 				| 67   5.45   100.00

gen race=. 
replace race=1 if ridreth3==3
replace race=2 if ridreth3==4
replace race=3 if ridreth3==1 | ridreth3==2
replace race=4 if ridreth3==6
replace race=5 if ridreth3==7

gen gender=riagendr


* create weight to standardize by age, 5 groups
gen STDWGT4=.
replace STDWGT4=0.2535027 if agegrp5c==1
replace STDWGT4=0.2383826 if agegrp5c==2
replace STDWGT4=0.2589169 if agegrp5c==3
replace STDWGT4=0.2491978 if agegrp5c==4


* create weight to standardize by age, 5 groups
gen STDWGT5=.
replace STDWGT5=0.189322 if agegrp5c==1
replace STDWGT5=0.178030 if agegrp5c==2
replace STDWGT5=0.193365 if agegrp5c==3
replace STDWGT5=0.186107 if agegrp5c==4
replace STDWGT5=0.253177 if agegrp5c==5

*weights to standardize by age and sex
*gen STDWGTFEM=.
*replace STDWGTFEM=0.180912 if agegrp5c==1 & gender==2
*replace STDWGTFEM=0.172873 if agegrp5c==2 & gender==2
*replace STDWGTFEM=0.189153 if agegrp5c==3 & gender==2
*replace STDWGTFEM=0.184935 if agegrp5c==4 & gender==2
*replace STDWGTFEM=0.272127 if agegrp5c==5 & gender==2

*gen STDWGTMALE=.
*replace STDWGTMALE=0.198278 if agegrp5c==1 & gender==1
*replace STDWGTMALE=0.183522 if agegrp5c==2 & gender==1
*replace STDWGTMALE=0.197851 if agegrp5c==3 & gender==1
*replace STDWGTMALE=0.187354 if agegrp5c==4 & gender==1
*replace STDWGTMALE=0.232995 if agegrp5c==5 & gender==1


*AGEGRP6C	Population	Weight
*1: 20-29	42687848	0.189321581
*2: 30-39	40141741	0.178029538
*3: 40-49	43599555	0.193365022
*4: 50-59	41962930	0.186106553
*5: 60-69	29253187	0.129738552
*6: 70 and over	27832721	0.123438753
*Total	225477982	1


* create weight to standardize by age, 6 groups
gen STDWGT6=.
replace STDWGT6=0.189321581 if agegrp6c==1
replace STDWGT6=0.178029538 if agegrp6c==2
replace STDWGT6=0.193365022 if agegrp6c==3
replace STDWGT6=0.186106553 if agegrp6c==4
replace STDWGT6=0.129738552 if agegrp6c==5
replace STDWGT6=0.123438753 if agegrp6c==6

svy, over(bmi3cat): prop vagsexpartners
svy, over(race): prop vagsexpartners


*** Ever yes/no oral, vaginal, same sex
* Age group
*** Ever yes/no oral, vaginal, same sex

*Sex 
putexcel set NHANES_4cat_20211016.xlsx, sheet(ever_sex) modify

svy, over(gender): prop everhadvagsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix evervagsex_sex = r(table)
matrix sampleevervagsex_sex = e(N)
putexcel A1 = matrix(evervagsex_sex), names nformat(number_d4)
putexcel A12= matrix(sampleevervagsex_sex)

svy, over(gender): prop everhadoralsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix everoralsex_sex = r(table)
matrix sampleeveroralsex_sex = e(N)
putexcel A15 = matrix(everoralsex_sex), names nformat(number_d4)
putexcel A26= matrix(sampleeveroralsex_sex)

svy, over(gender): prop everhadsamesexsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix eversamesex_sex = r(table)
matrix sampleeversamesex_sex = e(N)
putexcel A30 = matrix(eversamesex_sex), names nformat(number_d4)
putexcel A41= matrix(sampleeversamesex_sex)

*Race 
putexcel set NHANES_4cat_20211016.xlsx, sheet(ever_race) modify

svy, over(race): prop everhadvagsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix evervagsex_race = r(table)
matrix sampleevervagsex_race = e(N)
putexcel A1 = matrix(evervagsex_race), names nformat(number_d4)
putexcel A12= matrix(sampleevervagsex_race)

svy, over(race): prop everhadoralsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix everoralsex_race = r(table)
matrix sampleeveroralsex_race = e(N)
putexcel A15 = matrix(everoralsex_race), names nformat(number_d4)
putexcel A26= matrix(sampleeveroralsex_race)

svy, over(race): prop everhadsamesexsex,  stdize(agegrp4cat) stdweight(STDWGT4)
matrix eversamesex_race = r(table)
matrix sampleeversamesex_race = e(N)
putexcel A30 = matrix(eversamesex_race), names nformat(number_d4)
putexcel A41= matrix(sampleeversamesex_race)

*BMI 

putexcel set NHANES_4cat_20211016.xlsx, sheet(ever_bmi) modify

svy, over(bmi3cat): prop everhadvagsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix evervagsex_bmi = r(table)
matrix sampleevervagsex_bmi = e(N)
putexcel A1 = matrix(evervagsex_bmi), names nformat(number_d4)
putexcel A12= matrix(sampleevervagsex_bmi)

svy, over(bmi3cat): prop everhadoralsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix everoralsex_bmi = r(table)
matrix sampleeveroralsex_bmi = e(N)
putexcel A15 = matrix(everoralsex_bmi), names nformat(number_d4)
putexcel A26= matrix(sampleeveroralsex_bmi)

svy, over(bmi3cat): prop everhadsamesexsex, stdize(agegrp4cat) stdweight(STDWGT4)
matrix eversamesex_bmi = r(table)
matrix sampleeversamesex_bmi = e(N)
putexcel A30 = matrix(eversamesex_bmi), names nformat(number_d4)
putexcel A41= matrix(sampleeversamesex_bmi)

**************
** Number of partners in the past year limited to those who ever had each type of sex

replace vagsexpartners =. if everhadvagsex==0 & vagsexpartners==0
replace oralsexpartners =. if everhadoralsex==0 & oralsexpartners==0
replace samesexpartners =. if everhadsamesexsex ==0 & samesexpartners==0


* gender
putexcel set NHANES_4cat_20211016.xlsx, sheet(sexpartners_sex) modify

svy, over(gender): prop vagsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersvagsex_sex = r(table)
matrix samplepartnersvagsex_sex = e(N)
putexcel A1 = matrix(partnersvagsex_sex), names nformat(number_d4)
putexcel A12= matrix(samplepartnersvagsex_sex)

svy, over(gender): prop oralsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersoralsex_sex = r(table)
matrix samplepartnersoralsex_sex = e(N)
putexcel A15 = matrix(partnersoralsex_sex), names nformat(number_d4)
putexcel A26= matrix(samplepartnersoralsex_sex)


svy, over(gender): prop samesexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnerssamesex_sex = r(table)
matrix samplepartnerssamesex_sex = e(N)
putexcel A30 = matrix(partnerssamesex_sex), names nformat(number_d4)
putexcel A41= matrix(samplepartnerssamesex_sex)


*Figure in the manuscript results section
gen samesexpartners1plus=samesexpartners
replace samesexpartners1plus=1 if samesexpartners1plus==2
svy, over(gender): prop samesexpartners1plus,  stdize(agegrp4cat) stdweight(STDWGT4)



* race
putexcel set NHANES_4cat_20211016.xlsx, sheet(sexpartners_race) modify

svy, over(race): prop vagsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersvagsex_race = r(table)
matrix samplepartnersvagsex_race = e(N)
putexcel A1 = matrix(partnersvagsex_race), names nformat(number_d4)
putexcel A12= matrix(samplepartnersvagsex_race)

svy, over(race): prop oralsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersoralsex_race = r(table)
matrix samplepartnersoralsex_race = e(N)
putexcel A15 = matrix(partnersoralsex_race), names nformat(number_d4)
putexcel A26= matrix(samplepartnersoralsex_race)

svy, over(race): prop samesexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnerssamesex_race = r(table)
matrix samplepartnerssamesex_race = e(N)
putexcel A30 = matrix(partnerssamesex_race), names nformat(number_d4)
putexcel A41= matrix(samplepartnerssamesex_race)

* bmi
putexcel set NHANES_4cat_20211016.xlsx, sheet(sexpartners_bmi) modify

svy, over(bmi3cat): prop vagsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersvagsex_bmi = r(table)
matrix samplepartnersvagsex_bmi = e(N)
putexcel A1 = matrix(partnersvagsex_bmi), names nformat(number_d4)
putexcel A12= matrix(samplepartnersvagsex_bmi)

svy, over(bmi3cat): prop oralsexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnersoralsex_bmi = r(table)
matrix samplepartnersoralsex_bmi = e(N)
putexcel A15 = matrix(partnersoralsex_bmi), names nformat(number_d4)
putexcel A26= matrix(samplepartnersoralsex_bmi)

svy, over(bmi3cat): prop samesexpartners, stdize(agegrp4cat) stdweight(STDWGT4)
matrix partnerssamesex_bmi = r(table)
matrix samplepartnerssamesex_bmi = e(N)
putexcel A30 = matrix(partnerssamesex_bmi), names nformat(number_d4)
putexcel A41= matrix(samplepartnerssamesex_bmi)


egen eversex=  rowmiss( everhadvagsex everhadoralsex everhadsamesexsex)

*age
tab agegrp5c eversex if eversex!=3
tab2xl agegrp5c eversex if eversex!=3 using NHANEStabs_20211016, col(1) row(1)

*gender
tab gender eversex if eversex!=3  & agegrp4cat!=.
tab2xl gender eversex if eversex!=3 & agegrp4cat!=. using NHANEStabs_20211016, col(8) row(1)

*race
tab race eversex if eversex!=3  & agegrp4cat!=.
tab2xl race eversex if eversex!=3 & agegrp4cat!=. using NHANEStabs_20211016, col(16) row(1)

*bmi3cat
tab bmi3cat eversex if eversex!=3  & agegrp4cat!=.
tab2xl bmi3cat eversex if eversex!=3 & agegrp4cat!=. using NHANEStabs_20211016, col(24) row(1)


*** sex partners
egen anysexpart=  rowmiss( vagsexpartners oralsexpartners samesexpartners)

*age
*age/vag
tab agegrp5c vagsexpartners 
tab2xl agegrp5c vagsexpartners using NHANEStabs_20211016, col(1) row(12)

*age/oral
tab agegrp5c oralsexpartners 
tab2xl agegrp5c oralsexpartners using NHANEStabs_20211016, col(1) row(24)

*age/oral
tab agegrp5c samesexpartners 
tab2xl agegrp5c samesexpartners using NHANEStabs_20211016, col(1) row(36)

*gender
*gender/vag
tab gender vagsexpartners if agegrp4cat!=.
tab2xl gender vagsexpartners if agegrp4cat!=. using NHANEStabs_20211016, col(8) row(12)

*gender/oral
tab gender oralsexpartners if agegrp4cat!=.
tab2xl gender oralsexpartners if agegrp4cat!=. using NHANEStabs_20211016, col(8) row(24)

*gender/samesex
tab gender samesexpartners if agegrp4cat!=.
tab2xl gender samesexpartners if agegrp4cat!=. using NHANEStabs_20211016, col(8) row(36)

*race
*race/vag
tab race vagsexpartners if agegrp4cat!=.
tab2xl race  vagsexpartners if agegrp4cat!=. using NHANEStabs_20211016, col(16) row(12)

*race/oral
tab race oralsexpartners if agegrp4cat!=.
tab2xl race  oralsexpartners if agegrp4cat!=. using NHANEStabs_20211016, col(16) row(24)

*race/samesex
tab race samesexpartners if agegrp4cat!=.
tab2xl race  samesexpartners if agegrp4cat!=. using NHANEStabs_20211016, col(16) row(36)


*bmi
*bmi/vag
tab bmi3cat vagsexpartners if agegrp4cat!=.
tab2xl bmi3cat vagsexpartners if agegrp4cat!=. using NHANEStabs_20211016, col(24) row(12)

*bmi/oral
tab bmi3cat oralsexpartners if agegrp4cat!=.
tab2xl bmi3cat oralsexpartners if agegrp4cat!=. using NHANEStabs_20211016, col(24) row(24)

*bmi/samesex
tab bmi3cat samesexpartners if agegrp4cat!=.
tab2xl bmi3cat samesexpartners if agegrp4cat!=. using NHANEStabs_20211016, col(24) row(36)
