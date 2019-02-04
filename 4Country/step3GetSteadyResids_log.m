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
		SOC] = step3GetSteadyResids_log( InVec, lambda, eta, phiR, zetaR, gamma, scriptp, scriptq, ...
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
deltaKPT_, deltaHPT_, deltaKPNT_, deltaHPNT_, deltaKPW_, deltaHPW_, deltaKG_, deltaHG_, betabarb, ...
pT0, yTC0, m_, varpi_, eT0_, Ntilde1_, Ntilde2_, Ntilde3_, Ntilde4_)

%this file also serves as the base of steady_state_model in .mod, we need to make the following changes
%  1.delete ...
%  2.replace SN properly
%  3.delete neg_check
%  4.delete getjp, SOC, and all relevant to fzero
%  5.add any parameters that are equations of other parameters









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
	LW2l_ =      LW1l_      /Ntilde1_*Ntilde2_;
    LT2l_ =      LT1l_      /Ntilde1_*Ntilde2_;

    LSW2l_ =     LSW1l_     /Ntilde1_*Ntilde2_;
    LST2l_ =     LST1l_     /Ntilde1_*Ntilde2_;

    LNDCG2l_ =   LNDCG1l_   /Ntilde1_*Ntilde2_;

    CD2l_ =      CD1l_      /Ntilde1_*Ntilde2_;
    CND2l_ =     CND1l_     /Ntilde1_*Ntilde2_;



    CND2b_ =     CND1b_     /Ntilde1_*Ntilde2_;
	LKP2_ =      LKP1_      /Ntilde1_*Ntilde2_;
	LHP2_ =      LHP1_      /Ntilde1_*Ntilde2_;
	LND2_ =      LND1_      /Ntilde1_*Ntilde2_;
	LCG2_ =      LCG1_      /Ntilde1_*Ntilde2_;
	LKG2_ =      LKG1_      /Ntilde1_*Ntilde2_;
	LHG2_ =      LHG1_      /Ntilde1_*Ntilde2_;
	KPT2_ =      KPT1_      /Ntilde1_*Ntilde2_;

	KPW2_ =      KPW1_      /Ntilde1_*Ntilde2_;
	IKP2_ =      IKP1_      /Ntilde1_*Ntilde2_;
    IHP2_ =      IHP1_      /Ntilde1_*Ntilde2_;
    P2_ =        P1_        ;
	YWC2_ =      YWC1_      /Ntilde1_*Ntilde2_;
	X2_ =        X1_        /Ntilde1_*Ntilde2_;
	LW3l_ =      LW1l_      /Ntilde1_*Ntilde3_;
    LT3l_ =      LT1l_      /Ntilde1_*Ntilde3_;

    LSW3l_ =     LSW1l_     /Ntilde1_*Ntilde3_;
    LST3l_ =     LST1l_     /Ntilde1_*Ntilde3_;

    LNDCG3l_ =   LNDCG1l_   /Ntilde1_*Ntilde3_;

    CD3l_ =      CD1l_      /Ntilde1_*Ntilde3_;
    CND3l_ =     CND1l_     /Ntilde1_*Ntilde3_;



    CND3b_ =     CND1b_     /Ntilde1_*Ntilde3_;
	LKP3_ =      LKP1_      /Ntilde1_*Ntilde3_;
	LHP3_ =      LHP1_      /Ntilde1_*Ntilde3_;
	LND3_ =      LND1_      /Ntilde1_*Ntilde3_;
	LCG3_ =      LCG1_      /Ntilde1_*Ntilde3_;
	LKG3_ =      LKG1_      /Ntilde1_*Ntilde3_;
	LHG3_ =      LHG1_      /Ntilde1_*Ntilde3_;
	KPT3_ =      KPT1_      /Ntilde1_*Ntilde3_;

	KPW3_ =      KPW1_      /Ntilde1_*Ntilde3_;
	IKP3_ =      IKP1_      /Ntilde1_*Ntilde3_;
    IHP3_ =      IHP1_      /Ntilde1_*Ntilde3_;
    P3_ =        P1_        ;
	YWC3_ =      YWC1_      /Ntilde1_*Ntilde3_;
	X3_ =        X1_        /Ntilde1_*Ntilde3_;
	LW4l_ =      LW1l_      /Ntilde1_*Ntilde4_;
    LT4l_ =      LT1l_      /Ntilde1_*Ntilde4_;

    LSW4l_ =     LSW1l_     /Ntilde1_*Ntilde4_;
    LST4l_ =     LST1l_     /Ntilde1_*Ntilde4_;

    LNDCG4l_ =   LNDCG1l_   /Ntilde1_*Ntilde4_;

    CD4l_ =      CD1l_      /Ntilde1_*Ntilde4_;
    CND4l_ =     CND1l_     /Ntilde1_*Ntilde4_;



    CND4b_ =     CND1b_     /Ntilde1_*Ntilde4_;
	LKP4_ =      LKP1_      /Ntilde1_*Ntilde4_;
	LHP4_ =      LHP1_      /Ntilde1_*Ntilde4_;
	LND4_ =      LND1_      /Ntilde1_*Ntilde4_;
	LCG4_ =      LCG1_      /Ntilde1_*Ntilde4_;
	LKG4_ =      LKG1_      /Ntilde1_*Ntilde4_;
	LHG4_ =      LHG1_      /Ntilde1_*Ntilde4_;
	KPT4_ =      KPT1_      /Ntilde1_*Ntilde4_;

	KPW4_ =      KPW1_      /Ntilde1_*Ntilde4_;
	IKP4_ =      IKP1_      /Ntilde1_*Ntilde4_;
    IHP4_ =      IHP1_      /Ntilde1_*Ntilde4_;
    P4_ =        P1_        ;
	YWC4_ =      YWC1_      /Ntilde1_*Ntilde4_;
	X4_ =        X1_        /Ntilde1_*Ntilde4_;

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
	CND1_ = CND1b_ + CND1l_;
	LNDCG1_ = LNDCG1b_ + LNDCG1l_;
	N1b_ = 100*Ntilde1_ * varpi_;
	N1l_ = 100*Ntilde1_ * (1-varpi_);
	N1_ = N1b_ + N1l_;
	CND2_ = CND2b_ + CND2l_;

	N2b_ = 100*Ntilde2_ * varpi_;
	N2l_ = 100*Ntilde2_ * (1-varpi_);
	N2_ = N2b_ + N2l_;
	CND3_ = CND3b_ + CND3l_;

	N3b_ = 100*Ntilde3_ * varpi_;
	N3l_ = 100*Ntilde3_ * (1-varpi_);
	N3_ = N3b_ + N3l_;
	CND4_ = CND4b_ + CND4l_;

	N4b_ = 100*Ntilde4_ * varpi_;
	N4l_ = 100*Ntilde4_ * (1-varpi_);
	N4_ = N4b_ + N4l_;

NN_ = 0	...
		+ N1_ ...
		+ N2_ ...
		+ N3_ ...
		+ N4_ ...
	;

N0_ = 100 - NN_;

X_ = 0 ...
	+ X1_ ...
	+ X2_ ...
	+ X3_ ...
	+ X4_ ...
;
YWC_ = 0 ...
	+ YWC1_ ...
	+ YWC2_ ...
	+ YWC3_ ...
	+ YWC4_ ...
;


%a few equations from the production of IND and CG, in order to get beta first.
%also the production of public goods
    Y1_ = OmegaY_ *Ntilde1_ /Ntilde1_;
    YND1_ = ( CND1_ / OmegaND_ / LND1_ ^ ( 1 - alphaND ) ) ^ ( 1 / alphaND );
    PND1_DIVIDEDP1_ = YND1_ / CND1_ / alphaND;
	PND1_ = PND1_DIVIDEDP1_ * P1_;
    beta1b_ = betabarb - bbeta * log( CND1_ * PND1_DIVIDEDP1_ / Y1_ );
	beta1l_ = betabarl - bbeta * log( CND1_ * PND1_DIVIDEDP1_ / Y1_ );
	
	YCG1_ = tauCG_ * alphaCG * Y1_;
	CG1_ = OmegaCG_ * YCG1_ ^ alphaCG * LCG1_ ^ ( 1 - alphaCG );
	PCG1_ = P1_ * YCG1_ / alphaCG / CG1_;
    Y2_ = OmegaY_ *Ntilde2_ /Ntilde1_;
    YND2_ = ( CND2_ / OmegaND_ / LND2_ ^ ( 1 - alphaND ) ) ^ ( 1 / alphaND );
    PND2_DIVIDEDP2_ = YND2_ / CND2_ / alphaND;
	PND2_ = PND2_DIVIDEDP2_ * P2_;

	beta2l_ = betabarl - bbeta * log( CND2_ * PND2_DIVIDEDP2_ / Y2_ );
	
	YCG2_ = tauCG_ * alphaCG * Y2_;
	CG2_ = OmegaCG_ * YCG2_ ^ alphaCG * LCG2_ ^ ( 1 - alphaCG );

    Y3_ = OmegaY_ *Ntilde3_ /Ntilde1_;
    YND3_ = ( CND3_ / OmegaND_ / LND3_ ^ ( 1 - alphaND ) ) ^ ( 1 / alphaND );
    PND3_DIVIDEDP3_ = YND3_ / CND3_ / alphaND;
	PND3_ = PND3_DIVIDEDP3_ * P3_;

	beta3l_ = betabarl - bbeta * log( CND3_ * PND3_DIVIDEDP3_ / Y3_ );
	
	YCG3_ = tauCG_ * alphaCG * Y3_;
	CG3_ = OmegaCG_ * YCG3_ ^ alphaCG * LCG3_ ^ ( 1 - alphaCG );

    Y4_ = OmegaY_ *Ntilde4_ /Ntilde1_;
    YND4_ = ( CND4_ / OmegaND_ / LND4_ ^ ( 1 - alphaND ) ) ^ ( 1 / alphaND );
    PND4_DIVIDEDP4_ = YND4_ / CND4_ / alphaND;
	PND4_ = PND4_DIVIDEDP4_ * P4_;

	beta4l_ = betabarl - bbeta * log( CND4_ * PND4_DIVIDEDP4_ / Y4_ );
	
	YCG4_ = tauCG_ * alphaCG * Y4_;
	CG4_ = OmegaCG_ * YCG4_ ^ alphaCG * LCG4_ ^ ( 1 - alphaCG );


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



gYS_ = GN_ * GAs_ ^ d_;
gPS_ = GN_ * GAs_ ^ a_ / gYS_;


gKP_ = GN_ * GAs_ ^ ( d_ * alphaKP );
gHP_ = GN_ * GAs_ ^ ( d_ * alphaHP );


gKG_ = GN_ * GAs_ ^ ( d_ * alphaKG );
gHG_ = GN_ * GAs_ ^ ( d_ * alphaHG );
gYHL_ = GN_ * GAs_ ^ ( d_ * alphaHP * alphaHL );

gK_ = gKG_ ^ alphaK * gKP_ ^ ( 1 - alphaK );

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

glambda_B_ = glambda_CP_ * GAs_ ^ ( alphaCD * ( d_ * alphaD * alphah - d_ * alphaND ) - a_ + d_ * alphaND );
glambda_GD_ = glambda_CP_ * GAs_ ^ ( alphaCD * ( d_ * alphaD * alphah - d_ * alphaND ) + d_ * alphaND - d_ * alphaD );
glambda_D_ = glambda_GD_;
glambda_GK_ = glambda_CP_ * GAs_ ^ ( alphaCD * ( d_ * alphaD * alphah - d_ * alphaND ) + d_ * alphaND - d_ * alphaKP );
glambda_K_ = glambda_GK_;
glambda_GH_ = glambda_CP_ * GAs_ ^ ( alphaCD * ( d_ * alphaD * alphah - d_ * alphaND ) + d_ * alphaND - d_ * alphaHP );
glambda_H_ = glambda_GH_;

%%
%Consumption composite
		CDBar1b_ = CD1b_ / CND1b_ * gCDBar_ ^ ( -varrhoCD / ( 1 - varrhoCD ) );
		CP1b_ = N1b_ * OmegaCP_ * ( CDBar1b_ / gCDBar_ ) ^ alphaCD * ( alphaCD * ( CD1b_ / N1b_ / ( CDBar1b_ / gCDBar_ ) ) ^ ( ( eCP - 1 ) / eCP )  +  ( 1 - alphaCD ) * ( CND1b_ / N1b_ ) ^ ( ( eCP - 1 ) / eCP ) ) ^ ( eCP / ( eCP - 1 ) );
		CPBar1b_ = CP1b_ / CG1_ * ( N1b_ + N1l_ ) / N1b_ * gCPBar_ ^ ( -varrhoCP / ( 1 - varrhoCP ) );
		C1b_ = N1b_ * OmegaC_ * ( CPBar1b_ / gCPBar_ ) ^ alphaCP * ( alphaCP * ( CP1b_ / N1b_ / ( CPBar1b_ / gCPBar_ ) ) ^ ( ( eC - 1 ) / eC )  +  ( 1 - alphaCP ) * ( CG1_ / ( N1b_ + N1l_ ) ) ^ ( ( eC - 1 ) / eC ) ) ^ ( eC / ( eC - 1 ) );
		CBar1b_ = N1b_ * ( C1b_ / N1b_ ) * ( gCBar_ / GN_ ) ^ ( -varrhoC / ( 1 - varrhoC ) );
		CDBar1l_ = CD1l_ / CND1l_ * gCDBar_ ^ ( -varrhoCD / ( 1 - varrhoCD ) );
		CP1l_ = N1l_ * OmegaCP_ * ( CDBar1l_ / gCDBar_ ) ^ alphaCD * ( alphaCD * ( CD1l_ / N1l_ / ( CDBar1l_ / gCDBar_ ) ) ^ ( ( eCP - 1 ) / eCP )  +  ( 1 - alphaCD ) * ( CND1l_ / N1l_ ) ^ ( ( eCP - 1 ) / eCP ) ) ^ ( eCP / ( eCP - 1 ) );
		CPBar1l_ = CP1l_ / CG1_ * ( N1b_ + N1l_ ) / N1l_ * gCPBar_ ^ ( -varrhoCP / ( 1 - varrhoCP ) );
		C1l_ = N1l_ * OmegaC_ * ( CPBar1l_ / gCPBar_ ) ^ alphaCP * ( alphaCP * ( CP1l_ / N1l_ / ( CPBar1l_ / gCPBar_ ) ) ^ ( ( eC - 1 ) / eC )  +  ( 1 - alphaCP ) * ( CG1_ / ( N1b_ + N1l_ ) ) ^ ( ( eC - 1 ) / eC ) ) ^ ( eC / ( eC - 1 ) );
		CBar1l_ = N1l_ * ( C1l_ / N1l_ ) * ( gCBar_ / GN_ ) ^ ( -varrhoC / ( 1 - varrhoC ) );





		CDBar2l_ = CD2l_ / CND2l_ * gCDBar_ ^ ( -varrhoCD / ( 1 - varrhoCD ) );
		CP2l_ = N2l_ * OmegaCP_ * ( CDBar2l_ / gCDBar_ ) ^ alphaCD * ( alphaCD * ( CD2l_ / N2l_ / ( CDBar2l_ / gCDBar_ ) ) ^ ( ( eCP - 1 ) / eCP )  +  ( 1 - alphaCD ) * ( CND2l_ / N2l_ ) ^ ( ( eCP - 1 ) / eCP ) ) ^ ( eCP / ( eCP - 1 ) );
		CPBar2l_ = CP2l_ / CG2_ * ( N2b_ + N2l_ ) / N2l_ * gCPBar_ ^ ( -varrhoCP / ( 1 - varrhoCP ) );
		C2l_ = N2l_ * OmegaC_ * ( CPBar2l_ / gCPBar_ ) ^ alphaCP * ( alphaCP * ( CP2l_ / N2l_ / ( CPBar2l_ / gCPBar_ ) ) ^ ( ( eC - 1 ) / eC )  +  ( 1 - alphaCP ) * ( CG2_ / ( N2b_ + N2l_ ) ) ^ ( ( eC - 1 ) / eC ) ) ^ ( eC / ( eC - 1 ) );
		CBar2l_ = N2l_ * ( C2l_ / N2l_ ) * ( gCBar_ / GN_ ) ^ ( -varrhoC / ( 1 - varrhoC ) );





		CDBar3l_ = CD3l_ / CND3l_ * gCDBar_ ^ ( -varrhoCD / ( 1 - varrhoCD ) );
		CP3l_ = N3l_ * OmegaCP_ * ( CDBar3l_ / gCDBar_ ) ^ alphaCD * ( alphaCD * ( CD3l_ / N3l_ / ( CDBar3l_ / gCDBar_ ) ) ^ ( ( eCP - 1 ) / eCP )  +  ( 1 - alphaCD ) * ( CND3l_ / N3l_ ) ^ ( ( eCP - 1 ) / eCP ) ) ^ ( eCP / ( eCP - 1 ) );
		CPBar3l_ = CP3l_ / CG3_ * ( N3b_ + N3l_ ) / N3l_ * gCPBar_ ^ ( -varrhoCP / ( 1 - varrhoCP ) );
		C3l_ = N3l_ * OmegaC_ * ( CPBar3l_ / gCPBar_ ) ^ alphaCP * ( alphaCP * ( CP3l_ / N3l_ / ( CPBar3l_ / gCPBar_ ) ) ^ ( ( eC - 1 ) / eC )  +  ( 1 - alphaCP ) * ( CG3_ / ( N3b_ + N3l_ ) ) ^ ( ( eC - 1 ) / eC ) ) ^ ( eC / ( eC - 1 ) );
		CBar3l_ = N3l_ * ( C3l_ / N3l_ ) * ( gCBar_ / GN_ ) ^ ( -varrhoC / ( 1 - varrhoC ) );





		CDBar4l_ = CD4l_ / CND4l_ * gCDBar_ ^ ( -varrhoCD / ( 1 - varrhoCD ) );
		CP4l_ = N4l_ * OmegaCP_ * ( CDBar4l_ / gCDBar_ ) ^ alphaCD * ( alphaCD * ( CD4l_ / N4l_ / ( CDBar4l_ / gCDBar_ ) ) ^ ( ( eCP - 1 ) / eCP )  +  ( 1 - alphaCD ) * ( CND4l_ / N4l_ ) ^ ( ( eCP - 1 ) / eCP ) ) ^ ( eCP / ( eCP - 1 ) );
		CPBar4l_ = CP4l_ / CG4_ * ( N4b_ + N4l_ ) / N4l_ * gCPBar_ ^ ( -varrhoCP / ( 1 - varrhoCP ) );
		C4l_ = N4l_ * OmegaC_ * ( CPBar4l_ / gCPBar_ ) ^ alphaCP * ( alphaCP * ( CP4l_ / N4l_ / ( CPBar4l_ / gCPBar_ ) ) ^ ( ( eC - 1 ) / eC )  +  ( 1 - alphaCP ) * ( CG4_ / ( N4b_ + N4l_ ) ) ^ ( ( eC - 1 ) / eC ) ) ^ ( eC / ( eC - 1 ) );
		CBar4l_ = N4l_ * ( C4l_ / N4l_ ) * ( gCBar_ / GN_ ) ^ ( -varrhoC / ( 1 - varrhoC ) );

