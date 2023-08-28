********************************************************************************
********************************************************************************
********************************************************************************
*** Round 61 data - CE survey ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA papers\NSSO 61 round 2004-05 - Household consumer expenditure survey\DTA_NSS_R61_1_0"

use "Blocks 1,2 & 12_ Identification of sample household and perception of household regarding sufficiency of food.dta",clear

ren *,l
unique hhid

keep hhid state district round sector mlt dateofsurvey
ren dateofsurvey date_survey

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 61 CE part 1.dta",replace
********************************************************************************
use "Block 3 Part 1_Household Characteristics.dta",clear

ren *,l
unique hhid

keep hhid b3_q1 b3_q2 hh_type b3_q6 b3_q14
ren b3_q1 hh_size
ren b3_q2 nic
ren b3_q6 soc_grp
ren b3_q14 land

gen land_1="" 
replace land_1="01" if land<0.005
replace land_1="02" if land>=0.005 & land<=.01
replace land_1="03" if land>0.01 & land<=0.2
replace land_1="04" if land>0.2 & land<=0.4
replace land_1="05" if land>0.4 & land<=1
replace land_1="06" if land>1 & land<=2
replace land_1="07" if land>2 & land<=3
replace land_1="08" if land>3 & land<=4
replace land_1="10" if land>4 & land<=6
replace land_1="11" if land>6 & land<=8
replace land_1="12" if land>8 & land!=.

tab land_1
drop land
ren land_1 land
tab land

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 61 CE part 2.dta",replace
********************************************************************************
use "Block 3 Part 2_Household Characteristics.dta",clear

ren *,l
unique hhid

keep hhid b3_q28 
ren b3_q28 mpce

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 61 CE part 3.dta",replace
********************************************************************************
use "Block 5_Monthly consumption of food, pan, tobacco and intoxicants.dta",clear

ren *,l
unique hhid

tab b5_q1

sort hhid
*** Basic food - cereals, pulses, vegetables, sugar, salt and spices ***
by hhid:gen basic_food_1=sum(b5_q6) if inlist(b5_q1,"129","159","229","269","279","289")
by hhid:egen basic_food=max(basic_food_1)
*** Luxury food - milk & milk products, edible oil, egg,fish & meat, fruits (fresh & dry), beverages ***
by hhid:gen lux_food_1=sum(b5_q6) if inlist(b5_q1,"169","179","189","249","259","309")
by hhid:egen lux_food=max(lux_food_1)
*** Intoxicants - pan, tobacco & intoxicants ***
by hhid:gen intox_1=sum(b5_q6) if inlist(b5_q1,"319","329","339")
by hhid:egen intox=max(intox_1)

keep hhid basic_food lux_food intox
duplicates drop

summ basic_food
unique hhid if basic_food<1
replace basic_food=1 if basic_food<1
summ basic_food

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 61 CE part 4.dta",replace
********************************************************************************
use "Block 11_Expenditure for purchase and construction of durable goods for domestic use.dta",clear

ren *,l
unique hhid

sort hhid
*** Jewelry ***
by hhid:gen jewelry_1=sum(b11_q14) if inlist(b11_q1,"579")
by hhid:egen jewelry=max(jewelry_1)
*** Durable goods ***
by hhid:gen durabletemp_1=sum(b11_q14) if inlist(b11_q1,"659")
by hhid:egen durabletemp=max(durabletemp_1)
gen durable=durabletemp-jewelry
summ durable
replace durable=durabletemp if durable<0

keep hhid jewelry durable
duplicates drop

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 61 CE part 5.dta",replace
********************************************************************************
*** Round 61 data merge ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners"

use "Round 61 CE part 1.dta",clear

merge 1:1 hhid using "Round 61 CE part 2.dta"
ren _merge _mergeround61_2
tab _mergeround61_2

merge 1:1 hhid using "Round 61 CE part 3.dta"
ren _merge _mergeround61_3
tab _mergeround61_3

merge 1:1 hhid using "Round 61 CE part 4.dta"
ren _merge _mergeround61_4
tab _mergeround61_4

merge 1:1 hhid using "Round 61 CE part 5.dta"
ren _merge _mergeround61_5
tab _mergeround61_5

drop _mergeround61_2 _mergeround61_3 _mergeround61_4 _mergeround61_5

save "Round 61 CE data.dta",replace
********************************************************************************
********************************************************************************
********************************************************************************
*** Round 62 data - CE survey ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA papers\NSSO 62 round 2005-06 - Household consumer expenditure survey\DTA_NSS_R62_1_0"

use "Blocks 1,2_Identification of Sample Household.dta",clear

ren *,l
unique hhid
ren dateofsurvey date_survey

keep hhid state district sector round date_survey mlt

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 62 CE part 1.dta",replace
********************************************************************************
use "Block 3_Household Characteristics.dta",clear

ren *,l
unique hhid

keep hhid b3_q1 b3_q2 hh_type b3_q6 b3_q7 b3_q14 mlt
ren b3_q1 hh_size
ren b3_q2 nic
ren b3_q6 soc_grp
ren b3_q7 land
ren b3_q14 mpce

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 62 CE part 2.dta",replace
********************************************************************************
use "Block 5_Monthly household expenditure on food and non food items.dta",clear

ren *,l
ren hhid2 hhid
unique hhid

tab b5_q1

sort hhid
*** Basic food - cereals, pulses, vegetables, sugar, salt and spices ***
by hhid:gen basic_food_1=sum(b5_q4) if inlist(b5_q1,"129","159","229","269","279","289")
by hhid:egen basic_food=max(basic_food_1)
*** Luxury food - milk & milk products, edible oil, egg,fish & meat, fruits (fresh & dry), beverages ***
by hhid:gen lux_food_1=sum(b5_q4) if inlist(b5_q1,"169","179","189","249","259","309")
by hhid:egen lux_food=max(lux_food_1)
*** Intoxicants - pan, tobacco & intoxicants ***
by hhid:gen intox_1=sum(b5_q4) if inlist(b5_q1,"319","329","339")
by hhid:egen intox=max(intox_1)

keep hhid basic_food lux_food intox
duplicates drop

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 62 CE part 3.dta",replace
********************************************************************************
use "Block 11_Household expenditure on durables.dta",clear

ren *,l
unique hhid

sort hhid
*** Jewelry ***
by hhid:gen jewelry_1=sum(b11_q10) if inlist(b11_q1,"579")
by hhid:egen jewelry=max(jewelry_1)
*** Durable goods ***
by hhid:gen durabletemp_1=sum(b11_q10) if inlist(b11_q1,"659")
by hhid:egen durabletemp=max(durabletemp_1)
gen durable=durabletemp-jewelry

keep hhid jewelry durable
duplicates drop

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 62 CE part 4.dta",replace
********************************************************************************
*** Round 62 data merge ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners"

use "Round 62 CE part 1.dta",clear
merge 1:1 hhid using "Round 62 CE part 2.dta"
ren _merge _mergeround62_2
tab _mergeround62_2

merge 1:1 hhid using "Round 62 CE part 3.dta"
ren _merge _mergeround62_3
tab _mergeround62_3

merge 1:1 hhid using "Round 62 CE part 4.dta"
ren _merge _mergeround62_4
tab _mergeround62_4

drop _mergeround62_2 _mergeround62_3 _mergeround62_4

save "Round 62 CE data.dta",replace
********************************************************************************
********************************************************************************
********************************************************************************
*** Round 63 data - CE survey ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA papers\NSSO 63 round 2006-07 - Household consumer expenditure survey\DTA_NSS_R63_1_0"

use "Blocks 1,2_Identification of Sample Household",clear

ren *,l
unique hhid

ren dateofsurvey date_survey

keep hhid state district sector round date_survey mlt

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 63 CE part 1.dta",replace
********************************************************************************
use "Block 3_Household Characteristics",clear

ren *,l
unique hhid

keep hhid b3_q1 b3_q2 hh_type b3_q6 b3_q7 b3_q14
ren b3_q1 hh_size
ren b3_q2 nic
ren b3_q6 soc_grp
ren b3_q7 land
ren b3_q14 mpce

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 63 CE part 2.dta",replace
********************************************************************************
use "Block 5_Monthly household expenditure on food and non food items.dta",clear

ren *,l
unique hhid

tab b5_q1

sort hhid
*** Basic food - cereals, pulses, vegetables, sugar, salt and spices ***
by hhid:gen basic_food_1=sum(b5_q4) if inlist(b5_q1,"129","159","229","269","279","289")
by hhid:egen basic_food=max(basic_food_1)
*** Luxury food - milk & milk products, edible oil, egg,fish & meat, fruits (fresh & dry), beverages ***
by hhid:gen lux_food_1=sum(b5_q4) if inlist(b5_q1,"169","179","189","249","259","309")
by hhid:egen lux_food=max(lux_food_1)
*** Intoxicants - pan, tobacco & intoxicants ***
by hhid:gen intox_1=sum(b5_q4) if inlist(b5_q1,"319","329","339")
by hhid:egen intox=max(intox_1)

keep hhid basic_food lux_food intox
duplicates drop

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 63 CE part 3.dta",replace
********************************************************************************
use "Block 11_Household expenditure on durables.dta",clear

ren *,l
unique hhid

sort hhid
*** Jewelry ***
by hhid:gen jewelry_1=sum(b11_q10) if inlist(b11_q1,"579")
by hhid:egen jewelry=max(jewelry_1)
*** Durable goods ***
by hhid:gen durabletemp_1=sum(b11_q10) if inlist(b11_q1,"659")
by hhid:egen durabletemp=max(durabletemp_1)
gen durable=durabletemp-jewelry

keep hhid jewelry durable
duplicates drop

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 63 CE part 4.dta",replace
********************************************************************************
*** Round 63 data merge ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners"

use "Round 63 CE part 1.dta",clear
merge 1:1 hhid using "Round 63 CE part 2.dta"
ren _merge _mergeround63_2
tab _mergeround63_2

merge 1:1 hhid using "Round 63 CE part 3.dta"
ren _merge _mergeround63_3
tab _mergeround63_3

merge 1:1 hhid using "Round 63 CE part 4.dta"
ren _merge _mergeround63_4
tab _mergeround63_4

drop _mergeround63_2 _mergeround63_3 _mergeround63_4

save "Round 63 CE data.dta",replace
********************************************************************************
********************************************************************************
********************************************************************************
*** Round 64 data - CE survey ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA papers\NSSO 64 round 2007-08 - Household consumer expenditure survey\DTA_NSS_R64_1_0"

use "Identification of Sample Household.dta",clear

