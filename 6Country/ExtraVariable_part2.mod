As_DivFromTrend=As_DivFromTrend(-1)+log_GAs*100-steady_state(log_GAs)*100;
@#for n in 1:SN
GrGDPpc@{n}  = log(( GDP@{n} / GDPqlag@{n} * GDPplag@{n} / GDPplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100;
#GrPCEpc@{n} = log(( PCE@{n} / PCEqlag@{n} * PCEplag@{n} / PCEplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100;
#GrPDIpc@{n} = log(( PDI@{n} / PDIqlag@{n} * PDIplag@{n} / PDIplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100;
#GrIHPpc@{n} = log(IHP@{n} / IHP@{n}_LAG / (N@{n} / N@{n}_LAG))*100;
#GrXpc@{n}   = log(X@{n} / X@{n}_LAG / (N@{n} / N@{n}_LAG))*100;
#GrGCEpc@{n} = log(( GCE@{n} / GCEqlag@{n} * GCEplag@{n} / GCEplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100;
#GrGGIpc@{n} = log(( GGI@{n} / GGIqlag@{n} * GGIplag@{n} / GGIplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100;
#GrSpendingpc@{n} = log(( (GCE@{n}+GGI@{n}) / (GCEqlag@{n}+GGIqlag@{n}) * (GCEplag@{n}+GGIplag@{n}) / (GCEplagqlag@{n}+GGIplagqlag@{n}) ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100;

#steady_state_GrGDPpc@{n} = steady_state(log(( GDP@{n} / GDPqlag@{n} * GDPplag@{n} / GDPplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100);
#steady_state_GrPCEpc@{n} = steady_state(log(( PCE@{n} / PCEqlag@{n} * PCEplag@{n} / PCEplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100);
#steady_state_GrPDIpc@{n} = steady_state(log(( PDI@{n} / PDIqlag@{n} * PDIplag@{n} / PDIplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100);
#steady_state_GrIHPpc@{n} = steady_state(log(IHP@{n} / IHP@{n}_LAG / (N@{n} / N@{n}_LAG))*100);
#steady_state_GrXpc@{n}   = steady_state(log(X@{n} / X@{n}_LAG / (N@{n} / N@{n}_LAG))*100);
#steady_state_GrGCEpc@{n} = steady_state(log(( GCE@{n} / GCEqlag@{n} * GCEplag@{n} / GCEplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100);
#steady_state_GrGGIpc@{n} = steady_state(log(( GGI@{n} / GGIqlag@{n} * GGIplag@{n} / GGIplagqlag@{n} ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100);
#steady_state_GrSpendingpc@{n} = steady_state(log(( (GCE@{n}+GGI@{n}) / (GCEqlag@{n}+GGIqlag@{n}) * (GCEplag@{n}+GGIplag@{n}) / (GCEplagqlag@{n}+GGIplagqlag@{n}) ) ^ ( 1 / 2 ) / (N@{n} / N@{n}_LAG))*100);

//it's deviations from its deterministic trend, so it capture the dynamics of trend
rGDPpc@{n}_DivFromTrend=rGDPpc@{n}_DivFromTrend(-1)+GrGDPpc@{n}-steady_state_GrGDPpc@{n};
rPCEpc@{n}_DivFromTrend=rPCEpc@{n}_DivFromTrend(-1)+GrPCEpc@{n}-steady_state_GrPCEpc@{n};
rPDIpc@{n}_DivFromTrend=rPDIpc@{n}_DivFromTrend(-1)+GrPDIpc@{n}-steady_state_GrPDIpc@{n};
IHPpc@{n}_DivFromTrend=IHPpc@{n}_DivFromTrend(-1)+GrIHPpc@{n}-steady_state_GrIHPpc@{n};
Xpc@{n}_DivFromTrend=Xpc@{n}_DivFromTrend(-1)+GrXpc@{n}-steady_state_GrXpc@{n};
rGCEpc@{n}_DivFromTrend=rGCEpc@{n}_DivFromTrend(-1)+GrGCEpc@{n}-steady_state_GrGCEpc@{n};
rGGIpc@{n}_DivFromTrend=rGGIpc@{n}_DivFromTrend(-1)+GrGGIpc@{n}-steady_state_GrGGIpc@{n};
rGSpendingpc@{n}_DivFromTrend=rGSpendingpc@{n}_DivFromTrend(-1)+GrSpendingpc@{n}-steady_state_GrSpendingpc@{n};
GovDifY@{n} = (GCE@{n}+GGI@{n}-GovRev@{n}) / GDP@{n} * 100;
NXY@{n}=(Export@{n}-Import@{n}) / GDP@{n} * 100;
PRDY@{n} = log( YWC@{n} * PWC * ( scriptFI * II * ( scripts - ( 1 - scriptq ) * ( 1 - deltaI ) * scripts_LAG / GII ) + II * scripts * ScriptFRP * JP ) / YWC / GDP@{n} ) * 100;
GRDY@{n} = log( PHG@{n} * IHG@{n} / GDP@{n} ) * 100;
@#endfor
