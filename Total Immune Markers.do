import spss using "C:\Users\narul\Desktop\Projects\year2024\TOTAL IMMUNE MARKERS.sav"


*****************DATA MANAGEMENT & CLEANING****************


numlabel, a
replace age=42 if missing(age)
recode age (min/29=1 "<30 yrs") (30/39=2 "30-39 years") (40/49=3 "40-49 years") (50/59=4 "50-59 years") (60/99=5 "60+ yrs"),gen(age_grp)
recode EDUCATION (1 4=1 "Nil/Primary") (2=2 Secondary) (3=3 Tertiary) (.=4 Unknown), gen(educ)
recode MARITAL (1=1 Single) (2=2 Married) (3 4=3 "Separated/Divorced/Widowed") (.=.), gen(mar_stat)
recode RELIGION (1=1 Christianity) (2=2 Islam) (.=3 Unknown), gen(religion)

tab1 ARTGRP gender
sum age
tab1 age_grp EDUCATION educ MARITAL mar_stat religion orallesion

label variable IL_4 IL_4
label variable IL_6 IL_6
label variable IL_10 IL_10
label variable TNF TNF
label variable MPO MPO
label variable BETA_DF BETA_DF
label variable LACTOFERRIN LACTOFERRIN
label variable sIgA sIgA

swilk IL_4- sIgA
sktest IL_4- sIgA

oneway IL_4 ARTGRP, tabulate


table ARTGRP, content(freq p25 IL_4 p50 IL_4 p75 IL_4 mean IL_4 )
kwallis IL_4, by(ARTGRP)

table ARTGRP, content(freq p25 IL_6 p50 IL_6 p75 IL_6)
kwallis IL_6, by(ARTGRP)

table ARTGRP, content(freq p25 IL_10 p50 IL_10 p75 IL_10 mean IL_10 )
kwallis IL_10, by(ARTGRP)

table ARTGRP, content(freq p25 TNF p50 TNF p75 TNF mean TNF )
kwallis TNF, by(ARTGRP)

table ARTGRP, content(freq p25 MPO p50 MPO p75 MPO mean MPO )
kwallis MPO, by(ARTGRP)

table ARTGRP, content(freq p25 BETA_DF p50 BETA_DF p75 BETA_DF mean BETA_DF )
kwallis BETA_DF, by(ARTGRP)

table ARTGRP, content(freq p25 BETA_DF p50 BETA_DF p75 BETA_DF mean BETA_DF )
kwallis BETA_DF, by(ARTGRP)

table ARTGRP, content(freq p25 LACTOFERRIN p50 LACTOFERRIN p75 LACTOFERRIN mean LACTOFERRIN )
kwallis LACTOFERRIN, by(ARTGRP)

table ARTGRP, content(freq p25 sIgA p50 sIgA p75 sIgA mean sIgA )
kwallis sIgA, by(ARTGRP)

bysort ARTGRP: spearman IL_4- sIgA, stats(rho p)

graph matrix IL_4- sIgA

graph box IL_4 IL_6 , over( ARTGRP)
graph box IL_10, over( ARTGRP)

graph box IL_4, over(ARTGRP)
graph box IL_6, over(ARTGRP)
graph box IL_10, over(ARTGRP)
graph box TNF, over(ARTGRP)
graph box MPO, over(ARTGRP)
graph box BETA_DF, over(ARTGRP)
graph box LACTOFERRIN, over(ARTGRP)
graph box sIgA, over(ARTGRP)


ttest IL_4, by(CD4R)
ttest IL_6, by(CD4R)
ttest IL_10, by(CD4R)
ttest TNF, by(CD4R)
ttest MPO, by(CD4R)
ttest BETA_DF, by(CD4R)
ttest LACTOFERRIN, by(CD4R)
ttest sIgA, by(CD4R)

bysort CD4R: tabstat IL_4-sIgA, stat(p50 p25 p75)

ranksum IL_4, by(CD4R)
ranksum IL_6, by(CD4R)
ranksum IL_10, by(CD4R)
ranksum TNF, by(CD4R)
ranksum MPO, by(CD4R)
ranksum BETA_DF, by(CD4R)
ranksum LACTOFERRIN, by(CD4R)
ranksum sIgA, by(CD4R)

tab CD4R orallesion, row chi

recode CD4R (1=0 "<200") (2=1 ">200") (else=.), gen(cd4)

encode ORALDXS, gen(oraldx)
recode oraldx (1 3/7=1 Yes) (else=0 No), gen(oraldxx)
logistic cd4 i.ARTGRP, allbase
logistic cd4 i.gender, allbase
logistic cd4 i.age_grp, allbase
logistic cd4 IL_4, allbase
logistic cd4 IL_6, allbase
logistic cd4 IL_10, allbase
logistic cd4 TNF, allbase
logistic cd4 MPO, allbase
logistic cd4 BETA_DF, allbase
logistic cd4 LACTOFERRIN, allbase
logistic cd4 sIgA, allbase
logistic cd4 i.educ, allbase
logistic cd4 i.mar_stat, allbase
logistic cd4 i.religion, allbase
logistic cd4 i.orallesion, allbase
logistic cd4 i.oraldxx, allbase

logistic cd4 i.ARTGRP i.orallesion, allbase

table ARTGRP, content(mean IL_4 mean IL_6 mean IL_10 mean TNF)

table ARTGRP, content(mean MPO mean BETA_DF mean LACTOFERRIN mean sIgA)