ren *,l
ren hh_id hhid
unique hhid

ren date_of_survey date_survey
drop mlt
ren multiplier mlt

keep hhid state district sector round date_survey mlt

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 64 CE part 1.dta",replace
********************************************************************************
use "Household Characteristics.dta",clear

ren *,l
ren hh_id hhid
unique hhid

ren nic_2004_code nic
ren social_group soc_grp
ren land_possessed_code land
ren mpce_value mpce
ren hh_type_code hh_type

keep hhid hh_size hh_type nic soc_grp land mpce

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 64 CE part 2.dta",replace
********************************************************************************
use "Consumption of food, pan, tobacco , intoxicants and fuel during  the last 30 days.dta",clear

ren *,l
ren hh_id hhid
unique hhid

tab item_code

sort hhid item_code
*** Basic food - cereals, pulses, vegetables, sugar, salt and spices ***
by hhid:gen basic_food_1=sum(value_in_rs) if inlist(item_code,"129","159","229","269","279","289")
by hhid:egen basic_food=max(basic_food_1)
*** Luxury food - milk & milk products, edible oil, egg,fish & meat, fruits (fresh & dry), beverages ***
by hhid:gen lux_food_1=sum(value_in_rs) if inlist(item_code,"169","179","189","249","259","309")
by hhid:egen lux_food=max(lux_food_1)
*** Intoxicants - pan, tobacco & intoxicants ***
by hhid:gen intox_1=sum(value_in_rs) if inlist(item_code,"319","329","339")
by hhid:egen intox=max(intox_1)

keep hhid basic_food lux_food intox
duplicates drop

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 64 CE part 3.dta",replace
********************************************************************************
use "Expenditure for purchase and construction of durable goods for domestic use during the last 365.dta",clear

ren *,l
ren hh_id hhid
unique hhid

sort hhid item_code
*** Jewelry ***
by hhid:gen jewelry_1=sum(total_expenditure) if inlist(item_code,"579")
by hhid:egen jewelry=max(jewelry_1)
*** Durable goods ***
by hhid:gen durabletemp_1=sum(total_expenditure) if inlist(item_code,"659")
by hhid:egen durabletemp=max(durabletemp_1)
gen durable=durabletemp-jewelry

keep hhid jewelry durable
duplicates drop

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 64 CE part 4.dta",replace
********************************************************************************
*** Round 64 data merge ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners"

use "Round 64 CE part 1.dta",clear
merge 1:1 hhid using "Round 64 CE part 2.dta"
ren _merge _mergeround64_2
tab _mergeround64_2

merge 1:1 hhid using "Round 64 CE part 3.dta"
ren _merge _mergeround64_3
tab _mergeround64_3

merge 1:1 hhid using "Round 64 CE part 4.dta"
ren _merge _mergeround64_4
tab _mergeround64_4

drop _mergeround64_2 _mergeround64_3 _mergeround64_4

save "Round 64 CE data.dta",replace
********************************************************************************
********************************************************************************
********************************************************************************
*** Round 66 data - CE survey ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA papers\NSSO 66 round 2009-10 - Household consumer expenditure survey\DTA_NSS_R66_1_0_T1"

use "Identification of Sample Household.dta",clear

ren *,l
ren hh_id hhid
unique hhid

ren dos date_survey
drop mlt
ren multiplier mlt

keep hhid state district sector round date_survey mlt

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 66 CE part 1.dta",replace
********************************************************************************
use "Household Characteristics",clear

ren *,l
ren hh_id hhid
unique hhid

ren nic_2004 nic
ren social_group soc_grp
ren mpce_mrp mpce
ren land_cultivated land

gen land_1="" 
replace land_1="01" if land<0.005
replace land_1="02" if land>=0.005 & land<=.01
replace land_1="03" if land>0.01 & land<=0.2
replace land_1="04" if land>0.2 & land<=0.4
replace land_1="05" if land>0.4 & land<=1
replace land_1="06" if land>1 & land<=2
replace land_1="07" if land>2 & land<=3
replace land_1="08" if land>3 & land<=4
replace land_1="10" if land>4 & land<=6
replace land_1="11" if land>6 & land<=8
replace land_1="12" if land>8 & land!=.

tab land_1
drop land
ren land_1 land

keep hhid hh_size nic hh_type soc_grp land mpce

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 66 CE part 2.dta",replace
********************************************************************************
use "Consumption of cereals, pulses, milk and milk products, sugar and salt during the last 30 days.dta",clear

ren *,l
ren hh_id hhid
unique hhid

tab item_code

sort hhid item_code
*** Basic food - cereals, pulses, vegetables, sugar, salt and spices ***
by hhid:gen basic_food_1=sum(total_value) if inlist(item_code,"129","159","249","179","189","289")
by hhid:egen basic_food=max(basic_food_1)
*** Luxury food - milk & milk products, edible oil, egg,fish & meat, fruits (fresh & dry), beverages ***
by hhid:gen lux_food_1=sum(total_value) if inlist(item_code,"169","199","209","269","279","309")
by hhid:egen lux_food=max(lux_food_1)
*** Intoxicants - pan, tobacco & intoxicants ***
by hhid:gen intox_1=sum(total_value) if inlist(item_code,"319","329","339")
by hhid:egen intox=max(intox_1)

keep hhid basic_food lux_food intox
duplicates drop

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 66 CE part 3.dta",replace
********************************************************************************
use "Expenditure for purchase and construction of durable goods for domestic use.dta",clear

ren *,l
ren hh_id hhid
unique hhid

sort hhid item_code
*** Jewelry ***
by hhid:gen jewelry_1=sum(total_expenditure_365days) if inlist(item_code,"649")
by hhid:egen jewelry=max(jewelry_1)
*** Durable goods ***
by hhid:gen durabletemp_1=sum(total_expenditure_365days) if inlist(item_code,"659")
by hhid:egen durabletemp=max(durabletemp_1)
gen durable=durabletemp-jewelry

keep hhid jewelry durable
duplicates drop

save "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners\Round 66 CE part 4.dta",replace
********************************************************************************
*** Round 66 data merge ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners"

use "Round 66 CE part 1.dta",clear
merge 1:1 hhid using "Round 66 CE part 2.dta"
ren _merge _mergeround66_2
tab _mergeround66_2

merge 1:1 hhid using "Round 66 CE part 3.dta"
ren _merge _mergeround66_3
tab _mergeround66_3

merge 1:1 hhid using "Round 66 CE part 4.dta"
ren _merge _mergeround66_4
tab _mergeround66_4

drop _mergeround66_2 _mergeround66_3 _mergeround66_4

save "Round 66 CE data.dta",replace
********************************************************************************
********************************************************************************
******************************************************************************** 
*** Appending data ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners"

use "Round 61 CE data.dta",clear
append using "Round 62 CE data.dta"
append using "Round 63 CE data.dta"
append using "Round 64 CE data.dta"
append using "Round 66 CE data.dta"
********************************************************************************
********************************************************************************
********************************************************************************
tab state
unique state

tab land
forvalues i = 61(1)66 {
tab land if round=="`i'"
}

forvalues i = 61(1)66 {
unique district if round=="`i'"
}

tab district if round=="61"
tab district if round=="62"
tab district if round=="63"
tab district if round=="64"
tab district if round=="66"

unique district if state=="33" & round=="61"
unique district if state=="33" & round=="62"
unique district if state=="33" & round=="63"
unique district if state=="33" & round=="64"
unique district if state=="33" & round=="66"

gen district_64=substr(district,4,2) if round=="64"
replace district=district_64 if round=="64"
gen district_66=substr(district,3,2) if round=="66"
replace district=district_66 if round=="66"

forvalues i = 61(1)66 {
unique district if round=="`i'"
}

gen year=substr(date_survey,-2,2)
tab year
gen month=substr(date_survey,-4,2)
tab month
tab month year

forvalues i = 61(1)66 {
unique hhid if round=="`i'"
}
unique hhid
********************************************************************************
*** Need to use hhid_round instead of hhid due to duplicate hhids ***
egen hhid_round=group(hhid round)

forvalues i = 61(1)66 {
unique hhid_round if round=="`i'"
}

sort hhid
by hhid: gen hhid_count=_N
tab hhid_count

unique hhid_round
order hhid_round hhid round
sort round hhid hhid_round
********************************************************************************
********************************************************************************
********************************************************************************
gen season=1 if inlist(month,"01","02","03","04","05","06")
replace season=2 if inlist(month,"07","08","09","10","11","12")

gen quarter=1 if inlist(month,"01","02","03")
replace quarter=2 if inlist(month,"04","05","06")
replace quarter=3 if inlist(month,"07","08","09")
replace quarter=4 if inlist(month,"10","11","12")

egen year_season=group(year season)
egen year_quarter=group(year quarter)
tab year_quarter
tab year_season


global consumvar "mpce basic_food lux_food intox jewelry durable"

foreach y in $consumvar {
gen `y'_adj=`y' if round=="61"
replace `y'_adj=`y'*340/353 if round=="62"
replace `y'_adj=`y'*340/380 if round=="63"
replace `y'_adj=`y'*340/409 if round=="64"
gen ln_`y'_adj=ln(`y'_adj)
}
/*
gen mpce_adj=mpce if round=="61"
replace mpce_adj=mpce*340/358 if round=="62"
replace mpce_adj=mpce*340/392 if round=="63"
replace mpce_adj=mpce*340/423 if round=="64"
*** For round 66, didn't have the CPI-AL numbers clearly ***
*** https://www.indiabudget.gov.in/budget_archive/es2009-10/chapt2010/tab53.pdf ***
*/

destring state,gen(state_1)
destring round,gen(round_1)
destring month,gen(month_1)
destring year,gen(year_1)
destring soc_grp,gen(soc_grp_1)
replace soc_grp="" if inlist(soc_grp,"N","X")
destring soc_grp,gen(soc_grp_1)

egen state_district=group(state district)

gen landed=0
replace landed=1 if inlist(land,"03","04","05","06","07","08","10","11","12")

gen nic_3=substr(nic,1,3)
tab nic_3
***
summ $consumvar if sector=="1" & round=="61"
summ $consumvar if sector=="1" & round=="62"
summ $consumvar if sector=="1" & round=="63"
summ $consumvar if sector=="1" & round=="64"

