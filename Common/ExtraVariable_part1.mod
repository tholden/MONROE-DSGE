//real per capita term, deviation from steady state or trend, net rate 1=1%
var
As_DivFromTrend

@#for n in 1:SN
GrGDPpc@{n}

//it's deviations from its deterministic trend, so it capture the dynamics of trend
rGDPpc@{n}_DivFromTrend
rPCEpc@{n}_DivFromTrend
rPDIpc@{n}_DivFromTrend
IHPpc@{n}_DivFromTrend
Xpc@{n}_DivFromTrend
rGCEpc@{n}_DivFromTrend
rGGIpc@{n}_DivFromTrend
rGSpendingpc@{n}_DivFromTrend
//shares
GovDifY@{n}
NXY@{n}
PRDY@{n}
GRDY@{n}
@#endfor
;

var BEAgy1 MILLgy3;
