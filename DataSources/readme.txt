data_preparing.xlsx: collect data from original source and do all the calculations
data_ready.xlsx: copy clearned data from data_preparing
data_ready_1-6.mat: is simply the .mat version of the "1-6" sheet in data_ready.xlsx
data_ready_global: is simply the .mat version of the "global" sheet in data_ready.xlsx

load data_ready_global, and use addw.m to produce aggregate across countries, 
which produce data_2country_Wdata.mat etc.

load data_2/4/6country_Wdata.mat and data_ready_1-6.mat, save the union of them as 
data_2/4/6country.mat, which are the final data used in dynare