summ $consumvar if round=="61" & sector=="1" & landed==1 & nic_3=="011"
summ $consumvar if round=="62" & sector=="1" & landed==1 & nic_3=="011"
summ $consumvar if round=="63" & sector=="1" & landed==1 & nic_3=="011"
summ $consumvar if round=="64" & sector=="1" & landed==1 & nic_3=="011"
***
gen phase1=0
replace phase1=1 if year_1>=6 & month_1>=2
gen phase2=0
replace phase2=1 if year_1>=7 & month_1>=4
gen phase3=0
replace phase3=1 if year_1>=8 & month_1>=4

*** Removing UTs ***
gen all_state=0
replace all_state=1 if !inlist(state,"04","07","25","26","31","34","35")
*replace states=1 if inlist(state,"28","18","10","22","24","06","20","29","32")
*replace states=1 if inlist(state,"23","27","21","03","08","33","09","05","19")
*** Main states ***
gen main_state=0
replace main_state=1 if inlist(state,"02","03","05","06","08","09","10","18")
replace main_state=1 if inlist(state,"19","20","21","22","23","24","27","28")
replace main_state=1 if inlist(state,"29","32","33")
*** Star states ***
gen star_state=0
replace star_state=1 if inlist(state,"02","05","08","22","23","28","33")
********************************************************************************
********************************************************************************
********************************************************************************
gen district1=0
gen district2=0
gen district3=0
*** Andhra Pradesh ***
replace district1=1 if state=="28" & inlist(district,"01","22","03","20","23","10","07","04","08")
replace district1=1 if state=="28" & inlist(district,"02","06","12","09")
replace district2=1 if state=="28" & inlist(district,"19","14","11","21","18","17")
replace district3=1 if state=="28" & inlist(district,"15","16","13")
* Assam *
replace district1=1 if state=="18" & inlist(district,"04","13","03","19","01","12","20")
replace district2=1 if state=="18" & inlist(district,"09","08","07","05","23","21")
replace district3=1 if state=="18" & inlist(district,"22","18","16","11","02","10","17","15","14")
replace district3=1 if state=="18" & inlist(district,"06","26","25","27","24")
* Bihar *
replace district1=1 if state=="10" & inlist(district,"07","34","13","29","35","37","33","31","10")
replace district1=1 if state=="10" & inlist(district,"08","25","05","24","14","27","28","36","09")
replace district1=1 if state=="10" & inlist(district,"32","19","03","18","06")
replace district2=1 if state=="10" & inlist(district,"16","26","11","21","04","12","01","23","02")
replace district2=1 if state=="10" & inlist(district,"22","15","20","17","30","38")
* Chhattisgarh * 
replace district1=1 if state=="22" & inlist(district,"07","15","13","16","03","14","08","01","04")
replace district1=1 if state=="22" & inlist(district,"09","02")
replace district2=1 if state=="22" & inlist(district,"05","06","11","12")
replace district3=1 if state=="22" & inlist(district,"10")
* Gujarat *
replace district1=1 if state=="24" & inlist(district,"02","23","18","20","17","05")
replace district2=1 if state=="24" & inlist(district,"21","24","25")
replace district3=1 if state=="24" & inlist(district,"16","03","04","13","08","15","12","01","06")
replace district3=1 if state=="24" & inlist(district,"14","10","19","09","11","22","07")
* Haryana *
replace district1=1 if state=="06" & inlist(district,"11","16")
replace district2=1 if state=="06" & inlist(district,"02","20")
replace district3=1 if state=="06" & inlist(district,"10","17","13","05","09","15","18","08","12")
replace district3=1 if state=="06" & inlist(district,"04","06","03","14","01","07","19")
* Jharkhand *
replace district1=1 if state=="20" & inlist(district,"13","03","11","12","01","06","08","16","04")
replace district1=1 if state=="20" & inlist(district,"05","21","15","19","10","02","14","09","22")
replace district1=1 if state=="20" & inlist(district,"20","17")
replace district2=1 if state=="20" & inlist(district,"18","07")
*replace phase3=1 if state=="20" & inlist(district,") --> districts not present
* Karnataka *
replace district1=1 if state=="29" & inlist(district,"05","13","14","04","06")
replace district2=1 if state=="29" & inlist(district,"12","23","01","17","15","25")
replace district3=1 if state=="29" & inlist(district,"22","27","07","16","11","18","03","21","10")
replace district3=1 if state=="29" & inlist(district,"19","02","08","26","09","24","20")
* Kerala *
replace district1=1 if state=="32" & inlist(district,"06","03")
replace district2=1 if state=="32" & inlist(district,"09","01")
replace district3=1 if state=="32" & inlist(district,"05","12","10","07","11","14","04","08","02")
* Madhya Pradesh *
replace district1=1 if state=="23" & inlist(district,"45","28","09","35","25","41","24","29","27")
replace district1=1 if state=="23" & inlist(district,"42","13","44","01","06","16","08","15","17")
replace district2=1 if state=="23" & inlist(district,"43","36","10","38","07","23","05","14","12")
replace district2=1 if state=="23" & inlist(district,"30","46","47","48")
replace district3=1 if state=="23" & inlist(district,"40","33","22","34","19","31","02","03","10")
replace district3=1 if state=="23" & inlist(district,"18","20","37","21","39","04","26","32")
* Maharashtra *
replace district1=1 if state=="27" & inlist(district,"07","26","10","19","02","13","11","12","15")
replace district1=1 if state=="27" & inlist(district,"16","01","14")
replace district2=1 if state=="27" & inlist(district,"21","08","04","29","05","06")
replace district3=1 if state=="27" & inlist(district,"32","33","18","27","31","24","28","03","35")
replace district3=1 if state=="27" & inlist(district,"17","34","20","30","09","25")
* Orissa *
replace district1=1 if state=="21" & inlist(district,"22","24","04","14","19","20","02","21","26")
replace district1=1 if state=="21" & inlist(district,"06","29","07","30","25","28","03","27","05")
replace district1=1 if state=="21" & inlist(district,"23")
replace district2=1 if state=="21" & inlist(district,"01","15","08","09","13")
replace district3=1 if state=="21" & inlist(district,"10","16","11","12","18","17")
* Punjab *
replace district1=1 if state=="03" & inlist(district,"05")
replace district2=1 if state=="03" & inlist(district,"02","04","06")
replace district3=1 if state=="03" & inlist(district,"10","15","01","12","08","11","14","16","03")
replace district3=1 if state=="03" & inlist(district,"07","13","17","09","18")
* Rajasthan *
replace district1=1 if state=="08" & inlist(district,"27","28","09","32","19","26")
replace district2=1 if state=="08" & inlist(district,"10","22","17","29","16","18")
replace district3=1 if state=="08" & inlist(district,"11","25","06","31","08","14","07","23","02")
replace district3=1 if state=="08" & inlist(district,"24","05","13","01","20","04","15","03","21")
replace district3=1 if state=="08" & inlist(district,"12","30")
* Tamilnadu *
replace district1=1 if state=="33" & inlist(district,"13","18","19","23","06","07")
replace district2=1 if state=="33" & inlist(district,"20","21","14","29")
replace district3=1 if state=="33" & inlist(district,"05","17","16","22","09","27","04","28","26")
replace district3=1 if state=="33" & inlist(district,"08","10","03","15","01","25","11","24","12")
replace district3=1 if state=="33" & inlist(district,"30","31")
* Uttar Pradesh *
replace district1=1 if state=="09" & inlist(district,"40","61","46","66","41","42","38","58","25")
replace district1=1 if state=="09" & inlist(district,"35","44","64","23","59","37","39","43","69")
replace district1=1 if state=="09" & inlist(district,"24","28","26","70")
replace district2=1 if state=="09" & inlist(district,"33","36","49","62","48","55","56","57","50")
replace district2=1 if state=="09" & inlist(district,"54","51","52","53","63","17","19","29")
replace district3=1 if state=="09" & inlist(district,"60","65","47","68","18","32","21","30","08")
replace district3=1 if state=="09" & inlist(district,"13","22","31","03","11","06","45","02","05")
replace district3=1 if state=="09" & inlist(district,"01","14","12","16","04","20","10","67","07")
replace district3=1 if state=="09" & inlist(district,"15","09","27","34")
* Uttarakhand *
replace district1=1 if state=="05" & inlist(district,"02","10","04")
replace district2=1 if state=="05" & inlist(district,"12","13")
replace district3=1 if state=="05" & inlist(district,"03","08","01","09","06","07","11","15")
* West Bengal *
replace district1=1 if state=="19" & inlist(district,"13","18","05","08","02","04","06","15","07")
replace district1=1 if state=="19" & inlist(district,"14")
replace district2=1 if state=="19" & inlist(district,"03","10","09","19","11","12","01")
replace district3=1 if state=="19" & inlist(district,"16")


* Arunachal Pradesh *
replace district1=1 if state=="12" & inlist(district,"06")
replace district2=1 if state=="12" & inlist(district,"11","12")
replace district3=1 if state=="12" & inlist(district,"01","02","03","04","05","07","08","09","10")
replace district3=1 if state=="12" & inlist(district,"13")
* Himachal Pradesh *
replace district1=1 if state=="02" & inlist(district,"01","10")
replace district2=1 if state=="02" & inlist(district,"02","05")
replace district3=1 if state=="02" & inlist(district,"03","04","06","07","08","09","11","12")
* Jammu and Kashmir *
replace district1=1 if state=="01" & inlist(district,"01","09","11")
replace district2=1 if state=="01" & inlist(district,"06","13")
replace district3=1 if state=="01" & inlist(district,"02","03","04","05","07","08","10","12","14")
* Manipur *
replace district1=1 if state=="14" & inlist(district,"02")
replace district2=1 if state=="14" & inlist(district,"03","09")
replace district3=1 if state=="14" & inlist(district,"01","04","05","06","07","08")
* Meghalaya *
replace district1=1 if state=="17" & inlist(district,"01","03")
replace district2=1 if state=="17" & inlist(district,"05","06","07")
replace district3=1 if state=="17" & inlist(district,"02","04")
* Mizoram *
replace district1=1 if state=="15" & inlist(district,"07","08")
replace district2=1 if state=="15" & inlist(district,"04","06")
replace district3=1 if state=="15" & inlist(district,"01","02","03","05")
* Nagaland *
replace district1=1 if state=="13" & inlist(district,"01")
replace district2=1 if state=="13" & inlist(district,"03","07","02","05")
replace district3=1 if state=="13" & inlist(district,"04","08","06")
* Sikkim *
replace district1=1 if state=="11" & inlist(district,"01")
replace district2=1 if state=="11" & inlist(district,"03","04")
replace district3=1 if state=="11" & inlist(district,"02")
* Tripura *
replace district1=1 if state=="16" & inlist(district,"03")
replace district2=1 if state=="16" & inlist(district,"01","02")
replace district3=1 if state=="16" & inlist(district,"04")
* Goa *
replace district3=1 if state=="30" & inlist(district,"01","02")
********************************************************************************
********************************************************************************
********************************************************************************
gen post_nrega=0
replace post_nrega=1 if phase1==1 & district1==1
replace post_nrega=1 if phase2==1 & district2==1
replace post_nrega=1 if phase3==1 & district3==1

gen post_nrega_new=0
replace post_nrega_new=phase1*district1
replace post_nrega_new=phase2*district2 if post_nrega_new==0
replace post_nrega_new=phase3*district3 if post_nrega_new==0

gen post_nrega_new1=0
replace post_nrega_new1=1 if district1==1 & year_1>=06 & month_1>=02
replace post_nrega_new1=1 if district2==1 & year_1>=07 & month_1>=04
replace post_nrega_new1=1 if district3==1 & year_1>=08 & month_1>=04

gen post_nrega_new2=0
replace post_nrega_new2=phase1*district1
replace post_nrega_new2=phase2*district2
replace post_nrega_new2=phase3*district3

gen post_nrega_new3=phase1*district1
replace post_nrega_new3=phase2*district2 if post_nrega_new3==0
replace post_nrega_new3=phase3*district3 if post_nrega_new3==0

summ post_nrega post_nrega_new post_nrega_new1 post_nrega_new2 post_nrega_new3
/*
gen post_nrega_new_landed=0
replace post_nrega_new_landed=post_nrega_new*landed

gen post_nrega_new_landed1=0
replace post_nrega_new_landed1=1 if phase1==1 & district1==1 & landed==1
replace post_nrega_new_landed1=1 if phase2==1 & district2==1 & landed==1
replace post_nrega_new_landed1=1 if phase3==1 & district3==1 & landed==1

gen nrega_district_landed=0
replace nrega_district_landed=district1*landed
replace nrega_district_landed=district2*landed if nrega_district_landed==0
replace nrega_district_landed=district3*landed if nrega_district_landed==0

gen nrega_district_landed1=0
replace nrega_district_landed1=1 if district1==1 & landed==1
replace nrega_district_landed1=1 if district2==1 & landed==1
replace nrega_district_landed1=1 if district3==1 & landed==1

gen nrega_phase_landed=0
replace nrega_phase_landed=phase1*landed
replace nrega_phase_landed=phase2*landed if nrega_phase_landed==0
replace nrega_phase_landed=phase3*landed if nrega_phase_landed==0 

gen nrega_phase_landed1=0
replace nrega_phase_landed1=1 if phase1==1 & landed==1
replace nrega_phase_landed1=1 if phase2==1 & landed==1 
replace nrega_phase_landed1=1 if phase3==1 & landed==1

gen nrega_phase_marginal_n=0
replace nrega_phase_marginal_n=1 if phase1==1 & marginal_n==1
replace nrega_phase_marginal_n=1 if phase2==1 & marginal_n==1
replace nrega_phase_marginal_n=1 if phase3==1 & marginal_n==1

gen nrega_phase_marginal_n1=0
replace nrega_phase_marginal_n1=phase1*marginal_n
replace nrega_phase_marginal_n1=phase2*marginal_n if nrega_phase_marginal_n1==0
replace nrega_phase_marginal_n1=phase3*marginal_n if nrega_phase_marginal_n1==0

gen nrega_phase_small=0
replace nrega_phase_small=1 if phase1==1 & small==1
replace nrega_phase_small=1 if phase2==1 & small==1
replace nrega_phase_small=1 if phase3==1 & small==1

gen nrega_phase_small1=0
replace nrega_phase_small1=phase1*small
replace nrega_phase_small1=phase2*small if nrega_phase_small1==0
replace nrega_phase_small1=phase3*small if nrega_phase_small1==0

gen nrega_phase_semimedium=0
replace nrega_phase_semimedium=1 if phase1==1 & semimedium==1
replace nrega_phase_semimedium=1 if phase2==1 & semimedium==1
replace nrega_phase_semimedium=1 if phase3==1 & semimedium==1

gen nrega_phase_semimedium1=0
replace nrega_phase_semimedium1=phase1*semimedium
replace nrega_phase_semimedium1=phase2*semimedium if nrega_phase_semimedium1==0
replace nrega_phase_semimedium1=phase3*semimedium if nrega_phase_semimedium1==0

gen nrega_phase_large=0
replace nrega_phase_large=1 if phase1==1 & large==1
replace nrega_phase_large=1 if phase2==1 & large==1
replace nrega_phase_large=1 if phase3==1 & large==1

gen nrega_phase_large1=0
replace nrega_phase_large1=phase1*large
replace nrega_phase_large1=phase2*large if nrega_phase_large1==0
replace nrega_phase_large1=phase3*large if nrega_phase_large1==0
*/

foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 nrega_district_landed ///
				 nrega_phase_landed ///
				 post_nrega_new ///
				 post_nrega_new_landed ///
				 i.year_1  if star_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
				 
foreach y in $lnconsumvar {				 
areg `y'         nrega_district_landed ///
				 nrega_phase_landed ///
				 post_nrega_new ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if all_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c1_`y'
				 }
foreach y in $lnconsumvar {				 
areg `y'         marginal_n small semimedium medium large ///
				 nrega_district_marginal_n ///
				 nrega_district_small ///
				 nrega_district_semimedium ///
				 nrega_district_large ///
				 nrega_phase_marginal_n ///
				 nrega_phase_small ///
				 nrega_phase_semimedium ///
				 nrega_phase_large ///
				 post_nrega ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if star_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c1_`y'
				 }		
foreach y in $lnconsumvar {				 
areg `y'         marginal_n small semimedium medium large ///
				 nrega_district_landed1 ///
				 nrega_phase_landed1 ///
				 post_nrega ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if star_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c1_`y'
				 }				 
********************************************************************************
********************************************************************************
********************************************************************************

foreach y in marginal {
gen `y'=0
replace `y'=1 if inlist(land,"01","02","03","04","05")
gen `y'_1=0
replace `y'_1=1 if inlist(land,"01","02","03","04","05") & hh_type=="14"
gen `y'_2=0
replace `y'_2=1 if inlist(land,"01","02","03","04","05") & hh_type=="14" & inlist(nic_3,"011","013")
gen `y'_3=0
replace `y'_3=1 if inlist(land,"01","02","03","04","05") & hh_type!="14"
gen `y'_st=0
replace `y'_st=1 if inlist(land,"01","02","03","04","05") & soc_grp_1==1
gen `y'_sc=0
replace `y'_sc=1 if inlist(land,"01","02","03","04","05") & soc_grp_1==2
gen `y'_obc=0
replace `y'_obc=1 if inlist(land,"01","02","03","04","05") & soc_grp_1==3
gen `y'_scst=0
replace `y'_scst=1 if inlist(land,"01","02","03","04","05") & inlist(soc_grp_1,1,2)
}

foreach y in marginal_n {
gen `y'=0
replace `y'=1 if inlist(land,"03","04","05")
gen `y'_1=0
replace `y'_1=1 if inlist(land,"03","04","05") & hh_type=="14"
gen `y'_2=0
replace `y'_2=1 if inlist(land,"03","04","05") & hh_type=="14" & inlist(nic_3,"011","013")
gen `y'_3=0
replace `y'_3=1 if inlist(land,"03","04","05") & hh_type!="14"
gen `y'_st=0
replace `y'_st=1 if inlist(land,"03","04","05") & soc_grp_1==1
gen `y'_sc=0
replace `y'_sc=1 if inlist(land,"03","04","05") & soc_grp_1==2
gen `y'_obc=0
replace `y'_obc=1 if inlist(land,"03","04","05") & soc_grp_1==3
gen `y'_scst=0
replace `y'_scst=1 if inlist(land,"03","04","05") & inlist(soc_grp_1,1,2)
}

foreach y in small {
gen `y'=0
replace `y'=1 if inlist(land,"06")
gen `y'_1=0
replace `y'_1=1 if inlist(land,"06") & hh_type=="14"
gen `y'_2=0
replace `y'_2=1 if inlist(land,"06") & hh_type=="14" & inlist(nic_3,"011","013")
gen `y'_3=0
replace `y'_3=1 if inlist(land,"06") & hh_type!="14"
gen `y'_st=0
replace `y'_st=1 if inlist(land,"06") & soc_grp_1==1
gen `y'_sc=0
replace `y'_sc=1 if inlist(land,"06") & soc_grp_1==2
gen `y'_obc=0
replace `y'_obc=1 if inlist(land,"06") & soc_grp_1==3
gen `y'_scst=0
replace `y'_scst=1 if inlist(land,"06") & inlist(soc_grp_1,1,2)
}

foreach y in marginalsmall {
gen `y'=0
replace `y'=1 if inlist(land,"01","02","03","04","05","06")
gen `y'_n=0
replace `y'_n=1 if inlist(land,"03","04","05","06")
gen `y'_1=0
replace `y'_1=1 if inlist(land,"01","02","03","04","05","06") & hh_type=="14"
gen `y'_2=0
replace `y'_2=1 if inlist(land,"01","02","03","04","05","06") & hh_type=="14" & inlist(nic_3,"011","013")
gen `y'_3=0
replace `y'_3=1 if inlist(land,"01","02","03","04","05","06") & hh_type!="14"
gen `y'_st=0
replace `y'_st=1 if inlist(land,"01","02","03","04","05","06") & soc_grp_1==1
gen `y'_sc=0
replace `y'_sc=1 if inlist(land,"01","02","03","04","05","06") & soc_grp_1==2
gen `y'_obc=0
replace `y'_obc=1 if inlist(land,"01","02","03","04","05","06") & soc_grp_1==3
gen `y'_scst=0
replace `y'_scst=1 if inlist(land,"01","02","03","04","05","06") & inlist(soc_grp_1,1,2)
}

foreach y in semimedium {
gen `y'=0
replace `y'=1 if inlist(land,"07","08")
gen `y'_1=0
replace `y'_1=1 if inlist(land,"07","08") & hh_type=="14"
gen `y'_2=0
replace `y'_2=1 if inlist(land,"07","08") & hh_type=="14" & inlist(nic_3,"011","013")
gen `y'_3=0
replace `y'_3=1 if inlist(land,"07","08") & hh_type!="14"
gen `y'_st=0
replace `y'_st=1 if inlist(land,"07","08") & soc_grp_1==1
gen `y'_sc=0
replace `y'_sc=1 if inlist(land,"07","08") & soc_grp_1==2
gen `y'_obc=0
replace `y'_obc=1 if inlist(land,"07","08") & soc_grp_1==3
gen `y'_scst=0
replace `y'_scst=1 if inlist(land,"07","08") & inlist(soc_grp_1,1,2)
}

foreach y in medium {
gen `y'=0
replace `y'=1 if inlist(land,"10","11")
gen `y'_1=0
replace `y'_1=1 if inlist(land,"10","11") & hh_type=="14"
gen `y'_2=0
replace `y'_2=1 if inlist(land,"10","11") & hh_type=="14" & inlist(nic_3,"011","013")
gen `y'_3=0
replace `y'_3=1 if inlist(land,"10","11") & hh_type!="14"
gen `y'_st=0
replace `y'_st=1 if inlist(land,"10","11") & soc_grp_1==1
gen `y'_sc=0
replace `y'_sc=1 if inlist(land,"10","11") & soc_grp_1==2
gen `y'_obc=0
replace `y'_obc=1 if inlist(land,"10","11") & soc_grp_1==3
gen `y'_scst=0
replace `y'_scst=1 if inlist(land,"10","11") & inlist(soc_grp_1,1,2)
}

foreach y in large {
gen `y'=0
replace `y'=1 if inlist(land,"12")
gen `y'_1=0
replace `y'_1=1 if inlist(land,"12") & hh_type=="14"
gen `y'_2=0
replace `y'_2=1 if inlist(land,"12") & hh_type=="14" & inlist(nic_3,"011","013")
gen `y'_3=0
replace `y'_3=1 if inlist(land,"12") & hh_type!="14"
gen `y'_st=0
replace `y'_st=1 if inlist(land,"12") & soc_grp_1==1
gen `y'_sc=0
replace `y'_sc=1 if inlist(land,"12") & soc_grp_1==2
gen `y'_obc=0
replace `y'_obc=1 if inlist(land,"12") & soc_grp_1==3
gen `y'_scst=0
replace `y'_scst=1 if inlist(land,"12") & inlist(soc_grp_1,1,2)
}

global landvar "marginal small marginalsmall marginalsmall_n semimedium medium large"
foreach y in $landvar {
gen post_nrega_`y'=0
replace post_nrega_`y'=post_nrega*`y'
}
global landvar "marginal_1 small_1 marginalsmall_1 semimedium_1 medium_1 large_1"
foreach y in $landvar {
gen post_nrega_`y'=0
replace post_nrega_`y'=post_nrega*`y'
}
global landvar "marginal_2 small_2 marginalsmall_2 semimedium_2 medium_2 large_2"
foreach y in $landvar {
gen post_nrega_`y'=0
replace post_nrega_`y'=post_nrega*`y'
}
global landvar "marginal_3 small_3 marginalsmall_3 semimedium_3 medium_3 large_3"
foreach y in $landvar {
gen post_nrega_`y'=0
replace post_nrega_`y'=post_nrega*`y'
}
global landvar "marginal_st small_st marginalsmall_st semimedium_st medium_st large_st"
foreach y in $landvar {
gen post_nrega_`y'=0
replace post_nrega_`y'=post_nrega*`y'
}
global landvar "marginal_sc small_sc marginalsmall_sc semimedium_sc medium_sc large_sc"
foreach y in $landvar {
gen post_nrega_`y'=0
replace post_nrega_`y'=post_nrega*`y'
}
global landvar "marginal_obc small_obc marginalsmall_obc semimedium_obc medium_obc large_obc"
foreach y in $landvar {
gen post_nrega_`y'=0
replace post_nrega_`y'=post_nrega*`y'
}
global landvar "marginal_scst small_scst marginalsmall_scst semimedium_scst medium_scst large_scst"
foreach y in $landvar {
gen post_nrega_`y'=0
replace post_nrega_`y'=post_nrega*`y'
}
global landvar "marginal_n marginal_n_1 marginal_n_2 marginal_n_3 marginal_n_st marginal_n_sc marginal_n_obc marginal_n_scst"
foreach y in $landvar {
gen post_nrega_`y'=0
replace post_nrega_`y'=post_nrega*`y'
}

*gen landed=0
*replace landed=1 if inlist(land,"03","04","05","06","07","08","10","11","12")

global landvar "landed marginal_n small marginalsmall marginalsmall_n semimedium medium large"
foreach y in $landvar {
gen phase1_`y'=phase1*`y'
gen phase2_`y'=phase2*`y'
gen phase3_`y'=phase3*`y'
gen district1_`y'=district1*`y'
gen district2_`y'=district2*`y'
gen district3_`y'=district3*`y'
}

global landvar "landed marginal_n small marginalsmall marginalsmall_n semimedium medium large"
foreach y in $landvar {
gen post_nrega_new3_`y'=post_nrega_new3*`y'
}

*y=landed+phase1+phase2+phase3+d1+d2+d3+phase1*d1+phase2*d2+phase3*d3+post_nrega_new3

********************************************************************************
********************************************************************************
********************************************************************************
label var post_nrega "Post x NREGA"
label var landed "Landed"
label var post_nrega_new3_landed "Post x NREGA x Landed"
label var post_nrega_new3_marginal_n "Post x NREGA x Marginal"
label var post_nrega_new3_small "Post x NREGA x Small"
label var post_nrega_new3_marginalsmall_n "Post x NREGA x Marginal & Small"
label var post_nrega_new3_semimedium "Post x NREGA x Semi-medium"
label var post_nrega_new3_medium "Post x NREGA x Medium"
label var post_nrega_new3_large "Post x NREGA x Large"
label var post_nrega_new3_marginalsmall_n "Post x NREGA x Marginal & Small"
label var ln_mpce_adj "Log Monthly Per Capita Expenditure"
label var ln_basic_food "Log Basic Food"
label var ln_lux_food "Log Luxury Food"
label var ln_intox "Log Intoxicants"
label var ln_jewelry "Log Jewelry"
label var ln_durable "Log Durables"
global lnconsumvar "ln_mpce_adj ln_basic_food_adj ln_lux_food_adj ln_intox_adj ln_jewelry_adj ln_durable_adj"

*** working ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners"

*** General case ***
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_landed ///
				 i.year_1  if all_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
				 using "allst_postnreganew3_landed.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_landed) excel replace				 
				 erase "allst_postnreganew3_landed.txt"
summ $lnconsumvar if all_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0
summ $lnconsumvar if main_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0
summ $lnconsumvar if star_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0
				 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_landed ///
				 i.year_1  if main_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
				 using "majorst_postnreganew3_landed.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_landed) excel replace				 
				 erase "majorst_postnreganew3_landed.txt"				 
				 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_landed ///
				 i.year_1  if star_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
				 using "starst_postnreganew3_landed.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_landed) excel replace				 
				 erase "starst_postnreganew3_landed.txt"				 
********************************************************************************
********************************************************************************
********************************************************************************
*** General case - nic_3=="011" ***
*** General case - landless ***
gen landless=0
replace landless=1 if landed==0
gen phase1_landless=0
replace phase1_landless=phase1*landless
gen phase2_landless=0
replace phase2_landless=phase2*landless
gen phase3_landless=0
replace phase3_landless=phase3*landless
gen district1_landless=0
replace district1_landless=district1*landless
gen district2_landless=0
replace district2_landless=district2*landless
gen district3_landless=0
replace district3_landless=district3*landless
gen post_nrega_new3_landless=0
replace post_nrega_new3_landless=post_nrega_new3*landless

foreach y in $lnconsumvar {
areg `y' 		 post_nrega_new3 ///
				 i.year_1  if all_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }

foreach y in $lnconsumvar {
areg `y' 		 landless ///
				 phase1_landless ///
				 phase2_landless ///
				 phase3_landless ///
				 district1_landless ///
				 district2_landless ///
				 district3_landless ///
				 post_nrega_new3 ///
				 post_nrega_new3_landless ///
				 i.year_1  if all_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }

foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_landed ///
				 i.year_1  if all_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
				 using "allst_postnreganew3_landed_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_landed) excel replace				 
				 erase "allst_postnreganew3_landed_nic011.txt"

summ $lnconsumvar if all_state==1 & sector=="1" & landless==1 & post_nrega_new3==0
summ $lnconsumvar if all_state==1 & sector=="1" & landless==1 & post_nrega_new3==1
summ $lnconsumvar if all_state==1 & sector=="1" & landed==1 & post_nrega_new3==0 & nic_3=="011"				 
summ $lnconsumvar if all_state==1 & sector=="1" & landed==1 & post_nrega_new3==1 & nic_3=="011"

summ $lnconsumvar if all_state==1 & sector=="1" & landless==1 & post_nrega_new3==1
summ $lnconsumvar if all_state==1 & sector=="1" & marginal_n==1 & post_nrega_new3==1 & nic_3=="011"
summ $lnconsumvar if all_state==1 & sector=="1" & small==1 & post_nrega_new3==1 & nic_3=="011"
summ $lnconsumvar if all_state==1 & sector=="1" & marginalsmall_n==1 & post_nrega_new3==1 & nic_3=="011"
				 
summ $lnconsumvar if all_state==1 & sector=="1" & landless==1 & post_nrega_new3==0
summ $lnconsumvar if all_state==1 & sector=="1" & marginal_n==1 & post_nrega_new3==0 & nic_3=="011"
summ $lnconsumvar if all_state==1 & sector=="1" & small==1 & post_nrega_new3==0 & nic_3=="011"
summ $lnconsumvar if all_state==1 & sector=="1" & marginalsmall_n==1 & post_nrega_new3==0 & nic_3=="011"
				 
summ $lnconsumvar if all_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & nic_3=="011"
summ $lnconsumvar if main_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & nic_3=="011"
summ $lnconsumvar if star_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & nic_3=="011"

foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_landed ///
				 i.year_1  if main_state==1 & sector=="1" & nic_3=="011" &  ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store b1_`y'
				 }
outreg2 [b1_ln_mpce_adj b1_ln_basic_food_adj b1_ln_lux_food_adj b1_ln_intox_adj b1_ln_jewelry_adj b1_ln_durable_adj] ///
				 using "majorst_postnreganew3_landed_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_landed) excel replace				 
				 erase "majorst_postnreganew3_landed_nic011.txt"				 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_landed ///
				 i.year_1  if star_state==1 & sector=="1" & nic_3=="011" &  ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c1_`y'
				 }
