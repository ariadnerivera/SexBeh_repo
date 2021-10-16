

use "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\nychanes_v1_spage.dta" , clear


gen agegrp4cat=.
replace agegrp4cat=1 if spage>=20 & spage<30
replace agegrp4cat=2 if spage>=30 & spage<40
replace agegrp4cat=3 if spage>=40 & spage<50
replace agegrp4cat=4 if spage>=50 & spage<60


* Will need to fix survey design

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

drop if spage>69

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

**************
** Number of partners in the past year limited to those who ever had each type of sex
replace vagsexpartners =. if everhadvagsex==0 & vagsexpartners==0
replace oralsexpartners =. if everhadoralsex==0 & oralsexpartners==0
replace samesexpartners =. if everhadsamesexsex ==0 & samesexpartners==0
replace analsexpartners =. if everhadanalsex ==0 & analsexpartners==0

*unweighed
tab gender
tab agegrp5c
tab race
tab bmi3cat
tab everhadvagsex
tab everhadoralsex
tab everhadsamesexsex
tab1 vagsexpartners oralsexpartners samesexpartners

*weighted
svy: tab gender, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab agegrp5c
svy: tab race, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab bmi3cat, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab everhadvagsex, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab everhadoralsex, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab everhadsamesexsex, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab everhadanalsex, stdize(agegrp5c) stdweight(STDWGT5)

svy: tab vagsexpartners, stdize(agegrp5c) stdweight(STDWGT5) 
svy: tab oralsexpartners, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab samesexpartners, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab analsexpartners, stdize(agegrp5c) stdweight(STDWGT5)


************ NHANES

*In SAS 
*weight MEC4YR;
*CLUSTER SDMVPSU;
*STRATA SDMVSTRA;

use "C:\Users\rivera30\OneDrive - NYU Langone Health\NYC Sexual Behavior\Ariadne\national1114_v2.dta" , clear

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


gen everhadanalsex=.
replace everhadanalsex=0 if sxq706==2 | sxq806==2
replace everhadanalsex=1 if sxq706==1 | sxq806==1


** Number of partners in the past year limited to those who ever had each type of sex

replace vagsexpartners =. if everhadvagsex==0 & vagsexpartners==0
replace oralsexpartners =. if everhadoralsex==0 & oralsexpartners==0
replace samesexpartners =. if everhadsamesexsex ==0 & samesexpartners==0

drop if ridageyr>59

*unweighted
tab gender
tab agegrp5c
tab race
tab bmi3cat
tab everhadvagsex
tab everhadoralsex
tab everhadsamesexsex
tab1 vagsexpartners oralsexpartners samesexpartners

*weighted
svy: tab gender, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab agegrp5c
svy: tab race, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab bmi3cat, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab everhadvagsex, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab everhadoralsex, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab everhadsamesexsex, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab everhadanalsex, stdize(agegrp5c) stdweight(STDWGT5)

svy: tab vagsexpartners, stdize(agegrp5c) stdweight(STDWGT5) 
svy: tab oralsexpartners, stdize(agegrp5c) stdweight(STDWGT5) 
svy: tab samesexpartners, stdize(agegrp5c) stdweight(STDWGT5)
svy: tab analsexpartners, stdize(agegrp5c) stdweight(STDWGT5)
