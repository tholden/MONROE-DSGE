@#for n in 1:SN
GrGDPpc@{n} = log(( GDP@{n}_ / GDPqlag@{n}_ * GDPplag@{n}_ / GDPplagqlag@{n}_ ) ^ ( 1 / 2 ) / GN_)*100;
rGDPpc@{n}_DivFromTrend=0;
rPCEpc@{n}_DivFromTrend=0;
rPDIpc@{n}_DivFromTrend=0;
Xpc@{n}_DivFromTrend=0;
rGCEpc@{n}_DivFromTrend=0;
rGGIpc@{n}_DivFromTrend=0;
rGSpendingpc@{n}_DivFromTrend=0;
GovDifY@{n}=(GCE@{n}_+GGI@{n}_-GovRev@{n}_) / GDP@{n}_ * 100;
NXY@{n}=(Export@{n}_-Import@{n}_) / GDP@{n}_ * 100;
PRDY@{n} = log( YWC@{n}_ * PWC_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_ / GDP@{n}_ ) * 100;
GRDY@{n} = log( PHG@{n}_ * IHG@{n}_ / GDP@{n}_ ) * 100;
@#endfor