outreg2 [c1_ln_mpce_adj c1_ln_basic_food_adj c1_ln_lux_food_adj c1_ln_intox_adj c1_ln_jewelry_adj c1_ln_durable_adj] ///
				 using "starst_postnreganew3_landed_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_landed) excel replace				 
				 erase "starst_postnreganew3_landed_nic011.txt"				 
********************************************************************************
********************************************************************************
********************************************************************************
*** Land category case - nic_3=="011" ***
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1  if all_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
				 using "allst_postnreganew3_landcat_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_marginalsmall_n post_nrega_new3_semimedium post_nrega_new3_medium post_nrega_new3_large) excel replace				 
				 erase "allst_postnreganew3_landcat_nic011.txt"						 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1  if main_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store b1_`y'
				 }
outreg2 [b1_ln_mpce_adj b1_ln_basic_food_adj b1_ln_lux_food_adj b1_ln_intox_adj b1_ln_jewelry_adj b1_ln_durable_adj] ///
				 using "mainst_postnreganew3_landcat_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_marginalsmall_n post_nrega_new3_semimedium post_nrega_new3_medium post_nrega_new3_large) excel replace				 
				 erase "mainst_postnreganew3_landcat_nic011.txt"						 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1  if star_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c1_`y'
				 }
outreg2 [c1_ln_mpce_adj c1_ln_basic_food_adj c1_ln_lux_food_adj c1_ln_intox_adj c1_ln_jewelry_adj c1_ln_durable_adj] ///
				 using "starst_postnreganew3_landcat_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_marginalsmall_n post_nrega_new3_semimedium post_nrega_new3_medium post_nrega_new3_large) excel replace				 
				 erase "starst_postnreganew3_landcat_nic011.txt"						 
