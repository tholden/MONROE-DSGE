use "C:\Users\dystg\OneDrive\my\research\matlab\ProjectSurrey\data\pwt90_capital_detail.dta" 
drop Ic_Struc-Kp_Other
keep if countrycode=="BEL"|countrycode=="DNK"|countrycode=="FIN"|countrycode=="ITA"|countrycode=="NLD"|countrycode=="PRT"|countrycode=="ESP"|countrycode=="SWE"|countrycode=="AUS"|countrycode=="CAN"|countrycode=="JPN"|countrycode=="NOR"|countrycode=="CHE"
gen Dc=Dc_Struc+Dc_Mach+Dc_TraEq+Dc_Other
keep countrycode Dc year
reshape wide Dc, i(year) j(countrycode) string
//it is in million local currency (euro if in euro zone)