%STD and 2 engineering equations
	VV1l_=beta1l_ * gV_ ^ -sigma;
	VV1b_=beta1b_ * gV_ ^ -sigma;
    Xi1_ = VV1l_ * glambda_B_;
	VV2l_=beta2l_ * gV_ ^ -sigma;

    Xi2_ = VV2l_ * glambda_B_;
	VV3l_=beta3l_ * gV_ ^ -sigma;

    Xi3_ = VV3l_ * glambda_B_;
	VV4l_=beta4l_ * gV_ ^ -sigma;

    Xi4_ = VV4l_ * glambda_B_;
	Xi_ = Xi1_;
	Q_ = Xi_;

	lambda_F1_DIVIDEDlambda_B1b_ = ( Q_ - VV1b_ * glambda_B_ ) /  ( 1 - VV1b_ * glambda_B_ * rhoQB );






II_ = 1 / JP_ * muP_ / ( 1 + muP_ ) * ( ( 1 + mu_ ) / ( 1 + muP_ ) ) ^ ( 1 / lambda ) * Xi_ * GN_ * GAs_ ^ a_ * X_ * A_ ^ ( - 1 / lambda ) / ( ScriptFRP_ * PWC_ / scriptp ); %zero profit of engineering sector


%phsical/human capital related (KPS4_ PKP4_ IKPS4_ are solved from production side)


		KUT1_ = ( ( 1 - VV1l_ * glambda_K_ * ( 1 - deltaKPT_ ) ) / ( thetaKU0 / gKP_ - VV1l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKPT1_DIVIDEDPKP1_ = thetaKU0 * KUT1_ ^ thetaKU1 / gKP_ / ( 1 - tauKT_ );
		RHPT1_DIVIDEDPHP1_ = ( 1 - VV1l_ * glambda_H_ * ( 1 - deltaHPT_ ) ) / ( 1 - tauHT_ );


		KUNT1_ = ( ( 1 - VV1l_ * glambda_K_ * ( 1 - deltaKPNT_ ) ) / ( thetaKU0 / gKP_ - VV1l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKPNT1_DIVIDEDPKP1_ = thetaKU0 * KUNT1_ ^ thetaKU1 / gKP_ / ( 1 - tauKNT_ );
		RHPNT1_DIVIDEDPHP1_ = ( 1 - VV1l_ * glambda_H_ * ( 1 - deltaHPNT_ ) ) / ( 1 - tauHNT_ );


		KUW1_ = ( ( 1 - VV1l_ * glambda_K_ * ( 1 - deltaKPW_ ) ) / ( thetaKU0 / gKP_ - VV1l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKPW1_DIVIDEDPKP1_ = thetaKU0 * KUW1_ ^ thetaKU1 / gKP_ / ( 1 - tauKW_ );
		RHPW1_DIVIDEDPHP1_ = ( 1 - VV1l_ * glambda_H_ * ( 1 - deltaHPW_ ) ) / ( 1 - tauHW_ );


		KUT2_ = ( ( 1 - VV2l_ * glambda_K_ * ( 1 - deltaKPT_ ) ) / ( thetaKU0 / gKP_ - VV2l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKPT2_DIVIDEDPKP2_ = thetaKU0 * KUT2_ ^ thetaKU1 / gKP_ / ( 1 - tauKT_ );
		RHPT2_DIVIDEDPHP2_ = ( 1 - VV2l_ * glambda_H_ * ( 1 - deltaHPT_ ) ) / ( 1 - tauHT_ );







		KUW2_ = ( ( 1 - VV2l_ * glambda_K_ * ( 1 - deltaKPW_ ) ) / ( thetaKU0 / gKP_ - VV2l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKPW2_DIVIDEDPKP2_ = thetaKU0 * KUW2_ ^ thetaKU1 / gKP_ / ( 1 - tauKW_ );
		RHPW2_DIVIDEDPHP2_ = ( 1 - VV2l_ * glambda_H_ * ( 1 - deltaHPW_ ) ) / ( 1 - tauHW_ );


		KUT3_ = ( ( 1 - VV3l_ * glambda_K_ * ( 1 - deltaKPT_ ) ) / ( thetaKU0 / gKP_ - VV3l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKPT3_DIVIDEDPKP3_ = thetaKU0 * KUT3_ ^ thetaKU1 / gKP_ / ( 1 - tauKT_ );
		RHPT3_DIVIDEDPHP3_ = ( 1 - VV3l_ * glambda_H_ * ( 1 - deltaHPT_ ) ) / ( 1 - tauHT_ );







		KUW3_ = ( ( 1 - VV3l_ * glambda_K_ * ( 1 - deltaKPW_ ) ) / ( thetaKU0 / gKP_ - VV3l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKPW3_DIVIDEDPKP3_ = thetaKU0 * KUW3_ ^ thetaKU1 / gKP_ / ( 1 - tauKW_ );
		RHPW3_DIVIDEDPHP3_ = ( 1 - VV3l_ * glambda_H_ * ( 1 - deltaHPW_ ) ) / ( 1 - tauHW_ );


		KUT4_ = ( ( 1 - VV4l_ * glambda_K_ * ( 1 - deltaKPT_ ) ) / ( thetaKU0 / gKP_ - VV4l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKPT4_DIVIDEDPKP4_ = thetaKU0 * KUT4_ ^ thetaKU1 / gKP_ / ( 1 - tauKT_ );
		RHPT4_DIVIDEDPHP4_ = ( 1 - VV4l_ * glambda_H_ * ( 1 - deltaHPT_ ) ) / ( 1 - tauHT_ );







		KUW4_ = ( ( 1 - VV4l_ * glambda_K_ * ( 1 - deltaKPW_ ) ) / ( thetaKU0 / gKP_ - VV4l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKPW4_DIVIDEDPKP4_ = thetaKU0 * KUW4_ ^ thetaKU1 / gKP_ / ( 1 - tauKW_ );
		RHPW4_DIVIDEDPHP4_ = ( 1 - VV4l_ * glambda_H_ * ( 1 - deltaHPW_ ) ) / ( 1 - tauHW_ );

%Durable stock and home production related


    
    DU1l_ = ( ( 1 - VV1l_ * glambda_D_ * ( 1 - deltaD_ ) ) / ( thetaDU0 / gD_ - VV1l_ * glambda_D_ * thetaDU0 / ( 1+thetaDU1 ) ) ) ^ ( 1 / ( 1+thetaDU1 ) );
    DU1b_ = ( ( 1 - VV1b_ * glambda_D_ * ( 1 - deltaD_ ) - lambda_F1_DIVIDEDlambda_B1b_ * ( 1 - rhoQB ) * m_ / ( 1 + tauD_ ) ) / ( thetaDU0 / gD_ - VV1b_ * glambda_D_ * thetaDU0 / ( 1+thetaDU1 ) ) ) ^ ( 1 / ( 1+thetaDU1 ) );
    
		D1b_ = ( CD1b_ / Lh1b_ ^ ( 1 - alphah ) / Omegah_ ) ^ ( 1 / alphah ) / DU1b_;

		ID1b_ = ( D1b_ - D1b_ / gD_ * ( 1 - deltaD_ - thetaDU0 / ( 1 + thetaDU1 ) * DU1b_ ^ ( 1 + thetaDU1 ) ) );
		D1l_ = ( CD1l_ / Lh1l_ ^ ( 1 - alphah ) / Omegah_ ) ^ ( 1 / alphah ) / DU1l_;

		ID1l_ = ( D1l_ - D1l_ / gD_ * ( 1 - deltaD_ - thetaDU0 / ( 1 + thetaDU1 ) * DU1l_ ^ ( 1 + thetaDU1 ) ) );
	
	ID1_ = ID1b_ + ID1l_;


    


    






	



    


    






	



    


    






	


%production of specialized goods and labor supply
%ND in 1
    WNDCG1_ = PND1_ * ( 1 - alphaND ) * CND1_ / LND1_;
	tauLNDCG1_ = tauLa_ + tauLb_ * log( WNDCG1_ );
		V1b_DIVIDEDU1b_ = ( ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) / ( 1 - beta1b_ * gV_ ^ ( 1 - sigma ) ) ) ^ ( 1 / ( 1 - sigma ) );
		lambda_B1b_ = ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaNDCG_ * ( LNDCG1b_ / N1b_ ) ^ nuNDCG * CBar1b_ / N1b_ / ( gCBar_ / GN_ ) / WNDCG1_ / ( 1 - tauLNDCG1_ );
		V1l_DIVIDEDU1l_ = ( ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) / ( 1 - beta1l_ * gV_ ^ ( 1 - sigma ) ) ) ^ ( 1 / ( 1 - sigma ) );
		lambda_B1l_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaNDCG_ * ( LNDCG1l_ / N1l_ ) ^ nuNDCG * CBar1l_ / N1l_ / ( gCBar_ / GN_ ) / WNDCG1_ / ( 1 - tauLNDCG1_ );
%D in 1
%	WD1_ = (( ...
%		( 1 - tauLD1_ ) ^ ( 1 / nuD ) * ( ...
%		( lambda_B1l_ / ( V1l_DIVIDEDU1l_ ) ^ sigma / ( 1 - beta1l_ ) / N1l_ ^ ( xi - 1 + sigma ) / ( CBar1l_ / gCBar_ / ( N1l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N1l_ + ...
%		( lambda_B1b_ / ( V1b_DIVIDEDU1b_ ) ^ sigma / ( 1 - beta1b_ ) / N1b_ ^ ( xi - 1 + sigma ) / ( CBar1b_ / gCBar_ / ( N1b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N1b_ ...
%		) * OmegaD_ / ID1_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P1_ ^ alphaD ...
%		) ^ ( -1 / ( alphaD + 1 / nuD ) ));	

	WDini1_ = (( ...
		( 1 - tauLa_ ) ^ ( 1 / nuD ) * ( ...
		( lambda_B1l_ / ( V1l_DIVIDEDU1l_ ) ^ sigma / ( 1 - beta1l_ ) / N1l_ ^ ( xi - 1 + sigma ) / ( CBar1l_ / gCBar_ / ( N1l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N1l_ + ...
		( lambda_B1b_ / ( V1b_DIVIDEDU1b_ ) ^ sigma / ( 1 - beta1b_ ) / N1b_ ^ ( xi - 1 + sigma ) / ( CBar1b_ / gCBar_ / ( N1b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N1b_ ...
		) * OmegaD_ / ID1_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P1_ ^ alphaD ...
		) ^ ( -1 / ( alphaD + 1 / nuD ) ));	
	WDaux1_ = ( ...
		( lambda_B1l_ / ( V1l_DIVIDEDU1l_ ) ^ sigma / ( 1 - beta1l_ ) / N1l_ ^ ( xi - 1 + sigma ) / ( CBar1l_ / gCBar_ / ( N1l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N1l_ + ...
		( lambda_B1b_ / ( V1b_DIVIDEDU1b_ ) ^ sigma / ( 1 - beta1b_ ) / N1b_ ^ ( xi - 1 + sigma ) / ( CBar1b_ / gCBar_ / ( N1b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N1b_ ...
		) * OmegaD_ / ID1_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P1_ ^ alphaD;
	WD1_ = fzero( @(WD1_) real(WD1_ ^ ( -alphaD * nuD - 1 ) - ( 1 - tauLa_ - tauLb_ * log( WD1_ ) ) * WDaux1_ ^ nuD), WDini1_, optimset( 'display', 'off' ) );
	tauLD1_ = tauLa_ + tauLb_ * log( WD1_ );
	
		LD1b_ = (( ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaD_ * CBar1b_ / N1b_ ^ ( 1 + nuD ) / ( gCBar_ / GN_ ) / lambda_B1b_ / ( 1 - tauLD1_ ) / WD1_ ) ^ ( -1 / nuD ));
		LD1l_ = (( ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaD_ * CBar1l_ / N1l_ ^ ( 1 + nuD ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLD1_ ) / WD1_ ) ^ ( -1 / nuD ));
	LD1_ = LD1b_ + LD1l_;
    YD1_ = ( ID1_ / LD1_ ^ ( 1 - alphaD ) / OmegaD_ ) ^ ( 1 / alphaD );
    PD1_ = YD1_ / ID1_ / alphaD * P1_;
	
%H in 1
	WH1_ = ( ( 1 - alphaHP ) / alphaHP ) * ( IHP1_ / LHP1_ / OmegaHP_ ) ^ ( 1 / alphaHP ) * P1_;
	tauLH1_ = tauLa_ + tauLb_ * log( WH1_ );
		LH1b_ = (( ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaH_ * CBar1b_ / N1b_ ^ ( 1 + nuH ) / ( gCBar_ / GN_ ) / lambda_B1b_ / ( 1 - tauLH1_ ) / WH1_ ) ^ ( -1 / nuH ));
		LH1l_ = (( ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaH_ * CBar1l_ / N1l_ ^ ( 1 + nuH ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLH1_ ) / WH1_ ) ^ ( -1 / nuH ));
    YHP1_ = ( IHP1_ / LHP1_ ^ ( 1 - alphaHP ) / OmegaHP_ ) ^ ( 1 / alphaHP );
    PHP1_ = YHP1_ / IHP1_ / alphaHP * P1_;
	
	YHG1_ = tauHG_ * alphaHG * Y1_;
	IHG1_ = OmegaHG_ * YHG1_ ^ alphaHG * LHG1_ ^ ( 1 - alphaHG );
	HG1_ = IHG1_ / ( 1 - ( 1 - deltaHG_ ) / gHG_ );
	PHG1_ = P1_ * YHG1_ / alphaHG / IHG1_;
	
%K in 1
	WK1_ = ( ( 1 - alphaKP ) / alphaKP ) * ( IKP1_ / LKP1_ / OmegaKP_ ) ^ ( 1 / alphaKP ) * P1_;
	tauLK1_ = tauLa_ + tauLb_ * log( WK1_ );
		LK1b_ = (( ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaK_ * CBar1b_ / N1b_ ^ ( 1 + nuK ) / ( gCBar_ / GN_ ) / lambda_B1b_ / ( 1 - tauLK1_ ) / WK1_ ) ^ ( -1 / nuK ));
		LK1l_ = (( ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaK_ * CBar1l_ / N1l_ ^ ( 1 + nuK ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLK1_ ) / WK1_ ) ^ ( -1 / nuK ));
	YKP1_ = ( IKP1_ / LKP1_ ^ ( 1 - alphaKP ) / OmegaKP_ ) ^ ( 1 / alphaKP );
    PKP1_ = YKP1_ / IKP1_ / alphaKP * P1_;
	
	YKG1_ = tauKG_ * alphaKG * Y1_;
	IKG1_ = OmegaKG_ * YKG1_ ^ alphaKG * LKG1_ ^ ( 1 - alphaKG );
	KG1_ = IKG1_ / ( 1 - ( 1 - deltaKG_ ) / gKG_ );
	PKG1_ = P1_ * YKG1_ / alphaKG / IKG1_;
%ND in 2
    WNDCG2_ = PND2_ * ( 1 - alphaND ) * CND2_ / LND2_;
	tauLNDCG2_ = tauLa_ + tauLb_ * log( WNDCG2_ );


		V2l_DIVIDEDU2l_ = ( ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) / ( 1 - beta2l_ * gV_ ^ ( 1 - sigma ) ) ) ^ ( 1 / ( 1 - sigma ) );
		lambda_B2l_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaNDCG_ * ( LNDCG2l_ / N2l_ ) ^ nuNDCG * CBar2l_ / N2l_ / ( gCBar_ / GN_ ) / WNDCG2_ / ( 1 - tauLNDCG2_ );
%D in 2
%	WD2_ = (( ...
%		( 1 - tauLD2_ ) ^ ( 1 / nuD ) * ( ...
%		( lambda_B2l_ / ( V2l_DIVIDEDU2l_ ) ^ sigma / ( 1 - beta2l_ ) / N2l_ ^ ( xi - 1 + sigma ) / ( CBar2l_ / gCBar_ / ( N2l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N2l_ + ...
%		( lambda_B2b_ / ( V2b_DIVIDEDU2b_ ) ^ sigma / ( 1 - beta2b_ ) / N2b_ ^ ( xi - 1 + sigma ) / ( CBar2b_ / gCBar_ / ( N2b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N2b_ ...
%		) * OmegaD_ / ID2_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P2_ ^ alphaD ...
%		) ^ ( -1 / ( alphaD + 1 / nuD ) ));	













	





	
%H in 2




    YHP2_ = ( IHP2_ / LHP2_ ^ ( 1 - alphaHP ) / OmegaHP_ ) ^ ( 1 / alphaHP );
    PHP2_ = YHP2_ / IHP2_ / alphaHP * P2_;
	
	YHG2_ = tauHG_ * alphaHG * Y2_;
	IHG2_ = OmegaHG_ * YHG2_ ^ alphaHG * LHG2_ ^ ( 1 - alphaHG );
	HG2_ = IHG2_ / ( 1 - ( 1 - deltaHG_ ) / gHG_ );

	
%K in 2




	YKP2_ = ( IKP2_ / LKP2_ ^ ( 1 - alphaKP ) / OmegaKP_ ) ^ ( 1 / alphaKP );
    PKP2_ = YKP2_ / IKP2_ / alphaKP * P2_;
	
	YKG2_ = tauKG_ * alphaKG * Y2_;
	IKG2_ = OmegaKG_ * YKG2_ ^ alphaKG * LKG2_ ^ ( 1 - alphaKG );
	KG2_ = IKG2_ / ( 1 - ( 1 - deltaKG_ ) / gKG_ );

%ND in 3
    WNDCG3_ = PND3_ * ( 1 - alphaND ) * CND3_ / LND3_;
	tauLNDCG3_ = tauLa_ + tauLb_ * log( WNDCG3_ );


		V3l_DIVIDEDU3l_ = ( ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) / ( 1 - beta3l_ * gV_ ^ ( 1 - sigma ) ) ) ^ ( 1 / ( 1 - sigma ) );
		lambda_B3l_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaNDCG_ * ( LNDCG3l_ / N3l_ ) ^ nuNDCG * CBar3l_ / N3l_ / ( gCBar_ / GN_ ) / WNDCG3_ / ( 1 - tauLNDCG3_ );
%D in 3
%	WD3_ = (( ...
%		( 1 - tauLD3_ ) ^ ( 1 / nuD ) * ( ...
%		( lambda_B3l_ / ( V3l_DIVIDEDU3l_ ) ^ sigma / ( 1 - beta3l_ ) / N3l_ ^ ( xi - 1 + sigma ) / ( CBar3l_ / gCBar_ / ( N3l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N3l_ + ...
%		( lambda_B3b_ / ( V3b_DIVIDEDU3b_ ) ^ sigma / ( 1 - beta3b_ ) / N3b_ ^ ( xi - 1 + sigma ) / ( CBar3b_ / gCBar_ / ( N3b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N3b_ ...
%		) * OmegaD_ / ID3_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P3_ ^ alphaD ...
%		) ^ ( -1 / ( alphaD + 1 / nuD ) ));	













	





	
%H in 3




    YHP3_ = ( IHP3_ / LHP3_ ^ ( 1 - alphaHP ) / OmegaHP_ ) ^ ( 1 / alphaHP );
    PHP3_ = YHP3_ / IHP3_ / alphaHP * P3_;
	
	YHG3_ = tauHG_ * alphaHG * Y3_;
	IHG3_ = OmegaHG_ * YHG3_ ^ alphaHG * LHG3_ ^ ( 1 - alphaHG );
	HG3_ = IHG3_ / ( 1 - ( 1 - deltaHG_ ) / gHG_ );

	
%K in 3




	YKP3_ = ( IKP3_ / LKP3_ ^ ( 1 - alphaKP ) / OmegaKP_ ) ^ ( 1 / alphaKP );
    PKP3_ = YKP3_ / IKP3_ / alphaKP * P3_;
	
	YKG3_ = tauKG_ * alphaKG * Y3_;
	IKG3_ = OmegaKG_ * YKG3_ ^ alphaKG * LKG3_ ^ ( 1 - alphaKG );
	KG3_ = IKG3_ / ( 1 - ( 1 - deltaKG_ ) / gKG_ );

%ND in 4
    WNDCG4_ = PND4_ * ( 1 - alphaND ) * CND4_ / LND4_;
	tauLNDCG4_ = tauLa_ + tauLb_ * log( WNDCG4_ );


		V4l_DIVIDEDU4l_ = ( ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) / ( 1 - beta4l_ * gV_ ^ ( 1 - sigma ) ) ) ^ ( 1 / ( 1 - sigma ) );
		lambda_B4l_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaNDCG_ * ( LNDCG4l_ / N4l_ ) ^ nuNDCG * CBar4l_ / N4l_ / ( gCBar_ / GN_ ) / WNDCG4_ / ( 1 - tauLNDCG4_ );
%D in 4
%	WD4_ = (( ...
%		( 1 - tauLD4_ ) ^ ( 1 / nuD ) * ( ...
%		( lambda_B4l_ / ( V4l_DIVIDEDU4l_ ) ^ sigma / ( 1 - beta4l_ ) / N4l_ ^ ( xi - 1 + sigma ) / ( CBar4l_ / gCBar_ / ( N4l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N4l_ + ...
%		( lambda_B4b_ / ( V4b_DIVIDEDU4b_ ) ^ sigma / ( 1 - beta4b_ ) / N4b_ ^ ( xi - 1 + sigma ) / ( CBar4b_ / gCBar_ / ( N4b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N4b_ ...
%		) * OmegaD_ / ID4_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P4_ ^ alphaD ...
%		) ^ ( -1 / ( alphaD + 1 / nuD ) ));	













	





	
%H in 4




    YHP4_ = ( IHP4_ / LHP4_ ^ ( 1 - alphaHP ) / OmegaHP_ ) ^ ( 1 / alphaHP );
    PHP4_ = YHP4_ / IHP4_ / alphaHP * P4_;
	
	YHG4_ = tauHG_ * alphaHG * Y4_;
	IHG4_ = OmegaHG_ * YHG4_ ^ alphaHG * LHG4_ ^ ( 1 - alphaHG );
	HG4_ = IHG4_ / ( 1 - ( 1 - deltaHG_ ) / gHG_ );

	
%K in 4




	YKP4_ = ( IKP4_ / LKP4_ ^ ( 1 - alphaKP ) / OmegaKP_ ) ^ ( 1 / alphaKP );
    PKP4_ = YKP4_ / IKP4_ / alphaKP * P4_;
	
	YKG4_ = tauKG_ * alphaKG * Y4_;
	IKG4_ = OmegaKG_ * YKG4_ ^ alphaKG * LKG4_ ^ ( 1 - alphaKG );
	KG4_ = IKG4_ / ( 1 - ( 1 - deltaKG_ ) / gKG_ );


%Labor supply in W/T/NT, SW/ST/SNT, h
		%WW1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW1l_ ^ nuW * CBar1l_ / N1l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLW1_ );
		WWini1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW1l_ ^ nuW * CBar1l_ / N1l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ );
		WW1_ = fzero( @(WW1_) real(WW1_ - ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW1l_ ^ nuW * CBar1l_ / N1l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ - tauLb_ * log( WW1_ ) )), WWini1_, optimset( 'display', 'off' ) );
		tauLW1_ = tauLa_ + tauLb_ * log( WW1_ );
		%WT1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT1l_ ^ nuT * CBar1l_ / N1l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLT1_ );
		WTini1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT1l_ ^ nuT * CBar1l_ / N1l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ );
		WT1_ = fzero( @(WT1_) real(WT1_ - ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT1l_ ^ nuT * CBar1l_ / N1l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ - tauLb_ * log( WT1_ ) )), WTini1_, optimset( 'display', 'off' ) );
		tauLT1_ = tauLa_ + tauLb_ * log( WT1_ );
		%WNT1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaNT_ * LNT1l_ ^ nuNT * CBar1l_ / N1l_ ^ ( 1 + nuNT ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLNT1_ );
		WNTini1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaNT_ * LNT1l_ ^ nuNT * CBar1l_ / N1l_ ^ ( 1 + nuNT ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ );
		WNT1_ = fzero( @(WNT1_) real(WNT1_ - ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaNT_ * LNT1l_ ^ nuNT * CBar1l_ / N1l_ ^ ( 1 + nuNT ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ - tauLb_ * log( WNT1_ ) )), WNTini1_, optimset( 'display', 'off' ) );
		tauLNT1_ = tauLa_ + tauLb_ * log( WNT1_ );
		%WSW1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW1l_ ^ nuSW * CBar1l_ / N1l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLSW1_ );
		WSWini1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW1l_ ^ nuSW * CBar1l_ / N1l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ );
		WSW1_ = fzero( @(WSW1_) real(WSW1_ - ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW1l_ ^ nuSW * CBar1l_ / N1l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ - tauLb_ * log( WSW1_ ) )), WSWini1_, optimset( 'display', 'off' ) );

		%WST1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST1l_ ^ nuST * CBar1l_ / N1l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLST1_ );
		WSTini1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST1l_ ^ nuST * CBar1l_ / N1l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ );
		WST1_ = fzero( @(WST1_) real(WST1_ - ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST1l_ ^ nuST * CBar1l_ / N1l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ - tauLb_ * log( WST1_ ) )), WSTini1_, optimset( 'display', 'off' ) );

		%WSNT1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaSNT_ * LSNT1l_ ^ nuSNT * CBar1l_ / N1l_ ^ ( 1 + nuSNT ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLSNT1_ );
		WSNTini1_ = ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaSNT_ * LSNT1l_ ^ nuSNT * CBar1l_ / N1l_ ^ ( 1 + nuSNT ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ );
		WSNT1_ = fzero( @(WSNT1_) real(WSNT1_ - ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappaSNT_ * LSNT1l_ ^ nuSNT * CBar1l_ / N1l_ ^ ( 1 + nuSNT ) / ( gCBar_ / GN_ ) / lambda_B1l_ / ( 1 - tauLa_ - tauLb_ * log( WSNT1_ ) )), WSNTini1_, optimset( 'display', 'off' ) );

	
		LW1b_ = ( ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaW_ * CBar1b_ / N1b_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B1b_ / ( 1 - tauLW1_ ) / WW1_ ) ^ ( -1 / nuW );
		LT1b_ = ( ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaT_ * CBar1b_ / N1b_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B1b_ / ( 1 - tauLT1_ ) / WT1_ ) ^ ( -1 / nuT );
		LNT1b_ = ( ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaNT_ * CBar1b_ / N1b_ ^ ( 1 + nuNT ) / ( gCBar_ / GN_ ) / lambda_B1b_ / ( 1 - tauLNT1_ ) / WNT1_ ) ^ ( -1 / nuNT );
	
		LSW1b_ = ( ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaSW_ * CBar1b_ / N1b_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B1b_ / ( 1 - tauLW1_ ) / WW1_ ) ^ ( -1 / nuSW );
		LST1b_ = ( ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaST_ * CBar1b_ / N1b_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B1b_ / ( 1 - tauLT1_ ) / WT1_ ) ^ ( -1 / nuST );
		LSNT1b_ = ( ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappaSNT_ * CBar1b_ / N1b_ ^ ( 1 + nuSNT ) / ( gCBar_ / GN_ ) / lambda_B1b_ / ( 1 - tauLNT1_ ) / WNT1_ ) ^ ( -1 / nuSNT );

		lambda_CD1b_ = - ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * N1b_ ^ ( xi - 1 + sigma ) * kappah_ * Lh1b_ ^ nuh * CBar1b_ / N1b_ ^ ( 1 + nuh ) / ( gCBar_ / GN_ ) * Lh1b_ / CD1b_ / ( 1 - alphah );
		lambda_CD1l_ = - ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * N1l_ ^ ( xi - 1 + sigma ) * kappah_ * Lh1l_ ^ nuh * CBar1l_ / N1l_ ^ ( 1 + nuh ) / ( gCBar_ / GN_ ) * Lh1l_ / CD1l_ / ( 1 - alphah );
	
	LW1_ = LW1l_ + LW1b_ + LSW1b_;
    LT1_ = LT1l_ + LT1b_ + LST1b_;
    LNT1_ = LNT1l_ + LNT1b_ + LSNT1b_;
    LSW1_ = LSW1l_;
    LST1_ = LST1l_;
    LSNT1_ = LSNT1l_;
		%WW2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW2l_ ^ nuW * CBar2l_ / N2l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLW2_ );
		WWini2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW2l_ ^ nuW * CBar2l_ / N2l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLa_ );
		WW2_ = fzero( @(WW2_) real(WW2_ - ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW2l_ ^ nuW * CBar2l_ / N2l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLa_ - tauLb_ * log( WW2_ ) )), WWini2_, optimset( 'display', 'off' ) );

		%WT2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT2l_ ^ nuT * CBar2l_ / N2l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLT2_ );
		WTini2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT2l_ ^ nuT * CBar2l_ / N2l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLa_ );
		WT2_ = fzero( @(WT2_) real(WT2_ - ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT2l_ ^ nuT * CBar2l_ / N2l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLa_ - tauLb_ * log( WT2_ ) )), WTini2_, optimset( 'display', 'off' ) );

		%WNT2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaNT_ * LNT2l_ ^ nuNT * CBar2l_ / N2l_ ^ ( 1 + nuNT ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLNT2_ );



		%WSW2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW2l_ ^ nuSW * CBar2l_ / N2l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLSW2_ );
		WSWini2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW2l_ ^ nuSW * CBar2l_ / N2l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLa_ );
		WSW2_ = fzero( @(WSW2_) real(WSW2_ - ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW2l_ ^ nuSW * CBar2l_ / N2l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLa_ - tauLb_ * log( WSW2_ ) )), WSWini2_, optimset( 'display', 'off' ) );

		%WST2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST2l_ ^ nuST * CBar2l_ / N2l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLST2_ );
		WSTini2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST2l_ ^ nuST * CBar2l_ / N2l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLa_ );
		WST2_ = fzero( @(WST2_) real(WST2_ - ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST2l_ ^ nuST * CBar2l_ / N2l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLa_ - tauLb_ * log( WST2_ ) )), WSTini2_, optimset( 'display', 'off' ) );

		%WSNT2_ = ( V2l_DIVIDEDU2l_ ) ^ sigma  * ( 1 - beta2l_ ) * N2l_ ^ ( xi - 1 + sigma ) * kappaSNT_ * LSNT2l_ ^ nuSNT * CBar2l_ / N2l_ ^ ( 1 + nuSNT ) / ( gCBar_ / GN_ ) / lambda_B2l_ / ( 1 - tauLSNT2_ );



	



	






	






		%WW3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW3l_ ^ nuW * CBar3l_ / N3l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLW3_ );
		WWini3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW3l_ ^ nuW * CBar3l_ / N3l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLa_ );
		WW3_ = fzero( @(WW3_) real(WW3_ - ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW3l_ ^ nuW * CBar3l_ / N3l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLa_ - tauLb_ * log( WW3_ ) )), WWini3_, optimset( 'display', 'off' ) );

		%WT3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT3l_ ^ nuT * CBar3l_ / N3l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLT3_ );
		WTini3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT3l_ ^ nuT * CBar3l_ / N3l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLa_ );
		WT3_ = fzero( @(WT3_) real(WT3_ - ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT3l_ ^ nuT * CBar3l_ / N3l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLa_ - tauLb_ * log( WT3_ ) )), WTini3_, optimset( 'display', 'off' ) );

		%WNT3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaNT_ * LNT3l_ ^ nuNT * CBar3l_ / N3l_ ^ ( 1 + nuNT ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLNT3_ );



		%WSW3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW3l_ ^ nuSW * CBar3l_ / N3l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLSW3_ );
		WSWini3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW3l_ ^ nuSW * CBar3l_ / N3l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLa_ );
		WSW3_ = fzero( @(WSW3_) real(WSW3_ - ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW3l_ ^ nuSW * CBar3l_ / N3l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLa_ - tauLb_ * log( WSW3_ ) )), WSWini3_, optimset( 'display', 'off' ) );

		%WST3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST3l_ ^ nuST * CBar3l_ / N3l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLST3_ );
		WSTini3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST3l_ ^ nuST * CBar3l_ / N3l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLa_ );
		WST3_ = fzero( @(WST3_) real(WST3_ - ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST3l_ ^ nuST * CBar3l_ / N3l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLa_ - tauLb_ * log( WST3_ ) )), WSTini3_, optimset( 'display', 'off' ) );

		%WSNT3_ = ( V3l_DIVIDEDU3l_ ) ^ sigma  * ( 1 - beta3l_ ) * N3l_ ^ ( xi - 1 + sigma ) * kappaSNT_ * LSNT3l_ ^ nuSNT * CBar3l_ / N3l_ ^ ( 1 + nuSNT ) / ( gCBar_ / GN_ ) / lambda_B3l_ / ( 1 - tauLSNT3_ );



	



	






	






		%WW4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW4l_ ^ nuW * CBar4l_ / N4l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLW4_ );
		WWini4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW4l_ ^ nuW * CBar4l_ / N4l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLa_ );
		WW4_ = fzero( @(WW4_) real(WW4_ - ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaW_ * LW4l_ ^ nuW * CBar4l_ / N4l_ ^ ( 1 + nuW ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLa_ - tauLb_ * log( WW4_ ) )), WWini4_, optimset( 'display', 'off' ) );

		%WT4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT4l_ ^ nuT * CBar4l_ / N4l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLT4_ );
		WTini4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT4l_ ^ nuT * CBar4l_ / N4l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLa_ );
		WT4_ = fzero( @(WT4_) real(WT4_ - ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaT_ * LT4l_ ^ nuT * CBar4l_ / N4l_ ^ ( 1 + nuT ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLa_ - tauLb_ * log( WT4_ ) )), WTini4_, optimset( 'display', 'off' ) );

		%WNT4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaNT_ * LNT4l_ ^ nuNT * CBar4l_ / N4l_ ^ ( 1 + nuNT ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLNT4_ );



		%WSW4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW4l_ ^ nuSW * CBar4l_ / N4l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLSW4_ );
		WSWini4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW4l_ ^ nuSW * CBar4l_ / N4l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLa_ );
		WSW4_ = fzero( @(WSW4_) real(WSW4_ - ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaSW_ * LSW4l_ ^ nuSW * CBar4l_ / N4l_ ^ ( 1 + nuSW ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLa_ - tauLb_ * log( WSW4_ ) )), WSWini4_, optimset( 'display', 'off' ) );

		%WST4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST4l_ ^ nuST * CBar4l_ / N4l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLST4_ );
		WSTini4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST4l_ ^ nuST * CBar4l_ / N4l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLa_ );
		WST4_ = fzero( @(WST4_) real(WST4_ - ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaST_ * LST4l_ ^ nuST * CBar4l_ / N4l_ ^ ( 1 + nuST ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLa_ - tauLb_ * log( WST4_ ) )), WSTini4_, optimset( 'display', 'off' ) );

		%WSNT4_ = ( V4l_DIVIDEDU4l_ ) ^ sigma  * ( 1 - beta4l_ ) * N4l_ ^ ( xi - 1 + sigma ) * kappaSNT_ * LSNT4l_ ^ nuSNT * CBar4l_ / N4l_ ^ ( 1 + nuSNT ) / ( gCBar_ / GN_ ) / lambda_B4l_ / ( 1 - tauLSNT4_ );



	



	






	







%Utility related
		kappaTemp1b_ = kappa0_ + kappaW_ / ( 1 + nuW ) * ( LW1b_ / N1b_ ) ^ ( 1 + nuW ) + kappaT_ / ( 1 + nuT ) * ( LT1b_ / N1b_ ) ^ ( 1 + nuT ) + kappaNT_ / ( 1 + nuNT ) * ( LNT1b_ / N1b_ ) ^ ( 1 + nuNT )...
			+ kappaSW_ / ( 1 + nuSW ) * ( LSW1b_ / N1b_ ) ^ ( 1 + nuSW ) + kappaST_ / ( 1 + nuST ) * ( LST1b_ / N1b_ ) ^ ( 1 + nuST ) + kappaSNT_ / ( 1 + nuSNT ) * ( LSNT1b_ / N1b_ ) ^ ( 1 + nuSNT )...
			+ kappaD_ / ( 1 + nuD ) * ( LD1b_ / N1b_ ) ^ ( 1 + nuD )	+ kappaNDCG_ / ( 1 + nuNDCG ) * ( LNDCG1b_ / N1b_ ) ^ ( 1 + nuNDCG ) + kappaK_ / ( 1 + nuK ) * ( LK1b_ / N1b_ ) ^ ( 1 + nuK ) + kappaH_ / ( 1 + nuH ) * ( LH1b_ / N1b_ ) ^ ( 1 + nuH )...
			+ kappah_ / ( 1 + nuh ) * ( Lh1b_ / N1b_ ) ^ ( 1 + nuh );






		kappaTemp1l_ = kappa0_ + kappaW_ / ( 1 + nuW ) * ( LW1l_ / N1l_ ) ^ ( 1 + nuW ) + kappaT_ / ( 1 + nuT ) * ( LT1l_ / N1l_ ) ^ ( 1 + nuT ) + kappaNT_ / ( 1 + nuNT ) * ( LNT1l_ / N1l_ ) ^ ( 1 + nuNT )...
			+ kappaSW_ / ( 1 + nuSW ) * ( LSW1l_ / N1l_ ) ^ ( 1 + nuSW ) + kappaST_ / ( 1 + nuST ) * ( LST1l_ / N1l_ ) ^ ( 1 + nuST ) + kappaSNT_ / ( 1 + nuSNT ) * ( LSNT1l_ / N1l_ ) ^ ( 1 + nuSNT )...
			+ kappaD_ / ( 1 + nuD ) * ( LD1l_ / N1l_ ) ^ ( 1 + nuD )	+ kappaNDCG_ / ( 1 + nuNDCG ) * ( LNDCG1l_ / N1l_ ) ^ ( 1 + nuNDCG ) + kappaK_ / ( 1 + nuK ) * ( LK1l_ / N1l_ ) ^ ( 1 + nuK ) + kappaH_ / ( 1 + nuH ) * ( LH1l_ / N1l_ ) ^ ( 1 + nuH )...
			+ kappah_ / ( 1 + nuh ) * ( Lh1l_ / N1l_ ) ^ ( 1 + nuh );



































































%Solve other multipliers
		%FOC of Cbar
        lambda_CBar1b_ = VV1b_ * ( V1b_DIVIDEDU1b_ * gV_ / gC_ ) ^ sigma  * ( 1 - beta1b_ ) * ( N1b_ * GN_ ) ^ ( xi - 1 + sigma ) * GN_ * kappaTemp1b_ / ( VV1b_ * glambda_C_ * ( C1b_ * gCBar_ / GN_ / N1b_ )^ ( 1 - varrhoC) * GN_ * varrhoC * ( CBar1b_ / N1b_ ) ^ ( varrhoC -1 ) - 1 );
		%FOC of C
        lambda_C1b_ = - ( V1b_DIVIDEDU1b_ ) ^ sigma  * ( 1 - beta1b_ ) * ( N1b_ ^ ( xi - 1 + sigma ) - VV1b_ * ( gV_ / gC_ ) ^ sigma * ( N1b_ * GN_ ) ^ ( xi - 1 + sigma ) * GN_ * h ) - lambda_CBar1b_ * ( 1 - varrhoC ) * ( C1b_ / N1b_ ) ^ ( -varrhoC ) * ( CBar1b_ / N1b_ / ( gCBar_ / GN_ ) ) ^ varrhoC;
		%FOC of CPBar
        lambda_CPBar1b_ = VV1b_ * lambda_C1b_ * glambda_C_ * ( alphaCP * C1b_ * gC_ / CPBar1b_ - OmegaC_ * CPBar1b_ ^ ( ( alphaCP - 1 ) * ( 1 - 1 / eC ) - 1 ) * ( C1b_ * gC_ / OmegaC_ ) ^ ( 1 / eC ) * alphaCP * ( CP1b_ * gCP_ ) ^ ( 1 - 1 / eC ) )...
            / ( 1 - VV1b_ * glambda_CPBar_ * ( CP1b_ * gCP_ / CG1_ / gCG_ * ( N1b_ + N1l_ ) / N1b_ ) ^ ( 1 - varrhoCP ) * varrhoCP * CPBar1b_ ^ ( varrhoCP - 1 ) );
		%FOC of CP
		lambda_CP1b_ = lambda_C1b_ * OmegaC_ * ( CPBar1b_ / gCPBar_ ) ^ ( ( alphaCP - 1 ) * ( eC - 1 ) / eC ) * alphaCP * ( C1b_ / CP1b_ / OmegaC_ ) ^ ( 1 / eC ) + lambda_CPBar1b_ * ( ( N1b_ + N1l_ ) / N1b_ / CG1_ ) ^ ( 1 - varrhoCP ) * ( CPBar1b_ / gCPBar_ ) ^ varrhoCP * ( 1 - varrhoCP ) * CP1b_ ^ ( -varrhoCP );
		%FOC of CDBar
        lambda_CDBar1b_ = VV1b_ * lambda_CP1b_ * glambda_CP_ * ( alphaCD * CP1b_ * gCP_ / CDBar1b_ - OmegaCP_ * CDBar1b_ ^ ( ( alphaCD - 1 ) * ( 1 - 1 / eCP ) - 1 ) * ( CP1b_ * gCP_ / OmegaCP_ ) ^ ( 1 / eCP ) * alphaCD * ( CD1b_ * gCD_ ) ^ ( 1 - 1 / eCP ) )...
            / ( 1 - VV1b_ * glambda_CDBar_ * ( CD1b_ * gCD_ / CND1b_ / gCND_ ) ^ ( 1 - varrhoCD ) * varrhoCD * CDBar1b_ ^ ( varrhoCD - 1 ) );
		%FOC of Cbar
        lambda_CBar1l_ = VV1l_ * ( V1l_DIVIDEDU1l_ * gV_ / gC_ ) ^ sigma  * ( 1 - beta1l_ ) * ( N1l_ * GN_ ) ^ ( xi - 1 + sigma ) * GN_ * kappaTemp1l_ / ( VV1l_ * glambda_C_ * ( C1l_ * gCBar_ / GN_ / N1l_ )^ ( 1 - varrhoC) * GN_ * varrhoC * ( CBar1l_ / N1l_ ) ^ ( varrhoC -1 ) - 1 );
		%FOC of C
        lambda_C1l_ = - ( V1l_DIVIDEDU1l_ ) ^ sigma  * ( 1 - beta1l_ ) * ( N1l_ ^ ( xi - 1 + sigma ) - VV1l_ * ( gV_ / gC_ ) ^ sigma * ( N1l_ * GN_ ) ^ ( xi - 1 + sigma ) * GN_ * h ) - lambda_CBar1l_ * ( 1 - varrhoC ) * ( C1l_ / N1l_ ) ^ ( -varrhoC ) * ( CBar1l_ / N1l_ / ( gCBar_ / GN_ ) ) ^ varrhoC;
		%FOC of CPBar
        lambda_CPBar1l_ = VV1l_ * lambda_C1l_ * glambda_C_ * ( alphaCP * C1l_ * gC_ / CPBar1l_ - OmegaC_ * CPBar1l_ ^ ( ( alphaCP - 1 ) * ( 1 - 1 / eC ) - 1 ) * ( C1l_ * gC_ / OmegaC_ ) ^ ( 1 / eC ) * alphaCP * ( CP1l_ * gCP_ ) ^ ( 1 - 1 / eC ) )...
            / ( 1 - VV1l_ * glambda_CPBar_ * ( CP1l_ * gCP_ / CG1_ / gCG_ * ( N1b_ + N1l_ ) / N1l_ ) ^ ( 1 - varrhoCP ) * varrhoCP * CPBar1l_ ^ ( varrhoCP - 1 ) );
		%FOC of CP
		lambda_CP1l_ = lambda_C1l_ * OmegaC_ * ( CPBar1l_ / gCPBar_ ) ^ ( ( alphaCP - 1 ) * ( eC - 1 ) / eC ) * alphaCP * ( C1l_ / CP1l_ / OmegaC_ ) ^ ( 1 / eC ) + lambda_CPBar1l_ * ( ( N1b_ + N1l_ ) / N1l_ / CG1_ ) ^ ( 1 - varrhoCP ) * ( CPBar1l_ / gCPBar_ ) ^ varrhoCP * ( 1 - varrhoCP ) * CP1l_ ^ ( -varrhoCP );
		%FOC of CDBar
        lambda_CDBar1l_ = VV1l_ * lambda_CP1l_ * glambda_CP_ * ( alphaCD * CP1l_ * gCP_ / CDBar1l_ - OmegaCP_ * CDBar1l_ ^ ( ( alphaCD - 1 ) * ( 1 - 1 / eCP ) - 1 ) * ( CP1l_ * gCP_ / OmegaCP_ ) ^ ( 1 / eCP ) * alphaCD * ( CD1l_ * gCD_ ) ^ ( 1 - 1 / eCP ) )...
            / ( 1 - VV1l_ * glambda_CDBar_ * ( CD1l_ * gCD_ / CND1l_ / gCND_ ) ^ ( 1 - varrhoCD ) * varrhoCD * CDBar1l_ ^ ( varrhoCD - 1 ) );
		%FOC of Cbar

		%FOC of C

		%FOC of CPBar


		%FOC of CP

		%FOC of CDBar


		%FOC of Cbar

		%FOC of C

		%FOC of CPBar


		%FOC of CP

		%FOC of CDBar


		%FOC of Cbar

		%FOC of C

		%FOC of CPBar


		%FOC of CP

		%FOC of CDBar


		%FOC of Cbar

		%FOC of C

		%FOC of CPBar


		%FOC of CP

		%FOC of CDBar


		%FOC of Cbar

		%FOC of C

		%FOC of CPBar


		%FOC of CP

		%FOC of CDBar


		%FOC of Cbar

		%FOC of C

		%FOC of CPBar


		%FOC of CP

		%FOC of CDBar



%%
%production sectors
%first, built prices from down to up


		RKPT1_ = RKPT1_DIVIDEDPKP1_ * PKP1_;
		RHPT1_ = RHPT1_DIVIDEDPHP1_ * PHP1_;
		RKPNT1_ = RKPNT1_DIVIDEDPKP1_ * PKP1_;
		RHPNT1_ = RHPNT1_DIVIDEDPHP1_ * PHP1_;
		RKPW1_ = RKPW1_DIVIDEDPKP1_ * PKP1_;
		RHPW1_ = RHPW1_DIVIDEDPHP1_ * PHP1_;
	
	%scriptX
    YX1_ = YWC1_;
	scriptX1_ = X1_ * exp( -o * ( log( X1_ / X_ ) - log( YX1_ / YWC_ ) ) ^ 2 );
	PscriptX1_ = 1 / ( exp( -o * ( log( X1_ / X_ ) - log( YX1_ / YWC_ ) ) ^ 2 ) - scriptX1_ * 2 * o * ( log( X1_ / X_ ) - log( YX1_ / YWC_ ) ) * (X_ - X1_) / X1_ / X_ );
	PX1_ = PscriptX1_ * scriptX1_ * 2 * o * ( log( X1_ / X_ ) - log( YX1_ / YWC_ ) ) * ( YWC_ - YX1_ ) / YX1_ / YWC_;
	
		%HL in T1
		PHLT1_ = 1 / ( ( alphaHL / RHPT1_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WST1_ ) ^ ( 1 - alphaHL ) * OmegaHLT_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPT1_
		%Can I decompose total spendings on factors untill I got RKT1_TIMESKT1_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FKT1_ = OmegaKW_ * ( KG1_  / gKG_ ) ^ alphaK * ( KUW1_ * KPW1_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		KT1_ = OmegaKT_ * ( KG1_ / gKG_ ) ^ alphaK * ( KUT1_ * KPT1_ ) ^ ( 1 - alphaK ) - FKT1_;
		RKT1_ = RKPT1_ * KUT1_ * KPT1_ / ( 1 - alphaK ) / ( KT1_ + FKT1_ );
		
		%KL in T1
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTempT1_ = OmegaKLT_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKLT - 1 ) / eKLT ) + 1 - alphaKL ) ^ ( eKLT / ( eKLT - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTempT1_ = OmegaKLT_ ^ ( 1 - 1 / eKLT ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLT - 1 ) / eKLT ) * YKLTempT1_ ^ ( 1/ eKLT - 1 )...
			- Xi1_ * OmegaKLT_ ^ ( 1 - 1 / eKLT ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLT - 1 ) / eKLT ) * ( gYKL_ / gK_ ) ^ ( 1 / eKLT ) * YKLTempT1_ ^ ( 1/ eKLT - 1 )...
			+ Xi1_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKLT1_ = 1 / ( ( PKLTempT1_ * alphaKL / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) / RKT1_ ) ^ alphaKL * ( 1 / WT1_ - PKLTempT1_ * alphaKL / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) / WT1_ ) ^ ( 1 - alphaKL ) * YKLTempT1_ );

		%HLX in T1
		YHLXTempT1_ = OmegaHLXT_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLXT - 1 ) / eHLXT ) + 1 - alphaHLX ) ^ ( eHLXT / ( eHLXT - 1 ) );
		PHLXTempT1_ = OmegaHLXT_ ^ ( 1 - 1 / eHLXT ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXT - 1 ) / eHLXT ) * YHLXTempT1_ ^ ( 1/ eHLXT - 1 )...
			- Xi1_ * OmegaHLXT_ ^ ( 1 - 1 / eHLXT ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXT - 1 ) / eHLXT ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLXT  ) * YHLXTempT1_ ^ ( 1/ eHLXT - 1 )...
			+ Xi1_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLXT1_ = 1 / ( ( PHLXTempT1_ * alphaHLX / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLT1_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptXT_ ) / PscriptX1_ - PHLXTempT1_ * alphaHLX / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptXT_ )  / PscriptX1_ ) ^ ( 1 - alphaHLX ) * YHLXTempT1_ );

		%Y in T1
		YTempT1_ = OmegaT_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eYT - 1 ) / eYT ) + 1 - alphaY ) ^ ( eYT / ( eYT - 1 ) );
		PTempT1_ = OmegaT_ ^ ( 1 - 1 / eYT ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYT - 1 ) / eYT ) * YTempT1_ ^ ( 1/ eYT - 1 )...
			- Xi1_ * OmegaT_ ^ ( 1 - 1 / eYT ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYT - 1 ) / eYT ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eYT  ) * YTempT1_ ^ ( 1/ eYT - 1 )...
			+ Xi1_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		PT1_ = 1 / ( ( PTempT1_ * alphaY / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLXT1_ ) ^ alphaY * ( 1 / PKLT1_ - PTempT1_ * alphaY / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) / PKLT1_ ) ^ ( 1 - alphaY ) * YTempT1_ );
		%HL in NT1
		PHLNT1_ = 1 / ( ( alphaHL / RHPNT1_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WSNT1_ ) ^ ( 1 - alphaHL ) * OmegaHLNT_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPNT1_
		%Can I decompose total spendings on factors untill I got RKNT1_TIMESKNT1_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FKNT1_ = OmegaKW_ * ( KG1_  / gKG_ ) ^ alphaK * ( KUW1_ * KPW1_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		KNT1_ = OmegaKNT_ * ( KG1_ / gKG_ ) ^ alphaK * ( KUNT1_ * KPNT1_ ) ^ ( 1 - alphaK ) - FKNT1_;
		RKNT1_ = RKPNT1_ * KUNT1_ * KPNT1_ / ( 1 - alphaK ) / ( KNT1_ + FKNT1_ );
		
		%KL in NT1
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTempNT1_ = OmegaKLNT_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKLNT - 1 ) / eKLNT ) + 1 - alphaKL ) ^ ( eKLNT / ( eKLNT - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTempNT1_ = OmegaKLNT_ ^ ( 1 - 1 / eKLNT ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLNT - 1 ) / eKLNT ) * YKLTempNT1_ ^ ( 1/ eKLNT - 1 )...
			- Xi1_ * OmegaKLNT_ ^ ( 1 - 1 / eKLNT ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLNT - 1 ) / eKLNT ) * ( gYKL_ / gK_ ) ^ ( 1 / eKLNT ) * YKLTempNT1_ ^ ( 1/ eKLNT - 1 )...
			+ Xi1_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKLNT1_ = 1 / ( ( PKLTempNT1_ * alphaKL / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) / RKNT1_ ) ^ alphaKL * ( 1 / WNT1_ - PKLTempNT1_ * alphaKL / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) / WNT1_ ) ^ ( 1 - alphaKL ) * YKLTempNT1_ );

		%HLX in NT1
		YHLXTempNT1_ = OmegaHLXNT_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLXNT - 1 ) / eHLXNT ) + 1 - alphaHLX ) ^ ( eHLXNT / ( eHLXNT - 1 ) );
		PHLXTempNT1_ = OmegaHLXNT_ ^ ( 1 - 1 / eHLXNT ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXNT - 1 ) / eHLXNT ) * YHLXTempNT1_ ^ ( 1/ eHLXNT - 1 )...
			- Xi1_ * OmegaHLXNT_ ^ ( 1 - 1 / eHLXNT ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXNT - 1 ) / eHLXNT ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLXNT  ) * YHLXTempNT1_ ^ ( 1/ eHLXNT - 1 )...
			+ Xi1_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLXNT1_ = 1 / ( ( PHLXTempNT1_ * alphaHLX / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLNT1_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptXNT_ ) / PscriptX1_ - PHLXTempNT1_ * alphaHLX / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptXNT_ )  / PscriptX1_ ) ^ ( 1 - alphaHLX ) * YHLXTempNT1_ );

		%Y in NT1
		YTempNT1_ = OmegaNT_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eYNT - 1 ) / eYNT ) + 1 - alphaY ) ^ ( eYNT / ( eYNT - 1 ) );
		PTempNT1_ = OmegaNT_ ^ ( 1 - 1 / eYNT ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYNT - 1 ) / eYNT ) * YTempNT1_ ^ ( 1/ eYNT - 1 )...
			- Xi1_ * OmegaNT_ ^ ( 1 - 1 / eYNT ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYNT - 1 ) / eYNT ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eYNT  ) * YTempNT1_ ^ ( 1/ eYNT - 1 )...
			+ Xi1_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		PNT1_ = 1 / ( ( PTempNT1_ * alphaY / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLXNT1_ ) ^ alphaY * ( 1 / PKLNT1_ - PTempNT1_ * alphaY / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) / PKLNT1_ ) ^ ( 1 - alphaY ) * YTempNT1_ );
		%HL in W1
		PHLW1_ = 1 / ( ( alphaHL / RHPW1_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WSW1_ ) ^ ( 1 - alphaHL ) * OmegaHLW_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPW1_
		%Can I decompose total spendings on factors untill I got RKW1_TIMESKW1_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FKW1_ = OmegaKW_ * ( KG1_  / gKG_ ) ^ alphaK * ( KUW1_ * KPW1_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		KW1_ = OmegaKW_ * ( KG1_ / gKG_ ) ^ alphaK * ( KUW1_ * KPW1_ ) ^ ( 1 - alphaK ) - FKW1_;
		RKW1_ = RKPW1_ * KUW1_ * KPW1_ / ( 1 - alphaK ) / ( KW1_ + FKW1_ );
		
		%KL in W1
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTempW1_ = OmegaKLW_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKLW - 1 ) / eKLW ) + 1 - alphaKL ) ^ ( eKLW / ( eKLW - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTempW1_ = OmegaKLW_ ^ ( 1 - 1 / eKLW ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLW - 1 ) / eKLW ) * YKLTempW1_ ^ ( 1/ eKLW - 1 )...
			- Xi1_ * OmegaKLW_ ^ ( 1 - 1 / eKLW ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLW - 1 ) / eKLW ) * ( gYKL_ / gK_ ) ^ ( 1 / eKLW ) * YKLTempW1_ ^ ( 1/ eKLW - 1 )...
			+ Xi1_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKLW1_ = 1 / ( ( PKLTempW1_ * alphaKL / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) / RKW1_ ) ^ alphaKL * ( 1 / WW1_ - PKLTempW1_ * alphaKL / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) / WW1_ ) ^ ( 1 - alphaKL ) * YKLTempW1_ );

		%HLX in W1
		YHLXTempW1_ = OmegaHLXW_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLXW - 1 ) / eHLXW ) + 1 - alphaHLX ) ^ ( eHLXW / ( eHLXW - 1 ) );
		PHLXTempW1_ = OmegaHLXW_ ^ ( 1 - 1 / eHLXW ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXW - 1 ) / eHLXW ) * YHLXTempW1_ ^ ( 1/ eHLXW - 1 )...
			- Xi1_ * OmegaHLXW_ ^ ( 1 - 1 / eHLXW ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXW - 1 ) / eHLXW ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLXW  ) * YHLXTempW1_ ^ ( 1/ eHLXW - 1 )...
			+ Xi1_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLXW1_ = 1 / ( ( PHLXTempW1_ * alphaHLX / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLW1_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptXW_ ) / PscriptX1_ - PHLXTempW1_ * alphaHLX / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptXW_ )  / PscriptX1_ ) ^ ( 1 - alphaHLX ) * YHLXTempW1_ );

		%Y in W1
		YTempW1_ = OmegaW_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eYW - 1 ) / eYW ) + 1 - alphaY ) ^ ( eYW / ( eYW - 1 ) );
		PTempW1_ = OmegaW_ ^ ( 1 - 1 / eYW ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYW - 1 ) / eYW ) * YTempW1_ ^ ( 1/ eYW - 1 )...
			- Xi1_ * OmegaW_ ^ ( 1 - 1 / eYW ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYW - 1 ) / eYW ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eYW  ) * YTempW1_ ^ ( 1/ eYW - 1 )...
			+ Xi1_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		PW1_ = 1 / ( ( PTempW1_ * alphaY / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLXW1_ ) ^ alphaY * ( 1 / PKLW1_ - PTempW1_ * alphaY / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) / PKLW1_ ) ^ ( 1 - alphaY ) * YTempW1_ );

		RKPT2_ = RKPT2_DIVIDEDPKP2_ * PKP2_;
		RHPT2_ = RHPT2_DIVIDEDPHP2_ * PHP2_;


		RKPW2_ = RKPW2_DIVIDEDPKP2_ * PKP2_;
		RHPW2_ = RHPW2_DIVIDEDPHP2_ * PHP2_;
	
	%scriptX
    YX2_ = YWC2_;
	scriptX2_ = X2_ * exp( -o * ( log( X2_ / X_ ) - log( YX2_ / YWC_ ) ) ^ 2 );
	PscriptX2_ = 1 / ( exp( -o * ( log( X2_ / X_ ) - log( YX2_ / YWC_ ) ) ^ 2 ) - scriptX2_ * 2 * o * ( log( X2_ / X_ ) - log( YX2_ / YWC_ ) ) * (X_ - X2_) / X2_ / X_ );

	
		%HL in T2
		PHLT2_ = 1 / ( ( alphaHL / RHPT2_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WST2_ ) ^ ( 1 - alphaHL ) * OmegaHLT_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPT2_
		%Can I decompose total spendings on factors untill I got RKT2_TIMESKT2_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FKT2_ = OmegaKW_ * ( KG2_  / gKG_ ) ^ alphaK * ( KUW2_ * KPW2_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		KT2_ = OmegaKT_ * ( KG2_ / gKG_ ) ^ alphaK * ( KUT2_ * KPT2_ ) ^ ( 1 - alphaK ) - FKT2_;
		RKT2_ = RKPT2_ * KUT2_ * KPT2_ / ( 1 - alphaK ) / ( KT2_ + FKT2_ );
		
		%KL in T2
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTempT2_ = OmegaKLT_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKLT - 1 ) / eKLT ) + 1 - alphaKL ) ^ ( eKLT / ( eKLT - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTempT2_ = OmegaKLT_ ^ ( 1 - 1 / eKLT ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLT - 1 ) / eKLT ) * YKLTempT2_ ^ ( 1/ eKLT - 1 )...
			- Xi2_ * OmegaKLT_ ^ ( 1 - 1 / eKLT ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLT - 1 ) / eKLT ) * ( gYKL_ / gK_ ) ^ ( 1 / eKLT ) * YKLTempT2_ ^ ( 1/ eKLT - 1 )...
			+ Xi2_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKLT2_ = 1 / ( ( PKLTempT2_ * alphaKL / ( 1 - varrhoKL * Xi2_ * GN_ * GAs_ ^ a_ ) / RKT2_ ) ^ alphaKL * ( 1 / WT2_ - PKLTempT2_ * alphaKL / ( 1 - varrhoKL * Xi2_ * GN_ * GAs_ ^ a_ ) / WT2_ ) ^ ( 1 - alphaKL ) * YKLTempT2_ );

		%HLX in T2
		YHLXTempT2_ = OmegaHLXT_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLXT - 1 ) / eHLXT ) + 1 - alphaHLX ) ^ ( eHLXT / ( eHLXT - 1 ) );
		PHLXTempT2_ = OmegaHLXT_ ^ ( 1 - 1 / eHLXT ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXT - 1 ) / eHLXT ) * YHLXTempT2_ ^ ( 1/ eHLXT - 1 )...
			- Xi2_ * OmegaHLXT_ ^ ( 1 - 1 / eHLXT ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXT - 1 ) / eHLXT ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLXT  ) * YHLXTempT2_ ^ ( 1/ eHLXT - 1 )...
			+ Xi2_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLXT2_ = 1 / ( ( PHLXTempT2_ * alphaHLX / ( 1 - varrhoHLX * Xi2_ * GN_ * GAs_ ^ a_ ) / PHLT2_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptXT_ ) / PscriptX2_ - PHLXTempT2_ * alphaHLX / ( 1 - varrhoHLX * Xi2_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptXT_ )  / PscriptX2_ ) ^ ( 1 - alphaHLX ) * YHLXTempT2_ );

		%Y in T2
		YTempT2_ = OmegaT_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eYT - 1 ) / eYT ) + 1 - alphaY ) ^ ( eYT / ( eYT - 1 ) );
		PTempT2_ = OmegaT_ ^ ( 1 - 1 / eYT ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYT - 1 ) / eYT ) * YTempT2_ ^ ( 1/ eYT - 1 )...
			- Xi2_ * OmegaT_ ^ ( 1 - 1 / eYT ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYT - 1 ) / eYT ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eYT  ) * YTempT2_ ^ ( 1/ eYT - 1 )...
			+ Xi2_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		PT2_ = 1 / ( ( PTempT2_ * alphaY / ( 1 - varrhoY * Xi2_ * GN_ * GAs_ ^ a_ ) / PHLXT2_ ) ^ alphaY * ( 1 / PKLT2_ - PTempT2_ * alphaY / ( 1 - varrhoY * Xi2_ * GN_ * GAs_ ^ a_ ) / PKLT2_ ) ^ ( 1 - alphaY ) * YTempT2_ );
		%HL in NT2

		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPNT2_
		%Can I decompose total spendings on factors untill I got RKNT2_TIMESKNT2_ in each S0? Yes for nontradable but No for widget and tradable due to CES



		
		%KL in NT2
		%auxilary, gether growth terms in production of capital engineering composite

		%auxilary, gether growth terms in FOC of capital and engineering



		


		%HLX in NT2




		


		%Y in NT2




		

		%HL in W2
		PHLW2_ = 1 / ( ( alphaHL / RHPW2_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WSW2_ ) ^ ( 1 - alphaHL ) * OmegaHLW_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPW2_
		%Can I decompose total spendings on factors untill I got RKW2_TIMESKW2_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FKW2_ = OmegaKW_ * ( KG2_  / gKG_ ) ^ alphaK * ( KUW2_ * KPW2_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		KW2_ = OmegaKW_ * ( KG2_ / gKG_ ) ^ alphaK * ( KUW2_ * KPW2_ ) ^ ( 1 - alphaK ) - FKW2_;
		RKW2_ = RKPW2_ * KUW2_ * KPW2_ / ( 1 - alphaK ) / ( KW2_ + FKW2_ );
		
		%KL in W2
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTempW2_ = OmegaKLW_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKLW - 1 ) / eKLW ) + 1 - alphaKL ) ^ ( eKLW / ( eKLW - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTempW2_ = OmegaKLW_ ^ ( 1 - 1 / eKLW ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLW - 1 ) / eKLW ) * YKLTempW2_ ^ ( 1/ eKLW - 1 )...
			- Xi2_ * OmegaKLW_ ^ ( 1 - 1 / eKLW ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLW - 1 ) / eKLW ) * ( gYKL_ / gK_ ) ^ ( 1 / eKLW ) * YKLTempW2_ ^ ( 1/ eKLW - 1 )...
			+ Xi2_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKLW2_ = 1 / ( ( PKLTempW2_ * alphaKL / ( 1 - varrhoKL * Xi2_ * GN_ * GAs_ ^ a_ ) / RKW2_ ) ^ alphaKL * ( 1 / WW2_ - PKLTempW2_ * alphaKL / ( 1 - varrhoKL * Xi2_ * GN_ * GAs_ ^ a_ ) / WW2_ ) ^ ( 1 - alphaKL ) * YKLTempW2_ );

		%HLX in W2
		YHLXTempW2_ = OmegaHLXW_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLXW - 1 ) / eHLXW ) + 1 - alphaHLX ) ^ ( eHLXW / ( eHLXW - 1 ) );
		PHLXTempW2_ = OmegaHLXW_ ^ ( 1 - 1 / eHLXW ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXW - 1 ) / eHLXW ) * YHLXTempW2_ ^ ( 1/ eHLXW - 1 )...
			- Xi2_ * OmegaHLXW_ ^ ( 1 - 1 / eHLXW ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXW - 1 ) / eHLXW ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLXW  ) * YHLXTempW2_ ^ ( 1/ eHLXW - 1 )...
			+ Xi2_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLXW2_ = 1 / ( ( PHLXTempW2_ * alphaHLX / ( 1 - varrhoHLX * Xi2_ * GN_ * GAs_ ^ a_ ) / PHLW2_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptXW_ ) / PscriptX2_ - PHLXTempW2_ * alphaHLX / ( 1 - varrhoHLX * Xi2_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptXW_ )  / PscriptX2_ ) ^ ( 1 - alphaHLX ) * YHLXTempW2_ );

		%Y in W2
		YTempW2_ = OmegaW_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eYW - 1 ) / eYW ) + 1 - alphaY ) ^ ( eYW / ( eYW - 1 ) );
		PTempW2_ = OmegaW_ ^ ( 1 - 1 / eYW ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYW - 1 ) / eYW ) * YTempW2_ ^ ( 1/ eYW - 1 )...
			- Xi2_ * OmegaW_ ^ ( 1 - 1 / eYW ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYW - 1 ) / eYW ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eYW  ) * YTempW2_ ^ ( 1/ eYW - 1 )...
			+ Xi2_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		PW2_ = 1 / ( ( PTempW2_ * alphaY / ( 1 - varrhoY * Xi2_ * GN_ * GAs_ ^ a_ ) / PHLXW2_ ) ^ alphaY * ( 1 / PKLW2_ - PTempW2_ * alphaY / ( 1 - varrhoY * Xi2_ * GN_ * GAs_ ^ a_ ) / PKLW2_ ) ^ ( 1 - alphaY ) * YTempW2_ );

		RKPT3_ = RKPT3_DIVIDEDPKP3_ * PKP3_;
		RHPT3_ = RHPT3_DIVIDEDPHP3_ * PHP3_;


		RKPW3_ = RKPW3_DIVIDEDPKP3_ * PKP3_;
		RHPW3_ = RHPW3_DIVIDEDPHP3_ * PHP3_;
	
	%scriptX
    YX3_ = YWC3_;
	scriptX3_ = X3_ * exp( -o * ( log( X3_ / X_ ) - log( YX3_ / YWC_ ) ) ^ 2 );
	PscriptX3_ = 1 / ( exp( -o * ( log( X3_ / X_ ) - log( YX3_ / YWC_ ) ) ^ 2 ) - scriptX3_ * 2 * o * ( log( X3_ / X_ ) - log( YX3_ / YWC_ ) ) * (X_ - X3_) / X3_ / X_ );

	
		%HL in T3
		PHLT3_ = 1 / ( ( alphaHL / RHPT3_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WST3_ ) ^ ( 1 - alphaHL ) * OmegaHLT_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPT3_
		%Can I decompose total spendings on factors untill I got RKT3_TIMESKT3_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FKT3_ = OmegaKW_ * ( KG3_  / gKG_ ) ^ alphaK * ( KUW3_ * KPW3_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		KT3_ = OmegaKT_ * ( KG3_ / gKG_ ) ^ alphaK * ( KUT3_ * KPT3_ ) ^ ( 1 - alphaK ) - FKT3_;
		RKT3_ = RKPT3_ * KUT3_ * KPT3_ / ( 1 - alphaK ) / ( KT3_ + FKT3_ );
		
		%KL in T3
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTempT3_ = OmegaKLT_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKLT - 1 ) / eKLT ) + 1 - alphaKL ) ^ ( eKLT / ( eKLT - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTempT3_ = OmegaKLT_ ^ ( 1 - 1 / eKLT ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLT - 1 ) / eKLT ) * YKLTempT3_ ^ ( 1/ eKLT - 1 )...
			- Xi3_ * OmegaKLT_ ^ ( 1 - 1 / eKLT ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLT - 1 ) / eKLT ) * ( gYKL_ / gK_ ) ^ ( 1 / eKLT ) * YKLTempT3_ ^ ( 1/ eKLT - 1 )...
			+ Xi3_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKLT3_ = 1 / ( ( PKLTempT3_ * alphaKL / ( 1 - varrhoKL * Xi3_ * GN_ * GAs_ ^ a_ ) / RKT3_ ) ^ alphaKL * ( 1 / WT3_ - PKLTempT3_ * alphaKL / ( 1 - varrhoKL * Xi3_ * GN_ * GAs_ ^ a_ ) / WT3_ ) ^ ( 1 - alphaKL ) * YKLTempT3_ );

		%HLX in T3
		YHLXTempT3_ = OmegaHLXT_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLXT - 1 ) / eHLXT ) + 1 - alphaHLX ) ^ ( eHLXT / ( eHLXT - 1 ) );
		PHLXTempT3_ = OmegaHLXT_ ^ ( 1 - 1 / eHLXT ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXT - 1 ) / eHLXT ) * YHLXTempT3_ ^ ( 1/ eHLXT - 1 )...
			- Xi3_ * OmegaHLXT_ ^ ( 1 - 1 / eHLXT ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXT - 1 ) / eHLXT ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLXT  ) * YHLXTempT3_ ^ ( 1/ eHLXT - 1 )...
			+ Xi3_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLXT3_ = 1 / ( ( PHLXTempT3_ * alphaHLX / ( 1 - varrhoHLX * Xi3_ * GN_ * GAs_ ^ a_ ) / PHLT3_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptXT_ ) / PscriptX3_ - PHLXTempT3_ * alphaHLX / ( 1 - varrhoHLX * Xi3_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptXT_ )  / PscriptX3_ ) ^ ( 1 - alphaHLX ) * YHLXTempT3_ );

		%Y in T3
		YTempT3_ = OmegaT_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eYT - 1 ) / eYT ) + 1 - alphaY ) ^ ( eYT / ( eYT - 1 ) );
		PTempT3_ = OmegaT_ ^ ( 1 - 1 / eYT ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYT - 1 ) / eYT ) * YTempT3_ ^ ( 1/ eYT - 1 )...
			- Xi3_ * OmegaT_ ^ ( 1 - 1 / eYT ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYT - 1 ) / eYT ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eYT  ) * YTempT3_ ^ ( 1/ eYT - 1 )...
			+ Xi3_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		PT3_ = 1 / ( ( PTempT3_ * alphaY / ( 1 - varrhoY * Xi3_ * GN_ * GAs_ ^ a_ ) / PHLXT3_ ) ^ alphaY * ( 1 / PKLT3_ - PTempT3_ * alphaY / ( 1 - varrhoY * Xi3_ * GN_ * GAs_ ^ a_ ) / PKLT3_ ) ^ ( 1 - alphaY ) * YTempT3_ );
		%HL in NT3

		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPNT3_
		%Can I decompose total spendings on factors untill I got RKNT3_TIMESKNT3_ in each S0? Yes for nontradable but No for widget and tradable due to CES



		
		%KL in NT3
		%auxilary, gether growth terms in production of capital engineering composite

		%auxilary, gether growth terms in FOC of capital and engineering



		


		%HLX in NT3




		


		%Y in NT3




		

		%HL in W3
		PHLW3_ = 1 / ( ( alphaHL / RHPW3_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WSW3_ ) ^ ( 1 - alphaHL ) * OmegaHLW_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPW3_
		%Can I decompose total spendings on factors untill I got RKW3_TIMESKW3_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FKW3_ = OmegaKW_ * ( KG3_  / gKG_ ) ^ alphaK * ( KUW3_ * KPW3_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		KW3_ = OmegaKW_ * ( KG3_ / gKG_ ) ^ alphaK * ( KUW3_ * KPW3_ ) ^ ( 1 - alphaK ) - FKW3_;
		RKW3_ = RKPW3_ * KUW3_ * KPW3_ / ( 1 - alphaK ) / ( KW3_ + FKW3_ );
		
		%KL in W3
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTempW3_ = OmegaKLW_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKLW - 1 ) / eKLW ) + 1 - alphaKL ) ^ ( eKLW / ( eKLW - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTempW3_ = OmegaKLW_ ^ ( 1 - 1 / eKLW ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLW - 1 ) / eKLW ) * YKLTempW3_ ^ ( 1/ eKLW - 1 )...
			- Xi3_ * OmegaKLW_ ^ ( 1 - 1 / eKLW ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLW - 1 ) / eKLW ) * ( gYKL_ / gK_ ) ^ ( 1 / eKLW ) * YKLTempW3_ ^ ( 1/ eKLW - 1 )...
			+ Xi3_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKLW3_ = 1 / ( ( PKLTempW3_ * alphaKL / ( 1 - varrhoKL * Xi3_ * GN_ * GAs_ ^ a_ ) / RKW3_ ) ^ alphaKL * ( 1 / WW3_ - PKLTempW3_ * alphaKL / ( 1 - varrhoKL * Xi3_ * GN_ * GAs_ ^ a_ ) / WW3_ ) ^ ( 1 - alphaKL ) * YKLTempW3_ );

		%HLX in W3
		YHLXTempW3_ = OmegaHLXW_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLXW - 1 ) / eHLXW ) + 1 - alphaHLX ) ^ ( eHLXW / ( eHLXW - 1 ) );
		PHLXTempW3_ = OmegaHLXW_ ^ ( 1 - 1 / eHLXW ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXW - 1 ) / eHLXW ) * YHLXTempW3_ ^ ( 1/ eHLXW - 1 )...
			- Xi3_ * OmegaHLXW_ ^ ( 1 - 1 / eHLXW ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXW - 1 ) / eHLXW ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLXW  ) * YHLXTempW3_ ^ ( 1/ eHLXW - 1 )...
			+ Xi3_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLXW3_ = 1 / ( ( PHLXTempW3_ * alphaHLX / ( 1 - varrhoHLX * Xi3_ * GN_ * GAs_ ^ a_ ) / PHLW3_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptXW_ ) / PscriptX3_ - PHLXTempW3_ * alphaHLX / ( 1 - varrhoHLX * Xi3_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptXW_ )  / PscriptX3_ ) ^ ( 1 - alphaHLX ) * YHLXTempW3_ );

		%Y in W3
		YTempW3_ = OmegaW_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eYW - 1 ) / eYW ) + 1 - alphaY ) ^ ( eYW / ( eYW - 1 ) );
		PTempW3_ = OmegaW_ ^ ( 1 - 1 / eYW ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYW - 1 ) / eYW ) * YTempW3_ ^ ( 1/ eYW - 1 )...
			- Xi3_ * OmegaW_ ^ ( 1 - 1 / eYW ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYW - 1 ) / eYW ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eYW  ) * YTempW3_ ^ ( 1/ eYW - 1 )...
			+ Xi3_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		PW3_ = 1 / ( ( PTempW3_ * alphaY / ( 1 - varrhoY * Xi3_ * GN_ * GAs_ ^ a_ ) / PHLXW3_ ) ^ alphaY * ( 1 / PKLW3_ - PTempW3_ * alphaY / ( 1 - varrhoY * Xi3_ * GN_ * GAs_ ^ a_ ) / PKLW3_ ) ^ ( 1 - alphaY ) * YTempW3_ );

		RKPT4_ = RKPT4_DIVIDEDPKP4_ * PKP4_;
		RHPT4_ = RHPT4_DIVIDEDPHP4_ * PHP4_;


		RKPW4_ = RKPW4_DIVIDEDPKP4_ * PKP4_;
		RHPW4_ = RHPW4_DIVIDEDPHP4_ * PHP4_;
	
	%scriptX
    YX4_ = YWC4_;
	scriptX4_ = X4_ * exp( -o * ( log( X4_ / X_ ) - log( YX4_ / YWC_ ) ) ^ 2 );
	PscriptX4_ = 1 / ( exp( -o * ( log( X4_ / X_ ) - log( YX4_ / YWC_ ) ) ^ 2 ) - scriptX4_ * 2 * o * ( log( X4_ / X_ ) - log( YX4_ / YWC_ ) ) * (X_ - X4_) / X4_ / X_ );

	
		%HL in T4
		PHLT4_ = 1 / ( ( alphaHL / RHPT4_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WST4_ ) ^ ( 1 - alphaHL ) * OmegaHLT_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPT4_
		%Can I decompose total spendings on factors untill I got RKT4_TIMESKT4_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FKT4_ = OmegaKW_ * ( KG4_  / gKG_ ) ^ alphaK * ( KUW4_ * KPW4_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		KT4_ = OmegaKT_ * ( KG4_ / gKG_ ) ^ alphaK * ( KUT4_ * KPT4_ ) ^ ( 1 - alphaK ) - FKT4_;
		RKT4_ = RKPT4_ * KUT4_ * KPT4_ / ( 1 - alphaK ) / ( KT4_ + FKT4_ );
		
		%KL in T4
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTempT4_ = OmegaKLT_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKLT - 1 ) / eKLT ) + 1 - alphaKL ) ^ ( eKLT / ( eKLT - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTempT4_ = OmegaKLT_ ^ ( 1 - 1 / eKLT ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLT - 1 ) / eKLT ) * YKLTempT4_ ^ ( 1/ eKLT - 1 )...
			- Xi4_ * OmegaKLT_ ^ ( 1 - 1 / eKLT ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLT - 1 ) / eKLT ) * ( gYKL_ / gK_ ) ^ ( 1 / eKLT ) * YKLTempT4_ ^ ( 1/ eKLT - 1 )...
			+ Xi4_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKLT4_ = 1 / ( ( PKLTempT4_ * alphaKL / ( 1 - varrhoKL * Xi4_ * GN_ * GAs_ ^ a_ ) / RKT4_ ) ^ alphaKL * ( 1 / WT4_ - PKLTempT4_ * alphaKL / ( 1 - varrhoKL * Xi4_ * GN_ * GAs_ ^ a_ ) / WT4_ ) ^ ( 1 - alphaKL ) * YKLTempT4_ );

		%HLX in T4
		YHLXTempT4_ = OmegaHLXT_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLXT - 1 ) / eHLXT ) + 1 - alphaHLX ) ^ ( eHLXT / ( eHLXT - 1 ) );
		PHLXTempT4_ = OmegaHLXT_ ^ ( 1 - 1 / eHLXT ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXT - 1 ) / eHLXT ) * YHLXTempT4_ ^ ( 1/ eHLXT - 1 )...
			- Xi4_ * OmegaHLXT_ ^ ( 1 - 1 / eHLXT ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXT - 1 ) / eHLXT ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLXT  ) * YHLXTempT4_ ^ ( 1/ eHLXT - 1 )...
			+ Xi4_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLXT4_ = 1 / ( ( PHLXTempT4_ * alphaHLX / ( 1 - varrhoHLX * Xi4_ * GN_ * GAs_ ^ a_ ) / PHLT4_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptXT_ ) / PscriptX4_ - PHLXTempT4_ * alphaHLX / ( 1 - varrhoHLX * Xi4_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptXT_ )  / PscriptX4_ ) ^ ( 1 - alphaHLX ) * YHLXTempT4_ );

		%Y in T4
		YTempT4_ = OmegaT_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eYT - 1 ) / eYT ) + 1 - alphaY ) ^ ( eYT / ( eYT - 1 ) );
		PTempT4_ = OmegaT_ ^ ( 1 - 1 / eYT ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYT - 1 ) / eYT ) * YTempT4_ ^ ( 1/ eYT - 1 )...
			- Xi4_ * OmegaT_ ^ ( 1 - 1 / eYT ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYT - 1 ) / eYT ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eYT  ) * YTempT4_ ^ ( 1/ eYT - 1 )...
			+ Xi4_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		PT4_ = 1 / ( ( PTempT4_ * alphaY / ( 1 - varrhoY * Xi4_ * GN_ * GAs_ ^ a_ ) / PHLXT4_ ) ^ alphaY * ( 1 / PKLT4_ - PTempT4_ * alphaY / ( 1 - varrhoY * Xi4_ * GN_ * GAs_ ^ a_ ) / PKLT4_ ) ^ ( 1 - alphaY ) * YTempT4_ );
		%HL in NT4

		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPNT4_
		%Can I decompose total spendings on factors untill I got RKNT4_TIMESKNT4_ in each S0? Yes for nontradable but No for widget and tradable due to CES



		
		%KL in NT4
		%auxilary, gether growth terms in production of capital engineering composite

		%auxilary, gether growth terms in FOC of capital and engineering



		


		%HLX in NT4




		


		%Y in NT4




		

		%HL in W4
		PHLW4_ = 1 / ( ( alphaHL / RHPW4_ ) ^ alphaHL * ( ( 1 - alphaHL ) / WSW4_ ) ^ ( 1 - alphaHL ) * OmegaHLW_ );
		
		%KGKP
		%I can't form the price easily because decreasing return to scale for firms. So I have to guess KPW4_
		%Can I decompose total spendings on factors untill I got RKW4_TIMESKW4_ in each S0? Yes for nontradable but No for widget and tradable due to CES
        FKW4_ = OmegaKW_ * ( KG4_  / gKG_ ) ^ alphaK * ( KUW4_ * KPW4_ ) ^ ( 1 - alphaK ) * FKtilde / ( 1 + FKtilde );
		KW4_ = OmegaKW_ * ( KG4_ / gKG_ ) ^ alphaK * ( KUW4_ * KPW4_ ) ^ ( 1 - alphaK ) - FKW4_;
		RKW4_ = RKPW4_ * KUW4_ * KPW4_ / ( 1 - alphaK ) / ( KW4_ + FKW4_ );
		
		%KL in W4
		%auxilary, gether growth terms in production of capital engineering composite
		YKLTempW4_ = OmegaKLW_ * gKBar_ ^ ( -alphaKL / ( 1 - varrhoKL ) ) * ( alphaKL * gKBar_ ^ ( 1 / ( 1 - varrhoKL ) * ( eKLW - 1 ) / eKLW ) + 1 - alphaKL ) ^ ( eKLW / ( eKLW - 1 ) );
		%auxilary, gether growth terms in FOC of capital and engineering
		PKLTempW4_ = OmegaKLW_ ^ ( 1 - 1 / eKLW ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLW - 1 ) / eKLW ) * YKLTempW4_ ^ ( 1/ eKLW - 1 )...
			- Xi4_ * OmegaKLW_ ^ ( 1 - 1 / eKLW ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKLW - 1 ) / eKLW ) * ( gYKL_ / gK_ ) ^ ( 1 / eKLW ) * YKLTempW4_ ^ ( 1/ eKLW - 1 )...
			+ Xi4_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKLW4_ = 1 / ( ( PKLTempW4_ * alphaKL / ( 1 - varrhoKL * Xi4_ * GN_ * GAs_ ^ a_ ) / RKW4_ ) ^ alphaKL * ( 1 / WW4_ - PKLTempW4_ * alphaKL / ( 1 - varrhoKL * Xi4_ * GN_ * GAs_ ^ a_ ) / WW4_ ) ^ ( 1 - alphaKL ) * YKLTempW4_ );

		%HLX in W4
		YHLXTempW4_ = OmegaHLXW_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLXW - 1 ) / eHLXW ) + 1 - alphaHLX ) ^ ( eHLXW / ( eHLXW - 1 ) );
		PHLXTempW4_ = OmegaHLXW_ ^ ( 1 - 1 / eHLXW ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXW - 1 ) / eHLXW ) * YHLXTempW4_ ^ ( 1/ eHLXW - 1 )...
			- Xi4_ * OmegaHLXW_ ^ ( 1 - 1 / eHLXW ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLXW - 1 ) / eHLXW ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLXW  ) * YHLXTempW4_ ^ ( 1/ eHLXW - 1 )...
			+ Xi4_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLXW4_ = 1 / ( ( PHLXTempW4_ * alphaHLX / ( 1 - varrhoHLX * Xi4_ * GN_ * GAs_ ^ a_ ) / PHLW4_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptXW_ ) / PscriptX4_ - PHLXTempW4_ * alphaHLX / ( 1 - varrhoHLX * Xi4_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptXW_ )  / PscriptX4_ ) ^ ( 1 - alphaHLX ) * YHLXTempW4_ );

		%Y in W4
		YTempW4_ = OmegaW_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eYW - 1 ) / eYW ) + 1 - alphaY ) ^ ( eYW / ( eYW - 1 ) );
		PTempW4_ = OmegaW_ ^ ( 1 - 1 / eYW ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYW - 1 ) / eYW ) * YTempW4_ ^ ( 1/ eYW - 1 )...
			- Xi4_ * OmegaW_ ^ ( 1 - 1 / eYW ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eYW - 1 ) / eYW ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eYW  ) * YTempW4_ ^ ( 1/ eYW - 1 )...
			+ Xi4_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoY );
		
		PW4_ = 1 / ( ( PTempW4_ * alphaY / ( 1 - varrhoY * Xi4_ * GN_ * GAs_ ^ a_ ) / PHLXW4_ ) ^ alphaY * ( 1 / PKLW4_ - PTempW4_ * alphaY / ( 1 - varrhoY * Xi4_ * GN_ * GAs_ ^ a_ ) / PKLW4_ ) ^ ( 1 - alphaY ) * YTempW4_ );