********************************************************************************
********************************************************************************
********************************************************************************
*** Land category case 2 ***
foreach y in $lnconsumvar {
areg `y' 		 marginalsmall_n ///
				 semimedium ///
				 medium ///
				 large /// ///
				 phase1*marginalsmall_n ///
				 phase1*semimedium ///
				 phase1*medium ///
				 phase1*large ///
				 phase2*marginalsmall_n ///
				 phase2*semimedium ///
				 phase2*medium ///
				 phase2*large ///
				 phase3*marginalsmall_n ///
				 phase3*semimedium ///
				 phase3*medium ///
				 phase3*large ///
				 district1*marginalsmall_n ///
				 district1*semimedium ///
				 district1*medium ///
				 district1*large ///
				 district2*marginalsmall_n ///
				 district2*semimedium ///
				 district2*medium ///
				 district2*large ///
				 district3*marginalsmall_n ///
				 district3*semimedium ///
				 district3*medium ///
				 district3*large ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1 if star_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
********************************************************************************
********************************************************************************
********************************************************************************
*** Land category case 1 - non-dry season ***
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1  if all_state==1 & sector=="1" & nic_3=="011" & season==1 & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
				 using "allst_postnreganew3_landcat_dry.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_marginalsmall_n post_nrega_new3_semimedium post_nrega_new3_medium post_nrega_new3_large) excel replace				 
				 erase "allst_postnreganew3_landcat_dry.txt"
				 
summ $lnconsumvar if all_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & nic_3=="011" & season==2
summ $lnconsumvar if main_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & nic_3=="011" & season==2
summ $lnconsumvar if star_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & nic_3=="011" & season==2
				 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1  if main_state==1 & sector=="1" & nic_3=="011" & season==1 & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store b1_`y'
				 }
