#load packages
require(ggplot2)
require(dplyr)
library(wesanderson)
library(RColorBrewer)
library(hrbrthemes)
library(ggalt)
library(CGPfunctions)
library(ggpubr)
library(readxl)
library(cowplot)
library(stringr)
library(scales)


setwd("C:/Users/rivera30/OneDrive - NYU Langone Health/NYC Sexual Behavior/Ariadne")
d <- read_excel("Outcomes_ageadjusted4agecat_20210817.xlsx", sheet = "Outcomes")


# Ever variables

ever_all <- subset(d, var == "ever" & outcome=="Yes")


##############
#gender

gender <- subset(ever_all, cat == "gender")

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
gender$Outcome<- factor(gender$measure, levels = c("Vaginal sex", "Oral sex", "Same sex", "Anal sex"))
gender$Geography <- factor(gender$geography, levels = c("NYC", "National"))
gender$Group <- factor(gender$group, levels = c("Female", "Male"))
gender$Prevalence <- as.double(gender$estimate)
gender$lo_ci <- as.double(gender$lo_ci)
gender$hi_ci <- as.double(gender$hi_ci)
gender$estimate <- as.double(gender$estimate)

head(gender)

lifetimep_gender <- ggplot(data=gender, aes(x=geography_n, y=Prevalence, group = measure))+
  geom_point(aes(color=measure), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
  expand_limits(y=0)  +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

lifetimep_gender


lifetimep_gender_gp <- lifetimep_gender + geom_errorbar(data=gender, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                        alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())

lifetimep_gender_gp
#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


lifetimep_gender_gp_comb <- lifetimep_gender_gp + facet_wrap(~Group, ncol = 2, scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

lifetimep_gender_gp + facet_wrap(~Group, ncol = 2, scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("lifetimep_gender_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=6.3, units="in")



##############
#bmi

bmi <- subset(ever_all, cat == "BMI")

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
bmi$Outcome<- factor(bmi$measure, levels = c("Vaginal sex", "Oral sex", "Same sex", "Anal sex"))
bmi$Geography <- factor(bmi$geography, levels = c("NYC", "National"))
bmi$Group <- factor(bmi$group, levels = c("11-24.9", "25-29.9", "30-100"))
bmi$Prevalence <- as.double(bmi$estimate)
bmi$lo_ci <- as.double(bmi$lo_ci)
bmi$hi_ci <- as.double(bmi$hi_ci)
bmi$estimate <- as.double(bmi$estimate)

head(bmi)

lifetimep_bmi <- ggplot(data=bmi, aes(x=geography_n, y=Prevalence, group = measure))+
  geom_point(aes(color=measure), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
  expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

lifetimep_bmi


lifetimep_bmi_gp <- lifetimep_bmi + geom_errorbar(data=bmi, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                  alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())

lifetimep_bmi_gp
#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


lifetimep_bmi_gp_comb <- lifetimep_bmi_gp + facet_wrap(~Group, ncol = 3,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

lifetimep_bmi_gp + facet_wrap(~Group, ncol = 3,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")


ggsave("lifetimep_bmi_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=6.3, units="in")


##############
#race

race <- subset(ever_all, cat == "race")

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
race$Outcome<- factor(race$measure, levels = c("Vaginal sex", "Oral sex", "Same sex", "Anal sex"))
race$Geography <- factor(race$geography, levels = c("NYC", "National"))
race$Group <- factor(race$group, levels = c("Asian", "Black", "Hispanic", "White", "Other" ))
race$Prevalence <- as.double(race$estimate)
race$lo_ci <- as.double(race$lo_ci)
race$hi_ci <- as.double(race$hi_ci)
race$estimate <- as.double(race$estimate)


head(race)

lifetimep_race <- ggplot(data=race, aes(x=geography_n, y=Prevalence, group = measure))+
  geom_point(aes(color=measure), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

lifetimep_race


lifetimep_race_gp <- lifetimep_race + geom_errorbar(data=race, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                    alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())

lifetimep_race_gp
#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


lifetimep_race_gp_comb <- lifetimep_race_gp + facet_wrap(~Group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

lifetimep_race_gp + facet_wrap(~Group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")


ggsave("lifetimep_race_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=6.3, units="in")

##############
#age

age <- subset(ever_all, cat == "age")

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
age$Outcome<- factor(age$measure, levels = c("Vaginal sex", "Oral sex", "Same sex", "Anal sex"))
age$Geography <- factor(age$geography, levels = c("NYC", "National"))
age$Group <- factor(age$group, levels = c("20-29", "30-39", "40-49", "50-59", 
                                            "60-69", "70 and over"))
age$Prevalence <- as.double(age$estimate)
age$lo_ci <- as.double(age$lo_ci)
age$hi_ci <- as.double(age$hi_ci)
age$estimate <- as.double(age$estimate)

head(age)

lifetimep_age <- ggplot(data=age, aes(x=geography_n, y=Prevalence, group = measure))+
  geom_point(aes(color=measure), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

lifetimep_age


lifetimep_age_gp <- lifetimep_age + geom_errorbar(data=age, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                  alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())

lifetimep_age_gp
#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


lifetimep_age_gp_comb <- lifetimep_age_gp + facet_wrap(~Group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

lifetimep_age_gp + facet_wrap(~Group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")


ggsave("lifetimep_age_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

###################### Number of partners
table(d$var)


partners_all <- subset(d, var == "partners")
as.double(partners_all$estimate)

#############################################################################
## Race

race_vag <- subset(partners_all, cat == "race" & measure =="Vaginal sex")
table(race$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
race_vag$Outcome<- factor(race_vag$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
race_vag$Geography <- factor(race_vag$geography, levels = c("NYC", "National"))
race_vag$Group <- factor(race_vag$group, levels = c("Asian", "Black", "Hispanic", "White", "Other"))
race_vag$estimate <-as.double(race_vag$estimate)
race_vag$Prevalence <- race_vag$estimate


vagpartners_race3 <- ggplot(data=race_vag, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

vagpartners_race3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



vagpartners_race3 <- vagpartners_race3 + geom_errorbar(data=race_vag, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                       alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


vagpartners_race_gp_comb <- vagpartners_race3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

vagpartners_race_gp_comb + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("vagpartners_race_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")


### Oral sex

race_oral <- subset(partners_all, cat == "race" & measure =="Oral sex")
table(race$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
race_oral$Outcome<- factor(race_oral$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
race_oral$Geography <- factor(race_oral$geography, levels = c("NYC", "National"))
race_oral$Group <- factor(race_oral$group, levels = c("Asian", "Black", "Hispanic", "White", "Other"))
race_oral$estimate <-as.double(race_oral$estimate)
race_oral$Prevalence <- race_oral$estimate


oralpartners_race3 <- ggplot(data=race_oral, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

oralpartners_race3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



oralpartners_race3 <- oralpartners_race3 + geom_errorbar(data=race_oral, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                       alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


oralpartners_race_gp_comb <- oralpartners_race3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

oralpartners_race_gp_comb + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("oralpartners_race_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

### Same sex

race_samesex <- subset(partners_all, cat == "race" & measure =="Same sex")
table(race$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
race_samesex$Outcome<- factor(race_samesex$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
race_samesex$Geography <- factor(race_samesex$geography, levels = c("NYC", "National"))
race_samesex$Group <- factor(race_samesex$group, levels = c("Asian", "Black", "Hispanic", "White", "Other"))
race_samesex$estimate <-as.double(race_samesex$estimate)
race_samesex$Prevalence <- race_samesex$estimate


samesexpartners_race3 <- ggplot(data=race_samesex, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))


#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



samesexpartners_race3 <- samesexpartners_race3 + geom_errorbar(data=race_samesex, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                         alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


samesexpartners_race_gp_comb3 <- samesexpartners_race3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

samesexpartners_race_gp_comb3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")


ggsave("samesexpartners_race_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")


#############################################################################
## gender

gender_vag <- subset(partners_all, cat == "gender" & measure =="Vaginal sex")
table(gender$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
gender_vag$Outcome<- factor(gender_vag$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
gender_vag$Geography <- factor(gender_vag$geography, levels = c("NYC", "National"))
gender_vag$Group <- factor(gender_vag$group, levels = c("Female", "Male"))
gender_vag$estimate <-as.double(gender_vag$estimate)
gender_vag$Prevalence <- gender_vag$estimate


vagpartners_gender3 <- ggplot(data=gender_vag, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

vagpartners_gender3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



vagpartners_gender3 <- vagpartners_gender3 + geom_errorbar(data=gender_vag, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                       alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


vagpartners_gender_gp_comb3 <- vagpartners_gender3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

vagpartners_gender_gp_comb3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("vagpartners_gender_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

### Oral sex

gender_oral <- subset(partners_all, cat == "gender" & measure =="Oral sex")
table(gender$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
gender_oral$Outcome<- factor(gender_oral$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
gender_oral$Geography <- factor(gender_oral$geography, levels = c("NYC", "National"))
gender_oral$Group <- factor(gender_oral$group, levels = c("Female", "Male"))
gender_oral$estimate <-as.double(gender_oral$estimate)
gender_oral$Prevalence <- gender_oral$estimate


oralpartners_gender3 <- ggplot(data=gender_oral, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

oralpartners_gender3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



oralpartners_gender3 <- oralpartners_gender3 + geom_errorbar(data=gender_oral, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                         alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


oralpartners_gender_gp_comb3 <- oralpartners_gender3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

oralpartners_gender_gp_comb3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("oralpartners_gender_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

### Same sex

gender_samesex <- subset(partners_all, cat == "gender" & measure =="Same sex")
table(gender$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
gender_samesex$Outcome<- factor(gender_samesex$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
gender_samesex$Geography <- factor(gender_samesex$geography, levels = c("NYC", "National"))
gender_samesex$Group <- factor(gender_samesex$group, levels = c("Female", "Male"))
gender_samesex$estimate <-as.double(gender_samesex$estimate)
gender_samesex$Prevalence <- gender_samesex$estimate


samesexpartners_gender3 <- ggplot(data=gender_samesex, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

samesexpartners_gender3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



samesexpartners_gender3 <- samesexpartners_gender3 + geom_errorbar(data=gender_samesex, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                               alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


samesexpartners_gender_gp_comb3 <- samesexpartners_gender3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

samesexpartners_gender_gp_comb3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("samesexpartners_gender_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

#############################################################################
## bmi

bmi_vag <- subset(partners_all, cat == "BMI" & measure =="Vaginal sex")
table(bmi$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
bmi_vag$Outcome<- factor(bmi_vag$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
bmi_vag$Geography <- factor(bmi_vag$geography, levels = c("NYC", "National"))
bmi_vag$Group <- factor(bmi_vag$group, levels = c("11-24.9", "25-29.9", "30-100"))
bmi_vag$estimate <-as.double(bmi_vag$estimate)
bmi_vag$Prevalence <- bmi_vag$estimate


vagpartners_bmi3 <- ggplot(data=bmi_vag, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

vagpartners_bmi3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



vagpartners_bmi3 <- vagpartners_bmi3 + geom_errorbar(data=bmi_vag, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                           alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


vagpartners_bmi_gp_comb3 <- vagpartners_bmi3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

vagpartners_bmi_gp_comb3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")


ggsave("vagpartners_bmi_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

### Oral sex

bmi_oral <- subset(partners_all, cat == "BMI" & measure =="Oral sex")
table(bmi$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
bmi_oral$Outcome<- factor(bmi_oral$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
bmi_oral$Geography <- factor(bmi_oral$geography, levels = c("NYC", "National"))
bmi_oral$Group <- factor(bmi_oral$group, levels = c("11-24.9", "25-29.9", "30-100"))
bmi_oral$estimate <-as.double(bmi_oral$estimate)
bmi_oral$Prevalence <- bmi_oral$estimate


oralpartners_bmi3 <- ggplot(data=bmi_oral, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

oralpartners_bmi3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



oralpartners_bmi3 <- oralpartners_bmi3 + geom_errorbar(data=bmi_oral, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                             alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


oralpartners_bmi_gp_comb3 <- oralpartners_bmi3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

oralpartners_bmi_gp_comb3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("oralpartners_bmi_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

### Same sex

bmi_samesex <- subset(partners_all, cat == "BMI" & measure =="Same sex")
table(bmi$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
bmi_samesex$Outcome<- factor(bmi_samesex$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
bmi_samesex$Geography <- factor(bmi_samesex$geography, levels = c("NYC", "National"))
bmi_samesex$Group <- factor(bmi_samesex$group, levels = c("11-24.9", "25-29.9", "30-100"))
bmi_samesex$estimate <-as.double(bmi_samesex$estimate)
bmi_samesex$Prevalence <- bmi_samesex$estimate


samesexpartners_bmi3 <- ggplot(data=bmi_samesex, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

samesexpartners_bmi3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



samesexpartners_bmi3 <- samesexpartners_bmi3 + geom_errorbar(data=bmi_samesex, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                                   alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


samesexpartners_bmi_gp_comb3 <- samesexpartners_bmi3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

samesexpartners_bmi_gp_comb3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")


ggsave("samesexpartners_bmi_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

#############################################################################
## age

age_vag <- subset(partners_all, cat == "age" & measure =="Vaginal sex")
table(age$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
age_vag$Outcome<- factor(age_vag$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
age_vag$Geography <- factor(age_vag$geography, levels = c("NYC", "National"))
age_vag$Group <- factor(age_vag$group, levels = c("White", "Black", "Hispanic", "Asian", "Other"))
age_vag$estimate <-as.double(age_vag$estimate)
age_vag$Prevalence <- age_vag$estimate


vagpartners_age3 <- ggplot(data=age_vag, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

vagpartners_age3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



vagpartners_age3 <- vagpartners_age3 + geom_errorbar(data=age_vag, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                     alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


vagpartners_age_gp_comb3 <- vagpartners_age3 + facet_wrap(~group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

vagpartners_age_gp_comb3 + facet_wrap(~group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("vagpartners_age_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

### Oral sex

age_oral <- subset(partners_all, cat == "age" & measure =="Oral sex")
table(age$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
age_oral$Outcome<- factor(age_oral$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
age_oral$Geography <- factor(age_oral$geography, levels = c("NYC", "National"))
age_oral$Group <- factor(age_oral$group, levels = c("White", "Black", "Hispanic", "Asian", "Other"))
age_oral$estimate <-as.double(age_oral$estimate)
age_oral$Prevalence <- age_oral$estimate


oralpartners_age3 <- ggplot(data=age_oral, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

oralpartners_age3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



oralpartners_age3 <- oralpartners_age3 + geom_errorbar(data=age_oral, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                       alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


oralpartners_age_gp_comb3 <- oralpartners_age3 + facet_wrap(~group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

oralpartners_age_gp_comb3 + facet_wrap(~group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("oralpartners_age_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

### Same sex

age_samesex <- subset(partners_all, cat == "age" & measure =="Same sex")
table(age$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
age_samesex$Outcome<- factor(age_samesex$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
age_samesex$Geography <- factor(age_samesex$geography, levels = c("NYC", "National"))
age_samesex$Group <- factor(age_samesex$group, levels = c("11-24.9", "25-29.9", "30-100"))
age_samesex$estimate <-as.double(age_samesex$estimate)
age_samesex$Prevalence <- age_samesex$estimate


samesexpartners_age3 <- ggplot(data=age_samesex, aes(x=geography_n, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
    expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

samesexpartners_age3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



samesexpartners_age3 <- samesexpartners_age3 + geom_errorbar(data=age_samesex, mapping=aes(x=geography_n, ymin=lo_ci, ymax=hi_ci), 
                                                             alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


samesexpartners_age_gp_comb3 <- samesexpartners_age3 + facet_wrap(~group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

samesexpartners_age_gp_comb3 + facet_wrap(~group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("samesexpartners_age_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

#Anal sex partners
#############################################################################
## Race

race_anal <- subset(partners_all, cat == "race" & measure =="Anal sex")
table(race$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
race_anal$Outcome<- factor(race_anal$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
race_anal$Geography <- factor(race_anal$geography, levels = c("NYC", "National"))
race_anal$Group <- factor(race_anal$group, levels = c("Asian", "Black", "Hispanic", "White", "Other"))
race_anal$estimate <-as.double(race_anal$estimate)
race_anal$Prevalence <- race_anal$estimate


race_analpartners_race3 <- ggplot(data=race_anal, aes(x=samplesize, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
  expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

race_analpartners_race3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



race_analpartners_race3 <- race_analpartners_race3 + geom_errorbar(data=race_anal, mapping=aes(x=samplesize, ymin=lo_ci, ymax=hi_ci), 
                                                                   alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


race_analpartners_race_gp_comb <- race_analpartners_race3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

race_analpartners_race_gp_comb + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("race_analpartners_race_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

#############################################################################
## bmi

bmi_anal <- subset(partners_all, cat == "BMI" & measure =="Anal sex")
table(bmi$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
bmi_anal$Outcome<- factor(bmi_anal$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
bmi_anal$Geography <- factor(bmi_anal$geography, levels = c("NYC", "National"))
bmi_anal$Group <- factor(bmi_anal$group, levels = c("11-24.9", "25-29.9", "30-100"))
bmi_anal$estimate <-as.double(bmi_anal$estimate)
bmi_anal$Prevalence <- bmi_anal$estimate


analpartners_bmi3 <- ggplot(data=bmi_anal, aes(x=samplesize, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
  expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

analpartners_bmi3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



analpartners_bmi3 <- analpartners_bmi3 + geom_errorbar(data=bmi_anal, mapping=aes(x=samplesize, ymin=lo_ci, ymax=hi_ci), 
                                                       alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


analpartners_bmi_gp_comb3 <- analpartners_bmi3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

analpartners_bmi_gp_comb3 + facet_wrap(~Group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")


ggsave("analpartners_bmi_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

#############################################################################
## age

age_anal <- subset(partners_all, cat == "age" & measure =="Anal sex")
table(age$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
age_anal$Outcome<- factor(age_anal$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
age_anal$Geography <- factor(age_anal$geography, levels = c("NYC", "National"))
age_anal$Group <- factor(age_anal$group, levels = c("White", "Black", "Hispanic", "Asian", "Other"))
age_anal$estimate <-as.double(age_anal$estimate)
age_anal$Prevalence <- age_anal$estimate


analpartners_age3 <- ggplot(data=age_anal, aes(x=samplesize, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
  expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

analpartners_age3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



analpartners_age3 <- analpartners_age3 + geom_errorbar(data=age_anal, mapping=aes(x=samplesize, ymin=lo_ci, ymax=hi_ci), 
                                                       alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


analpartners_age_gp_comb3 <- analpartners_age3 + facet_wrap(~group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

analpartners_age_gp_comb3 + facet_wrap(~group, ncol = 6,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("analpartners_age_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")

#############################################################################
## gender

gender_anal <- subset(partners_all, cat == "gender" & measure =="Anal sex")
table(gender$outcome)

#factor for easier graphing and name the levels so that this is how it appears in the legend with ggplot
#Prev is a weird one but I named it this so it would appear in the legend this way 
gender_anal$Outcome<- factor(gender_anal$outcome, levels = c("0 partners", "1 partner", "2+ partners"))
gender_anal$Geography <- factor(gender_anal$geography, levels = c("NYC", "National"))
gender_anal$Group <- factor(gender_anal$group, levels = c("Female", "Male"))
gender_anal$estimate <-as.double(gender_anal$estimate)
gender_anal$Prevalence <- gender_anal$estimate


analpartners_gender3 <- ggplot(data=gender_anal, aes(x=samplesize, y=Prevalence, group = outcome))+
  geom_point(aes(color=Outcome), size = 2) +
  scale_y_continuous(limits = c(0, 1), labels = function(x) paste0(x*100, "%")) + 
  expand_limits(y=0) +  scale_x_discrete(labels = function(x) str_wrap(x, width=6))

analpartners_gender3

#this is to order the legend as we need
#  scale_color_discrete(breaks=c("White", "Black", "Hispanic", "Asian", "Other"))



analpartners_gender3 <- analpartners_gender3 + geom_errorbar(data=gender_anal, mapping=aes(x=samplesize, ymin=lo_ci, ymax=hi_ci), 
                                                             alpha = 0.3, width=0.2) +  theme(legend.title = element_blank(), axis.title.x=element_blank())


#position = position_dodge(width = 0.1) #this is to tilt the error bars so they do not overlap


analpartners_gender_gp_comb3 <- analpartners_gender3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

analpartners_gender_gp_comb3 + facet_wrap(~group, ncol = 5,  scales = "free_x") +
  theme(strip.background = element_blank(), strip.placement = "outside")

ggsave("analpartners_gender_gp_comb_updated20210921.png", dpi=1200, height=3.7, width=7.3, units="in")