%-----------------------------ROW-----------------------------
PT0_ = PT1_ * pT0;


%-----------------------------ROW-----------------------------

	PTC1_ = ( ...
			+ N0_ * ( PT0_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N1_ * ( PT1_ * ( ...
				1 ...
			) ) ^ ( 1 - eT ) ...
			+ N2_ * ( PT2_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N3_ * ( PT3_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N4_ * ( PT4_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
	) ^ ( 1 / ( 1 - eT ) ) / OmegaTC_;
	
	PWP1_ = ( ...
			+ N1_ / NN_ * ( PW1_ * ( ...
				1 ...
			) ) ^ ( 1 - eW ) ...
			+ N2_ / NN_ * ( PW2_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
			+ N3_ / NN_ * ( PW3_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
			+ N4_ / NN_ * ( PW4_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
	) ^ ( 1 / ( 1 - eW ) ) / OmegaWP_;
	
	%PWC_ is in residual, PX1_ is above
	%I don't form P here because we already use the production function of Y (and effectively the market clearing condition of Y)
	PTC2_ = ( ...
			+ N0_ * ( PT0_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N1_ * ( PT1_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N2_ * ( PT2_ * ( ...
				1 ...
			) ) ^ ( 1 - eT ) ...
			+ N3_ * ( PT3_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N4_ * ( PT4_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
	) ^ ( 1 / ( 1 - eT ) ) / OmegaTC_;
	
	PWP2_ = ( ...
			+ N1_ / NN_ * ( PW1_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
			+ N2_ / NN_ * ( PW2_ * ( ...
				1 ...
			) ) ^ ( 1 - eW ) ...
			+ N3_ / NN_ * ( PW3_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
			+ N4_ / NN_ * ( PW4_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
	) ^ ( 1 / ( 1 - eW ) ) / OmegaWP_;
	
	%PWC_ is in residual, PX2_ is above
	%I don't form P here because we already use the production function of Y (and effectively the market clearing condition of Y)
	PTC3_ = ( ...
			+ N0_ * ( PT0_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N1_ * ( PT1_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N2_ * ( PT2_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N3_ * ( PT3_ * ( ...
				1 ...
			) ) ^ ( 1 - eT ) ...
			+ N4_ * ( PT4_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
	) ^ ( 1 / ( 1 - eT ) ) / OmegaTC_;
	
	PWP3_ = ( ...
			+ N1_ / NN_ * ( PW1_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
			+ N2_ / NN_ * ( PW2_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
			+ N3_ / NN_ * ( PW3_ * ( ...
				1 ...
			) ) ^ ( 1 - eW ) ...
			+ N4_ / NN_ * ( PW4_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
	) ^ ( 1 / ( 1 - eW ) ) / OmegaWP_;
	
	%PWC_ is in residual, PX3_ is above
	%I don't form P here because we already use the production function of Y (and effectively the market clearing condition of Y)
	PTC4_ = ( ...
			+ N0_ * ( PT0_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N1_ * ( PT1_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N2_ * ( PT2_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N3_ * ( PT3_ * ( ...
				1 + iotaTM_ + iotaTX_ ...
			) ) ^ ( 1 - eT ) ...
			+ N4_ * ( PT4_ * ( ...
				1 ...
			) ) ^ ( 1 - eT ) ...
	) ^ ( 1 / ( 1 - eT ) ) / OmegaTC_;
	
	PWP4_ = ( ...
			+ N1_ / NN_ * ( PW1_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
			+ N2_ / NN_ * ( PW2_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
			+ N3_ / NN_ * ( PW3_ * ( ...
				1 + iotaWM_ + iotaWX_ ...
			) ) ^ ( 1 - eW ) ...
			+ N4_ / NN_ * ( PW4_ * ( ...
				1 ...
			) ) ^ ( 1 - eW ) ...
	) ^ ( 1 / ( 1 - eW ) ) / OmegaWP_;
	
	%PWC_ is in residual, PX4_ is above
	%I don't form P here because we already use the production function of Y (and effectively the market clearing condition of Y)

%%
%then, get quantity by demand from up to down
    YNT1_ = alphaNC * P1_ * Y1_ / PNT1_ / ( 1 + tauNT_ );

    YTC1_ = ( 1 - alphaNC ) * P1_ * Y1_ / PTC1_ / ( 1 + tauTC_ );

    FWC1_=FWCtilde * YWC1_;
    %YWC1_ is guessed, demand of YWP is in the residual
	YWP1_ = ( ( YWC1_ + FWC1_ ) / OmegaWC_ / ( HG1_ / gHG_ ) ^ alphaHW ) ^ ( 1 / ( 1 - alphaHW ) );
	



		YT11_ = ( PTC1_ * OmegaTC_ / ( PT1_ * ( ...
			1 ...
		) ) ) ^ eT * YTC1_ / OmegaTC_ * N1_;









	
        YW11_ = ( PWP1_ * OmegaWP_/ ( PW1_ * ( ...
            1 ...
        ) ) ) ^ eW * YWP1_ / OmegaWP_ * N1_ / NN_;











    YTC2_ = ( 1 - alphaNC ) * P2_ * Y2_ / PTC2_ / ( 1 + tauTC_ );

    FWC2_=FWCtilde * YWC2_;
    %YWC2_ is guessed, demand of YWP is in the residual
	YWP2_ = ( ( YWC2_ + FWC2_ ) / OmegaWC_ / ( HG2_ / gHG_ ) ^ alphaHW ) ^ ( 1 / ( 1 - alphaHW ) );
	



		YT21_ = ( PTC2_ * OmegaTC_ / ( PT1_ * ( ...
			1 + iotaTM_ + iotaTX_ ...
		) ) ) ^ eT * YTC2_ / OmegaTC_ * N1_;









	
        YW21_ = ( PWP2_ * OmegaWP_/ ( PW1_ * ( ...
            1 + iotaWM_ + iotaWX_ ...
        ) ) ) ^ eW * YWP2_ / OmegaWP_ * N1_ / NN_;











    YTC3_ = ( 1 - alphaNC ) * P3_ * Y3_ / PTC3_ / ( 1 + tauTC_ );

    FWC3_=FWCtilde * YWC3_;
    %YWC3_ is guessed, demand of YWP is in the residual
	YWP3_ = ( ( YWC3_ + FWC3_ ) / OmegaWC_ / ( HG3_ / gHG_ ) ^ alphaHW ) ^ ( 1 / ( 1 - alphaHW ) );
	



		YT31_ = ( PTC3_ * OmegaTC_ / ( PT1_ * ( ...
			1 + iotaTM_ + iotaTX_ ...
		) ) ) ^ eT * YTC3_ / OmegaTC_ * N1_;









	
        YW31_ = ( PWP3_ * OmegaWP_/ ( PW1_ * ( ...
            1 + iotaWM_ + iotaWX_ ...
        ) ) ) ^ eW * YWP3_ / OmegaWP_ * N1_ / NN_;











    YTC4_ = ( 1 - alphaNC ) * P4_ * Y4_ / PTC4_ / ( 1 + tauTC_ );

    FWC4_=FWCtilde * YWC4_;
    %YWC4_ is guessed, demand of YWP is in the residual
	YWP4_ = ( ( YWC4_ + FWC4_ ) / OmegaWC_ / ( HG4_ / gHG_ ) ^ alphaHW ) ^ ( 1 / ( 1 - alphaHW ) );
	



		YT41_ = ( PTC4_ * OmegaTC_ / ( PT1_ * ( ...
			1 + iotaTM_ + iotaTX_ ...
		) ) ) ^ eT * YTC4_ / OmegaTC_ * N1_;









	
        YW41_ = ( PWP4_ * OmegaWP_/ ( PW1_ * ( ...
            1 + iotaWM_ + iotaWX_ ...
        ) ) ) ^ eW * YWP4_ / OmegaWP_ * N1_ / NN_;










%-----------------------------ROW-----------------------------
YTC0_ = YTC1_ / N1_ * N0_ * yTC0;
    YT01_ = ( PT0_ / ( PT1_ * ( 1 + iotaTM_ + iotaTX_ ) ) ) ^ eT0_ * YTC0_ * N1_;



%-----------------------------ROW-----------------------------														  

	YT1_ = YT01_ * ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) ...
		+ YT11_ * ...
			1 ...
		+ YT21_ * ...
			( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) ...
		+ YT31_ * ...
			( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) ...
		+ YT41_ * ...
			( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) ...
	;
	
	YW1_ = 0 ...
		+ YW11_ * ...
			1 ...
		+ YW21_ * ...
			( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) ...
		+ YW31_ * ...
			( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) ...
		+ YW41_ * ...
			( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) ...
	;










	




















	




















	











%Demand of HLX in T1
    YHLXT1_ = PT1_ * YT1_ * alphaY * PTempT1_ / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLXT1_;

%demand of KL in T1
    YKLT1_ = PT1_ * YT1_ * ( 1 - alphaY * PTempT1_ / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) ) / PKLT1_;
    
%demand of HL in T1
    YHLT1_ = PHLXT1_ * YHLXT1_ * alphaHLX * PHLXTempT1_ / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLT1_;

%demand of scriptX in T1
    scriptXT1_ = PHLXT1_ * YHLXT1_ * ( 1 - alphaHLX * PHLXTempT1_ / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) ) / ( 1 + tauscriptXT_ ) / PscriptX1_;
	
%demand of K in T1
	%demand in residual

    IKPT1_ = ( 1 - ( 1 - deltaKPT_ - thetaKU0 / ( 1+thetaKU1 ) * KUT1_ ^ ( 1+thetaKU1 ) ) / gKP_ ) * KPT1_;

%demand of H in T1
    HPT1_ = PHLT1_ * YHLT1_ * alphaHL / RHPT1_;

    IHPT1_ = ( 1 - ( 1 - deltaHPT_ ) / gHP_ ) * HPT1_;

%define all production habit in T1



%Demand of HLX in NT1
    YHLXNT1_ = PNT1_ * YNT1_ * alphaY * PTempNT1_ / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLXNT1_;

%demand of KL in NT1
    YKLNT1_ = PNT1_ * YNT1_ * ( 1 - alphaY * PTempNT1_ / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) ) / PKLNT1_;
    
%demand of HL in NT1
    YHLNT1_ = PHLXNT1_ * YHLXNT1_ * alphaHLX * PHLXTempNT1_ / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLNT1_;

%demand of scriptX in NT1
    scriptXNT1_ = PHLXNT1_ * YHLXNT1_ * ( 1 - alphaHLX * PHLXTempNT1_ / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) ) / ( 1 + tauscriptXNT_ ) / PscriptX1_;
	
%demand of K in NT1
	%demand in residual

    IKPNT1_ = ( 1 - ( 1 - deltaKPNT_ - thetaKU0 / ( 1+thetaKU1 ) * KUNT1_ ^ ( 1+thetaKU1 ) ) / gKP_ ) * KPNT1_;

%demand of H in NT1
    HPNT1_ = PHLNT1_ * YHLNT1_ * alphaHL / RHPNT1_;

    IHPNT1_ = ( 1 - ( 1 - deltaHPNT_ ) / gHP_ ) * HPNT1_;

%define all production habit in NT1



%Demand of HLX in W1
    YHLXW1_ = PW1_ * YW1_ * alphaY * PTempW1_ / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLXW1_;

%demand of KL in W1
    YKLW1_ = PW1_ * YW1_ * ( 1 - alphaY * PTempW1_ / ( 1 - varrhoY * Xi1_ * GN_ * GAs_ ^ a_ ) ) / PKLW1_;
    
%demand of HL in W1
    YHLW1_ = PHLXW1_ * YHLXW1_ * alphaHLX * PHLXTempW1_ / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) / PHLW1_;

%demand of scriptX in W1
    scriptXW1_ = PHLXW1_ * YHLXW1_ * ( 1 - alphaHLX * PHLXTempW1_ / ( 1 - varrhoHLX * Xi1_ * GN_ * GAs_ ^ a_ ) ) / ( 1 + tauscriptXW_ ) / PscriptX1_;
	
%demand of K in W1
	%demand in residual

    IKPW1_ = ( 1 - ( 1 - deltaKPW_ - thetaKU0 / ( 1+thetaKU1 ) * KUW1_ ^ ( 1+thetaKU1 ) ) / gKP_ ) * KPW1_;

%demand of H in W1
    HPW1_ = PHLW1_ * YHLW1_ * alphaHL / RHPW1_;

    IHPW1_ = ( 1 - ( 1 - deltaHPW_ ) / gHP_ ) * HPW1_;

%define all production habit in W1



%Demand of HLX in T2


%demand of KL in T2

    
%demand of HL in T2


%demand of scriptX in T2

	
%demand of K in T2
	%demand in residual



%demand of H in T2




%define all production habit in T2



%Demand of HLX in NT2


%demand of KL in NT2

    
%demand of HL in NT2


%demand of scriptX in NT2

	
%demand of K in NT2
	%demand in residual



%demand of H in NT2




%define all production habit in NT2



%Demand of HLX in W2


%demand of KL in W2

    
%demand of HL in W2


%demand of scriptX in W2

	
%demand of K in W2
	%demand in residual



%demand of H in W2




%define all production habit in W2



%Demand of HLX in T3


%demand of KL in T3

    
%demand of HL in T3


%demand of scriptX in T3

	
%demand of K in T3
	%demand in residual



%demand of H in T3




%define all production habit in T3



%Demand of HLX in NT3


%demand of KL in NT3

    
%demand of HL in NT3


%demand of scriptX in NT3

	
%demand of K in NT3
	%demand in residual



%demand of H in NT3




%define all production habit in NT3



%Demand of HLX in W3


%demand of KL in W3

    
%demand of HL in W3


%demand of scriptX in W3

	
%demand of K in W3
	%demand in residual



%demand of H in W3




%define all production habit in W3



%Demand of HLX in T4


%demand of KL in T4

    
%demand of HL in T4


%demand of scriptX in T4

	
%demand of K in T4
	%demand in residual



%demand of H in T4




%define all production habit in T4



%Demand of HLX in NT4


%demand of KL in NT4

    
%demand of HL in NT4


%demand of scriptX in NT4

	
%demand of K in NT4
	%demand in residual



%demand of H in NT4




%define all production habit in NT4



%Demand of HLX in W4


%demand of KL in W4

    
%demand of HL in W4


%demand of scriptX in W4

	
%demand of K in W4
	%demand in residual



%demand of H in W4




%define all production habit in W4




%Impatient's collateral constraint
	B1_ = ( 1 - rhoQB ) * m_ * D1b_ * PD1_ / ( 1 - rhoQB / ( GN_ * GAs_ ^ ( 1 + b_ ) ) );




%variables in measurement equations











































































































































































































































































%PCE (personal consumption expenditure + government expenditure on education) and deflator






%DND (personal consumption expenditure except education) and deflator






%PDI (private domestic investment) and deflator












%GCE (government consumption expenditures) and deflator






%GGI (government gross investment) and deflator






%GDI (gross domestic investment) and deflator






%Export and deflator





















%Import and deflator





















%cfc of durable goods stock




%cfc of private physical capital stock






%cfc of public physical capital stock


%cfc of public R&D capital stock


%cfc





%Labour income


























%HoursWorkedPerCapita













%ex post real exchange rate (t-1 to t)


%Spread

	
%government revenue



























































%PCE (personal consumption expenditure + government expenditure on education) and deflator






%DND (personal consumption expenditure except education) and deflator






%PDI (private domestic investment) and deflator












%GCE (government consumption expenditures) and deflator






%GGI (government gross investment) and deflator






%GDI (gross domestic investment) and deflator






%Export and deflator





















%Import and deflator





















%cfc of durable goods stock




%cfc of private physical capital stock






%cfc of public physical capital stock


%cfc of public R&D capital stock


%cfc





%Labour income


























%HoursWorkedPerCapita













%ex post real exchange rate (t-1 to t)


%Spread

	
%government revenue



























































%PCE (personal consumption expenditure + government expenditure on education) and deflator






%DND (personal consumption expenditure except education) and deflator






%PDI (private domestic investment) and deflator












%GCE (government consumption expenditures) and deflator






%GGI (government gross investment) and deflator






%GDI (gross domestic investment) and deflator






%Export and deflator





















%Import and deflator





















%cfc of durable goods stock




%cfc of private physical capital stock






%cfc of public physical capital stock


%cfc of public R&D capital stock


%cfc





%Labour income


























%HoursWorkedPerCapita













%ex post real exchange rate (t-1 to t)


%Spread

	
%government revenue



























































%PCE (personal consumption expenditure + government expenditure on education) and deflator






%DND (personal consumption expenditure except education) and deflator






%PDI (private domestic investment) and deflator












%GCE (government consumption expenditures) and deflator






%GGI (government gross investment) and deflator






%GDI (gross domestic investment) and deflator






%Export and deflator





















%Import and deflator





















%cfc of durable goods stock




%cfc of private physical capital stock






%cfc of public physical capital stock


%cfc of public R&D capital stock


%cfc





%Labour income


























%HoursWorkedPerCapita













%ex post real exchange rate (t-1 to t)


%Spread

	
%government revenue




























































%%
ComplexResids = complex(zeros( 28, 1 ));
Resids = zeros( 28 * 2, 1 );
%     ComplexResids( 1 + ( 1 - 1 ) * 27 ) = PKG1_ * ( 1 - alphaKG ) * IKG1_ / LKG1_ - WK1_;
%     ComplexResids( 2 + ( 1 - 1 ) * 27 ) = PHG1_ * ( 1 - alphaHG ) * IHG1_ / LHG1_ - WH1_;
%     ComplexResids( 3 + ( 1 - 1 ) * 27 ) = PCG1_ * ( 1 - alphaCG ) * CG1_ / LCG1_ - WNDCG1_;
% 
%     ComplexResids( 4 + ( 1 - 1 ) * 27 ) = KW1_ - PKLW1_ * YKLW1_ * alphaKL * PKLTempW1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) / RKW1_;
%     ComplexResids( 5 + ( 1 - 1 ) * 27 ) = KT1_ - PKLT1_ * YKLT1_ * alphaKL * PKLTempT1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) / RKT1_ ;
%     ComplexResids( 6 + ( 1 - 1 ) * 27 ) = KNT1_ - PKLNT1_ * YKLNT1_ * alphaKL * PKLTempNT1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) / RKNT1_;
%     ComplexResids( 7 + ( 1 - 1 ) * 27 ) = LW1_ - PKLW1_ * YKLW1_ * ( 1 - alphaKL * PKLTempW1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) ) / WW1_;
%     ComplexResids( 8 + ( 1 - 1 ) * 27 ) = LT1_ - PKLT1_ * YKLT1_ * ( 1 - alphaKL * PKLTempT1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) ) / WT1_;
%     ComplexResids( 9 + ( 1 - 1 ) * 27 ) = LNT1_ - PKLNT1_ * YKLNT1_ * ( 1 - alphaKL * PKLTempNT1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) ) / WNT1_;
%     ComplexResids( 10 + ( 1 - 1 ) * 27 ) = LSW1_ - PHLW1_ * YHLW1_ * ( 1 - alphaHL ) / WSW1_;
%     ComplexResids( 11 + ( 1 - 1 ) * 27 ) = LST1_ - PHLT1_ * YHLT1_ * ( 1 - alphaHL ) / WST1_;
%     ComplexResids( 12 + ( 1 - 1 ) * 27 ) = LSNT1_ - PHLNT1_ * YHLNT1_ * ( 1 - alphaHL ) / WSNT1_;
%     ComplexResids( 13 + ( 1 - 1 ) * 27 ) = IKP1_ - IKPT1_ - IKPNT1_ - IKPW1_;
%     ComplexResids( 14 + ( 1 - 1 ) * 27 ) = IHP1_ - IHPT1_ - IHPNT1_ - IHPW1_;
% 
%     ComplexResids( 15 + ( 1 - 1 ) * 27 ) = lambda_B1l_ * PD1_ * ( 1 + tauD_ ) * thetaDU0 * DU1l_ ^ ( thetaDU1 + 1 ) + lambda_CD1l_ * alphah * CD1l_ / D1l_ * gD_;
%     ComplexResids( 16 + ( 1 - 1 ) * 27 ) = lambda_B1b_ * PD1_ * ( 1 + tauD_ ) * thetaDU0 * DU1b_ ^ ( thetaDU1 + 1 ) + lambda_CD1b_ * alphah * CD1b_ / D1b_ * gD_;
% 
%     ComplexResids( 17 + ( 1 - 1 ) * 27 ) = - lambda_CP1l_ * OmegaCP_ * ( CDBar1l_ / gCDBar_ ) ^ ( alphaCD * ( eCP - 1 ) / eCP ) * ( 1 - alphaCD ) * ( CP1l_ / CND1l_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar1l_ * CD1l_ ^ ( 1 - varrhoCD ) * ( CDBar1l_ / gCDBar_ ) ^ varrhoCD * ( varrhoCD - 1 ) * CND1l_ ^ ( varrhoCD - 2 ) - lambda_B1l_ * PND1_ * ( 1 + tauND_ );
%     ComplexResids( 18 + ( 1 - 1 ) * 27 ) = - lambda_CP1b_ * OmegaCP_ * ( CDBar1b_ / gCDBar_ ) ^ ( alphaCD * ( eCP - 1 ) / eCP ) * ( 1 - alphaCD ) * ( CP1b_ / CND1b_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar1b_ * CD1b_ ^ ( 1 - varrhoCD ) * ( CDBar1b_ / gCDBar_ ) ^ varrhoCD * ( varrhoCD - 1 ) * CND1b_ ^ ( varrhoCD - 2 ) - lambda_B1b_ * PND1_ * ( 1 + tauND_ );
% 
%     ComplexResids( 19 + ( 1 - 1 ) * 27 ) = - lambda_CP1l_ * OmegaCP_ * ( CDBar1l_ / gCDBar_ ) ^ ( ( alphaCD - 1 ) * ( eCP - 1 ) / eCP ) * alphaCD * ( CP1l_ / CD1l_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar1l_ * CND1l_ ^ ( varrhoCD - 1 ) * ( CDBar1l_ / gCDBar_ ) ^ varrhoCD * ( 1 - varrhoCD ) * CD1l_ ^ ( -varrhoCD ) + lambda_CD1l_;
%     ComplexResids( 20 + ( 1 - 1 ) * 27 ) = - lambda_CP1b_ * OmegaCP_ * ( CDBar1b_ / gCDBar_ ) ^ ( ( alphaCD - 1 ) * ( eCP - 1 ) / eCP ) * alphaCD * ( CP1b_ / CD1b_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar1b_ * CND1b_ ^ ( varrhoCD - 1 ) * ( CDBar1b_ / gCDBar_ ) ^ varrhoCD * ( 1 - varrhoCD ) * CD1b_ ^ ( -varrhoCD ) + lambda_CD1b_;
% 
%     ComplexResids( 21 + ( 1 - 1 ) * 27 ) = - ID1b_ * PD1_ * ( 1 + tauD_ ) - CND1b_ * PND1_ * ( 1 + tauND_ ) ...
% 										- B1_ / ( GN_ * GAs_ ^ a_ ) + Q_ * B1_ ...
%                                         - taub_ * Y1_ * P1_ ...
% 											+ WW1_ * ( 1 - tauLW1_ ) * LW1b_ ...
% 											+ WT1_ * ( 1 - tauLT1_ ) * LT1b_ ...
% 											+ WNT1_ * ( 1 - tauLNT1_ ) * LNT1b_ ...
% 											+ WD1_ * ( 1 - tauLD1_ ) * LD1b_ ...
% 											+ WNDCG1_ * ( 1 - tauLNDCG1_ ) * LNDCG1b_ ...
% 											+ WK1_ * ( 1 - tauLK1_ ) * LK1b_ ...
% 											+ WH1_ * ( 1 - tauLH1_ ) * LH1b_ ...
% 											+ WW1_ * ( 1 - tauLW1_ ) * LSW1b_ ...
% 											+ WT1_ * ( 1 - tauLT1_ ) * LST1b_ ...
% 											+ WNT1_ * ( 1 - tauLNT1_ ) * LSNT1b_ ...
% 										;
% 
%     ComplexResids( 22 + ( 1 - 1 ) * 27 ) = 	( PX1_ + PWC_ ) * ( YWC1_ + FWC1_ ) * ( 1 - alphaHW ) / PWP1_ - YWP1_; 
% 
%     ComplexResids( 23 + ( 1 - 1 ) * 27 ) = 	scriptX1_...
%                                           - scriptXT1_...
%                                           - scriptXNT1_...
%                                           - scriptXW1_...
%                                         ;
%     ComplexResids( 24 + ( 1 - 1 ) * 27 ) = 	LKG1_ - (LK1b_ + LK1l_ - LKP1_);
%     ComplexResids( 25 + ( 1 - 1 ) * 27 ) = 	LHG1_ - (LH1b_ + LH1l_ - LHP1_);
% 	ComplexResids( 26 + ( 1 - 1 ) * 27 ) =   LNDCG1_ - LND1_ - LCG1_;
% 	ComplexResids( 27 + ( 1 - 1 ) * 27 ) =   Y1_ * ( 1 - tauCG_ * alphaCG - tauKG_ * alphaKG - tauHG_ * alphaHG ) - YD1_ - YND1_ - YHP1_ - YKP1_;
% 
% %    ComplexResids( 27 * SN + 2 - 1 ) = Xi1_-Xi2_;
% %    ComplexResids( 27 * SN + 3 - 1 ) = Xi1_-Xi3_;
% %    ComplexResids( 27 * SN + 4 - 1 ) = Xi1_-Xi4_;
% 
% ComplexResids( 28 ) = scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ + X_ * PWC_ ^ ( - ( 1 + lambda ) / lambda ) * ( ( 1 - scripts_ ) * ( AN_ / GAs_ ) ^ ( 1 / lambda ) * ( 1 / ( 1 + eta * lambda ) ) ^ ( ( 1 + lambda ) / lambda ) + scripts_ * ( 1 / ( 1 + muP_ ) ) ^ ( ( 1 + lambda ) / lambda ) ) - YWC_;	
% Resids(1:28)=real(ComplexResids);
% Resids(28+1:28*2)=imag(ComplexResids);
% end

	ComplexResids( 1 + ( 1 - 1 ) * 27 ) = log(PKG1_) + log( 1 - alphaKG ) + log(IKG1_)  - log(WK1_) - log(LKG1_);
	ComplexResids( 2 + ( 1 - 1 ) * 27 ) = log(PHG1_) + log( 1 - alphaHG ) + log(IHG1_)  - log(WH1_) - log(LHG1_);
	ComplexResids( 3 + ( 1 - 1 ) * 27 ) = log(PCG1_) + log( 1 - alphaCG ) + log(CG1_)   - log(WNDCG1_) - log(LCG1_);
	
	ComplexResids( 4 + ( 1 - 1 ) * 27 ) = log(KW1_) + log(RKW1_) - log(PKLW1_) - log(YKLW1_) - log(alphaKL) - log(PKLTempW1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ));
	ComplexResids( 5 + ( 1 - 1 ) * 27 ) = log(KT1_) + log(RKT1_) - log(PKLT1_) - log(YKLT1_) - log(alphaKL) - log(PKLTempT1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ));
	ComplexResids( 6 + ( 1 - 1 ) * 27 ) = log(KNT1_) + log(RKNT1_) - log(PKLNT1_) - log(YKLNT1_) - log(alphaKL) - log(PKLTempNT1_/ ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ));
  ComplexResids( 7 + ( 1 - 1 ) * 27 ) = log(LW1_) + log(WW1_) - log(PKLW1_) - log(YKLW1_) - log( 1 - alphaKL * PKLTempW1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) );
  ComplexResids( 8 + ( 1 - 1 ) * 27 ) = log(LT1_) + log(WT1_) - log(PKLT1_) - log(YKLT1_) - log( 1 - alphaKL * PKLTempT1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) );
  ComplexResids( 9 + ( 1 - 1 ) * 27 ) = log(LNT1_) + log(WNT1_) - log(PKLNT1_) - log(YKLNT1_) - log( 1 - alphaKL * PKLTempNT1_ / ( 1 - varrhoKL * Xi1_ * GN_ * GAs_ ^ a_ ) );
  ComplexResids( 10 + ( 1 - 1 ) * 27 ) = log(LSW1_) + log(WSW1_) - log(PHLW1_) - log(YHLW1_) - log( 1 - alphaHL );
  ComplexResids( 11 + ( 1 - 1 ) * 27 ) = log(LST1_) + log(WST1_) - log(PHLT1_) - log(YHLT1_) - log( 1 - alphaHL );
  ComplexResids( 12 + ( 1 - 1 ) * 27 ) = log(LSNT1_) + log(WSNT1_) - log(PHLNT1_) - log(YHLNT1_) - log( 1 - alphaHL );
  ComplexResids( 13 + ( 1 - 1 ) * 27 ) = log(IKP1_) - log(IKPT1_ + IKPNT1_ + IKPW1_);
  ComplexResids( 14 + ( 1 - 1 ) * 27 ) = log(IHP1_) - log(IHPT1_ + IHPNT1_ + IHPW1_);
	
  ComplexResids( 15 + ( 1 - 1 ) * 27 ) = log(lambda_B1l_ * PD1_ * ( 1 + tauD_ ) * thetaDU0 * DU1l_ ^ ( thetaDU1 + 1 )) - log(-lambda_CD1l_ * alphah * CD1l_ / D1l_ * gD_);
  ComplexResids( 16 + ( 1 - 1 ) * 27 ) = log(lambda_B1b_ * PD1_ * ( 1 + tauD_ ) * thetaDU0 * DU1b_ ^ ( thetaDU1 + 1 )) - log(-lambda_CD1b_ * alphah * CD1b_ / D1b_ * gD_);

  ComplexResids( 17 + ( 1 - 1 ) * 27 ) = log(- lambda_CP1l_ * OmegaCP_ * ( CDBar1l_ / gCDBar_ ) ^ ( alphaCD * ( eCP - 1 ) / eCP ) * ( 1 - alphaCD ) * ( CP1l_ / CND1l_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar1l_ * CD1l_ ^ ( 1 - varrhoCD ) * ( CDBar1l_ / gCDBar_ ) ^ varrhoCD * ( varrhoCD - 1 ) * CND1l_ ^ ( varrhoCD - 2 )) - log(lambda_B1l_ * PND1_ * ( 1 + tauND_ ));
  ComplexResids( 18 + ( 1 - 1 ) * 27 ) = log(- lambda_CP1b_ * OmegaCP_ * ( CDBar1b_ / gCDBar_ ) ^ ( alphaCD * ( eCP - 1 ) / eCP ) * ( 1 - alphaCD ) * ( CP1b_ / CND1b_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar1b_ * CD1b_ ^ ( 1 - varrhoCD ) * ( CDBar1b_ / gCDBar_ ) ^ varrhoCD * ( varrhoCD - 1 ) * CND1b_ ^ ( varrhoCD - 2 )) - log(lambda_B1b_ * PND1_ * ( 1 + tauND_ ));

  ComplexResids( 19 + ( 1 - 1 ) * 27 ) = log(- lambda_CP1l_ * OmegaCP_ * ( CDBar1l_ / gCDBar_ ) ^ ( ( alphaCD - 1 ) * ( eCP - 1 ) / eCP ) * alphaCD * ( CP1l_ / CD1l_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar1l_ * CND1l_ ^ ( varrhoCD - 1 ) * ( CDBar1l_ / gCDBar_ ) ^ varrhoCD * ( 1 - varrhoCD ) * CD1l_ ^ ( -varrhoCD )) - log(-lambda_CD1l_);
  ComplexResids( 20 + ( 1 - 1 ) * 27 ) = log(- lambda_CP1b_ * OmegaCP_ * ( CDBar1b_ / gCDBar_ ) ^ ( ( alphaCD - 1 ) * ( eCP - 1 ) / eCP ) * alphaCD * ( CP1b_ / CD1b_ / OmegaCP_ ) ^ ( 1 / eCP ) - lambda_CDBar1b_ * CND1b_ ^ ( varrhoCD - 1 ) * ( CDBar1b_ / gCDBar_ ) ^ varrhoCD * ( 1 - varrhoCD ) * CD1b_ ^ ( -varrhoCD )) - log(-lambda_CD1b_);

	ComplexResids( 21 + ( 1 - 1 ) * 27 ) = log (Q_ * B1_ ...
											+ WW1_ * ( 1 - tauLW1_ ) * LW1b_ ...
											+ WT1_ * ( 1 - tauLT1_ ) * LT1b_ ...
											+ WNT1_ * ( 1 - tauLNT1_ ) * LNT1b_ ...
											+ WD1_ * ( 1 - tauLD1_ ) * LD1b_ ...
											+ WNDCG1_ * ( 1 - tauLNDCG1_ ) * LNDCG1b_ ...
											+ WK1_ * ( 1 - tauLK1_ ) * LK1b_ ...
											+ WH1_ * ( 1 - tauLH1_ ) * LH1b_ ...
											+ WW1_ * ( 1 - tauLW1_ ) * LSW1b_ ...
											+ WT1_ * ( 1 - tauLT1_ ) * LST1b_ ...
											+ WNT1_ * ( 1 - tauLNT1_ ) * LSNT1b_ ...
                                        ) - log( ID1b_ * PD1_ * ( 1 + tauD_ ) + CND1b_ * PND1_ * ( 1 + tauND_ ) ...
										+ B1_ / ( GN_ * GAs_ ^ a_ ) ...
                                        + taub_ * Y1_ * P1_);

    ComplexResids( 22 + ( 1 - 1 ) * 27 ) = 	log(( PX1_ + PWC_ ) * ( YWC1_ + FWC1_ )) + log( 1 - alphaHW ) - log(YWP1_) - log(PWP1_); 										

    ComplexResids( 23 + ( 1 - 1 ) * 27 ) = 	log(scriptX1_) - log(...
                                          + scriptXT1_...
                                          + scriptXNT1_...
                                          + scriptXW1_...
                                        );
	ComplexResids( 24 + ( 1 - 1 ) * 27 ) = 	log(LKG1_ + LKP1_) - log(LK1b_ + LK1l_);
  ComplexResids( 25 + ( 1 - 1 ) * 27 ) = 	log(LHG1_ + LHP1_) - log(LH1b_ + LH1l_);
	ComplexResids( 26 + ( 1 - 1 ) * 27 ) =   log(LNDCG1_) - log( LND1_ + LCG1_);
	ComplexResids( 27 + ( 1 - 1 ) * 27 ) =   log(Y1_ * ( 1 - tauCG_ * alphaCG - tauKG_ * alphaKG - tauHG_ * alphaHG )) - log(YD1_ + YND1_ + YHP1_ + YKP1_);

% 	ComplexResids( 27 * SN + 2 - 1 ) = log(Xi1_)-log(Xi2_);
% 	ComplexResids( 27 * SN + 3 - 1 ) = log(Xi1_)-log(Xi3_);
% 	ComplexResids( 27 * SN + 4 - 1 ) = log(Xi1_)-log(Xi4_);

ComplexResids( 28 ) = log(scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ + X_ * PWC_ ^ ( - ( 1 + lambda ) / lambda ) * ( ( 1 - scripts_ ) * ( AN_ / GAs_ ) ^ ( 1 / lambda ) * ( 1 / ( 1 + eta * lambda ) ) ^ ( ( 1 + lambda ) / lambda ) + scripts_ * ( 1 / ( 1 + muP_ ) ) ^ ( ( 1 + lambda ) / lambda ) )) - log(YWC_);
Resids(1:28)=real(ComplexResids);
Resids(28+1:28*2)=imag(ComplexResids);
end

