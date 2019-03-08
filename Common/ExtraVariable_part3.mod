As_DivFromTrend=0;
BEAgy1 = BEAgcy1 + BEAgiy1;
MILLgy3 = MILLgcy3 + MILLgiy3;

@#for n in 1:SN
GrGDPpc@{n} = log(( GDP@{n}_ / GDPqlag@{n}_ * GDPplag@{n}_ / GDPplagqlag@{n}_ ) ^ ( 1 / 2 ) / GN_)*100;
rGDPpc@{n}_DivFromTrend=0;
rPCEpc@{n}_DivFromTrend=0;
rPDIpc@{n}_DivFromTrend=0;
IHPpc@{n}_DivFromTrend=0;
Xpc@{n}_DivFromTrend=0;
rGCEpc@{n}_DivFromTrend=0;
rGGIpc@{n}_DivFromTrend=0;
rGSpendingpc@{n}_DivFromTrend=0;
NXY@{n}=(Export@{n}_-Import@{n}_) / GDP@{n}_ * 100;
PRDY@{n} = ( YWC@{n}_ * PWC_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_ / GDP@{n}_ ) * 100;
GRDY@{n} = ( PHG@{n}_ * IHG@{n}_ / GDP@{n}_ ) * 100;
@#endfor

GovDifY1 = ( BEAgy1 - JSTtauy1 ) * 100;
GovDifY2 = ( JSTgy2 - JSTtauy2 ) * 100;
GovDifY3 = ( MILLgy3 - MILLtauy3 ) * 100;
GovDifY4 = ( JSTgy4 - JSTtauy4 ) * 100;
GovDifY5 = ( JSTgy5 - JSTtauy5 ) * 100;
GovDifY6 = ( JSTgy6 - JSTtauy6 ) * 100;