outreg2 [b1_ln_mpce_adj b1_ln_basic_food_adj b1_ln_lux_food_adj b1_ln_intox_adj b1_ln_jewelry_adj b1_ln_durable_adj] ///
				 using "mainst_postnreganew3_landcat_dry.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_marginalsmall_n post_nrega_new3_semimedium post_nrega_new3_medium post_nrega_new3_large) excel replace				 
				 erase "mainst_postnreganew3_landcat_dry.txt"					 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1  if star_state==1 & sector=="1" & nic_3=="011" & season==2 & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c1_`y'
				 }
outreg2 [c1_ln_mpce_adj c1_ln_basic_food_adj c1_ln_lux_food_adj c1_ln_intox_adj c1_ln_jewelry_adj c1_ln_durable_adj] ///
				 using "starst_postnreganew3_landcat_nondry.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_marginalsmall_n post_nrega_new3_semimedium post_nrega_new3_medium post_nrega_new3_large) excel replace				 
				 erase "starst_postnreganew3_landcat_nondry.txt"				 
********************************************************************************
********************************************************************************
********************************************************************************
*** Land category case 1 for SCs and OBCs  ***
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1  if all_state==1 & sector=="1" & inlist(soc_grp,"2","3") & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
				 using "allst_postnreganew3_landcat_scobc_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_marginalsmall_n post_nrega_new3_semimedium post_nrega_new3_medium post_nrega_new3_large) excel replace				 
				 erase "allst_postnreganew3_landcat_scobc_nic011.txt"	
				 
summ $lnconsumvar if all_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & nic_3=="011" & !inlist(soc_grp,"2","3")
summ $lnconsumvar if main_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & nic_3=="011" & !inlist(soc_grp,"2","3")
summ $lnconsumvar if star_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & nic_3=="011" & !inlist(soc_grp,"2","3")
				 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1  if main_state==1 & sector=="1" & inlist(soc_grp,"2","3") & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store b1_`y'
				 }
outreg2 [b1_ln_mpce_adj b1_ln_basic_food_adj b1_ln_lux_food_adj b1_ln_intox_adj b1_ln_jewelry_adj b1_ln_durable_adj] ///
				 using "mainst_postnreganew3_landcat_scobc_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_marginalsmall_n post_nrega_new3_semimedium post_nrega_new3_medium post_nrega_new3_large) excel replace				 
				 erase "mainst_postnreganew3_landcat_scobc_nic011.txt"					 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_marginalsmall_n ///
				 post_nrega_new3_semimedium ///
				 post_nrega_new3_medium ///
				 post_nrega_new3_large ///
				 i.year_1  if star_state==1 & sector=="1" & inlist(soc_grp,"2","3") & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c1_`y'
				 }
outreg2 [c1_ln_mpce_adj c1_ln_basic_food_adj c1_ln_lux_food_adj c1_ln_intox_adj c1_ln_jewelry_adj c1_ln_durable_adj] ///
				 using "starst_postnreganew3_landcat_scobc_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_marginalsmall_n post_nrega_new3_semimedium post_nrega_new3_medium post_nrega_new3_large) excel replace				 
				 erase "starst_postnreganew3_landcat_scobc_nic011.txt"					 
********************************************************************************
********************************************************************************
********************************************************************************
*** Land category case 1 for non-agricluture - 452(construction), 522-523(retail trade) ***
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_landed ///
				 i.year_1  if all_state==1 & sector=="1" & inlist(nic_3,"522","523") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
				 using "allst_postnreganew3_landed_nic522523.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_landed) excel replace				 
				 erase "allst_postnreganew3_landed_nic522523.txt"
				 
summ $lnconsumvar if all_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & inlist(nic_3,"522","523")  
summ $lnconsumvar if main_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & inlist(nic_3,"522","523")
summ $lnconsumvar if star_state==1 & sector=="1" & landed==0 & post_nrega_new3_landed==0 & inlist(nic_3,"522","523")
				 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_landed ///
				 i.year_1  if main_state==1 & sector=="1" & inlist(nic_3,"522","523") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store b1_`y'
				 }
outreg2 [b1_ln_mpce_adj b1_ln_basic_food_adj b1_ln_lux_food_adj b1_ln_intox_adj b1_ln_jewelry_adj b1_ln_durable_adj] ///
				 using "mainst_postnreganew3_landed_nic522523.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_landed) excel replace				 
				 erase "mainst_postnreganew3_landed_nic522523.txt"					 
foreach y in $lnconsumvar {
areg `y' 		 landed ///
				 phase1*landed ///
				 phase2*landed ///
				 phase3*landed ///
				 district1*landed ///
				 district2*landed ///
				 district3*landed ///
				 post_nrega_new3 ///
				 post_nrega_new3_landed ///
				 i.year_1  if star_state==1 & sector=="1" & inlist(nic_3,"522","523") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c1_`y'
				 }
outreg2 [c1_ln_mpce_adj c1_ln_basic_food_adj c1_ln_lux_food_adj c1_ln_intox_adj c1_ln_jewelry_adj c1_ln_durable_adj] ///
				 using "starst_postnreganew3_landed_nic522523.xls", ///
				 addtext(Year FE,Yes,District FE,Yes) label nocons dec(3) keep(post_nrega_new3_landed) excel replace				 
				 erase "starst_postnreganew3_landed_nic522523.txt"					 
********************************************************************************
********************************************************************************
********************************************************************************





gen post_nrega_landed=0
replace post_nrega_landed=post_nrega*landed

gen land_cont=0
replace land_cont=0.005 if land=="01"
replace land_cont=0.0075 if land=="02"
replace land_cont=0.11 if land=="03"
replace land_cont=0.305 if land=="04"
replace land_cont=0.705 if land=="05"
replace land_cont=1.505 if land=="06"
replace land_cont=2.505 if land=="07"
replace land_cont=3.505 if land=="08"
replace land_cont=5.005 if land=="10"
replace land_cont=7.005 if land=="11"
replace land_cont=8 if land=="12"
gen post_nrega_land_cont=0
replace post_nrega_land_cont=post_nrega*land_cont
********************************************************************************
********************************************************************************
********************************************************************************
label var post_nrega "Post NREGA"
label var landed "Landed"
label var post_nrega_landed "Post NREGA x Landed"
label var post_nrega_marginal_n "Post NREGA x Marginal"
label var post_nrega_small "Post NREGA x Small"
label var post_nrega_semimedium "Post NREGA x Semimedium"
label var post_nrega_medium "Post NREGA x Medium"
label var post_nrega_large "Post NREGA x Large"
label var post_nrega_marginalsmall_n "Post NREGA x Marginal & Small"
label var ln_mpce_adj "Log Monthly Per Capita Expenditure"
label var ln_basic_food "Log Basic Food"
label var ln_lux_food "Log Luxury Food"
label var ln_intox "Log Intoxicants"
label var ln_jewelry "Log Jewelry"
label var ln_durable "Log Durables"
global lnconsumvar "ln_mpce_adj ln_basic_food_adj ln_lux_food_adj ln_intox_adj ln_jewelry_adj ln_durable_adj"

*** working ***
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\NREGA and landowners"

*** Summary statistics ***

summ $lnconsumvar if sector=="1" & round=="61"
summ $lnconsumvar if sector=="1" & round=="62"
summ $lnconsumvar if sector=="1" & round=="63"
summ $lnconsumvar if sector=="1" & round=="64"

