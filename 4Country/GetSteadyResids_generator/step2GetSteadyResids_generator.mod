@#define SN = 4

%We use dynare pre-processor to process this file further
%the resulting file, after changing file name to "step2GetSteadyResids", will be further processed by step3GetSteadyResids_generator.m
%in our old version, we set a variable to nan if they turns to be complex or negative (which may give complex number later). Doing this may introduce 2 problems
%1. we may get nan at the initial point then the solver stops
%2. we throw all information the algorithm needs to search on a correct direction.
%so we decide to make our problem non square by making real part and complex part of residuals =0. so double output than input.
%Fsolve with Levenberg-Marquardt can handle that, which are based on the nonlinear least-squares algorithms also used in lsqnonlin.
%when generating mex, allow InVec to be complex. another way is replace log, pow, etc. with log(complex(.
function [Resids, JP_, ...
		WD1_, WW1_, WT1_ ,WNT1_ ,WSW1_ ,WST1_ ,WSNT1_, ...
		SOC] = step3GetSteadyResids( InVec, lambda, eta, phiR, zetaR, gamma, scriptp, scriptq, ...
alphaCP, alphaCD, alphah, alphaKP, alphaD, alphaND, alphaHP, alphaHW, alphaHL, alphaK, alphaKL, alphaHLX, alphaY, betabarl, ...
sigma, xi, bbeta, ...
h, varrhoC, eC, varrhoCP, eCP, varrhoCD, ...
nuW, nuT, nuNT, nuSW, nuST, nuSNT, nuD, nuNDCG, nuK, nuH, nuh, ...
rhoQB, ...
thetaKU0, thetaKU1, thetaDU0, thetaDU1, ...
alphaNC, eT, eW, FWCtilde, FKtilde, ...
o, eKLT, eKLNT, eKLW, varrhoKL, eHLXT, eHLXNT, eHLXW, varrhoHLX, eYT, eYNT, eYW, varrhoY, ...
tauKG_, tauHG_, tauCG_, taub_, tauD_, tauND_, tauNT_, tauTC_, iotaTX_, iotaTM_, iotaWX_, iotaWM_, tauLa_, tauLb_, tauHW_, tauHT_, tauHNT_, tauKW_, tauKT_, tauKNT_, tauscriptXW_, tauscriptXT_, tauscriptXNT_, ...
phiiotaTX ,phiiotaTM, phiiotaWX, phiiotaWM,...
Omegah_, OmegaCP_, OmegaC_, OmegaKP_, OmegaHP_, OmegaD_, OmegaND_, OmegaKG_, OmegaHG_, OmegaCG_, OmegaY_, OmegaTC_, OmegaWP_, OmegaWC_, OmegaKT_, OmegaHLT_, OmegaKLT_, OmegaHLXT_, OmegaT_, OmegaKNT_, OmegaHLNT_, OmegaKLNT_, OmegaHLXNT_, OmegaNT_, OmegaKW_, OmegaHLW_, OmegaKLW_, OmegaHLXW_, OmegaW_, ...
GN_, Z_, deltaItilde_, scriptFI_, deltaD_, kappa0_, kappah_, ...
kappaT_, kappaNT_, kappaW_, kappaST_, kappaSNT_, kappaSW_, kappaD_, kappaNDCG_, kappaK_, kappaH_, ...
deltaK_,deltaH_, betabarb, ...
pT0, yTC0, m_, varpi_, eT0_
@#for n in 1:SN
, Ntilde@{n}_
@#endfor
);

%this file also serves as the base of steady_state_model in .mod, we need to make the following changes
%  1.delete ...
%  2.replace SN properly
%  3.delete neg_check
%  4.delete getjp, SOC, and all relevant to fzero
%  5.add any parameters that are equations of other parameters

@#define Sectors0 = [ "T", "NT", "W" ]
@#define Sectors1 = [ "K", "H", "D", "NDCG" ]
@#define SectorsP1 = [ "KP", "HP", "D", "ND" ]
@#define SectorsG1 = [ "KG", "HG", "CG" ]
@#define Sectors2 = [ "T", "NT", "W", "ST", "SNT", "SW", "D", "NDCG", "K", "H" ]
@#define Members = [ "b", "l" ]

    LW1l_ = exp( InVec( 1+(1-1)*28 ) );
    LT1l_ = exp( InVec( 2+(1-1)*28 ) );
    LNT1l_ = exp( InVec( 3+(1-1)*28 ) );
    LSW1l_ = exp( InVec( 4+(1-1)*28 ) );
    LST1l_ = exp( InVec( 5+(1-1)*28 ) );
    LSNT1l_ = exp( InVec( 6+(1-1)*28 ) );
	
    LNDCG1l_ = exp( InVec( 7+(1-1)*28 ) );
    Lh1l_ = exp( InVec( 8+(1-1)*28 ) );
    CD1l_ = exp( InVec( 9+(1-1)*28 ) );
    CND1l_ = exp( InVec( 10+(1-1)*28 ) );
	
    LNDCG1b_ = exp( InVec( 11+(1-1)*28 ) );
    Lh1b_ = exp( InVec( 12+(1-1)*28 ) );
    CD1b_ = exp( InVec( 13+(1-1)*28 ) );
    CND1b_ = exp( InVec( 14+(1-1)*28 ) );
	
	%it is possible not to guess these 3, in which case WK, WH, LND etc. are a solution of a polynomial with nonstandard order
    %and it's hard to guess these 3, because they can easily make LKG, LHG, LCG negative and other variable complex.
	LKP1_ = exp( InVec( 15+(1-1)*28 ) );
	LHP1_ = exp( InVec( 16+(1-1)*28 ) );
	LND1_ = exp( InVec( 17+(1-1)*28 ) );
	LCG1_ = exp( InVec( 18+(1-1)*28 ) ); % to aviod LCG1_ = LNDCG1_ - LND1_;
	LKG1_ = exp( InVec( 19+(1-1)*28 ) );
	LHG1_ = exp( InVec( 20+(1-1)*28 ) );
	
	%it is possible not to guess these, see price-forming block in s0
	KPT1_ = exp( InVec( 21+(1-1)*28 ) );
	KPNT1_ = exp( InVec( 22+(1-1)*28 ) );
	KPW1_ = exp( InVec( 23+(1-1)*28 ) );
	
	IKP1_ = exp( InVec( 24+(1-1)*28 ) ); %to avoid YKP1_ = Y1_ * ( 1 - tauCG_ * alphaCG - tauKG_ * alphaKG - tauHG_ * alphaHG ) - YD1_ - YND1_ - YHP1_;
    IHP1_ = exp( InVec( 25+(1-1)*28 ) );
    P1_ = exp( InVec( 26+(1-1)*28 ) );
	YWC1_ = exp( InVec( 27+(1-1)*28 ) );
	X1_ = exp( InVec( 28+(1-1)*28 ) );
@#for n in 2:SN
	LW@{n}l_ =      LW1l_      /Ntilde1_*Ntilde@{n}_;
    LT@{n}l_ =      LT1l_      /Ntilde1_*Ntilde@{n}_;
    LNT@{n}l_ =     LNT1l_     /Ntilde1_*Ntilde@{n}_;
    LSW@{n}l_ =     LSW1l_     /Ntilde1_*Ntilde@{n}_;
    LST@{n}l_ =     LST1l_     /Ntilde1_*Ntilde@{n}_;
    LSNT@{n}l_ =    LSNT1l_    /Ntilde1_*Ntilde@{n}_;
    LNDCG@{n}l_ =   LNDCG1l_   /Ntilde1_*Ntilde@{n}_;
    Lh@{n}l_ =      Lh1l_      /Ntilde1_*Ntilde@{n}_;
    CD@{n}l_ =      CD1l_      /Ntilde1_*Ntilde@{n}_;
    CND@{n}l_ =     CND1l_     /Ntilde1_*Ntilde@{n}_;
    LNDCG@{n}b_  =  LNDCG1b_   /Ntilde1_*Ntilde@{n}_;
    Lh@{n}b_ =      Lh1b_      /Ntilde1_*Ntilde@{n}_;
    CD@{n}b_ =      CD1b_      /Ntilde1_*Ntilde@{n}_;
    CND@{n}b_ =     CND1b_     /Ntilde1_*Ntilde@{n}_;
	LKP@{n}_ =      LKP1_      /Ntilde1_*Ntilde@{n}_;
	LHP@{n}_ =      LHP1_      /Ntilde1_*Ntilde@{n}_;
	LND@{n}_ =      LND1_      /Ntilde1_*Ntilde@{n}_;
	LCG@{n}_ =      LCG1_      /Ntilde1_*Ntilde@{n}_;
	LKG@{n}_ =      LKG1_      /Ntilde1_*Ntilde@{n}_;
	LHG@{n}_ =      LHG1_      /Ntilde1_*Ntilde@{n}_;
	KPT@{n}_ =      KPT1_      /Ntilde1_*Ntilde@{n}_;
	KPNT@{n}_ =     KPNT1_     /Ntilde1_*Ntilde@{n}_;
	KPW@{n}_ =      KPW1_      /Ntilde1_*Ntilde@{n}_;
	IKP@{n}_ =      IKP1_      /Ntilde1_*Ntilde@{n}_;
    IHP@{n}_ =      IHP1_      /Ntilde1_*Ntilde@{n}_;
    P@{n}_ =        P1_        ;
	YWC@{n}_ =      YWC1_      /Ntilde1_*Ntilde@{n}_;
	X@{n}_ =        X1_        /Ntilde1_*Ntilde@{n}_;
@#endfor

alphaHG = alphaHP;
alphaKG = alphaKP;
alphaCG = alphaND;

%growth rate
tt3 = (alphaK * alphaY);
tt4 = (tt3 * alphaHG);
tt6 = (alphaHW * alphaKG * alphaKL);
tt10 = (alphaHW * alphaKL * alphaKP);
tt13 = (alphaY * alphaHG);
tt15 = (alphaHLX * alphaHP);
tt16 = (tt15 * alphaHW);
tt21 = (alphaK * alphaHG);
tt26 = (alphaHW ^ 2);
tt31 = (alphaY * alphaHL);
tt33 = (alphaKG * alphaKL);
tt35 = (alphaKL * alphaKP);
tt37 = (alphaK * alphaHW);
tt44 = 2 * tt4 * tt6 - 2 * tt4 * tt10 - 2 * tt13 * alphaHL * tt16 + tt3 * tt6 - tt3 * tt10 - 2 * tt21 * tt6 + 2 * tt21 * tt10 - tt13 * alphaHLX * tt26 + 2 * tt13 * tt10 - tt31 * tt16 - tt3 * tt33 + tt3 * tt35 - tt37 * tt33 + tt37 * tt35 + tt13 * alphaHLX * alphaHW + tt13 * tt26 + tt31 * tt15;
tt45 = alphaY * alphaHLX;
tt47 = alphaY * alphaHW;
tt49 = alphaHW * alphaHG;
tt64 = alphaK * alphaKG * alphaKL - alphaK * alphaKL * alphaKP - alphaY * alphaKL * alphaKP + alphaY * tt26 - tt13 * alphaHW - tt45 * tt26 + tt47 * tt35 - 2 * tt49 * tt35 + 2 * tt45 * alphaHW + alphaY - tt10 + tt35 - tt45 - 2 * tt47 + 2 * tt49 + alphaHW - 1;
b_ = (-1 + alphaHLX) * alphaY / (tt44 + tt64) * (tt49 + alphaHW - 1) * (-1 + alphaHW);
c_ =b_*alphaHG/(1-alphaHW-alphaHW*alphaHG);
d_ =(b_-c_*alphaHW)/(1-alphaHW);
a_ = b_+1;

%%
%some aggregation and population
@#for n in 1:SN
	CND@{n}_ = CND@{n}b_ + CND@{n}l_;
	LNDCG@{n}_ = LNDCG@{n}b_ + LNDCG@{n}l_;
	N@{n}b_ = 100*Ntilde@{n}_ * varpi_;
	N@{n}l_ = 100*Ntilde@{n}_ * (1-varpi_);
	N@{n}_ = N@{n}b_ + N@{n}l_;
@#endfor

NN_ = 0	...
	@#for n in 1:SN
		+ N@{n}_ ...
	@#endfor
	;

N0_ = 100 - NN_;

X_ = 0 ...
@#for n in 1:SN
	+ X@{n}_ ...
@#endfor
;
YWC_ = 0 ...
@#for n in 1:SN
	+ YWC@{n}_ ...
@#endfor
;


%a few equations from the production of IND and CG, in order to get beta first.
%also the production of public goods
@#for n in 1:SN
    Y@{n}_ = OmegaY_ *Ntilde@{n}_ /Ntilde1_;
    YND@{n}_ = ( CND@{n}_ / OmegaND_ / LND@{n}_ ^ ( 1 - alphaND ) ) ^ ( 1 / alphaND );
    PND@{n}_DIVIDEDP@{n}_ = YND@{n}_ / CND@{n}_ / alphaND;
	PND@{n}_ = PND@{n}_DIVIDEDP@{n}_ * P@{n}_;
    beta@{n}b_ = betabarb - bbeta * log( CND@{n}_ * PND@{n}_DIVIDEDP@{n}_ / Y@{n}_ );
	beta@{n}l_ = betabarl - bbeta * log( CND@{n}_ * PND@{n}_DIVIDEDP@{n}_ / Y@{n}_ );
	
	YCG@{n}_ = tauCG_ * alphaCG * Y@{n}_;
	CG@{n}_ = OmegaCG_ * YCG@{n}_ ^ alphaCG * LCG@{n}_ ^ ( 1 - alphaCG );
	PCG@{n}_ = P@{n}_ * YCG@{n}_ / alphaCG / CG@{n}_;
@#endfor

%%
%engineering sector, %SOC=positive if second order condition of firms w.r.t research in engineering sector satisfied
JP_ = GetJP( beta1l_, Z_, deltaItilde_, eta, gamma, lambda, phiR, scriptp, scriptq, zetaR, GN_, scriptFI_, sigma, xi, d_, b_, alphaND, alphaD, alphah, alphaCD, alphaCG, alphaCP  );
SOC=JP_^3*gamma*eta^3*(JP_-1+eta)^3*lambda^3+2*eta^2*(JP_-1+eta)*((JP_^3+(2*eta-2)*JP_^2+3*(-1+eta)^2*JP_*(1/2)+(eta-1/2)*(-1+eta)^2)*gamma-(1/2)*(JP_-1+eta)*(JP_^2+(3*eta-3)*JP_+eta^2-3*eta+2))*JP_^2*lambda^2+eta*((JP_^2+(-1+eta)*JP_+(-1+eta)^2)*(JP_^3+(2*eta-2)*JP_^2+(-1+eta)^2*JP_+eta*(-1+eta)^2)*gamma-(2*(JP_^4+(4*eta-4)*JP_^3+(4*eta^2-9*eta+5)*JP_^2+(3*eta^3-8*eta^2+7*eta-2)*JP_+eta*(eta-2)*(-1+eta)^2))*(JP_-1+eta))*JP_*lambda-JP_^6+(-5*eta+5)*JP_^5+(-8*eta^2+17*eta-9)*JP_^4+(-8*eta^3+22*eta^2-20*eta+6)*JP_^3+(-7*eta^4+22*eta^3-22*eta^2+6*eta+1)*JP_^2-(3*(eta^2-(4/3)*eta-1))*(-1+eta)^3*JP_-(eta^2-eta-1)*(-1+eta)^4;
muP_ = lambda * eta * JP_ / ( JP_ - ( 1 - eta ) );
omegaP_ = JP_ * ( 1 - eta ) / ( JP_ - ( 1 - eta ) ) ^ 2 / ( 1 + muP_ ); 
scriptdP_ = 1 - omegaP_ / ( 1 + omegaP_ ) * ( lambda - muP_ ) * ( muP_ - eta * lambda ) / lambda / ( 1 - eta ) / muP_;
ScriptFRP_ = muP_ * scriptp / ( scriptdP_ - muP_ * scriptp * gamma ) / Z_;
GAs_ = ( 1 + gamma * Z_ * ScriptFRP_ ) ^ ( 1 / gamma );
GERP_ = ( GAs_ ^ ( b_ * phiR - zetaR ) * GN_ ^ phiR ) ^ ( 1 / ( 1 - phiR ) );    
GII_ = GERP_ * GN_ * GAs_ ^ b_;
scripts_ = ( 1 - ( 1 - deltaItilde_ ) / GII_ ) / ( 1 - ( 1 - deltaItilde_ ) / GII_ * ( 1 - scriptq ) );
mu_ = ( ( 1 - scripts_ ) * ( 1 / ( 1 + eta * lambda ) ) ^ ( 1 / lambda ) + scripts_ * ( 1 / ( 1 + muP_ ) ) ^ ( 1 / lambda ) ) ^ ( -lambda ) - 1;
AN_ = ( ( 1 - ( 1 - deltaItilde_ ) / GII_ * ( 1 - scripts_ ) / ( 1 - scripts_ ) ) / ( 1 - ( 1 - deltaItilde_ ) / GII_ * ( 1 - scripts_ ) / ( 1 - scripts_ ) * ( GAs_ ) ^ ( -1 / lambda ) ) ) ^ lambda;
%aggregate productivity of engineering and engineering productivity law of motion
PWC_ = ( ( 1 - scripts_ ) * ( AN_ / ( 1 + eta * lambda ) / GAs_ ) ^ ( 1 / lambda ) + scripts_ * ( 1 / ( 1 + muP_ ) ) ^ ( 1 / lambda ) ) ^ lambda;
A_ = PWC_ * ( 1 + mu_ );

gII_ = GN_ * GAs_ ^ b_;
gB_ = GN_ * GAs_ ^ a_;
gYS_ = GN_ * GAs_ ^ d_;
gPS_ = GN_ * GAs_ ^ a_ / gYS_;
gYWC_ = GN_ * GAs_ ^ b_;
gX_ = GN_ * GAs_ ^ a_;
gKP_ = GN_ * GAs_ ^ ( d_ * alphaKP );
gHP_ = GN_ * GAs_ ^ ( d_ * alphaHP );
gPKP_ = GN_ * GAs_ ^ a_ / gKP_;
gPHP_ = GN_ * GAs_ ^ a_ / gHP_;
gKG_ = GN_ * GAs_ ^ ( d_ * alphaKG );
gHG_ = GN_ * GAs_ ^ ( d_ * alphaHG );
gYHL_ = GN_ * GAs_ ^ ( d_ * alphaHP * alphaHL );
gPHL_ = GN_ * GAs_ ^ a_ / gYHL_;
gK_ = gKG_ ^ alphaK * gKP_ ^ ( 1 - alphaK );
gRK_ = GN_ * GAs_ ^ a_ / gK_;
gYKL_ = gK_ ^ alphaKL * GN_ ^ ( 1 - alphaKL );
gPKL_ = GN_ * GAs_ ^ a_ / gYKL_;
gKBar_ = gK_ / GN_;
gYHLX_ = gYHL_ ^ alphaHLX * ( GN_ * GAs_ ^ a_ ) ^ ( 1 - alphaHLX );
gPHLX_ = GN_ * GAs_ ^ a_ / gYHLX_;
gYHLBar_ = gYHL_ / ( GN_ * GAs_ ^ a_ );
gYHLXBar_ = gYHLX_ / gYKL_;
gCG_ = GN_ * GAs_ ^ ( d_ * alphaCG );
gCND_ = GN_ * GAs_ ^ ( d_ * alphaND );
gD_ = GN_ * GAs_ ^ ( d_ * alphaD );
gPD_ = GN_ * GAs_ ^ a_ / gD_;
gPND_ = GN_ * GAs_ ^ a_ / gCND_;
gCD_ = GN_ * GAs_ ^ ( d_ * alphaD * alphah );
gCDBar_ = gCD_ / gCND_;
gCP_ = gCDBar_ ^ alphaCD * gCND_;
gCPBar_ = gCP_ / gCG_;
gC_ = gCPBar_ ^ alphaCP * gCG_;
gCBar_ = gC_;
gV_ = gCBar_ * GN_ ^ ( xi / ( 1 - sigma ) - 1 );
glambda_C_ = GN_ ^ ( xi / ( 1 - sigma ) - 1 );
glambda_CPBar_ = gC_ / gCPBar_ * glambda_C_;
glambda_CP_ = glambda_CPBar_ / gCG_;
glambda_CDBar_ = glambda_CP_ * gCP_ / gCDBar_;
glambda_CD_ = glambda_CDBar_ / gCND_;
glambda_B_ = glambda_CP_ * GAs_ ^ ( alphaCD * ( d_ * alphaD * alphah - d_ * alphaND ) - a_ + d_ * alphaND );
glambda_GD_ = glambda_CP_ * GAs_ ^ ( alphaCD * ( d_ * alphaD * alphah - d_ * alphaND ) + d_ * alphaND - d_ * alphaD );
glambda_D_ = glambda_GD_;
glambda_GK_ = glambda_CP_ * GAs_ ^ ( alphaCD * ( d_ * alphaD * alphah - d_ * alphaND ) + d_ * alphaND - d_ * alphaKP );
glambda_K_ = glambda_GK_;
glambda_GH_ = glambda_CP_ * GAs_ ^ ( alphaCD * ( d_ * alphaD * alphah - d_ * alphaND ) + d_ * alphaND - d_ * alphaHP );
glambda_H_ = glambda_GH_;

%%
%Consumption composite
@#for n in 1:SN
	@#for m in Members
		CDBar@{n}@{m}_ = CD@{n}@{m}_ / CND@{n}@{m}_ * gCDBar_ ^ ( -varrhoCD / ( 1 - varrhoCD ) );
		CP@{n}@{m}_ = N@{n}@{m}_ * OmegaCP_ * ( CDBar@{n}@{m}_ / gCDBar_ ) ^ alphaCD * ( alphaCD * ( CD@{n}@{m}_ / N@{n}@{m}_ / ( CDBar@{n}@{m}_ / gCDBar_ ) ) ^ ( ( eCP - 1 ) / eCP )  +  ( 1 - alphaCD ) * ( CND@{n}@{m}_ / N@{n}@{m}_ ) ^ ( ( eCP - 1 ) / eCP ) ) ^ ( eCP / ( eCP - 1 ) );
		CPBar@{n}@{m}_ = CP@{n}@{m}_ / CG@{n}_ * ( N@{n}b_ + N@{n}l_ ) / N@{n}@{m}_ * gCPBar_ ^ ( -varrhoCP / ( 1 - varrhoCP ) );
		C@{n}@{m}_ = N@{n}@{m}_ * OmegaC_ * ( CPBar@{n}@{m}_ / gCPBar_ ) ^ alphaCP * ( alphaCP * ( CP@{n}@{m}_ / N@{n}@{m}_ / ( CPBar@{n}@{m}_ / gCPBar_ ) ) ^ ( ( eC - 1 ) / eC )  +  ( 1 - alphaCP ) * ( CG@{n}_ / ( N@{n}b_ + N@{n}l_ ) ) ^ ( ( eC - 1 ) / eC ) ) ^ ( eC / ( eC - 1 ) );
		CBar@{n}@{m}_ = N@{n}@{m}_ * ( C@{n}@{m}_ / N@{n}@{m}_ ) * ( gCBar_ / GN_ ) ^ ( -varrhoC / ( 1 - varrhoC ) );
	@#endfor
@#endfor

%STD and 2 engineering equations
@#for n in 1:SN
	VV@{n}l_=beta@{n}l_ * gV_ ^ -sigma;
	VV@{n}b_=beta@{n}b_ * gV_ ^ -sigma;
    Xi@{n}_ = VV@{n}l_ * glambda_B_;
@#endfor
	Xi_ = Xi1_;
	Q_ = Xi_;
@#for n in 1:SN
    QB@{n}_ = VV@{n}b_ * glambda_B_;
	lambda_F@{n}_DIVIDEDlambda_B@{n}b_ = ( Q_ - VV@{n}b_ * glambda_B_ ) /  ( 1 - VV@{n}b_ * glambda_B_ * rhoQB );
@#endfor
II_ = 1 / JP_ * muP_ / ( 1 + muP_ ) * ( ( 1 + mu_ ) / ( 1 + muP_ ) ) ^ ( 1 / lambda ) * Xi_ * GN_ * GAs_ ^ a_ * X_ * A_ ^ ( - 1 / lambda ) / ( ScriptFRP_ * PWC_ / scriptp ); %zero profit of engineering sector
VI_ = scriptFI_ * PWC_; %zero profit of invention

%phsical/human capital related (KPS@{n}_ PKP@{n}_ IKPS@{n}_ are solved from production side)
@#for n in 1:SN    
	@#for S in Sectors0
		lambda_GK@{S}@{n}_=0;
		lambda_GH@{S}@{n}_=0;
		KU@{S}@{n}_ = ( ( 1 - VV@{n}l_ * glambda_K_ * ( 1 - deltaK_ ) ) / ( thetaKU0 / gKP_ - VV@{n}l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKP@{S}@{n}_DIVIDEDPKP@{n}_ = thetaKU0 * KU@{S}@{n}_ ^ thetaKU1 / gKP_ / ( 1 - tauK@{S}_ );
		RHP@{S}@{n}_DIVIDEDPHP@{n}_ = ( 1 - VV@{n}l_ * glambda_H_ * ( 1 - deltaH_ ) ) / ( 1 - tauH@{S}_ );
	@#endfor
@#endfor

%Durable stock and home production related
@#for n in 1:SN	
	lambda_GD@{n}l_=0;
	lambda_GD@{n}b_=0;
    
    DU@{n}l_ = ( ( 1 - VV@{n}l_ * glambda_D_ * ( 1 - deltaD_ ) ) / ( thetaDU0 / gD_ - VV@{n}l_ * glambda_D_ * thetaDU0 / ( 1+thetaDU1 ) ) ) ^ ( 1 / ( 1+thetaDU1 ) );
    DU@{n}b_ = ( ( 1 - VV@{n}b_ * glambda_D_ * ( 1 - deltaD_ ) - lambda_F@{n}_DIVIDEDlambda_B@{n}b_ * ( 1 - rhoQB ) * m_ / ( 1 + tauD_ ) ) / ( thetaDU0 / gD_ - VV@{n}b_ * glambda_D_ * thetaDU0 / ( 1+thetaDU1 ) ) ) ^ ( 1 / ( 1+thetaDU1 ) );
    
	@#for m in Members
		D@{n}@{m}_ = ( CD@{n}@{m}_ / Lh@{n}@{m}_ ^ ( 1 - alphah ) / Omegah_ ) ^ ( 1 / alphah ) / DU@{n}@{m}_;
		DP@{n}@{m}_ = D@{n}@{m}_ * gD_;    
		ID@{n}@{m}_ = ( D@{n}@{m}_ - D@{n}@{m}_ / gD_ * ( 1 - deltaD_ - thetaDU0 / ( 1 + thetaDU1 ) * DU@{n}@{m}_ ^ ( 1 + thetaDU1 ) ) );
	@#endfor
	
	ID@{n}_ = ID@{n}b_ + ID@{n}l_;
@#endfor

%production of specialized goods and labor supply
@#for n in 1:SN
%ND in @{n}
    WNDCG@{n}_ = PND@{n}_ * ( 1 - alphaND ) * CND@{n}_ / LND@{n}_;
	tauLNDCG@{n}_ = tauLa_ + tauLb_ * log( WNDCG@{n}_ );
	@#for m in Members
		V@{n}@{m}_DIVIDEDU@{n}@{m}_ = ( ( 1 - beta@{n}@{m}_ ) * N@{n}@{m}_ ^ ( xi - 1 + sigma ) / ( 1 - beta@{n}@{m}_ * gV_ ^ ( 1 - sigma ) ) ) ^ ( 1 / ( 1 - sigma ) );
		lambda_B@{n}@{m}_ = ( V@{n}@{m}_DIVIDEDU@{n}@{m}_ ) ^ sigma  * ( 1 - beta@{n}@{m}_ ) * N@{n}@{m}_ ^ ( xi - 1 + sigma ) * kappaNDCG_ * ( LNDCG@{n}@{m}_ / N@{n}@{m}_ ) ^ nuNDCG * CBar@{n}@{m}_ / N@{n}@{m}_ / ( gCBar_ / GN_ ) / WNDCG@{n}_ / ( 1 - tauLNDCG@{n}_ );
	@#endfor
%D in @{n}
%	WD@{n}_ = (( ...
%		( 1 - tauLD@{n}_ ) ^ ( 1 / nuD ) * ( ...
%		( lambda_B@{n}l_ / ( V@{n}l_DIVIDEDU@{n}l_ ) ^ sigma / ( 1 - beta@{n}l_ ) / N@{n}l_ ^ ( xi - 1 + sigma ) / ( CBar@{n}l_ / gCBar_ / ( N@{n}l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N@{n}l_ + ...
%		( lambda_B@{n}b_ / ( V@{n}b_DIVIDEDU@{n}b_ ) ^ sigma / ( 1 - beta@{n}b_ ) / N@{n}b_ ^ ( xi - 1 + sigma ) / ( CBar@{n}b_ / gCBar_ / ( N@{n}b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N@{n}b_ ...
%		) * OmegaD_ / ID@{n}_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P@{n}_ ^ alphaD ...
%		) ^ ( -1 / ( alphaD + 1 / nuD ) ));	

	WDini@{n}_ = (( ...
		( 1 - tauLa_ ) ^ ( 1 / nuD ) * ( ...
		( lambda_B@{n}l_ / ( V@{n}l_DIVIDEDU@{n}l_ ) ^ sigma / ( 1 - beta@{n}l_ ) / N@{n}l_ ^ ( xi - 1 + sigma ) / ( CBar@{n}l_ / gCBar_ / ( N@{n}l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N@{n}l_ + ...
		( lambda_B@{n}b_ / ( V@{n}b_DIVIDEDU@{n}b_ ) ^ sigma / ( 1 - beta@{n}b_ ) / N@{n}b_ ^ ( xi - 1 + sigma ) / ( CBar@{n}b_ / gCBar_ / ( N@{n}b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N@{n}b_ ...
		) * OmegaD_ / ID@{n}_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P@{n}_ ^ alphaD ...
		) ^ ( -1 / ( alphaD + 1 / nuD ) ));	
	WDaux@{n}_ = ( ...
		( lambda_B@{n}l_ / ( V@{n}l_DIVIDEDU@{n}l_ ) ^ sigma / ( 1 - beta@{n}l_ ) / N@{n}l_ ^ ( xi - 1 + sigma ) / ( CBar@{n}l_ / gCBar_ / ( N@{n}l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N@{n}l_ + ...
		( lambda_B@{n}b_ / ( V@{n}b_DIVIDEDU@{n}b_ ) ^ sigma / ( 1 - beta@{n}b_ ) / N@{n}b_ ^ ( xi - 1 + sigma ) / ( CBar@{n}b_ / gCBar_ / ( N@{n}b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N@{n}b_ ...
		) * OmegaD_ / ID@{n}_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P@{n}_ ^ alphaD;
	WD@{n}_ = fzero( @(WD@{n}_) real(WD@{n}_ ^ ( -alphaD * nuD - 1 ) - ( 1 - tauLa_ - tauLb_ * log( WD@{n}_ ) ) * WDaux@{n}_ ^ nuD), WDini@{n}_, optimset( 'display', 'off' ) );
	tauLD@{n}_ = tauLa_ + tauLb_ * log( WD@{n}_ );
	
	@#for m in Members
		LD@{n}@{m}_ = (( ( V@{n}@{m}_DIVIDEDU@{n}@{m}_ ) ^ sigma  * ( 1 - beta@{n}@{m}_ ) * N@{n}@{m}_ ^ ( xi - 1 + sigma ) * kappaD_ * CBar@{n}@{m}_ / N@{n}@{m}_ ^ ( 1 + nuD ) / ( gCBar_ / GN_ ) / lambda_B@{n}@{m}_ / ( 1 - tauLD@{n}_ ) / WD@{n}_ ) ^ ( -1 / nuD ));
	@#endfor
	LD@{n}_ = LD@{n}b_ + LD@{n}l_;
    YD@{n}_ = ( ID@{n}_ / LD@{n}_ ^ ( 1 - alphaD ) / OmegaD_ ) ^ ( 1 / alphaD );
    PD@{n}_ = YD@{n}_ / ID@{n}_ / alphaD * P@{n}_;
	
%H in @{n}
	WH@{n}_ = ( ( 1 - alphaHP ) / alphaHP ) * ( IHP@{n}_ / LHP@{n}_ / OmegaHP_ ) ^ ( 1 / alphaHP ) * P@{n}_;
	tauLH@{n}_ = tauLa_ + tauLb_ * log( WH@{n}_ );
	@#for m in Members
		LH@{n}@{m}_ = (( ( V@{n}@{m}_DIVIDEDU@{n}@{m}_ ) ^ sigma  * ( 1 - beta@{n}@{m}_ ) * N@{n}@{m}_ ^ ( xi - 1 + sigma ) * kappaH_ * CBar@{n}@{m}_ / N@{n}@{m}_ ^ ( 1 + nuH ) / ( gCBar_ / GN_ ) / lambda_B@{n}@{m}_ / ( 1 - tauLH@{n}_ ) / WH@{n}_ ) ^ ( -1 / nuH ));
	@#endfor
    YHP@{n}_ = ( IHP@{n}_ / LHP@{n}_ ^ ( 1 - alphaHP ) / OmegaHP_ ) ^ ( 1 / alphaHP );
    PHP@{n}_ = YHP@{n}_ / IHP@{n}_ / alphaHP * P@{n}_;
	
	YHG@{n}_ = tauHG_ * alphaHG * Y@{n}_;
	IHG@{n}_ = OmegaHG_ * YHG@{n}_ ^ alphaHG * LHG@{n}_ ^ ( 1 - alphaHG );
	HG@{n}_ = IHG@{n}_ / ( 1 - ( 1 - deltaH_ ) / gHG_ );
	PHG@{n}_ = P@{n}_ * YHG@{n}_ / alphaHG / IHG@{n}_;
	
%K in @{n}
	WK@{n}_ = ( ( 1 - alphaKP ) / alphaKP ) * ( IKP@{n}_ / LKP@{n}_ / OmegaKP_ ) ^ ( 1 / alphaKP ) * P@{n}_;
	tauLK@{n}_ = tauLa_ + tauLb_ * log( WK@{n}_ );
	@#for m in Members
		LK@{n}@{m}_ = (( ( V@{n}@{m}_DIVIDEDU@{n}@{m}_ ) ^ sigma  * ( 1 - beta@{n}@{m}_ ) * N@{n}@{m}_ ^ ( xi - 1 + sigma ) * kappaK_ * CBar@{n}@{m}_ / N@{n}@{m}_ ^ ( 1 + nuK ) / ( gCBar_ / GN_ ) / lambda_B@{n}@{m}_ / ( 1 - tauLK@{n}_ ) / WK@{n}_ ) ^ ( -1 / nuK ));
	@#endfor
	YKP@{n}_ = ( IKP@{n}_ / LKP@{n}_ ^ ( 1 - alphaKP ) / OmegaKP_ ) ^ ( 1 / alphaKP );
    PKP@{n}_ = YKP@{n}_ / IKP@{n}_ / alphaKP * P@{n}_;
	
	YKG@{n}_ = tauKG_ * alphaKG * Y@{n}_;
	IKG@{n}_ = OmegaKG_ * YKG@{n}_ ^ alphaKG * LKG@{n}_ ^ ( 1 - alphaKG );
	KG@{n}_ = IKG@{n}_ / ( 1 - ( 1 - deltaK_ ) / gKG_ );
	PKG@{n}_ = P@{n}_ * YKG@{n}_ / alphaKG / IKG@{n}_;
@#endfor

%Labor supply in W/T/NT, SW/ST/SNT, h
@#for n in 1:SN
	@#for S in [ "W", "T", "NT", "SW", "ST", "SNT" ]
		%W@{S}@{n}_ = ( V@{n}l_DIVIDEDU@{n}l_ ) ^ sigma  * ( 1 - beta@{n}l_ ) * N@{n}l_ ^ ( xi - 1 + sigma ) * kappa@{S}_ * L@{S}@{n}l_ ^ nu@{S} * CBar@{n}l_ / N@{n}l_ ^ ( 1 + nu@{S} ) / ( gCBar_ / GN_ ) / lambda_B@{n}l_ / ( 1 - tauL@{S}@{n}_ );
		W@{S}ini@{n}_ = ( V@{n}l_DIVIDEDU@{n}l_ ) ^ sigma  * ( 1 - beta@{n}l_ ) * N@{n}l_ ^ ( xi - 1 + sigma ) * kappa@{S}_ * L@{S}@{n}l_ ^ nu@{S} * CBar@{n}l_ / N@{n}l_ ^ ( 1 + nu@{S} ) / ( gCBar_ / GN_ ) / lambda_B@{n}l_ / ( 1 - tauLa_ );
		W@{S}@{n}_ = fzero( @(W@{S}@{n}_) real(W@{S}@{n}_ - ( V@{n}l_DIVIDEDU@{n}l_ ) ^ sigma  * ( 1 - beta@{n}l_ ) * N@{n}l_ ^ ( xi - 1 + sigma ) * kappa@{S}_ * L@{S}@{n}l_ ^ nu@{S} * CBar@{n}l_ / N@{n}l_ ^ ( 1 + nu@{S} ) / ( gCBar_ / GN_ ) / lambda_B@{n}l_ / ( 1 - tauLa_ - tauLb_ * log( W@{S}@{n}_ ) )), W@{S}ini@{n}_, optimset( 'display', 'off' ) );
		tauL@{S}@{n}_ = tauLa_ + tauLb_ * log( W@{S}@{n}_ );
	@#endfor
	
	@#for S in [ "W", "T", "NT" ]
		L@{S}@{n}b_ = ( ( V@{n}b_DIVIDEDU@{n}b_ ) ^ sigma  * ( 1 - beta@{n}b_ ) * N@{n}b_ ^ ( xi - 1 + sigma ) * kappa@{S}_ * CBar@{n}b_ / N@{n}b_ ^ ( 1 + nu@{S} ) / ( gCBar_ / GN_ ) / lambda_B@{n}b_ / ( 1 - tauL@{S}@{n}_ ) / W@{S}@{n}_ ) ^ ( -1 / nu@{S} );
	@#endfor
	
	@#for S in [ "W", "T", "NT" ]
		LS@{S}@{n}b_ = ( ( V@{n}b_DIVIDEDU@{n}b_ ) ^ sigma  * ( 1 - beta@{n}b_ ) * N@{n}b_ ^ ( xi - 1 + sigma ) * kappaS@{S}_ * CBar@{n}b_ / N@{n}b_ ^ ( 1 + nuS@{S} ) / ( gCBar_ / GN_ ) / lambda_B@{n}b_ / ( 1 - tauL@{S}@{n}_ ) / W@{S}@{n}_ ) ^ ( -1 / nuS@{S} );
	@#endfor

	@#for m in Members
		lambda_CD@{n}@{m}_ = - ( V@{n}@{m}_DIVIDEDU@{n}@{m}_ ) ^ sigma  * ( 1 - beta@{n}@{m}_ ) * N@{n}@{m}_ ^ ( xi - 1 + sigma ) * kappah_ * Lh@{n}@{m}_ ^ nuh * CBar@{n}@{m}_ / N@{n}@{m}_ ^ ( 1 + nuh ) / ( gCBar_ / GN_ ) * Lh@{n}@{m}_ / CD@{n}@{m}_ / ( 1 - alphah );
	@#endfor
	
	LW@{n}_ = LW@{n}l_ + LW@{n}b_ + LSW@{n}b_;
    LT@{n}_ = LT@{n}l_ + LT@{n}b_ + LST@{n}b_;
    LNT@{n}_ = LNT@{n}l_ + LNT@{n}b_ + LSNT@{n}b_;
    LSW@{n}_ = LSW@{n}l_;
    LST@{n}_ = LST@{n}l_;
    LSNT@{n}_ = LSNT@{n}l_;
@#endfor

%Utility related
@#for n in 1:SN
	@#for m in Members
		kappaTemp@{n}@{m}_ = kappa0_ + kappaW_ / ( 1 + nuW ) * ( LW@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuW ) + kappaT_ / ( 1 + nuT ) * ( LT@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuT ) + kappaNT_ / ( 1 + nuNT ) * ( LNT@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuNT )...
			+ kappaSW_ / ( 1 + nuSW ) * ( LSW@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuSW ) + kappaST_ / ( 1 + nuST ) * ( LST@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuST ) + kappaSNT_ / ( 1 + nuSNT ) * ( LSNT@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuSNT )...
			+ kappaD_ / ( 1 + nuD ) * ( LD@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuD )	+ kappaNDCG_ / ( 1 + nuNDCG ) * ( LNDCG@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuNDCG ) + kappaK_ / ( 1 + nuK ) * ( LK@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuK ) + kappaH_ / ( 1 + nuH ) * ( LH@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuH )...
			+ kappah_ / ( 1 + nuh ) * ( Lh@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuh );

		U@{n}@{m}_ = C@{n}@{m}_ - h * C@{n}@{m}_ / ( gCBar_ / GN_ ) - CBar@{n}@{m}_ / ( gCBar_ / GN_ )* kappaTemp@{n}@{m}_;

		V@{n}@{m}_ = U@{n}@{m}_ * ( ( 1 - beta@{n}@{m}_ ) * N@{n}@{m}_ ^ ( xi - 1 + sigma ) / ( 1 - beta@{n}@{m}_ * gV_ ^ ( 1 - sigma ) ) ) ^ ( 1 / ( 1 - sigma ) );

		EV@{n}@{m}_ = V@{n}@{m}_ * gV_;
	@#endfor
@#endfor

%Solve other multipliers
@#for n in 1:SN
	@#for m in Members
		%FOC of Cbar
        lambda_CBar@{n}@{m}_ = VV@{n}@{m}_ * ( V@{n}@{m}_DIVIDEDU@{n}@{m}_ * gV_ / gC_ ) ^ sigma  * ( 1 - beta@{n}@{m}_ ) * ( N@{n}@{m}_ * GN_ ) ^ ( xi - 1 + sigma ) * GN_ * kappaTemp@{n}@{m}_ / ( VV@{n}@{m}_ * glambda_C_ * ( C@{n}@{m}_ * gCBar_ / GN_ / N@{n}@{m}_ )^ ( 1 - varrhoC) * GN_ * varrhoC * ( CBar@{n}@{m}_ / N@{n}@{m}_ ) ^ ( varrhoC -1 ) - 1 );
		%FOC of C
        lambda_C@{n}@{m}_ = - ( V@{n}@{m}_DIVIDEDU@{n}@{m}_ ) ^ sigma  * ( 1 - beta@{n}@{m}_ ) * ( N@{n}@{m}_ ^ ( xi - 1 + sigma ) - VV@{n}@{m}_ * ( gV_ / gC_ ) ^ sigma * ( N@{n}@{m}_ * GN_ ) ^ ( xi - 1 + sigma ) * GN_ * h ) - lambda_CBar@{n}@{m}_ * ( 1 - varrhoC ) * ( C@{n}@{m}_ / N@{n}@{m}_ ) ^ ( -varrhoC ) * ( CBar@{n}@{m}_ / N@{n}@{m}_ / ( gCBar_ / GN_ ) ) ^ varrhoC;
		%FOC of CPBar
        lambda_CPBar@{n}@{m}_ = VV@{n}@{m}_ * lambda_C@{n}@{m}_ * glambda_C_ * ( alphaCP * C@{n}@{m}_ * gC_ / CPBar@{n}@{m}_ - OmegaC_ * CPBar@{n}@{m}_ ^ ( ( alphaCP - 1 ) * ( 1 - 1 / eC ) - 1 ) * ( C@{n}@{m}_ * gC_ / OmegaC_ ) ^ ( 1 / eC ) * alphaCP * ( CP@{n}@{m}_ * gCP_ ) ^ ( 1 - 1 / eC ) )...
            / ( 1 - VV@{n}@{m}_ * glambda_CPBar_ * ( CP@{n}@{m}_ * gCP_ / CG@{n}_ / gCG_ * ( N@{n}b_ + N@{n}l_ ) / N@{n}@{m}_ ) ^ ( 1 - varrhoCP ) * varrhoCP * CPBar@{n}@{m}_ ^ ( varrhoCP - 1 ) );
		%FOC of CP
		lambda_CP@{n}@{m}_ = lambda_C@{n}@{m}_ * OmegaC_ * ( CPBar@{n}@{m}_ / gCPBar_ ) ^ ( ( alphaCP - 1 ) * ( eC - 1 ) / eC ) * alphaCP * ( C@{n}@{m}_ / CP@{n}@{m}_ / OmegaC_ ) ^ ( 1 / eC ) + lambda_CPBar@{n}@{m}_ * ( ( N@{n}b_ + N@{n}l_ ) / N@{n}@{m}_ / CG@{n}_ ) ^ ( 1 - varrhoCP ) * ( CPBar@{n}@{m}_ / gCPBar_ ) ^ varrhoCP * ( 1 - varrhoCP ) * CP@{n}@{m}_ ^ ( -varrhoCP );
		%FOC of CDBar
        lambda_CDBar@{n}@{m}_ = VV@{n}@{m}_ * lambda_CP@{n}@{m}_ * glambda_CP_ * ( alphaCD * CP@{n}@{m}_ * gCP_ / CDBar@{n}@{m}_ - OmegaCP_ * CDBar@{n}@{m}_ ^ ( ( alphaCD - 1 ) * ( 1 - 1 / eCP ) - 1 ) * ( CP@{n}@{m}_ * gCP_ / OmegaCP_ ) ^ ( 1 / eCP ) * alphaCD * ( CD@{n}@{m}_ * gCD_ ) ^ ( 1 - 1 / eCP ) )...
            / ( 1 - VV@{n}@{m}_ * glambda_CDBar_ * ( CD@{n}@{m}_ * gCD_ / CND@{n}@{m}_ / gCND_ ) ^ ( 1 - varrhoCD ) * varrhoCD * CDBar@{n}@{m}_ ^ ( varrhoCD - 1 ) );
	@#endfor
@#endfor

%%
%production sectors
%first, built prices from down to up

@#for n in 1:SN
	lambda_F@{n}_ = lambda_F@{n}_DIVIDEDlambda_B@{n}b_ * lambda_B@{n}b_;
	@#for S in Sectors0
		RKP@{S}@{n}_ = RKP@{S}@{n}_DIVIDEDPKP@{n}_ * PKP@{n}_;
		RHP@{S}@{n}_ = RHP@{S}@{n}_DIVIDEDPHP@{n}_ * PHP@{n}_;
	@#endfor
	
	%scriptX
    YX@{n}_ = YWC@{n}_;
	scriptX@{n}_ = X@{n}_ * exp( -o * ( log( X@{n}_ / X_ ) - log( YX@{n}_ / YWC_ ) ) ^ 2 );
	PscriptX@{n}_ = 1 / ( exp( -o * ( log( X@{n}_ / X_ ) - log( YX@{n}_ / YWC_ ) ) ^ 2 ) - scriptX@{n}_ * 2 * o * ( log( X@{n}_ / X_ ) - log( YX@{n}_ / YWC_ ) ) * (X_ - X@{n}_) / X@{n}_ / X_ );
	PX@{n}_ = PscriptX@{n}_ * scriptX@{n}_ * 2 * o * ( log( X@{n}_ / X_ ) - log( YX@{n}_ / YWC_ ) ) * ( YWC_ - YX@{n}_ ) / YX@{n}_ / YWC_;
	
	@#for S in Sectors0
		%HL in @{S}@{n}
		PHL@{S}@{n}_ = 1 / ( ( alphaHL / RHP@{S}@{n}_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WS@{S}@{n}_ ) ^ ( 1 - alphaHL ) * OmegaHL@{S}_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KP@{S}@{n}_
		%Can I decompose total spendings on factors untill I got RK@{S}@{n}_TIMESK@{S}@{n}_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FK@{S}@{n}_ = OmegaKW_ * ( KG@{n}_  / gKG_ ) ^ alphaK * ( KUW@{n}_ * KPW@{n}_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		K@{S}@{n}_ = OmegaK@{S}_ * ( KG@{n}_ / gKG_ ) ^ alphaK * ( KU@{S}@{n}_ * KP@{S}@{n}_ ) ^ ( 1 - alphaK ) - FK@{S}@{n}_;
		RK@{S}@{n}_ = RKP@{S}@{n}_ * KU@{S}@{n}_ * KP@{S}@{n}_ / ( 1 - alphaK ) / ( K@{S}@{n}_ + FK@{S}@{n}_ );
		
		%KL in @{S}@{n}
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTemp@{S}@{n}_ = OmegaKL@{S}_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKL@{S} - 1 ) / eKL@{S} ) + 1 - alphaKL ) ^ ( eKL@{S} / ( eKL@{S} - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTemp@{S}@{n}_ = OmegaKL@{S}_ ^ ( 1 - 1 / eKL@{S} ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKL@{S} - 1 ) / eKL@{S} ) * YKLTemp@{S}@{n}_ ^ ( 1/ eKL@{S} - 1 )...
			- Xi@{n}_ * OmegaKL@{S}_ ^ ( 1 - 1 / eKL@{S} ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKL@{S} - 1 ) / eKL@{S} ) * ( gYKL_ / gK_ ) ^ ( 1 / eKL@{S} ) * YKLTemp@{S}@{n}_ ^ ( 1/ eKL@{S} - 1 )...
			+ Xi@{n}_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKL@{S}@{n}_ = 1 / ( ( PKLTemp@{S}@{n}_ * alphaKL / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / RK@{S}@{n}_ ) ^ alphaKL * ( 1 / W@{S}@{n}_ - PKLTemp@{S}@{n}_ * alphaKL / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / W@{S}@{n}_ ) ^ ( 1 - alphaKL ) * YKLTemp@{S}@{n}_ );

		%HLX in @{S}@{n}
		YHLXTemp@{S}@{n}_ = OmegaHLX@{S}_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLX@{S} - 1 ) / eHLX@{S} ) + 1 - alphaHLX ) ^ ( eHLX@{S} / ( eHLX@{S} - 1 ) );
		PHLXTemp@{S}@{n}_ = OmegaHLX@{S}_ ^ ( 1 - 1 / eHLX@{S} ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLX@{S} - 1 ) / eHLX@{S} ) * YHLXTemp@{S}@{n}_ ^ ( 1/ eHLX@{S} - 1 )...
			- Xi@{n}_ * OmegaHLX@{S}_ ^ ( 1 - 1 / eHLX@{S} ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLX@{S} - 1 ) / eHLX@{S} ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLX@{S}  ) * YHLXTemp@{S}@{n}_ ^ ( 1/ eHLX@{S} - 1 )...
			+ Xi@{n}_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLX@{S}@{n}_ = 1 / ( ( PHLXTemp@{S}@{n}_ * alphaHLX / ( 1 - varrhoHLX * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / PHL@{S}@{n}_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptX@{S}_ ) / PscriptX@{n}_ - PHLXTemp@{S}@{n}_ * alphaHLX / ( 1 - varrhoHLX * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptX@{S}_ )  / PscriptX@{n}_ ) ^ ( 1 - alphaHLX ) * YHLXTemp@{S}@{n}_ );

		%Y in @{S}@{n}
		YTemp@{S}@{n}_ = Omega@{S}_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eY@{S} - 1 ) / eY@{S} ) + 1 - alphaY ) ^ ( eY@{S} / ( eY@{S} - 1 ) );
		PTemp@{S}@{n}_ = Omega@{S}_ ^ ( 1 - 1 / eY@{S} ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eY@{S} - 1 ) / eY@{S} ) * YTemp@{S}@{n}_ ^ ( 1/ eY@{S} - 1 )...
			- Xi@{n}_ * Omega@{S}_ ^ ( 1 - 1 / eY@{S} ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eY@{S} - 1 ) / eY@{S} ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eY@{S}  ) * YTemp@{S}@{n}_ ^ ( 1/ eY@{S} - 1 )...
			+ Xi@{n}_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		P@{S}@{n}_ = 1 / ( ( PTemp@{S}@{n}_ * alphaY / ( 1 - varrhoY * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / PHLX@{S}@{n}_ ) ^ alphaY * ( 1 / PKL@{S}@{n}_ - PTemp@{S}@{n}_ * alphaY / ( 1 - varrhoY * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / PKL@{S}@{n}_ ) ^ ( 1 - alphaY ) * YTemp@{S}@{n}_ );
	@#endfor
@#endfor

%-----------------------------ROW-----------------------------
PT0_ = PT1_ * pT0;
iotaTM0_ = 0;
iotaTX0_ = 0;
%-----------------------------ROW-----------------------------

@#for n in 1:SN
	PTC@{n}_ = ( ...
		@#for m in 0:SN
			+ N@{m}_ * ( PT@{m}_ * ( ...
			@#if n == m
				1 ...
			@#else
				1 + iotaTM_ + iotaTX_ ...
			@#endif
			) ) ^ ( 1 - eT ) ...
		@#endfor
	) ^ ( 1 / ( 1 - eT ) ) / OmegaTC_;
	
	PWP@{n}_ = ( ...
		@#for m in 1:SN
			+ N@{m}_ / NN_ * ( PW@{m}_ * ( ...
			@#if n == m
				1 ...
			@#else
				1 + iotaWM_ + iotaWX_ ...
			@#endif
			) ) ^ ( 1 - eW ) ...
		@#endfor
	) ^ ( 1 / ( 1 - eW ) ) / OmegaWP_;
	
	%PWC_ is in residual, PX@{n}_ is above
	%I don't form P here because we already use the production function of Y (and effectively the market clearing condition of Y)
@#endfor

%%
%then, get quantity by demand from up to down
@#for n in 1:SN
    YNT@{n}_ = alphaNC * P@{n}_ * Y@{n}_ / PNT@{n}_ / ( 1 + tauNT_ );

    YTC@{n}_ = ( 1 - alphaNC ) * P@{n}_ * Y@{n}_ / PTC@{n}_ / ( 1 + tauTC_ );

    FWC@{n}_=FWCtilde * YWC@{n}_;
    %YWC@{n}_ is guessed, demand of YWP is in the residual
	YWP@{n}_ = ( ( YWC@{n}_ + FWC@{n}_ ) / OmegaWC_ / ( HG@{n}_ / gHG_ ) ^ alphaHW ) ^ ( 1 / ( 1 - alphaHW ) );
	
	@#for m in 0:SN
		YT@{n}@{m}_ = ( PTC@{n}_ * OmegaTC_ / ( PT@{m}_ * ( ...
		@#if n == m
			1 ...
		@#else
			1 + iotaTM_ + iotaTX_ ...
		@#endif
		) ) ) ^ eT * YTC@{n}_ / OmegaTC_ * N@{m}_;
	@#endfor
	
	@#for m in 1:SN
        YW@{n}@{m}_ = ( PWP@{n}_ * OmegaWP_/ ( PW@{m}_ * ( ...
        @#if n == m
            1 ...
        @#else
            1 + iotaWM_ + iotaWX_ ...
        @#endif
        ) ) ) ^ eW * YWP@{n}_ / OmegaWP_ * N@{m}_ / NN_;
    @#endfor      
@#endfor

%-----------------------------ROW-----------------------------
YTC0_ = YTC1_ / N1_ * N0_ * yTC0;
@#for m in 1:SN
    YT0@{m}_ = ( PT0_ / ( PT@{m}_ * ( 1 + iotaTM_ + iotaTX_ ) ) ) ^ eT0_ * YTC0_ * N@{m}_;
@#endfor
%-----------------------------ROW-----------------------------														  

@#for n in 1:SN
	YT@{n}_ = YT0@{n}_ * ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) ...
	@#for m in 1:SN
		+ YT@{m}@{n}_ * ...
		@#if n == m
			1 ...
		@#else
			( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) ...
		@#endif
	@#endfor
	;
	
	YW@{n}_ = 0 ...
	@#for m in 1:SN
		+ YW@{m}@{n}_ * ...
		@#if n == m
			1 ...
		@#else
			( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) ...
		@#endif
	@#endfor
	;
@#endfor

@#for n in 1:SN
	@#for S in Sectors0
%Demand of HLX in @{S}@{n}
    YHLX@{S}@{n}_ = P@{S}@{n}_ * Y@{S}@{n}_ * alphaY * PTemp@{S}@{n}_ / ( 1 - varrhoY * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / PHLX@{S}@{n}_;

%demand of KL in @{S}@{n}
    YKL@{S}@{n}_ = P@{S}@{n}_ * Y@{S}@{n}_ * ( 1 - alphaY * PTemp@{S}@{n}_ / ( 1 - varrhoY * Xi@{n}_ * GN_ * GAs_ ^ a_ ) ) / PKL@{S}@{n}_;
    
%demand of HL in @{S}@{n}
    YHL@{S}@{n}_ = PHLX@{S}@{n}_ * YHLX@{S}@{n}_ * alphaHLX * PHLXTemp@{S}@{n}_ / ( 1 - varrhoHLX * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / PHL@{S}@{n}_;

%demand of scriptX in @{S}@{n}
    scriptX@{S}@{n}_ = PHLX@{S}@{n}_ * YHLX@{S}@{n}_ * ( 1 - alphaHLX * PHLXTemp@{S}@{n}_ / ( 1 - varrhoHLX * Xi@{n}_ * GN_ * GAs_ ^ a_ ) ) / ( 1 + tauscriptX@{S}_ ) / PscriptX@{n}_;
	
%demand of K in @{S}@{n}
	%demand in residual
	KPP@{S}@{n}_ = KP@{S}@{n}_ * gKP_;
    IKP@{S}@{n}_ = ( 1 - ( 1 - deltaK_ - thetaKU0 / ( 1+thetaKU1 ) * KU@{S}@{n}_ ^ ( 1+thetaKU1 ) ) / gKP_ ) * KP@{S}@{n}_;

%demand of H in @{S}@{n}
    HP@{S}@{n}_ = PHL@{S}@{n}_ * YHL@{S}@{n}_ * alphaHL / RHP@{S}@{n}_;
	HPP@{S}@{n}_ = HP@{S}@{n}_ * gHP_;
    IHP@{S}@{n}_ = ( 1 - ( 1 - deltaH_ ) / gHP_ ) * HP@{S}@{n}_;

%define all production habit in @{S}@{n}
    YHLXBar@{S}@{n}_ = YHLX@{S}@{n}_ / YKL@{S}@{n}_ * gYHLXBar_ ^ ( -varrhoY / ( 1 - varrhoY ) );
    YHLBar@{S}@{n}_ = YHL@{S}@{n}_ / scriptX@{S}@{n}_ * gYHLBar_ ^ ( -varrhoHLX / ( 1 - varrhoHLX ) );
    KBar@{S}@{n}_ = K@{S}@{n}_ / L@{S}@{n}_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) );
	@#endfor
@#endfor

%Impatient's collateral constraint
@#for n in 1:SN
	B@{n}_ = ( 1 - rhoQB ) * m_ * D@{n}b_ * PD@{n}_ / ( 1 - rhoQB / ( GN_ * GAs_ ^ ( 1 + b_ ) ) );
@#endfor

%variables in measurement equations
@#for n in 1:SN
    GDP@{n}_ = ...
    PKP@{n}_ * IKP@{n}_ + PHP@{n}_ * IHP@{n}_ + PD@{n}_ * ID@{n}_ + PND@{n}_ * CND@{n}_ + PKG@{n}_ * IKG@{n}_ + PHG@{n}_ * IHG@{n}_ + PCG@{n}_ * CG@{n}_ ...
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ ...
            - ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ * PT@{n}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ * PW@{n}_ ...
            - ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ * PT@{m}_ - ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ * PW@{m}_ ...
		@#endif
	@#endfor
    + YWC@{n}_ * PWC_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_;
    GDPplagqlag@{n}_ = GDP@{n}_ / gB_;
    GDPplag@{n}_ = ...
    PKP@{n}_ / gPKP_ * IKP@{n}_ + PHP@{n}_ / gPHP_ * IHP@{n}_ + PD@{n}_ / gPD_ * ID@{n}_ + PND@{n}_ / gPND_ * CND@{n}_ + PKG@{n}_ / (gB_ / gKG_) * IKG@{n}_ + PHG@{n}_ / (gB_ / gHG_) * IHG@{n}_ + PCG@{n}_ / (gB_ / gCG_) * CG@{n}_ ...
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ / gPS_ ...
            - ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ / gPS_ ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ * PT@{n}_ / gPS_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ * PW@{n}_ / gPS_ ...
            - ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ * PT@{m}_ / gPS_ - ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ * PW@{m}_ / gPS_ ...
		@#endif
	@#endfor
    + YWC@{n}_ * PWC_ / GAs_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_;
    GDPqlag@{n}_ = ...
    PKP@{n}_ * IKP@{n}_ / gKP_ + PHP@{n}_ * IHP@{n}_ / gHP_ + PD@{n}_ * ID@{n}_ / gD_ + PND@{n}_ * CND@{n}_ / gCND_ + PKG@{n}_ * IKG@{n}_ / gKG_ + PHG@{n}_ * IHG@{n}_ / gHG_ + PCG@{n}_ * CG@{n}_ / gCG_ ...
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ / gYS_ ...
            - ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ / gYS_ ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ / gYS_ * PT@{n}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ / gYS_ * PW@{n}_ ...
            - ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ / gYS_ * PT@{m}_ - ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ / gYS_ * PW@{m}_ ...
		@#endif
	@#endfor
    + YWC@{n}_ / gYWC_ * PWC_ * ( scriptFI_ * II_ / gII_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ / gII_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_ * gYWC_;
    GDPInflation@{n}_ = log( ( GDP@{n}_ / GDPplag@{n}_ * GDPqlag@{n}_ / GDPplagqlag@{n}_ ) ^ ( 1 / 2 ) );

    @#for m in Members
        Dtilde@{n}@{m}_ = ID@{n}@{m}_ / ( 1 - ( 1 - deltaD_ ) / gD_ );
        deltaDtildeAUXD@{n}@{m}_ = Dtilde@{n}@{m}_;
        deltaDtildeAUXN@{n}@{m}_ = Dtilde@{n}@{m}_ * deltaD_;
	@#endfor
    @#for S in Sectors0
        KPtilde@{S}@{n}_ = IKP@{S}@{n}_ / ( 1 - ( 1 - deltaK_ ) / gKP_ );
        deltaKPtildeAUXD@{S}@{n}_ = KPtilde@{S}@{n}_;
        deltaKPtildeAUXN@{S}@{n}_ = KPtilde@{S}@{n}_ * deltaK_;
	@#endfor

    deltaKGtildeAUXD@{n}_ = IKG@{n}_ / ( 1- ( 1 - deltaK_ ) / gKG_ );
    deltaKGtildeAUXN@{n}_ = deltaKGtildeAUXD@{n}_ * deltaK_;

    deltaHGtildeAUXD@{n}_ = IHG@{n}_ / ( 1 - ( 1 - deltaH_ ) / gHG_ );
    deltaHGtildeAUXN@{n}_ = deltaHGtildeAUXD@{n}_ * deltaH_;
@#endfor

GDPW_ = 0 ...
    @#for n in 1:SN
        + GDP@{n}_ ...
    @#endfor
    ;
GDPWplagqlag_ = 0 ...
    @#for n in 1:SN
        + GDPplagqlag@{n}_ ...
    @#endfor
    ;
GDPWplag_ = 0 ...
    @#for n in 1:SN
        + GDPplag@{n}_ ...
    @#endfor
    ;
GDPWqlag_ = 0 ...
    @#for n in 1:SN
        + GDPqlag@{n}_ ...
    @#endfor
    ;
GRGDPW_ = log( ( GDPW_ / GDPWqlag_ * GDPWplag_ / GDPWplagqlag_ ) ^ ( 1 / 2 ) );

@#for n in 1:SN
%PCE (personal consumption expenditure + government expenditure on education) and deflator
    PCE@{n}_ = PHP@{n}_ * IHP@{n}_ + PD@{n}_ * ID@{n}_ * ( 1 - alpha_resid_ ) + PND@{n}_ * CND@{n}_;
    PCEplagqlag@{n}_ = PCE@{n}_ / gB_;
    PCEplag@{n}_ = PHP@{n}_ / gPHP_ * IHP@{n}_ + PD@{n}_ / gPD_ * ID@{n}_ * ( 1 - alpha_resid_ ) + PND@{n}_ / gPND_ * CND@{n}_;
    PCEqlag@{n}_ = PHP@{n}_ * IHP@{n}_ / gHP_ + PD@{n}_ * ID@{n}_ / gD_ * ( 1 - alpha_resid_ ) + PND@{n}_ * CND@{n}_ / gCND_;
    PCEInflation@{n}_ = log( ( PCE@{n}_ / PCEplag@{n}_ * PCEqlag@{n}_ / PCEplagqlag@{n}_ ) ^ ( 1 / 2 ) ) ;

%DND (personal consumption expenditure except education) and deflator
    DND@{n}_ = PD@{n}_ * ID@{n}_ * ( 1 - alpha_resid_ ) + PND@{n}_ * CND@{n}_;
    DNDplagqlag@{n}_ = DND@{n}_ / gB_;
    DNDplag@{n}_ = PD@{n}_ / gPD_ * ID@{n}_ * ( 1 - alpha_resid_ ) + PND@{n}_ / gPND_ * CND@{n}_;
    DNDqlag@{n}_ = PD@{n}_ * ID@{n}_ / gD_ * ( 1 - alpha_resid_ ) + PND@{n}_ * CND@{n}_ / gCND_;
    DNDInflation@{n}_ = log( ( DND@{n}_ / DNDplag@{n}_ * DNDqlag@{n}_ / DNDplagqlag@{n}_ ) ^ ( 1 / 2 ) ) ;

%PDI (private domestic investment) and deflator
    PDI@{n}_ = ...
    PKP@{n}_ * IKP@{n}_ + PD@{n}_ * ID@{n}_ * alpha_resid_ ...
    + YWC@{n}_ * PWC_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_;
    PDIplagqlag@{n}_ = PDI@{n}_ / gB_;
    PDIplag@{n}_ = ...
    PKP@{n}_ / gPKP_ * IKP@{n}_ + PD@{n}_ / gPD_ * ID@{n}_ * alpha_resid_ ...
    + YWC@{n}_ * PWC_ / GAs_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_;
    PDIqlag@{n}_ = ...
    PKP@{n}_ * IKP@{n}_ / gKP_ + PD@{n}_ * ID@{n}_ / gD_ * alpha_resid_ ...
    + YWC@{n}_ / gYWC_ * PWC_ * ( scriptFI_ * II_ / gII_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ / gII_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_ *  gYWC_;
    PDIInflation@{n}_ = log( ( PDI@{n}_ / PDIplag@{n}_ * PDIqlag@{n}_ / PDIplagqlag@{n}_ ) ^ ( 1 / 2 ) );

%GCE (government consumption expenditures) and deflator
    GCE@{n}_ = PCG@{n}_ * CG@{n}_;
    GCEplagqlag@{n}_ = GCE@{n}_ / gB_;
    GCEplag@{n}_ = PCG@{n}_ / (gB_ / gCG_) * CG@{n}_;
    GCEqlag@{n}_ = PCG@{n}_ * CG@{n}_ / gCG_;
    GCEInflation@{n}_ = log( ( GCE@{n}_ / GCEplag@{n}_ * GCEqlag@{n}_ / GCEplagqlag@{n}_ ) ^ ( 1 / 2 ) );

%GGI (government gross investment) and deflator
    GGI@{n}_ = PKG@{n}_ * IKG@{n}_ + PHG@{n}_ * IHG@{n}_;
    GGIplagqlag@{n}_ = GGI@{n}_ / gB_;
    GGIplag@{n}_ = PKG@{n}_ / (gB_ / gKG_) * IKG@{n}_ + PHG@{n}_ / (gB_ / gHG_) * IHG@{n}_;
    GGIqlag@{n}_ = PKG@{n}_ * IKG@{n}_ / gKG_ + PHG@{n}_ * IHG@{n}_ / gHG_;
    GGIInflation@{n}_ = log( ( GGI@{n}_ / GGIplag@{n}_ * GGIqlag@{n}_ / GGIplagqlag@{n}_ ) ^ ( 1 / 2 ) );

%GDI (gross domestic investment) and deflator
    GDI@{n}_ = GGI@{n}_ + PDI@{n}_;
    GDIplagqlag@{n}_ = GGIplagqlag@{n}_ + PDIplagqlag@{n}_;
    GDIplag@{n}_ = GGIplag@{n}_ + PDIplag@{n}_;
    GDIqlag@{n}_ = GGIqlag@{n}_ + PDIqlag@{n}_;
    GDIInflation@{n}_ = log( ( GDI@{n}_ / GDIplag@{n}_ * GDIqlag@{n}_ / GDIplagqlag@{n}_ ) ^ ( 1 / 2 ) );

%GERD (Gross domestic expenditure on R&D, or R&D intensity)
	GERD@{n}_ = ( PHG@{n}_ * IHG@{n}_ + YWC@{n}_ * PWC_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_ ) / GDP@{n}_;

%Export and deflator
    Export@{n}_ = ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ * PT@{n}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ * PW@{n}_ ...
		@#endif
	@#endfor
    ;
    Exportplagqlag@{n}_ = Export@{n}_ / gB_;
    Exportplag@{n}_ = ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ / gPS_ ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ * PT@{n}_ / gPS_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ * PW@{n}_ / gPS_ ...
		@#endif
	@#endfor
    ;
    Exportqlag@{n}_ = ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ / gYS_ ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ / gYS_ * PT@{n}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ / gYS_ * PW@{n}_ ...
		@#endif
	@#endfor
    ;
    ExportInflation@{n}_ = log( ( Export@{n}_ / Exportplag@{n}_ * Exportqlag@{n}_ / Exportplagqlag@{n}_ ) ^ ( 1 / 2 ) );

%Import and deflator
    Import@{n}_ = ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
            + ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ * PT@{m}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ * PW@{m}_ ...
		@#endif
	@#endfor
    ;
    Importplagqlag@{n}_ = Import@{n}_ / gB_;
    Importplag@{n}_ = ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ / gPS_ ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
            + ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ * PT@{m}_ / gPS_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ * PW@{m}_ / gPS_ ...
		@#endif
	@#endfor
    ;
    Importqlag@{n}_ = ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ / gYS_ ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
            + ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ / gYS_ * PT@{m}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ / gYS_ * PW@{m}_ ...
		@#endif
	@#endfor
    ;
    ImportInflation@{n}_ = log( ( Import@{n}_ / Importplag@{n}_ * Importqlag@{n}_ / Importplagqlag@{n}_ ) ^ ( 1 / 2 ) );

%cfc of durable goods stock
    @#for m in Members
        deltaDtilde@{n}@{m}_ = deltaD_;
        Dcfc@{n}@{m}_ = deltaDtilde@{n}@{m}_ * Dtilde@{n}@{m}_ / gD_ * PD@{n}_;
	@#endfor
%cfc of private physical capital stock
    @#for S in Sectors0
        deltaKPtilde@{S}@{n}_ = deltaK_;
        KPcfc@{S}@{n}_ = deltaKPtilde@{S}@{n}_ * KPtilde@{S}@{n}_ / gKP_ * PKP@{n}_;
	@#endfor
%cfc of public physical capital stock
    deltaKGtilde@{n}_ = deltaK_;
    KGcfc@{n}_ = deltaKGtilde@{n}_ * KG@{n}_ / gKG_ * PKG@{n}_;
%cfc of public R&D capital stock
    deltaHGtilde@{n}_ = deltaH_;
    HGcfc@{n}_ = deltaHGtilde@{n}_ * HG@{n}_ / gHG_ * PHG@{n}_;
%cfc
    CFC@{n}_ = Dcfc@{n}l_ * alpha_resid_ + Dcfc@{n}b_ * alpha_resid_ + KPcfcT@{n}_ + KPcfcNT@{n}_ + KPcfcW@{n}_ + KGcfc@{n}_ + HGcfc@{n}_;
    deltaALL@{n}_ = CFC@{n}_ / ( Dtilde@{n}l_ / gD_ * PD@{n}_ * alpha_resid_ + Dtilde@{n}b_ / gD_ * PD@{n}_ * alpha_resid_ ...
                              + KPtildeT@{n}_ / gKP_ * PKP@{n}_ + KPtildeNT@{n}_ / gKP_ * PKP@{n}_ + KPtildeW@{n}_ / gKP_ * PKP@{n}_ ...
                              + KG@{n}_ / gKG_ * PKG@{n}_ + HG@{n}_ / gHG_ * PHG@{n}_ );

%Labour income
    LabourIncome@{n}_ = 0 ...
	@#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
	  + W@{S}@{n}_ * L@{S}@{n}b_ ...
	@#endfor
	@#for S in [ "W", "T", "NT" ]
	  + W@{S}@{n}_ * LS@{S}@{n}b_ ...
	@#endfor
	@#for S in Sectors2
	  + W@{S}@{n}_ * L@{S}@{n}l_ ...
	@#endfor
    @#for S in Sectors0
      + RHP@{S}@{n}_ * HP@{S}@{n}_ ...
	@#endfor
    ;

%HoursWorkedPerCapita
    Log_HoursWorkedPerCapita@{n}_ = log( ( ...
	@#for S in Sectors2
	  + L@{S}@{n}l_ + L@{S}@{n}b_ ...
	@#endfor
    ) / ( N@{n}l_ + N@{n}b_ ) );

%ex post real exchange rate (t-1 to t)
    ExPostR@{n}_ = log( 1 / Q_ ) - GDPInflation@{n}_;

%Spread
    Spread@{n}_ = ( log( 1 / QB@{n}_ ) - log( 1 / Q_ ) );
	
%government revenue
    GovRev@{n}_ = ...
    ( ...
	@#for m in 0:SN
		@#if n == m
			+ 0 ...
		@#else
            + YT@{m}@{n}_ * PT@{n}_ ...
		@#endif
	@#endfor
    ) * iotaTX_ * phiiotaTX ...
    + ( ...
	@#for m in 0:SN
		@#if n == m
			+ 0 ...
		@#else
            + YT@{n}@{m}_ * PT@{m}_ ...
		@#endif
	@#endfor
    ) * iotaTM_ * phiiotaTM ...
    + ( ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
            + YW@{m}@{n}_ * PW@{n}_ ...
		@#endif
	@#endfor
    ) * iotaWX_ * phiiotaWX ...
    + ( ...
	@#for m in 1:SN
		@#if n == m
			+ 0 ...
		@#else
            + YW@{n}@{m}_ * PW@{m}_ ...
		@#endif
	@#endfor
    ) * iotaWM_ * phiiotaWM ...
    + YNT@{n}_ * PNT@{n}_ * tauNT_ * phitauNT + YTC@{n}_ * PTC@{n}_ * tauTC_ * phitauTC ...
    + ID@{n}b_ * PD@{n}_ * tauD_ * phitauD + CND@{n}b_ * PND@{n}_ * tauND_ * phitauND + ID@{n}l_ * PD@{n}_ * tauD_ * phitauD + CND@{n}l_ * PND@{n}_ * tauND_ * phitauND ...
    @#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
      + W@{S}@{n}_ * tauL@{S}@{n}_ * L@{S}@{n}b_ * phitauL ...
    @#endfor
    @#for S in [ "W", "T", "NT" ]
      + W@{S}@{n}_ * tauL@{S}@{n}_ * LS@{S}@{n}b_ * phitauL ...
    @#endfor
    @#for S in Sectors2
      + W@{S}@{n}_ * tauL@{S}@{n}_ * L@{S}@{n}l_ * phitauL ...
    @#endfor
    @#for S in Sectors0
      + RHP@{S}@{n}_ * HP@{S}@{n}_ * tauH@{S}_ * phitauH@{S} ...
      + KU@{S}@{n}_ * RKP@{S}@{n}_ * KP@{S}@{n}_ * tauK@{S}_ * phitauK@{S} ...
      + PscriptX@{n}_ * scriptX@{S}@{n}_ * tauscriptX@{S}_ * phitauscriptX@{S} ...
    @#endfor
    + ( taub_ + taul_ ) * Y@{n}_ * P@{n}_;
@#endfor

%%
ComplexResids = complex(zeros( 28, 1 ));
Resids = zeros( 28 * 2, 1 );
@#for n in 1:1
    ComplexResids( 1 + ( @{n} - 1 ) * 27 ) = PKG@{n}_ * ( 1 - alphaKG ) * IKG@{n}_ / LKG@{n}_ - WK@{n}_;
    ComplexResids( 2 + ( @{n} - 1 ) * 27 ) = PHG@{n}_ * ( 1 - alphaHG ) * IHG@{n}_ / LHG@{n}_ - WH@{n}_;
    ComplexResids( 3 + ( @{n} - 1 ) * 27 ) = PCG@{n}_ * ( 1 - alphaCG ) * CG@{n}_ / LCG@{n}_ - WNDCG@{n}_;

    ComplexResids( 4 + ( @{n} - 1 ) * 27 ) = KW@{n}_ - PKLW@{n}_ * YKLW@{n}_ * alphaKL * PKLTempW@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / RKW@{n}_;
    ComplexResids( 5 + ( @{n} - 1 ) * 27 ) = KT@{n}_ - PKLT@{n}_ * YKLT@{n}_ * alphaKL * PKLTempT@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / RKT@{n}_ ;
    ComplexResids( 6 + ( @{n} - 1 ) * 27 ) = KNT@{n}_ - PKLNT@{n}_ * YKLNT@{n}_ * alphaKL * PKLTempNT@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / RKNT@{n}_;
    ComplexResids( 7 + ( @{n} - 1 ) * 27 ) = LW@{n}_ - PKLW@{n}_ * YKLW@{n}_ * ( 1 - alphaKL * PKLTempW@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) ) / WW@{n}_;
    ComplexResids( 8 + ( @{n} - 1 ) * 27 ) = LT@{n}_ - PKLT@{n}_ * YKLT@{n}_ * ( 1 - alphaKL * PKLTempT@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) ) / WT@{n}_;
    ComplexResids( 9 + ( @{n} - 1 ) * 27 ) = LNT@{n}_ - PKLNT@{n}_ * YKLNT@{n}_ * ( 1 - alphaKL * PKLTempNT@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) ) / WNT@{n}_;
    ComplexResids( 10 + ( @{n} - 1 ) * 27 ) = LSW@{n}_ - PHLW@{n}_ * YHLW@{n}_ * ( 1 - alphaHL ) / WSW@{n}_;
    ComplexResids( 11 + ( @{n} - 1 ) * 27 ) = LST@{n}_ - PHLT@{n}_ * YHLT@{n}_ * ( 1 - alphaHL ) / WST@{n}_;
    ComplexResids( 12 + ( @{n} - 1 ) * 27 ) = LSNT@{n}_ - PHLNT@{n}_ * YHLNT@{n}_ * ( 1 - alphaHL ) / WSNT@{n}_;
    ComplexResids( 13 + ( @{n} - 1 ) * 27 ) = IKP@{n}_ - IKPT@{n}_ - IKPNT@{n}_ - IKPW@{n}_;
    ComplexResids( 14 + ( @{n} - 1 ) * 27 ) = IHP@{n}_ - IHPT@{n}_ - IHPNT@{n}_ - IHPW@{n}_;

    ComplexResids( 15 + ( @{n} - 1 ) * 27 ) = lambda_B@{n}l_ * PD@{n}_ * ( 1 + tauD_ ) * thetaDU0 * DU@{n}l_ ^ ( thetaDU1 + 1 ) + lambda_CD@{n}l_ * alphah * CD@{n}l_ / D@{n}l_ * gD_;
    ComplexResids( 16 + ( @{n} - 1 ) * 27 ) = lambda_B@{n}b_ * PD@{n}_ * ( 1 + tauD_ ) * thetaDU0 * DU@{n}b_ ^ ( thetaDU1 + 1 ) + lambda_CD@{n}b_ * alphah * CD@{n}b_ / D@{n}b_ * gD_;

    ComplexResids( 17 + ( @{n} - 1 ) * 27 ) = - lambda_CP@{n}l_ * OmegaCP_ * ( CDBar@{n}l_ / gCDBar_ ) ^ ( alphaCD * ( eCP - 1 ) / eCP ) * ( 1 - alphaCD ) * ( CP@{n}l_ / CND@{n}l_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar@{n}l_ * CD@{n}l_ ^ ( 1 - varrhoCD ) * ( CDBar@{n}l_ / gCDBar_ ) ^ varrhoCD * ( varrhoCD - 1 ) * CND@{n}l_ ^ ( varrhoCD - 2 ) - lambda_B@{n}l_ * PND@{n}_ * ( 1 + tauND_ );
    ComplexResids( 18 + ( @{n} - 1 ) * 27 ) = - lambda_CP@{n}b_ * OmegaCP_ * ( CDBar@{n}b_ / gCDBar_ ) ^ ( alphaCD * ( eCP - 1 ) / eCP ) * ( 1 - alphaCD ) * ( CP@{n}b_ / CND@{n}b_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar@{n}b_ * CD@{n}b_ ^ ( 1 - varrhoCD ) * ( CDBar@{n}b_ / gCDBar_ ) ^ varrhoCD * ( varrhoCD - 1 ) * CND@{n}b_ ^ ( varrhoCD - 2 ) - lambda_B@{n}b_ * PND@{n}_ * ( 1 + tauND_ );

    ComplexResids( 19 + ( @{n} - 1 ) * 27 ) = - lambda_CP@{n}l_ * OmegaCP_ * ( CDBar@{n}l_ / gCDBar_ ) ^ ( ( alphaCD - 1 ) * ( eCP - 1 ) / eCP ) * alphaCD * ( CP@{n}l_ / CD@{n}l_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar@{n}l_ * CND@{n}l_ ^ ( varrhoCD - 1 ) * ( CDBar@{n}l_ / gCDBar_ ) ^ varrhoCD * ( 1 - varrhoCD ) * CD@{n}l_ ^ ( -varrhoCD ) + lambda_CD@{n}l_;
    ComplexResids( 20 + ( @{n} - 1 ) * 27 ) = - lambda_CP@{n}b_ * OmegaCP_ * ( CDBar@{n}b_ / gCDBar_ ) ^ ( ( alphaCD - 1 ) * ( eCP - 1 ) / eCP ) * alphaCD * ( CP@{n}b_ / CD@{n}b_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar@{n}b_ * CND@{n}b_ ^ ( varrhoCD - 1 ) * ( CDBar@{n}b_ / gCDBar_ ) ^ varrhoCD * ( 1 - varrhoCD ) * CD@{n}b_ ^ ( -varrhoCD ) + lambda_CD@{n}b_;

    ComplexResids( 21 + ( @{n} - 1 ) * 27 ) = - ID@{n}b_ * PD@{n}_ * ( 1 + tauD_ ) - CND@{n}b_ * PND@{n}_ * ( 1 + tauND_ ) ...
										- B@{n}_ / ( GN_ * GAs_ ^ a_ ) + Q_ * B@{n}_ ...
                                        - taub_ * Y@{n}_ * P@{n}_ ...
										@#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
											+ W@{S}@{n}_ * ( 1 - tauL@{S}@{n}_ ) * L@{S}@{n}b_ ...
										@#endfor
										@#for S in [ "W", "T", "NT" ]
											+ W@{S}@{n}_ * ( 1 - tauL@{S}@{n}_ ) * LS@{S}@{n}b_ ...
										@#endfor
										;

    ComplexResids( 22 + ( @{n} - 1 ) * 27 ) = 	( PX@{n}_ + PWC_ ) * ( YWC@{n}_ + FWC@{n}_ ) * ( 1 - alphaHW ) / PWP@{n}_ - YWP@{n}_; 

    ComplexResids( 23 + ( @{n} - 1 ) * 27 ) = 	scriptX@{n}_...
                                        @#for S in Sectors0
                                          - scriptX@{S}@{n}_...
                                        @#endfor
                                        ;
    ComplexResids( 24 + ( @{n} - 1 ) * 27 ) = 	LKG@{n}_ - (LK@{n}b_ + LK@{n}l_ - LKP@{n}_);
    ComplexResids( 25 + ( @{n} - 1 ) * 27 ) = 	LHG@{n}_ - (LH@{n}b_ + LH@{n}l_ - LHP@{n}_);
	ComplexResids( 26 + ( @{n} - 1 ) * 27 ) =   LNDCG@{n}_ - LND@{n}_ - LCG@{n}_;
	ComplexResids( 27 + ( @{n} - 1 ) * 27 ) =   Y@{n}_ * ( 1 - tauCG_ * alphaCG - tauKG_ * alphaKG - tauHG_ * alphaHG ) - YD@{n}_ - YND@{n}_ - YHP@{n}_ - YKP@{n}_;
@#endfor

@#for n in 2:SN
%    ComplexResids( 27 * SN + @{n} - 1 ) = Xi1_-Xi@{n}_;
@#endfor

ComplexResids( 28 ) = scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ + X_ * PWC_ ^ ( - ( 1 + lambda ) / lambda ) * ( ( 1 - scripts_ ) * ( AN_ / GAs_ ) ^ ( 1 / lambda ) * ( 1 / ( 1 + eta * lambda ) ) ^ ( ( 1 + lambda ) / lambda ) + scripts_ * ( 1 / ( 1 + muP_ ) ) ^ ( ( 1 + lambda ) / lambda ) ) - YWC_;	
Resids(1:28)=real(ComplexResids);
Resids(28+1:28*2)=imag(ComplexResids);
end

 @#for n in 1:1
% 	ComplexResids( 1 + ( @{n} - 1 ) * 27 ) = log(PKG@{n}_) + log( 1 - alphaKG ) + log(IKG@{n}_)  - log(WK@{n}_) - log(LKG@{n}_);
% 	ComplexResids( 2 + ( @{n} - 1 ) * 27 ) = log(PHG@{n}_) + log( 1 - alphaHG ) + log(IHG@{n}_)  - log(WH@{n}_) - log(LHG@{n}_);
% 	ComplexResids( 3 + ( @{n} - 1 ) * 27 ) = log(PCG@{n}_) + log( 1 - alphaCG ) + log(CG@{n}_)   - log(WNDCG@{n}_) - log(LCG@{n}_);
% 	
% 	ComplexResids( 4 + ( @{n} - 1 ) * 27 ) = log(KW@{n}_) + log(RKW@{n}_) - log(PKLW@{n}_) - log(YKLW@{n}_) - log(alphaKL) - log(PKLTempW@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ));
% 	ComplexResids( 5 + ( @{n} - 1 ) * 27 ) = log(KT@{n}_) + log(RKT@{n}_) - log(PKLT@{n}_) - log(YKLT@{n}_) - log(alphaKL) - log(PKLTempT@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ));
% 	ComplexResids( 6 + ( @{n} - 1 ) * 27 ) = log(KNT@{n}_) + log(RKNT@{n}_) - log(PKLNT@{n}_) - log(YKLNT@{n}_) - log(alphaKL) - log(PKLTempNT@{n}_/ ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ));
%   ComplexResids( 7 + ( @{n} - 1 ) * 27 ) = log(LW@{n}_) + log(WW@{n}_) - log(PKLW@{n}_) - log(YKLW@{n}_) - log( 1 - alphaKL * PKLTempW@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) );
%   ComplexResids( 8 + ( @{n} - 1 ) * 27 ) = log(LT@{n}_) + log(WT@{n}_) - log(PKLT@{n}_) - log(YKLT@{n}_) - log( 1 - alphaKL * PKLTempT@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) );
%   ComplexResids( 9 + ( @{n} - 1 ) * 27 ) = log(LNT@{n}_) + log(WNT@{n}_) - log(PKLNT@{n}_) - log(YKLNT@{n}_) - log( 1 - alphaKL * PKLTempNT@{n}_ / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) );
%   ComplexResids( 10 + ( @{n} - 1 ) * 27 ) = log(LSW@{n}_) + log(WSW@{n}_) - log(PHLW@{n}_) - log(YHLW@{n}_) - log( 1 - alphaHL );
%   ComplexResids( 11 + ( @{n} - 1 ) * 27 ) = log(LST@{n}_) + log(WST@{n}_) - log(PHLT@{n}_) - log(YHLT@{n}_) - log( 1 - alphaHL );
%   ComplexResids( 12 + ( @{n} - 1 ) * 27 ) = log(LSNT@{n}_) + log(WSNT@{n}_) - log(PHLNT@{n}_) - log(YHLNT@{n}_) - log( 1 - alphaHL );
%   ComplexResids( 13 + ( @{n} - 1 ) * 27 ) = log(IKP@{n}_) - log(IKPT@{n}_ + IKPNT@{n}_ + IKPW@{n}_);
%   ComplexResids( 14 + ( @{n} - 1 ) * 27 ) = log(IHP@{n}_) - log(IHPT@{n}_ + IHPNT@{n}_ + IHPW@{n}_);
% 	
%   ComplexResids( 15 + ( @{n} - 1 ) * 27 ) = log(lambda_B@{n}l_ * PD@{n}_ * ( 1 + tauD_ ) * thetaDU0 * DU@{n}l_ ^ ( thetaDU1 + 1 )) - log(-lambda_CD@{n}l_ * alphah * CD@{n}l_ / D@{n}l_ * gD_);
%   ComplexResids( 16 + ( @{n} - 1 ) * 27 ) = log(lambda_B@{n}b_ * PD@{n}_ * ( 1 + tauD_ ) * thetaDU0 * DU@{n}b_ ^ ( thetaDU1 + 1 )) - log(-lambda_CD@{n}b_ * alphah * CD@{n}b_ / D@{n}b_ * gD_);
% 
%   ComplexResids( 17 + ( @{n} - 1 ) * 27 ) = log(- lambda_CP@{n}l_ * OmegaCP_ * ( CDBar@{n}l_ / gCDBar_ ) ^ ( alphaCD * ( eCP - 1 ) / eCP ) * ( 1 - alphaCD ) * ( CP@{n}l_ / CND@{n}l_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar@{n}l_ * CD@{n}l_ ^ ( 1 - varrhoCD ) * ( CDBar@{n}l_ / gCDBar_ ) ^ varrhoCD * ( varrhoCD - 1 ) * CND@{n}l_ ^ ( varrhoCD - 2 )) - log(lambda_B@{n}l_ * PND@{n}_ * ( 1 + tauND_ ));
%   ComplexResids( 18 + ( @{n} - 1 ) * 27 ) = log(- lambda_CP@{n}b_ * OmegaCP_ * ( CDBar@{n}b_ / gCDBar_ ) ^ ( alphaCD * ( eCP - 1 ) / eCP ) * ( 1 - alphaCD ) * ( CP@{n}b_ / CND@{n}b_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar@{n}b_ * CD@{n}b_ ^ ( 1 - varrhoCD ) * ( CDBar@{n}b_ / gCDBar_ ) ^ varrhoCD * ( varrhoCD - 1 ) * CND@{n}b_ ^ ( varrhoCD - 2 )) - log(lambda_B@{n}b_ * PND@{n}_ * ( 1 + tauND_ ));
% 
%   ComplexResids( 19 + ( @{n} - 1 ) * 27 ) = log(- lambda_CP@{n}l_ * OmegaCP_ * ( CDBar@{n}l_ / gCDBar_ ) ^ ( ( alphaCD - 1 ) * ( eCP - 1 ) / eCP ) * alphaCD * ( CP@{n}l_ / CD@{n}l_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar@{n}l_ * CND@{n}l_ ^ ( varrhoCD - 1 ) * ( CDBar@{n}l_ / gCDBar_ ) ^ varrhoCD * ( 1 - varrhoCD ) * CD@{n}l_ ^ ( -varrhoCD )) - log(-lambda_CD@{n}l_);
%   ComplexResids( 20 + ( @{n} - 1 ) * 27 ) = log(- lambda_CP@{n}b_ * OmegaCP_ * ( CDBar@{n}b_ / gCDBar_ ) ^ ( ( alphaCD - 1 ) * ( eCP - 1 ) / eCP ) * alphaCD * ( CP@{n}b_ / CD@{n}b_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar@{n}b_ * CND@{n}b_ ^ ( varrhoCD - 1 ) * ( CDBar@{n}b_ / gCDBar_ ) ^ varrhoCD * ( 1 - varrhoCD ) * CD@{n}b_ ^ ( -varrhoCD )) - log(-lambda_CD@{n}b_);
% 
% 	ComplexResids( 21 + ( @{n} - 1 ) * 27 ) = log (Q_ * B@{n}_ ...
 										@#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
% 											+ W@{S}@{n}_ * ( 1 - tauL@{S}@{n}_ ) * L@{S}@{n}b_ ...
 										@#endfor
 										@#for S in [ "W", "T", "NT" ]
% 											+ W@{S}@{n}_ * ( 1 - tauL@{S}@{n}_ ) * LS@{S}@{n}b_ ...
 										@#endfor
%                                         ) - log( ID@{n}b_ * PD@{n}_ * ( 1 + tauD_ ) + CND@{n}b_ * PND@{n}_ * ( 1 + tauND_ ) ...
% 										+ B@{n}_ / ( GN_ * GAs_ ^ a_ ) ...
%                                         + taub_ * Y@{n}_ * P@{n}_);
% 
%     ComplexResids( 22 + ( @{n} - 1 ) * 27 ) = 	log(( PX@{n}_ + PWC_ ) * ( YWC@{n}_ + FWC@{n}_ )) + log( 1 - alphaHW ) - log(YWP@{n}_) - log(PWP@{n}_); 										
% 
%     ComplexResids( 23 + ( @{n} - 1 ) * 27 ) = 	log(scriptX@{n}_) - log(...
                                         @#for S in Sectors0
%                                           + scriptX@{S}@{n}_...
                                         @#endfor
%                                         );
% 	ComplexResids( 24 + ( @{n} - 1 ) * 27 ) = 	log(LKG@{n}_ + LKP@{n}_) - log(LK@{n}b_ + LK@{n}l_);
%   ComplexResids( 25 + ( @{n} - 1 ) * 27 ) = 	log(LHG@{n}_ + LHP@{n}_) - log(LH@{n}b_ + LH@{n}l_);
%	ComplexResids( 26 + ( @{n} - 1 ) * 27 ) =   log(LNDCG@{n}_) - log( LND@{n}_ + LCG@{n}_);
%	ComplexResids( 27 + ( @{n} - 1 ) * 27 ) =   log(Y@{n}_ * ( 1 - tauCG_ * alphaCG - tauKG_ * alphaKG - tauHG_ * alphaHG )) - log(YD@{n}_ + YND@{n}_ + YHP@{n}_ + YKP@{n}_);
 @#endfor
% 
 @#for n in 2:SN
%% 	ComplexResids( 27 * SN + @{n} - 1 ) = log(Xi1_)-log(Xi@{n}_);
 @#endfor
% 
% ComplexResids( 28 ) = log(scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ + X_ * PWC_ ^ ( - ( 1 + lambda ) / lambda ) * ( ( 1 - scripts_ ) * ( AN_ / GAs_ ) ^ ( 1 / lambda ) * ( 1 / ( 1 + eta * lambda ) ) ^ ( ( 1 + lambda ) / lambda ) + scripts_ * ( 1 / ( 1 + muP_ ) ) ^ ( ( 1 + lambda ) / lambda ) )) - log(YWC_);
% Resids(1:28)=real(ComplexResids);
% Resids(28+1:28*2)=imag(ComplexResids);
% end