summ $lnconsumvar if round=="61" & sector=="1" & landed==1 & nic_3=="011"
summ $lnconsumvar if round=="62" & sector=="1" & landed==1 & nic_3=="011"
summ $lnconsumvar if round=="63" & sector=="1" & landed==1 & nic_3=="011"
summ $lnconsumvar if round=="64" & sector=="1" & landed==1 & nic_3=="011"

summ $lnconsumvar if round=="61" & sector=="1" & marginal_n==1
summ $lnconsumvar if round=="62" & sector=="1" & marginal_n==1
summ $lnconsumvar if round=="63" & sector=="1" & marginal_n==1
summ $lnconsumvar if round=="64" & sector=="1" & marginal_n==1
********************************************************************************
count if landed==1 & inlist(round,"61","62","63","64")
count if landed==1 & sector=="1" & inlist(round,"61","62","63","64")
count if marginal_n==1 & landed==1 & sector=="1" & inlist(round,"61","62","63","64")
count if small==1 & landed==1 & sector=="1" & inlist(round,"61","62","63","64")
count if semimedium==1 & landed==1 & sector=="1" & inlist(round,"61","62","63","64")
count if medium==1 & landed==1 & sector=="1" & inlist(round,"61","62","63","64")
count if large==1 & landed==1 & sector=="1" & inlist(round,"61","62","63","64")



foreach y in $lnconsumvar {
areg `y' 		 post_nrega ///
				 landed ///
				 post_nrega_landed ///
				 i.year_1  if all_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
		using "allst_postnrega_landed_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes) drop(i.year_1) label nocons dec(3) excel replace
		erase "allst_postnrega_landed_allconsum.txt"				 
foreach y in $lnconsumvar {
areg `y'         post_nrega ///
				 landed ///
				 post_nrega_landed ///
				 i.year_1  if main_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a2_`y'
				 }
outreg2 [a2_ln_mpce_adj a2_ln_basic_food_adj a2_ln_lux_food_adj a2_ln_intox_adj a2_ln_jewelry_adj a2_ln_durable_adj] ///
		using "mainst_postnrega_landed_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes) drop(i.year_1) label nocons dec(3) excel replace
		erase "mainst_postnrega_landed_allconsum.txt"					 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 landed ///
				 post_nrega_landed ///
				 i.year_1  if star_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a3_`y'
				 }
outreg2 [a3_ln_mpce_adj a3_ln_basic_food_adj a3_ln_lux_food_adj a3_ln_intox_adj a3_ln_jewelry_adj a3_ln_durable_adj] ///
		using "starst_postnrega_landed_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes) drop(i.year_1) label nocons dec(3) excel replace
		erase "starst_postnrega_landed_allconsum.txt"
********************************************************************************
*** working ***
foreach y in $lnconsumvar {
areg `y'         post_nrega ///
				 landed ///
				 post_nrega_landed ///
				 i.year_1  if all_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store b1_`y'
				 }
outreg2 [b1_ln_mpce_adj b1_ln_basic_food_adj b1_ln_lux_food_adj b1_ln_intox_adj b1_ln_jewelry_adj b1_ln_durable_adj] ///
		using "allst_postnrega_landed_nic011_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes) drop(i.year_1) label nocons dec(3) excel replace
		erase "allst_postnrega_landed_nic011_allconsum.txt"				 
foreach y in $lnconsumvar {
areg `y'         post_nrega ///
				 landed ///
				 post_nrega_landed ///
				 i.year_1  if main_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store b2_`y'
				 }
outreg2 [b2_ln_mpce_adj b2_ln_basic_food_adj b2_ln_lux_food_adj b2_ln_intox_adj b2_ln_jewelry_adj b2_ln_durable_adj] ///
		using "mainst_postnrega_landed_nic011_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes) drop(i.year_1) label nocons dec(3) excel replace
		erase "mainst_postnrega_landed_nic011_allconsum.txt"				 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 landed ///
				 post_nrega_landed ///
				 i.year_1  if star_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store b3_`y'
				 }
outreg2 [b3_ln_mpce_adj b3_ln_basic_food_adj b3_ln_lux_food_adj b3_ln_intox_adj b3_ln_jewelry_adj b3_ln_durable_adj] ///
		using "starst_postnrega_landed_nic011_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes) drop(i.year_1) label nocons dec(3) excel replace
		erase "starst_postnrega_landed_nic011_allconsum.txt"				 
********************************************************************************
*** working ***
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if all_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c1_`y'
				 }
outreg2 [c1_ln_mpce_adj c1_ln_basic_food_adj c1_ln_lux_food_adj c1_ln_intox_adj c1_ln_jewelry_adj c1_ln_durable_adj] ///
				 using "allst_postnrega_landcat1_allconsum.xls", ///
				 addtext(Year FE,Yes,District FE,Yes,Land categories,Yes) keep(post_nrega post_nrega_marginal_n post_nrega_small post_nrega_semimedium post_nrega_medium post_nrega_large) label nocons dec(3) excel replace				 
				 erase "allst_postnrega_landcat1_allconsum.txt"
				 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if main_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c2_`y'
				 }
outreg2 [c2_ln_mpce_adj c2_ln_basic_food_adj c2_ln_lux_food_adj c2_ln_intox_adj c2_ln_jewelry_adj c2_ln_durable_adj] ///
				 using "mainst_postnrega_landcat1_allconsum.xls", ///
				 addtext(Year FE,Yes,District FE,Yes,Land categories,Yes) keep(post_nrega post_nrega_marginal_n post_nrega_small post_nrega_semimedium post_nrega_medium post_nrega_large) label nocons dec(3) excel replace				 
				 erase "mainst_postnrega_landcat1_allconsum.txt"
				 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if star_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store c3_`y'
				 }
outreg2 [c3_ln_mpce_adj c3_ln_basic_food_adj c3_ln_lux_food_adj c3_ln_intox_adj c3_ln_jewelry_adj c3_ln_durable_adj] ///
				 using "starst_postnrega_landcat1_allconsum.xls", ///
				 addtext(Year FE,Yes,District FE,Yes,Land categories,Yes) keep(post_nrega post_nrega_marginal_n post_nrega_small post_nrega_semimedium post_nrega_medium post_nrega_large) label nocons dec(3) excel replace				 
				 erase "starst_postnrega_landcat1_allconsum.txt"
********************************************************************************
*** working ***
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if all_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store t1_`y'
				 }
outreg2 [t1_ln_mpce_adj t1_ln_basic_food_adj t1_ln_lux_food_adj t1_ln_intox_adj t1_ln_jewelry_adj t1_ln_durable_adj] ///
				 using "allst_postnrega_landcat1_nic011_allconsum.xls", ///
				 addtext(Year FE,Yes,District FE,Yes,Land categories,Yes) keep(post_nrega post_nrega_marginal_n post_nrega_small post_nrega_semimedium post_nrega_medium post_nrega_large) label nocons dec(3) excel replace				 
				 erase "allst_postnrega_landcat1_nic011_allconsum.txt"
				 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if main_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store t2_`y'
				 }
outreg2 [t2_ln_mpce_adj t2_ln_basic_food_adj t2_ln_lux_food_adj t2_ln_intox_adj t2_ln_jewelry_adj t2_ln_durable_adj] ///
				 using "mainst_postnrega_landcat1_nic011_allconsum.xls", ///
				 addtext(Year FE,Yes,District FE,Yes,Land categories,Yes) keep(post_nrega post_nrega_marginal_n post_nrega_small post_nrega_semimedium post_nrega_medium post_nrega_large) label nocons dec(3) excel replace				 
				 erase "mainst_postnrega_landcat1_nic011_allconsum.txt"
				 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if star_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store t3_`y'
				 }
outreg2 [t3_ln_mpce_adj t3_ln_basic_food_adj t3_ln_lux_food_adj t3_ln_intox_adj t3_ln_jewelry_adj t3_ln_durable_adj] ///
				 using "starst_postnrega_landcat1_nic011_allconsum.xls", ///
				 addtext(Year FE,Yes,District FE,Yes,Land categories,Yes) keep(post_nrega post_nrega_marginal_n post_nrega_small post_nrega_semimedium post_nrega_medium post_nrega_large) label nocons dec(3) excel replace				 
				 erase "starst_postnrega_landcat1_nic011_allconsum.txt"
********************************************************************************
*** working ***
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if all_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store d1_`y'
				 }
outreg2 [d1_ln_mpce_adj d1_ln_basic_food_adj d1_ln_lux_food_adj d1_ln_intox_adj d1_ln_jewelry_adj d1_ln_durable_adj] ///
		using "allst_postnrega_landcat2_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "allst_postnrega_landcat2_allconsum.txt"				 				 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if main_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store d2_`y'
				 }
outreg2 [d2_ln_mpce_adj d2_ln_basic_food_adj d2_ln_lux_food_adj d2_ln_intox_adj d2_ln_jewelry_adj d2_ln_durable_adj] ///
		using "mainst_postnrega_landcat2_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "mainst_postnrega_landcat2_allconsum.txt"				 				 		 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if star_state==1 & sector=="1" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store d3_`y'
				 }
outreg2 [d3_ln_mpce_adj d3_ln_basic_food_adj d3_ln_lux_food_adj d3_ln_intox_adj d3_ln_jewelry_adj d3_ln_durable_adj] ///
		using "starst_postnrega_landcat2_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "starst_postnrega_landcat2_allconsum.txt"				 				 
********************************************************************************				 
*** working ***
foreach y in $lnconsumvar {
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if all_state==1 & sector=="1" & hh_type=="14" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 }
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if main_state==1 & sector=="1" & hh_type=="14" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 }
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if star_state==1 & sector=="1" & hh_type=="14" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 }				 
********************************************************************************
*** working for all except for star states ***
foreach y in $lnconsumvar {
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if all_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store e1
				 }
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if main_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store e2
				 }
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if star_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store e3
				 }
outreg2 [e1 e2 e3] using "postnrega_landcat1_nic011.xls", ///
				 addtext(Year FE,Yes,District FE,Yes,Land categories,Yes) keep(post_nrega post_nrega_marginal_n post_nrega_small post_nrega_semimedium post_nrega_medium post_nrega_large) label nocons dec(3) excel replace				 
				 erase "postnrega_landcat1_nic011.txt"
********************************************************************************
*** working ***
foreach y in $lnconsumvar {
areg `y'         post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if all_state==1 & sector=="1" & inlist(nic_3,"011") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store f1_`y'
				 }
outreg2 [f1_ln_mpce_adj f1_ln_basic_food_adj f1_ln_lux_food_adj f1_ln_intox_adj f1_ln_jewelry_adj f1_ln_durable_adj] ///
		using "allst_postnrega_landcat2_nic011_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "allst_postnrega_landcat2_nic011_allconsum.txt"				 				 				 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if main_state==1 & sector=="1" & inlist(nic_3,"011") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store f2_`y'
				 }
outreg2 [f2_ln_mpce_adj f2_ln_basic_food_adj f2_ln_lux_food_adj f2_ln_intox_adj f2_ln_jewelry_adj f2_ln_durable_adj] ///
		using "mainst_postnrega_landcat2_nic011_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "mainst_postnrega_landcat2_nic011_allconsum.txt"				 				 				 
foreach y in $lnconsumvar {				 
areg `y'         post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if star_state==1 & sector=="1" & inlist(nic_3,"011") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store f3_`y'
				 }
outreg2 [f3_ln_mpce_adj f3_ln_basic_food_adj f3_ln_lux_food_adj f3_ln_intox_adj f3_ln_jewelry_adj f3_ln_durable_adj] ///
		using "starst_postnrega_landcat2_nic011_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "starst_postnrega_landcat2_nic011_allconsum.txt"				 				 
********************************************************************************
*** not working for soc_grp==1 ***
*** partially working for soc_grp==2 ***
*** working for soc_grp==3 ***
areg ln_mpce_adj post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if main_state==1 & sector=="1" & soc_grp=="3" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)				 				
areg ln_mpce_adj post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if main_state==1 & sector=="1" & soc_grp=="3" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
********************************************************************************
*** partially working for soc_grp==1 ***
*** not working for soc_grp==2 ***
*** partially working for soc_grp==3 ***
areg ln_mpce_adj post_nrega ///
				 marginal_n small semimedium medium large ///
				 post_nrega_marginal_n ///
				 post_nrega_small ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if all_state==1 & sector=="1" & hh_type=="14" & soc_grp=="2" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)				 				
areg ln_mpce_adj post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if all_state==1 & sector=="1" & hh_type=="14" & soc_grp=="2" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
********************************************************************************
*** working first regression for soc_grp==1 ***
*** working for soc_grp==2 ***
*** partially working for soc_grp==3 ***
foreach y in $lnconsumvar {
areg `y' post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if all_state==1 & sector=="1" & nic_3=="011" & inlist(soc_grp,"3") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store j1_`y'
				 }
outreg2 [j1_ln_mpce_adj j1_ln_basic_food_adj j1_ln_lux_food_adj j1_ln_intox_adj j1_ln_jewelry_adj j1_ln_durable_adj] ///
		using "allst_postnrega_landcat2_nic011_obc_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "allst_postnrega_landcat2_nic011_obc_allconsum.txt"				 				 
				 
foreach y in $lnconsumvar {
areg `y' post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if main_state==1 & sector=="1" & nic_3=="011" & inlist(soc_grp,"3") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store j2_`y'
				 }
outreg2 [j2_ln_mpce_adj j2_ln_basic_food_adj j2_ln_lux_food_adj j2_ln_intox_adj j2_ln_jewelry_adj j2_ln_durable_adj] ///
		using "mainst_postnrega_landcat2_nic011_obc_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "mainst_postnrega_landcat2_nic011_obc_allconsum.txt"				 				 

foreach y in $lnconsumvar {
areg `y' post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1 if star_state==1 & sector=="1" & nic_3=="011" & inlist(soc_grp,"3") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store j3_`y'
				 }
outreg2 [j3_ln_mpce_adj j3_ln_basic_food_adj j3_ln_lux_food_adj j3_ln_intox_adj j3_ln_jewelry_adj j3_ln_durable_adj] ///
		using "starst_postnrega_landcat2_nic011_obc_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "starst_postnrega_landcat2_nic011_obc_allconsum.txt"				 				 
********************************************************************************
*** not working for season==1 ***
*** working for season==2 ***
foreach y in $lnconsumvar {	
areg `y' 		 post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if all_state==1 & sector=="1" &  season==2 & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store h1_`y'
				 }
outreg2 [h1_ln_mpce_adj h1_ln_basic_food_adj h1_ln_lux_food_adj h1_ln_intox_adj h1_ln_jewelry_adj h1_ln_durable_adj] ///
		using "allst_postnrega_landcat2_season2_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "allst_postnrega_landcat2_season2_allconsum.txt"				 				 
				 
foreach y in $lnconsumvar {	
areg `y' 		 post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if main_state==1 & sector=="1" &  season==2 & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store h2_`y'
				 }
outreg2 [h2_ln_mpce_adj h2_ln_basic_food_adj h2_ln_lux_food_adj h2_ln_intox_adj h2_ln_jewelry_adj h2_ln_durable_adj] ///
		using "mainst_postnrega_landcat2_season2_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "mainst_postnrega_landcat2_season2_allconsum.txt"				 				 
				 
foreach y in $lnconsumvar {	
areg `y'		 post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if star_state==1 & sector=="1" &  season==2 & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store h3_`y'				 
				 }
outreg2 [h3_ln_mpce_adj h3_ln_basic_food_adj h3_ln_lux_food_adj h3_ln_intox_adj h3_ln_jewelry_adj h3_ln_durable_adj] ///
		using "starst_postnrega_landcat2_season2_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "starst_postnrega_landcat2_season2_allconsum.txt"				 				 
********************************************************************************
***Regressions for nic_3==452,602,522,801 ***
foreach y in $lnconsumvar {	
areg `y' 		 post_nrega ///
				 marginalsmall_n semimedium medium large ///
				 post_nrega_marginalsmall_n ///
				 post_nrega_semimedium ///
				 post_nrega_medium ///
				 post_nrega_large ///
				 i.year_1  if all_state==1 & sector=="1" & nic_3=="452" & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store h1_`y'
				 }
outreg2 [h1_ln_mpce_adj h1_ln_basic_food_adj h1_ln_lux_food_adj h1_ln_intox_adj h1_ln_jewelry_adj h1_ln_durable_adj] ///
		using "allst_postnrega_landcat2_nic452_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes, Land Category Dummy,Yes) drop(i.year_1 marginalsmall_n semimedium medium large) label nocons dec(3) excel replace
		erase "allst_postnrega_landcat2_nic452_allconsum.txt"				 				 

foreach y in $lnconsumvar {
areg `y' 		 post_nrega ///
				 landed ///
				 post_nrega_landed ///
				 i.year_1  if all_state==1 & sector=="1" & inlist(nic_3,"522","523") & ///
				 inlist(round,"61","62","63","64") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }
outreg2 [a1_ln_mpce_adj a1_ln_basic_food_adj a1_ln_lux_food_adj a1_ln_intox_adj a1_ln_jewelry_adj a1_ln_durable_adj] ///
		using "allst_postnrega_landed_nic522523_allconsum.xls", ///
		addtext(Year FE, Yes, District FE, Yes) drop(i.year_1) label nocons dec(3) excel replace
		erase "allst_postnrega_landed_nic522523_allconsum.txt"				 

********************************************************************************
*** Continuous land measure ***		
foreach y in $lnconsumvar {
areg `y' 		 post_nrega ///
				 land_cont ///
				 post_nrega_land_cont ///
				 i.year_1  if all_state==1 & sector=="1" & nic_3=="011" & ///
				 inlist(round,"61","62","63","64") & !inlist(land,"01","02") ///
				 [pweight=mlt],absorb(state_district) cluster(state_district)
				 est store a1_`y'
				 }		
********************************************************************************
********************************************************************************
********************************************************************************
*** ICRISAT Rainfall data ***
clear
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and employment preference\Yield and Rainfall data"
import delimited "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and employment preference\Yield and Rainfall data\ICRISAT-District Level Data - Rainfall.csv", clear

tab year		
order statename distname year		
sort statename distname year		

ren januaryrainfallmillimeters  janrainmm
ren februaryrainfallmillimeters febrainmm
ren marchrainfallmillimeters marrainmm
ren aprilrainfallmillimeters aprrainmm
ren mayrainfallmillimeters mayrainmm
ren junerainfallmillimeters junrainmm
ren julyrainfallmillimeters julrainmm
ren augustrainfallmillimeters augrainmm
ren septemberrainfallmillimeters seprainmm
ren octoberrainfallmillimeters octrainmm
ren novemberrainfallmillimeters novrainmm
ren decemberrainfallmillimeters decrainmm
ren annualrainfallmillimeters annualrainmm
egen sample=rowtotal(janrainmm-decrainmm)
drop sample
*** from above 'sample' variable total, we can infer that annualrainmm is sum of all month's rainfall ***
*** Generate mean from 2000-2007 and compare it with the rainfall of 2008 year ***
tab year
drop if year==2009
sort statename distname year
by statename distname:egen meanrainmm20002007=mean(annualrainmm) if year<2008
tab year if meanrainmm20002007==.
*replace meanrainmm20002007=annualrainmm if meanrainmm20002007==.
gen rainmm2008_1=annualrainmm if meanrainmm20002007==.
by statename distname:egen rainmm2008=mean(rainmm2008)
drop rainmm2008_1

gen raindep=rainmm2008-meanrainmm20002007
count if raindep==.
tab year if raindep==.
drop if raindep==.
xtile tercile=raindep,nq(3)
drop year-rainmm2008
duplicates drop

sort raindep
export excel using "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and employment preference\Yield and Rainfall data\ICRISAT-District Level Data - Rainfall - output.xls",firstrow(variables) replace
********************************************************************************
*** ICRISAT Yield data ***
clear
cd "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and employment preference\Yield and Rainfall data"
import delimited "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and employment preference\Yield and Rainfall data\ICRISAT-District Level Data - Yield.csv", clear

tab year		
order statename distname year		
sort statename distname year		

drop if year==2009

egen allyield=rowtotal(riceyieldkgperha-cottonyieldkgperha)
by statename distname: egen meanallyield20002007=mean(allyield) if year!=2008
by statename distname: gen allyield2008_1=allyield if year==2008
by statename distname: egen allyield2008=mean(allyield2008_1)
drop allyield2008_1
gen yielddep=allyield2008-meanallyield20002007
drop if meanallyield20002007==.

xtile tercile=yielddep,nq(3)

summ yielddep
summ yielddep if tercile==1
summ yielddep if tercile==2
summ yielddep if tercile==3

drop year-allyield2008
duplicates drop

sort yielddep
export excel using "C:\Users\venka\Box\Personal\Tufts PhD\Research work\Debt waiver and employment preference\Yield and Rainfall data\ICRISAT-District Level Data - Yield - output.xls",firstrow(variables) replace












