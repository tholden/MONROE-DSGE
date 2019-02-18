//waiting a update of transformation engine.
//For now, I have to define growth rate (that is a expression) of trends as an endogenous variable instead of MLV

@#define ExtraVariable=0
@#define MaximumLag=3
@#define MaximumLead=3
@#define UsingGrowthSyntax = 1
@#include "Initialize.mod"
//be careful to use Numbers, it start from 0, so Numbers[n] means n-1!!

//choose number of countries
//names of widget, tradable, nontradable sectors
//names of durable, nondurable, pysical capital sectors
//names of more sectors
//names of borrowers and lenders
@#define SN = 4
@#define Sectors0 = [ "T", "NT", "W" ]
@#define Sectors1 = [ "K", "H", "D", "NDCG" ]
@#define SectorsP1 = [ "KP", "HP", "D", "ND" ]
@#define SectorsG1 = [ "KG", "HG", "CG" ]
@#define Sectors2 = [ "T", "NT", "W", "ST", "SNT", "SW", "D", "NDCG", "K", "H" ]
@#define Members = [ "b", "l" ]

parameters InitialStateLogitEigCap InitialStateAllowCorrelation InitialStateLogPower InitialStateLogScale;

InitialStateLogitEigCap = 5;
InitialStateAllowCorrelation = 0.5;
InitialStateLogPower = 0;
InitialStateLogScale = 10;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                       //
//                                              declare endogenous                                                       //
//                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//growth rate of variable x can be decompose into 4 component: ss growth rate of trend, deviation from this ss, ss deviation from trend, deviation from this ss.
//growth rate of trends, denoted by g. Growth rate of the variable it self is denoted by G. (for example, gII and GII are different even at ss because I manually detrend II, gII is only growth rate of part of the trend )
//it could be the case the growth rate of a trend is the growth rate of another variable
var
log_gII
log_gB
log_gYS
log_gPS
log_gYWC
log_gX
log_gKP
log_gHP
log_gPKP
log_gPHP
log_gKG
log_gHG
log_gPHL
log_gPKL
log_gKBar
log_gPHLX
log_gYHLBar
log_gYHLXBar
log_gCND
log_gD
log_gCDBar
log_gCPBar
log_gCBar
log_gV
log_glambda_C
log_glambda_B
log_glambda_CPBar
log_glambda_CP
log_glambda_CDBar
log_glambda_CD
log_glambda_GD
log_glambda_GK
log_glambda_GH
log_gPD
log_gPND	
log_gCG
;
//ROW
@#for n in 1:SN
	@#define ShockProcesses = ShockProcesses + [ "eT0" + Numbers[n+1], "0", "Inf", "eT0_", "1", "sigmaeT0" ]
@#endfor
@#define EndoVariables = EndoVariables + [ "YTC" + Numbers[1], "0", "Inf", "gYS" ]
@#define EndoVariables = EndoVariables + [ "PT" + Numbers[1], "0", "Inf", "gPS" ]
varexo epsilon_P0 epsilon_Y0;

//Population variables
@#define PureTrendEndoVariables = PureTrendEndoVariables + [ "N", "GN" ]
@#define ShockProcesses = ShockProcesses + [ "GN", "0", "Inf", "GN_", "rhoGN", "sigmaGN" ]
@#for n in 1:SN
	@#define ShockProcesses = ShockProcesses + [ "Ntilde" + Numbers[n+1], "0", "1", "Ntilde" + Numbers[n+1] + "_", "1", "sigmaNtilde" ]
	@#define ShockProcesses = ShockProcesses + [ "varpi"  + Numbers[n+1], "0", "1", "varpi_"                     , "1", "sigmavarpi"  ]
    @#for m in Members
		@#define EndoVariables = EndoVariables + [ "N" + Numbers[n+1] + m, "0", "Inf", "GN" ]
    @#endfor
@#endfor

//Engineering sector variables, All prices are relative to engineering (so we can define price of final goods in each country)
//VI omegaP scriptdP mu muP A GERP GII deltaI are MLV
//As appear in several equations such as productivity aggregation, law of motion for AN. I have manually handled As in these equations
@#define PureTrendEndoVariables = PureTrendEndoVariables + [ "As", "GAs" ]
@#define EndoVariables = EndoVariables + [ "GAs", "0", "Inf", "1" ]
@#define EndoVariables = EndoVariables + [ "ScriptFRP", "0", "Inf", "1" ]
@#define EndoVariables = EndoVariables + [ "scripts", "0", "1", "1" ]
@#define EndoVariables = EndoVariables + [ "AN", "0", "1", "GAs" ]
@#define EndoVariables = EndoVariables + [ "JP", "0", "Inf", "1" ]
@#define EndoVariables = EndoVariables + [ "II", "0", "Inf", "gII" ]
//I mannully detrend the ERP part of II's trend
//research idea shock, industry depreciation shock, industry invention shock
@#define ShockProcesses = ShockProcesses + [ "Z", "0", "Inf", "Z_", "rhoZ", "sigmaZ" ]
@#define ShockProcesses = ShockProcesses + [ "deltaItilde", "0", "1", "deltaItilde_", "rhodeltaItilde", "sigmadeltaItilde" ]
@#define ShockProcesses = ShockProcesses + [ "scriptFI", "0", "Inf", "scriptFI_", "rhoscriptFI", "sigmascriptFI" ]

//Global variables,
@#define EndoVariables = EndoVariables + [ "PWC", "0", "Inf", "GAs" ]
@#define EndoVariables = EndoVariables + [ "Xi", "0", "Inf", "1" ]
@#define EndoVariables = EndoVariables + [ "Q", "0", "Inf", "1" ]

//Household
@#for n in 1:SN
	@#define ShockProcesses = ShockProcesses + [ "deltaD" + Numbers[n+1], "0", "1", "deltaD" + "_", "rhodeltaD", "sigmadeltaD" ]
	@#define ShockProcesses = ShockProcesses + [ "kappa0" + Numbers[n+1], "-Inf", "Inf", "kappa0" + "_", "rhokappa0", "sigmakappa0" ]
    %kappa0 is habit stock shock. while being positive is normal, negative kappa0 is understandable.
    %we want to aviod kappa0 being too large such that utility becomes negative, or being too negative such that (kappa0+labour terms) becomes negative
	@#define ShockProcesses = ShockProcesses + [ "kappah" + Numbers[n+1], "0", "Inf", "kappah" + "_", "rhokappah", "sigmakappah" ]
	@#for S in Sectors2
		@#define ShockProcesses = ShockProcesses + [ "kappa" + S + Numbers[n+1], "0", "Inf", "kappa" + S + "_", "rhokappa" + S, "sigmakappa" + S ]
	@#endfor
	varexo epsilon_beta@{n};
    @#for m in Members
		@#define EndoVariables = EndoVariables + [ "CND" + Numbers[n+1] + m, "0", "Inf", "gCND"]
		@#define EndoVariables = EndoVariables + [ "D" + Numbers[n+1] + m, "0", "Inf", "gD"]
		@#define EndoVariables = EndoVariables + [ "DU" + Numbers[n+1] + m, "0", "Inf", "1" ]
		@#define EndoVariables = EndoVariables + [ "DP" + Numbers[n+1] + m, "0", "Inf", "gD"]
		%ID IND are MLV
		%CD, CP, C are MLV
		@#define EndoVariables = EndoVariables + [ "CDBar" + Numbers[n+1] + m, "0", "Inf", "gCDBar"]
		@#define EndoVariables = EndoVariables + [ "CPBar" + Numbers[n+1] + m, "0", "Inf", "gCPBar"]
		@#define EndoVariables = EndoVariables + [ "CBar" + Numbers[n+1] + m, "0", "Inf", "gCBar"]
		@#define EndoVariables = EndoVariables + [ "Lh" + Numbers[n+1] + m, "0", "Inf", "GN" ]
		@#for S in Sectors2
			@#define EndoVariables = EndoVariables + [ "L" + S + Numbers[n+1] + m, "0", "Inf", "GN" ]
		@#endfor
		%U is MLV
		@#define EndoVariables = EndoVariables + [ "beta" + Numbers[n+1] + m, "0", "1", "1" ]
		@#define EndoVariables = EndoVariables + [ "V" + Numbers[n+1] + m, "0", "Inf", "gV"]
		@#define EndoVariables = EndoVariables + [ "EV" + Numbers[n+1] + m, "0", "Inf", "gV"]
    @#endfor

	@#for S in Sectors0
		%IKP, IHP are MLV
		@#define EndoVariables = EndoVariables + [ "KP" + S + Numbers[n+1], "0", "Inf", "gKP"]
		@#define EndoVariables = EndoVariables + [ "KU" + S + Numbers[n+1], "0", "Inf", "1" ]
		@#define EndoVariables = EndoVariables + [ "KPP" + S + Numbers[n+1], "0", "Inf", "gKP"]
		@#define EndoVariables = EndoVariables + [ "HP" + S + Numbers[n+1], "0", "Inf", "gHP"]
		@#define EndoVariables = EndoVariables + [ "HPP" + S + Numbers[n+1], "0", "Inf", "gHP"]
		@#define ShockProcesses = ShockProcesses + [ "deltaKP" + S + Numbers[n+1], "0", "1", "deltaK" + "_", "rhodeltaK", "sigmadeltaK" ]
		@#define ShockProcesses = ShockProcesses + [ "deltaHP" + S + Numbers[n+1], "0", "1", "deltaH" + "_", "rhodeltaH", "sigmadeltaH" ]
	@#endfor
	
	@#define ShockProcesses = ShockProcesses + [ "m" + Numbers[n+1], "0", "Inf", "m_", "1", "sigmam" ]
    @#define EndoVariables = EndoVariables + [ "B" + Numbers[n+1], "0", "Inf", "gB"]
    @#define EndoVariables = EndoVariables + [ "QB" + Numbers[n+1], "0", "Inf", "1" ]
    %QB is the shadow price of domestic assets: how much the impatient households are willing to pay for marginal loan, only used to calculate spread

	@#define EndoVariables = EndoVariables + [ "lambda_F" + Numbers[n+1], "0", "Inf", "glambda_B"]
    @#for m in Members
		@#define EndoVariables = EndoVariables + [ "lambda_CBar" + Numbers[n+1] + m, "-Inf", "Inf", "glambda_C" ]
		@#define EndoVariables = EndoVariables + [ "lambda_C" + Numbers[n+1] + m, "-Inf", "Inf", "glambda_C" ]
		@#define EndoVariables = EndoVariables + [ "lambda_CPBar" + Numbers[n+1] + m, "-Inf", "Inf", "glambda_CPBar"]
		@#define EndoVariables = EndoVariables + [ "lambda_CP" + Numbers[n+1] + m, "-Inf", "Inf", "glambda_CP"]
		@#define EndoVariables = EndoVariables + [ "lambda_CDBar" + Numbers[n+1] + m, "-Inf", "Inf", "glambda_CDBar"]
		@#define EndoVariables = EndoVariables + [ "lambda_CD" + Numbers[n+1] + m, "-Inf", "Inf", "glambda_CD"]
		@#define EndoVariables = EndoVariables + [ "lambda_B" + Numbers[n+1] + m, "0", "Inf", "glambda_B"]
		@#define EndoVariables = EndoVariables + [ "lambda_GD" + Numbers[n+1] + m, "-Inf", "Inf", "glambda_GD"]
	@#endfor
    //lambda_D, lambda_K, lambda_H are MLV
    @#for S in Sectors0
		@#define EndoVariables = EndoVariables + [ "lambda_GK" + S + Numbers[n+1], "-Inf", "Inf", "glambda_GK"]
		@#define EndoVariables = EndoVariables + [ "lambda_GH" + S + Numbers[n+1], "-Inf", "Inf", "glambda_GH"]
	@#endfor

//Production and prices
	//all wages are MLVs
	
	@#for S in [ "KP", "HP", "ND" ]
		@#define EndoVariables = EndoVariables + [ "L" + S + Numbers[n+1], "0", "Inf", "GN" ]
	@#endfor
	@#for S in SectorsP1
		@#define EndoVariables = EndoVariables + [ "Y" + S + Numbers[n+1], "0", "Inf", "gYS"]
	@#endfor
	@#define EndoVariables = EndoVariables + [ "PKP" + Numbers[n+1], "0", "Inf", "gPKP"]
	@#define EndoVariables = EndoVariables + [ "PHP" + Numbers[n+1], "0", "Inf", "gPHP"]
	@#define EndoVariables = EndoVariables + [ "PD" + Numbers[n+1], "0", "Inf", "gPD"]
	@#define EndoVariables = EndoVariables + [ "PND" + Numbers[n+1], "0", "Inf", "gPND"]
	
	//L, Y, I, P in SectorsG1 are all MLVs
    //Note that KG_LAG is used for production at t, but we detrend it by trend at t-1. This is only a normalization and doesn't matters
	@#define EndoVariables = EndoVariables + [ "CG" + Numbers[n+1], "0", "Inf", "gCG"]
	@#define EndoVariables = EndoVariables + [ "KG" + Numbers[n+1], "0", "Inf", "gKG"]
	@#define EndoVariables = EndoVariables + [ "HG" + Numbers[n+1], "0", "Inf", "gHG"]
	@#define ShockProcesses = ShockProcesses + [ "deltaKG" + Numbers[n+1], "0", "1", "deltaK" + "_", "rhodeltaK", "sigmadeltaK" ]
	@#define ShockProcesses = ShockProcesses + [ "deltaHG" + Numbers[n+1], "0", "1", "deltaH" + "_", "rhodeltaH", "sigmadeltaH" ]
	
	//Y yNT yTC are MLV
	@#define EndoVariables = EndoVariables + [ "P" + Numbers[n+1], "0", "Inf", "gPS" ]

	//YNT YTC are MLV
	@#define EndoVariables = EndoVariables + [ "PTC" + Numbers[n+1], "0", "Inf", "gPS" ]
	//YTnm YTn are defined as MLV

	//PWCn is defined as MLV and = PWC, YX is MLV
    //YWP can be easily defined as MLV (see my code) but somehow it cause the equation "YHLTemp@{S}@{n} = Xi_LEAD *..." not holding at steady state due to some numerical issues (I guess)
    @#define EndoVariables = EndoVariables + [ "PWP" + Numbers[n+1], "0", "Inf", "gPS" ]
    @#define EndoVariables = EndoVariables + [ "YWP" + Numbers[n+1], "0", "Inf", "gYS" ]
	@#define EndoVariables = EndoVariables + [ "YWC" + Numbers[n+1], "0", "Inf", "gYWC"]
	//YWP and PX are MLV, FOC of YX implies that PX is zero if the global economy is symmetric
    //@#define EndoVariables = EndoVariables + [ "PX" + Numbers[n+1], "-Inf", "Inf", "GAs" ]
	//YWnm YWn are defined as MLV

	@#define EndoVariables = EndoVariables + [ "X" + Numbers[n+1], "0", "Inf", "gX"]
	%PscriptX@{n} is MLV
	
	@#for S in Sectors0
		//K RK YHL YKL YHLX are MLV
		@#define EndoVariables = EndoVariables + [ "RHP" + S + Numbers[n+1], "0", "Inf", "gPHP"]
		@#define EndoVariables = EndoVariables + [ "PHL" + S + Numbers[n+1], "0", "Inf", "gPHL"]
		
		@#define EndoVariables = EndoVariables + [ "PKL" + S + Numbers[n+1], "0", "Inf", "gPKL"]
		@#define EndoVariables = EndoVariables + [ "RKP" + S + Numbers[n+1], "0", "Inf", "gPKP"]
		@#define EndoVariables = EndoVariables + [ "KBar" + S + Numbers[n+1], "0", "Inf", "gKBar"]

		@#define EndoVariables = EndoVariables + [ "PHLX" + S + Numbers[n+1], "0", "Inf", "gPHLX"]
		@#define EndoVariables = EndoVariables + [ "YHLBar" + S + Numbers[n+1], "0", "Inf", "gYHLBar"]
		@#define EndoVariables = EndoVariables + [ "scriptX" + S + Numbers[n+1], "0", "Inf", "gX"]		
		
		@#define EndoVariables = EndoVariables + [ "P" + S + Numbers[n+1], "0", "Inf", "gPS" ]
		@#define EndoVariables = EndoVariables + [ "YHLXBar" + S + Numbers[n+1], "0", "Inf", "gYHLXBar"]
	@#endfor

//TFPs
	@#define ShockProcesses = ShockProcesses + [ "OmegaALL"       + Numbers[n+1], "0", "Inf", "1", "rhoOmegaALL",       "sigmaOmegaALL" ]
                                                                                                                        
	@#define ShockProcesses = ShockProcesses + [ "OmegaS0ALL"     + Numbers[n+1], "0", "Inf", "1", "rhoOmegaS0ALL",     "sigmaOmegaS0ALL" ]
                                                                                                                        
    @#define ShockProcesses = ShockProcesses + [ "OmegaTALL"      + Numbers[n+1], "0", "Inf", "1", "rhoOmegaTALL",      "sigmaOmegaTALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaNTALL"     + Numbers[n+1], "0", "Inf", "1", "rhoOmegaNTALL",     "sigmaOmegaNTALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaWALL"      + Numbers[n+1], "0", "Inf", "1", "rhoOmegaWALL",      "sigmaOmegaWALL" ]
                                                                                                                        
    @#define ShockProcesses = ShockProcesses + [ "OmegaKKALL"     + Numbers[n+1], "0", "Inf", "1", "rhoOmegaKKALL",     "sigmaOmegaKKALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaHLALL"     + Numbers[n+1], "0", "Inf", "1", "rhoOmegaHLALL",     "sigmaOmegaHLALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaKLALL"     + Numbers[n+1], "0", "Inf", "1", "rhoOmegaKLALL",     "sigmaOmegaKLALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaHLXALL"    + Numbers[n+1], "0", "Inf", "1", "rhoOmegaHLXALL",    "sigmaOmegaHLXALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaHLXKLALL"  + Numbers[n+1], "0", "Inf", "1", "rhoOmegaHLXKLALL",  "sigmaOmegaHLXKLALL" ]
                                                                                                                        
	@#define ShockProcesses = ShockProcesses + [ "OmegaS1ALL"     + Numbers[n+1], "0", "Inf", "1", "rhoOmegaS1ALL",     "sigmaOmegaS1ALL" ]
                                                                                                                        
    @#define ShockProcesses = ShockProcesses + [ "OmegaKALL"      + Numbers[n+1], "0", "Inf", "1", "rhoOmegaKALL",      "sigmaOmegaKALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaHALL"      + Numbers[n+1], "0", "Inf", "1", "rhoOmegaHALL",      "sigmaOmegaHALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaCALL"      + Numbers[n+1], "0", "Inf", "1", "rhoOmegaCALL",      "sigmaOmegaCALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaDi"        + Numbers[n+1], "0", "Inf", "1", "rhoOmegaDi",        "sigmaOmegaDi" ]
                                                                                                                        
    @#define ShockProcesses = ShockProcesses + [ "OmegaPALL"      + Numbers[n+1], "0", "Inf", "1", "rhoOmegaPALL",      "sigmaOmegaPALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaGALL"      + Numbers[n+1], "0", "Inf", "1", "rhoOmegaGALL",      "sigmaOmegaGALL" ]

    @#define ShockProcesses = ShockProcesses + [ "OmegaDemandALL" + Numbers[n+1], "0", "Inf", "1", "rhoOmegaDemandALL", "sigmaOmegaDemandALL" ]
    @#define ShockProcesses = ShockProcesses + [ "Omegahi"        + Numbers[n+1], "0", "Inf", "1", "rhoOmegahi",        "sigmaOmegahi" ]
	@#define ShockProcesses = ShockProcesses + [ "OmegaCPi"       + Numbers[n+1], "0", "Inf", "1", "rhoOmegaCPi",       "sigmaOmegaCPi" ]
	@#define ShockProcesses = ShockProcesses + [ "OmegaCi"        + Numbers[n+1], "0", "Inf", "1", "rhoOmegaCi",        "sigmaOmegaCi" ]

    @#define ShockProcesses = ShockProcesses + [ "OmegaTradeALL"  + Numbers[n+1], "0", "Inf", "1", "rhoOmegaTradeALL",  "sigmaOmegaTradeALL" ]
    @#define ShockProcesses = ShockProcesses + [ "OmegaYi"        + Numbers[n+1], "0", "Inf", "1", "rhoOmegaYi",        "sigmaOmegaYi" ]
	@#define ShockProcesses = ShockProcesses + [ "OmegaTCi"       + Numbers[n+1], "0", "Inf", "1", "rhoOmegaTCi",       "sigmaOmegaTCi" ]
	@#define ShockProcesses = ShockProcesses + [ "OmegaWPi"       + Numbers[n+1], "0", "Inf", "1", "rhoOmegaWPi",       "sigmaOmegaWPi" ]
	@#define ShockProcesses = ShockProcesses + [ "OmegaWCi"       + Numbers[n+1], "0", "Inf", "1", "rhoOmegaWCi",       "sigmaOmegaWCi" ]

//Gov variables
	@#define EndoVariables = EndoVariables + [ "tauKG" + Numbers[n+1], "0", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "tauHG" + Numbers[n+1], "0", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "tauCG" + Numbers[n+1], "0", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "tau" + Numbers[n+1] + "b", "-Inf", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "tau" + Numbers[n+1] + "l", "-Inf", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "tauD" + Numbers[n+1], "-Inf", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "tauND" + Numbers[n+1], "-Inf", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "tauNT" + Numbers[n+1], "-Inf", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "tauTC" + Numbers[n+1], "-Inf", "Inf", "1" ]

	@#define EndoVariables = EndoVariables + [ "iotaTX" + Numbers[n+1], "-Inf", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "iotaTM" + Numbers[n+1], "-Inf", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "iotaWX" + Numbers[n+1], "-Inf", "Inf", "1" ]
	@#define EndoVariables = EndoVariables + [ "iotaWM" + Numbers[n+1], "-Inf", "Inf", "1" ]

    @#for S in Sectors0
        @#define EndoVariables = EndoVariables + [ "tauH" + S + Numbers[n+1], "-Inf", "Inf", "1" ]
        @#define EndoVariables = EndoVariables + [ "tauK" + S + Numbers[n+1], "-Inf", "Inf", "1" ]
        @#define EndoVariables = EndoVariables + [ "tauscriptX" + S + Numbers[n+1], "-Inf", "Inf", "1" ]
    @#endfor

    @#for S in Sectors2
        @#define EndoVariables = EndoVariables + [ "tauL" + S + Numbers[n+1], "-Inf", "Inf", "1" ]
    @#endfor
    @#define EndoVariables = EndoVariables + [ "tauLa" + Numbers[n+1], "-Inf", "Inf", "1" ]
    @#define EndoVariables = EndoVariables + [ "tauLb" + Numbers[n+1], "0", "Inf", "1" ]

    //individual policy shocks
    @#define ShockProcesses = ShockProcesses + [ "uKG" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauKG" ]
    @#define ShockProcesses = ShockProcesses + [ "uHG" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauHG" ]
    @#define ShockProcesses = ShockProcesses + [ "uCG" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauCG" ]
    @#define ShockProcesses = ShockProcesses + [ "u"   + Numbers[n+1] + "b", "-Inf", "Inf", "0", "0", "sigmaub" ]
    @#define ShockProcesses = ShockProcesses + [ "u"   + Numbers[n+1] + "l", "-Inf", "Inf", "0", "0", "sigmaul" ]
    @#define ShockProcesses = ShockProcesses + [ "uD"  + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauD" ]
    @#define ShockProcesses = ShockProcesses + [ "uND" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauND" ]
    @#define ShockProcesses = ShockProcesses + [ "uNT" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauNT" ]
    @#define ShockProcesses = ShockProcesses + [ "uTC" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauTC" ]

    @#define ShockProcesses = ShockProcesses + [ "uTX" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauTX" ]
    @#define ShockProcesses = ShockProcesses + [ "uTM" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauTM" ]
    @#define ShockProcesses = ShockProcesses + [ "uWX" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauWX" ]
    @#define ShockProcesses = ShockProcesses + [ "uWM" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauWM" ]
    
    @#define ShockProcesses = ShockProcesses + [ "uLa" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauLa" ]
    @#define ShockProcesses = ShockProcesses + [ "uLb" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauLb" ]
    
    //common policy shocks
    @#define ShockProcesses = ShockProcesses + [ "uALL"     + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauALL"     ]
    @#define ShockProcesses = ShockProcesses + [ "uS1ALL"   + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauS1ALL"   ]
    @#define ShockProcesses = ShockProcesses + [ "uiotaALL" + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauiotaALL" ]
    @#define ShockProcesses = ShockProcesses + [ "ulbALL"   + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmaulbALL"   ]
    @#define ShockProcesses = ShockProcesses + [ "uCALL"    + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauCALL"    ]
    @#define ShockProcesses = ShockProcesses + [ "uLALL"    + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauLALL"    ]
    @#define ShockProcesses = ShockProcesses + [ "uHALL"    + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauHALL"    ]
    @#define ShockProcesses = ShockProcesses + [ "uKALL"    + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauKALL"    ]
    @#define ShockProcesses = ShockProcesses + [ "uXALL"    + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauXALL"    ]
    @#define ShockProcesses = ShockProcesses + [ "uTALL"    + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauTALL"    ]
    @#define ShockProcesses = ShockProcesses + [ "uNTALL"   + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauNTALL"   ]
    @#define ShockProcesses = ShockProcesses + [ "uWALL"    + Numbers[n+1], "-Inf", "Inf", "0", "0", "sigmauWALL"    ]

//variables in measurement equations
	@#define ShockProcesses = ShockProcesses + [ "alpha_resid" + Numbers[n+1], "0", "1", "alpha_resid_", "1", "sigmaalpha_resid" ]
	@#define ShockProcesses = ShockProcesses + [ "alpha_pubedu" + Numbers[n+1], "0", "1", "alpha_pubedu_", "1", "sigmaalpha_pubedu" ]
    @#for m in Members
        @#define EndoVariables = EndoVariables + [ "Dtilde" + Numbers[n+1] + m, "0", "Inf", "gD"]
        @#define EndoVariables = EndoVariables + [ "deltaDtildeAUXD" + Numbers[n+1] + m, "0", "Inf", "gD"]
        @#define EndoVariables = EndoVariables + [ "deltaDtildeAUXN" + Numbers[n+1] + m, "0", "Inf", "gD"]
    @#endfor

    @#for S in Sectors0
        @#define EndoVariables = EndoVariables + [ "KPtilde" + S + Numbers[n+1], "0", "Inf", "gKP"]
        @#define EndoVariables = EndoVariables + [ "deltaKPtildeAUXD" + S + Numbers[n+1], "0", "Inf", "gKP"]
        @#define EndoVariables = EndoVariables + [ "deltaKPtildeAUXN" + S + Numbers[n+1], "0", "Inf", "gKP"]
    @#endfor

	@#define EndoVariables = EndoVariables + [ "deltaKGtildeAUXD" + Numbers[n+1], "0", "Inf", "gKG"]
	@#define EndoVariables = EndoVariables + [ "deltaKGtildeAUXN" + Numbers[n+1], "0", "Inf", "gKG"]
	@#define EndoVariables = EndoVariables + [ "deltaHGtildeAUXD" + Numbers[n+1], "0", "Inf", "gHG"]
	@#define EndoVariables = EndoVariables + [ "deltaHGtildeAUXN" + Numbers[n+1], "0", "Inf", "gHG"]
@#endfor

//Final observables and measurement errors (for estimation)
var
  gryW gpopW
  @#for n in 1:SN-1
	yshare@{n}
  @#endfor
  @#for n in 1:SN
	popshare@{n}
  @#endfor
  @#if SN > 0
    OECDihy1 ESrdy1 BEAcy1  JSTiy1  BEAgcy1  BEAgiy1  JSTxy1  BEAgpcgpy1  BEAgpigpy1  BEAgpgcgpy1 BEAgpgigpy1 BEAgpxgpy1  BEAgpmgpy1  BEAhpop1   BEAwhy1   BEAcfcy1  JSTexpostr1  FREDlrni1 JSTtauy1
  @#endif
  @#if SN > 1
    OECDihy2 ESrdy2 PWTcy2  JSTiy2  JSTgy2            JSTxy2  PWTgpcgpy2  PWTgpigpy2  PWTgpgcgpy2             PWTgpxgpy2  PWTgpmgpy2  PWThpop2   PWTwhy2   PWTdelta2 JSTexpostr2  DBlrni2   JSTtauy2
  @#endif
  @#if SN > 2
    OECDihy3 ESrdy3 MILLcy3 MILLiy3 MILLgcy3 MILLgiy3 MILLxy3 MILLgpcgpy3 MILLgpigpy3 MILLgpgcgpy3            MILLgpxgpy3 MILLgpmgpy3 MILLhpop3  MILLwhy3  MILLcfcy3 MILLexpostr3 MILLlrni3 MILLtauy3
  @#endif
  @#if SN > 3
    OECDihy4 ESrdy4 PWTcy4  JSTiy4  JSTgy4            JSTxy4  PWTgpcgpy4  PWTgpigpy4  PWTgpgcgpy4             PWTgpxgpy4  PWTgpmgpy4  PWThpop4   PWTwhy4   PWTdelta4 JSTexpostr4  BDFlrni4  JSTtauy4
  @#endif
  @#if SN > 4
    OECDihy5 ESrdy5 PWTcy5  JSTiy5  JSTgy5            JSTxy5  PWTgpcgpy5  PWTgpigpy5  PWTgpgcgpy5             PWTgpxgpy5  PWTgpmgpy5  PWThpop5   PWTwhy5   PWTcfcy5  JSTexpostr5            JSTtauy5
  @#endif
  @#if SN > 5
    OECDihy6 ESrdy6 PWTcy6  JSTiy6  JSTgy6            JSTxy6  PWTgpcgpy6  PWTgpigpy6  PWTgpgcgpy6             PWTgpxgpy6  PWTgpmgpy6  PWThpop6   PWTwhy6   PWTcfcy6  JSTexpostr6            JSTtauy6;
  @#endif
varexo
  epsilon_gryW epsilon_gpopW
  @#for n in 1:SN-1
	epsilon_yshare@{n}
  @#endfor
  @#for n in 1:SN
	epsilon_popshare@{n}
  @#endfor
  @#if SN > 0
    epsilon_OECDihy1 epsilon_ESrdy1 epsilon_BEAcy1  epsilon_JSTiy1  epsilon_BEAgcy1  epsilon_BEAgiy1   epsilon_JSTxy1     epsilon_BEAgpcgpy1  epsilon_BEAgpigpy1  epsilon_BEAgpgcgpy1 epsilon_BEAgpgigpy1 epsilon_BEAgpxgpy1  epsilon_BEAgpmgpy1  epsilon_BEAhpop1   epsilon_BEAwhy1   epsilon_BEAcfcy1  epsilon_JSTexpostr1  epsilon_FREDlrni1 epsilon_JSTtauy1
  @#endif
  @#if SN > 1
    epsilon_OECDihy2 epsilon_ESrdy2 epsilon_PWTcy2  epsilon_JSTiy2  epsilon_JSTgy2                     epsilon_JSTxy2     epsilon_PWTgpcgpy2  epsilon_PWTgpigpy2  epsilon_PWTgpgcgpy2                     epsilon_PWTgpxgpy2  epsilon_PWTgpmgpy2  epsilon_PWThpop2   epsilon_PWTwhy2   epsilon_PWTdelta2 epsilon_JSTexpostr2  epsilon_DBlrni2   epsilon_JSTtauy2
  @#endif
  @#if SN > 2
    epsilon_OECDihy3 epsilon_ESrdy3 epsilon_MILLcy3 epsilon_MILLiy3 epsilon_MILLgcy3 epsilon_MILLgiy3  epsilon_MILLxy3    epsilon_MILLgpcgpy3 epsilon_MILLgpigpy3 epsilon_MILLgpgcgpy3                    epsilon_MILLgpxgpy3 epsilon_MILLgpmgpy3 epsilon_MILLhpop3  epsilon_MILLwhy3  epsilon_MILLcfcy3 epsilon_MILLexpostr3 epsilon_MILLlrni3 epsilon_MILLtauy3
  @#endif
  @#if SN > 3
    epsilon_OECDihy4 epsilon_ESrdy4 epsilon_PWTcy4  epsilon_JSTiy4  epsilon_JSTgy4                     epsilon_JSTxy4     epsilon_PWTgpcgpy4  epsilon_PWTgpigpy4  epsilon_PWTgpgcgpy4                     epsilon_PWTgpxgpy4  epsilon_PWTgpmgpy4  epsilon_PWThpop4   epsilon_PWTwhy4   epsilon_PWTdelta4 epsilon_JSTexpostr4  epsilon_BDFlrni4  epsilon_JSTtauy4
  @#endif
  @#if SN > 4
    epsilon_OECDihy5 epsilon_ESrdy5 epsilon_PWTcy5  epsilon_JSTiy5  epsilon_JSTgy5                     epsilon_JSTxy5     epsilon_PWTgpcgpy5  epsilon_PWTgpigpy5  epsilon_PWTgpgcgpy5                     epsilon_PWTgpxgpy5  epsilon_PWTgpmgpy5  epsilon_PWThpop5   epsilon_PWTwhy5   epsilon_PWTcfcy5  epsilon_JSTexpostr5                    epsilon_JSTtauy5
  @#endif
  @#if SN > 5
    epsilon_OECDihy6 epsilon_ESrdy6 epsilon_PWTcy6  epsilon_JSTiy6  epsilon_JSTgy6                     epsilon_JSTxy6     epsilon_PWTgpcgpy6  epsilon_PWTgpigpy6  epsilon_PWTgpgcgpy6                     epsilon_PWTgpxgpy6  epsilon_PWTgpmgpy6  epsilon_PWThpop6   epsilon_PWTwhy6   epsilon_PWTcfcy6  epsilon_JSTexpostr6                    epsilon_JSTtauy6;
  @#endif

//Extra final observables (for IRF)
@#if ExtraVariable == 1
    @#include "ExtraVariable_part1.mod"
@#endif

@#include "CreateShocks.mod"
@#include "ClassifyDeclare.mod"

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                       //
//                                              declare parameters                                                       //
//                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//global parameters
parameters lambda eta phiR zetaR gamma scriptp scriptq psi psib psil;
parameters hpop_ rdy_;

//country-specific parameters but must be constant across countries as required by the model
parameters alphaCP alphaCD alphah alphaKP alphaD alphaND alphaHP alphaHW alphaHL alphaK alphaKL alphaHLX alphaY betabarl;

//country-specific parameters that are assumed to be constant across countries
parameters sigma gammaV xi bbeta;
parameters h varrhoC eC varrhoCP eCP varrhoCD ;
parameters nuW nuT nuNT nuSW nuST nuSNT nuD nuNDCG nuK nuH nuh;
parameters rhoQB;
parameters thetaGKP thetaPKP thetaKU0 thetaKU1 thetaGHP thetaPHP thetaGD thetaPD thetaDU0 thetaDU1;
parameters eNC alphaNC eT eW FWCtilde FKtilde;
parameters o eKLT eKLNT eKLW varrhoKL eHLXT eHLXNT eHLXW varrhoHLX eYT eYNT eYW varrhoY;

//Policy (unit roots): SS, std, responsiveness, and the extent to which taxes are true taxes, fixed across countries
parameters tauKG_            phiYtauKG         phiLtauKG  phiutauKG    sigmauKG    sigmauS1ALL   sigmauALL    ;
parameters tauHG_            phiYtauHG         phiLtauHG  phiutauHG    sigmauHG                               ;
parameters tauCG_            phiYtauCG         phiLtauCG  phiutauCG    sigmauCG                               ;
parameters taub_             phiYtaub          phiLtaub   phiutaub     sigmaub     sigmaulbALL                ;
parameters taul_             phiYtaul          phiLtaul   phiutaul     sigmaul                                ;
parameters tauD_             phitauD                      phiutauD     sigmauD     sigmauCALL                 ;
parameters tauND_            phitauND                     phiutauND    sigmauND                               ;
parameters tauNT_            phitauNT                     phiutauNT    sigmauNT                               ;
parameters tauTC_            phitauTC                     phiutauTC    sigmauTC                               ;
parameters iotaTX_           phiiotaTX                    phiuiotaTX   sigmauTX    sigmauiotaALL              ;
parameters iotaTM_           phiiotaTM                    phiuiotaTM   sigmauTM                               ;
parameters iotaWX_           phiiotaWX                    phiuiotaWX   sigmauWX                               ;
parameters iotaWM_           phiiotaWM                    phiuiotaWM   sigmauWM                               ;
parameters tauLa_            phitauL                      phiutauLa    sigmauLa    sigmauLALL                 ;
parameters tauLb_                                         phiutauLb    sigmauLb                               ;
parameters tauHW_            phitauHW                     phiutauHW                sigmauHALL    sigmauWALL   ;
parameters tauHT_            phitauHT                     phiutauHT                              sigmauTALL   ;
parameters tauHNT_           phitauHNT                    phiutauHNT                             sigmauNTALL  ;
parameters tauKW_            phitauKW                     phiutauKW                sigmauKALL                 ;
parameters tauKT_            phitauKT                     phiutauKT                                           ;
parameters tauKNT_           phitauKNT                    phiutauKNT                                          ;
parameters tauscriptXW_      phitauscriptXW               phiutauXW                sigmauXALL                 ;
parameters tauscriptXT_      phitauscriptXT               phiutauXT                                           ;
parameters tauscriptXNT_     phitauscriptXNT              phiutauXNT                                          ;

//TFPs: parameters fixedd across countries
parameters rhoOmegaALL       sigmaOmegaALL        ;
parameters rhoOmegaS0ALL     sigmaOmegaS0ALL      ;
parameters rhoOmegaTALL      sigmaOmegaTALL       ;
parameters rhoOmegaNTALL     sigmaOmegaNTALL      ;
parameters rhoOmegaWALL      sigmaOmegaWALL       ;
parameters rhoOmegaKKALL     sigmaOmegaKKALL      ;
parameters rhoOmegaHLALL     sigmaOmegaHLALL      ;
parameters rhoOmegaKLALL     sigmaOmegaKLALL      ;
parameters rhoOmegaHLXALL    sigmaOmegaHLXALL     ;
parameters rhoOmegaHLXKLALL  sigmaOmegaHLXKLALL   ;
parameters rhoOmegaS1ALL     sigmaOmegaS1ALL      ;
parameters rhoOmegaKALL      sigmaOmegaKALL       ;
parameters rhoOmegaHALL      sigmaOmegaHALL       ;
parameters rhoOmegaCALL      sigmaOmegaCALL       ;
parameters rhoOmegaDi        sigmaOmegaDi         ;
parameters rhoOmegaPALL      sigmaOmegaPALL       ;
parameters rhoOmegaGALL      sigmaOmegaGALL       ;
parameters rhoOmegaDemandALL sigmaOmegaDemandALL  ;
parameters rhoOmegahi        sigmaOmegahi         ;
parameters rhoOmegaCPi       sigmaOmegaCPi        ;
parameters rhoOmegaCi        sigmaOmegaCi         ;
parameters rhoOmegaTradeALL  sigmaOmegaTradeALL   ;
parameters rhoOmegaYi        sigmaOmegaYi         ;
parameters rhoOmegaTCi       sigmaOmegaTCi        ;
parameters rhoOmegaWPi       sigmaOmegaWPi        ;
parameters rhoOmegaWCi       sigmaOmegaWCi        ;
parameters Omegah_ OmegaCP_ OmegaC_ OmegaKP_ OmegaHP_ OmegaD_ OmegaND_ OmegaKG_ OmegaHG_ OmegaCG_ OmegaY_ OmegaTC_ OmegaWP_ OmegaWC_ OmegaKT_ OmegaHLT_ OmegaKLT_ OmegaHLXT_ OmegaT_ OmegaKNT_ OmegaHLNT_ OmegaKLNT_ OmegaHLXNT_ OmegaNT_ OmegaKW_ OmegaHLW_ OmegaKLW_ OmegaHLXW_ OmegaW_;

//stationary processes: parameters fixedd across countries
//note that the processes of beta and ROW are defined manually (not by transformation engine)
parameters rhoGN          sigmaGN            GN_         ;
parameters rhoZ           sigmaZ             Z_          ;
parameters rhodeltaItilde sigmadeltaItilde   deltaItilde_;
parameters rhoscriptFI    sigmascriptFI      scriptFI_   ;
parameters rhodeltaD      sigmadeltaD        deltaD_     ;
parameters rhokappa0      sigmakappa0        kappa0_     ;
parameters rhokappah      sigmakappah        kappah_     ;
@#for S in Sectors2
parameters rhokappa@{S}   sigmakappa@{S}     kappa@{S}_  ;
@#endfor
parameters rhodeltaK      sigmadeltaK        deltaK_    ;
parameters rhodeltaH      sigmadeltaH        deltaH_    ;
parameters rhobeta        sigmabeta          betabarb    ;
parameters rhoPP0 rhoPY0 rhoYP0 rhoYY0 rho0 sigmaP0 sigmaY0 pT0 yTC0;

//RW: parameters fixedd across countries except the SS of population shares
parameters sigmam             m_            ;           
parameters sigmavarpi         varpi_        ;       
parameters sigmaeT0           eT0_          ;         
parameters sigmaalpha_resid   alpha_resid_  ; 
parameters sigmaalpha_pubedu  alpha_pubedu_ ;
parameters sigmaNtilde                      ;             
@#for n in 1:SN
    parameters Ntilde@{n}_;
@#endfor

//STD of measurement errors, fixed across countries
//note that measurement errors are defined manually (not by transformation engine)
parameters  sigma_gryW sigma_yshare sigma_gpopW sigma_popshare;
parameters  sigma_ihy sigma_rdy sigma_cy  sigma_iy  sigma_gcy sigma_giy  sigma_xy  sigma_gpcgpy  sigma_gpigpy  sigma_gpgcgpy  sigma_gpgigpy  sigma_gpxgpy  sigma_gpmgpy  sigma_hpop   sigma_why   sigma_cfcy  sigma_expostr  sigma_lrni sigma_tauy;

@#include "est_calibration.mod"

//////////////////////////////////////Parameter transformation (not calibrated)//////////////////////////////////////////////////
parameters logit_xi;
parameters logit_rhoGN logit_rhoZ logit_rhodeltaItilde logit_rhoscriptFI logit_rhodeltaD logit_rhokappa0 logit_rhokappah;
@#for S in Sectors2
parameters logit_rhokappa@{S};
@#endfor

parameters logit_alphaCP logit_alphaCD logit_alphah logit_alphaKP logit_alphaD logit_alphaND logit_alphaHP logit_alphaHW logit_alphaHL logit_alphaK logit_alphaKL logit_alphaHLX logit_alphaY;

//////////////////////////////////////Parameter hierarchical structure (not calibrated)//////////////////////////////////////////////////

//parameters nuPriorALL nuPriorS0ALL nuPriorSS0ALL nuPriorS1ALL nuPriorWALL nuPriorTALL nuPriorNTALL nuPriorDi nuPriorNDCGi nuPriorKi nuPriorHi nuPriorhi;

@#for S in Sectors0
//	parameters eKL@{S}Priori eHLX@{S}Priori eY@{S}Priori;
@#endfor
//parameters eKLPriorALL eHLXPriorALL eYPriorALL;

//parameters rhoOmegaPriorALL rhoOmegaPriorS0ALL rhoOmegaPriorStepALL rhoOmegaPriorS1ALL rhoOmegaPriorPGALL rhoOmegaPriorALLi rhoOmegaPriorS0ALLi rhoOmegaPriorTALLi rhoOmegaPriorNTALLi rhoOmegaPriorWALLi rhoOmegaPriorKKALLi rhoOmegaPriorHLALLi rhoOmegaPriorKLALLi rhoOmegaPriorHLXALLi rhoOmegaPriorHLXKLALLi rhoOmegaPriorS1ALLi rhoOmegaPriorKALLi rhoOmegaPriorHALLi rhoOmegaPriorCALLi rhoOmegaPriorDii rhoOmegaPriorPALLi rhoOmegaPriorGALLi rhoOmegaPriorDemandALLi rhoOmegaPriorhii rhoOmegaPriorCPii rhoOmegaPriorCii rhoOmegaPriorTradeALLi rhoOmegaPriorYii rhoOmegaPriorTCii rhoOmegaPriorWPii rhoOmegaPriorWCii;
//parameters sigmaOmegaPriorALL sigmaOmegaPriorS0ALL sigmaOmegaPriorStepALL sigmaOmegaPriorS1ALL sigmaOmegaPriorPGALL sigmaOmegaPriorALLi sigmaOmegaPriorS0ALLi sigmaOmegaPriorTALLi sigmaOmegaPriorNTALLi sigmaOmegaPriorWALLi sigmaOmegaPriorKKALLi sigmaOmegaPriorHLALLi sigmaOmegaPriorKLALLi sigmaOmegaPriorHLXALLi sigmaOmegaPriorHLXKLALLi sigmaOmegaPriorS1ALLi sigmaOmegaPriorKALLi sigmaOmegaPriorHALLi sigmaOmegaPriorCALLi sigmaOmegaPriorDii sigmaOmegaPriorPALLi sigmaOmegaPriorGALLi sigmaOmegaPriorDemandALLi sigmaOmegaPriorhii sigmaOmegaPriorCPii sigmaOmegaPriorCii sigmaOmegaPriorTradeALLi sigmaOmegaPriorYii sigmaOmegaPriorTCii sigmaOmegaPriorWPii sigmaOmegaPriorWCii;

//parameters phiLtauSG1PriorALL phiLtauKGPriori phiLtauHGPriori phiLtauCGPriori;
//parameters phiLtaulbPriorALL phiLtaubPriori phiLtaulPriori;

//parameters phiYtauSG1PriorALL phiYtauKGPriori phiYtauHGPriori phiYtauCGPriori; 
//parameters phiYtaulbPriorALL phiYtaubPriori phiYtaulPriori;

//parameters phiutauPriorALL phiuiotaPriorALL phiutauSG1PriorALL phiutaulbPriorALL phiutauCPriorALL phiutauLPriorALL phiutauHPriorALL phiutauKPriorALL phiutauXPriorALL phiutauWPriorALL phiutauTPriorALL phiutauNTPriorALL;
//parameters phiuiotaTXPriori phiuiotaTMPriori phiuiotaWXPriori phiuiotaWMPriori phiutauKGPriori  phiutauHGPriori  phiutauCGPriori  phiutaubPriori   phiutaulPriori   phiutauDPriori   phiutauNDPriori  phiutauNTPriori  phiutauLaPriori  phiutauLbPriori;

//parameters phiiotaTXPriori phiiotaTMPriori phiiotaWXPriori phiiotaWMPriori phitauDPriori phitauNDPriori;
//parameters phiiotaPriorALL phitauCPriorALL phitauHPriorALL phitauKPriorALL phitauXPriorALL phitauWPriorALL phitauTPriorALL phitauNTPriorALL ;

//parameters tauPriorALL_ tauSG1PriorALL_ tauKGPriori_ tauHGPriori_ tauCGPriori_ taubPriori_ taulPriori_ tauDPriori_ tauNDPriori_ tauNTPriori_ tauLaPriori_ tauLbPriori_;
//parameters taulbPriorALL_ tauCPriorALL_ tauLPriorALL_ tauHPriorALL_ tauKPriorALL_ tauXPriorALL_ tauWPriorALL_ tauTPriorALL_ tauNTPriorALL_ ;

//parameters sigmauPriorALL sigmauKGPriori sigmauHGPriori sigmauCGPriori sigmaubPriori sigmaulPriori sigmauDPriori sigmauNDPriori sigmauNTPriori sigmauTXPriori sigmauTMPriori sigmauWXPriori sigmauWMPriori sigmauLaPriori sigmauLbPriori sigmauALLPriori sigmauS1ALLPriori sigmauiotaALLPriori sigmaulbALLPriori sigmauCALLPriori sigmauLALLPriori sigmauHALLPriori sigmauKALLPriori sigmauXALLPriori sigmauTALLPriori sigmauNTALLPriori sigmauWALLPriori;
//parameters sigmauSG1PriorALL sigmaulbPriorALL sigmauCPriorALL sigmauiotaPriorALL sigmauLPriorALL sigmauPriorHKXALL sigmauPriorS0ALL;

@#for n in 1:151
    parameters InternalPrior_@{n};
@#endfor
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                       //
//                                              start of the model                                                       //
//                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
model(use_dll);
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                     cross-country homogeneous parameters                                              //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//shared parameters, dynamic model use @{n}, but static model and ss solver don't
@#for n in 1:SN
    #alphaHG@{n}=alphaHP;
    #alphaHP@{n}=alphaHP;
    #alphaHW@{n}=alphaHW;

    #alphaKG@{n}=alphaKP;
    #alphaKP@{n}=alphaKP;
    #alphaK@{n}=alphaK;

    #alphaHL@{n}=alphaHL;
    #alphaKL@{n}=alphaKL;
    #alphaHLX@{n}=alphaHLX;
    #alphaY@{n}=alphaY;

    #alphaND@{n} = alphaND;
    #alphaD@{n} = alphaD;
    #alphah@{n} = alphah;
    #alphaCD@{n} = alphaCD;
    #alphaCG@{n} = alphaND;
    #alphaCP@{n} = alphaCP;

    #betabar@{n}l = betabarl;
@#endfor

//Extra restrictions we put on estimation, dynamic model use @{n}, but static model and ss solver don't
@#for n in 1:SN
    #sigma@{n} = sigma;
    #gammaV@{n} = gammaV;
    #xi@{n} = xi;
    #bbeta@{n} = bbeta;
    #h@{n} = h;
    #varrhoC@{n} = varrhoC;
    #eC@{n} = eC;
    #varrhoCP@{n} = varrhoCP;
    #eCP@{n} = eCP;
    #varrhoCD@{n} = varrhoCD;
    #nuW@{n} = nuW;
    #nuT@{n} = nuT;
    #nuNT@{n} = nuNT;
    #nuSW@{n} = nuSW;
    #nuST@{n} = nuST;
    #nuSNT@{n} = nuSNT;
    #nuD@{n} = nuD;
    #nuNDCG@{n} = nuNDCG;
    #nuK@{n} = nuK;
    #nuH@{n} = nuH;
    #nuh@{n} = nuh;
	#rhoQB@{n} = rhoQB;
    #thetaGKP@{n} = thetaGKP;
    #thetaPKP@{n} = thetaPKP;
    #thetaKU0@{n} = thetaKU0;
    #thetaKU1@{n} = thetaKU1;
    #thetaGHP@{n} = thetaGHP;
    #thetaPHP@{n} = thetaPHP;
    #thetaGD@{n} = thetaGD;
    #thetaPD@{n} = thetaPD;
    #thetaDU0@{n} = thetaDU0;
    #thetaDU1@{n} = thetaDU1;
    #thetaGKG@{n} = thetaGKP;
    #thetaGHG@{n} = thetaGHP;
    #eNC@{n} = eNC;
    #alphaNC@{n} = alphaNC;
    #eT@{n} = eT;
    #eW@{n} = eW;
    #FWCtilde@{n} = FWCtilde;
    #FKtilde@{n} = FKtilde;
    #o@{n} = o;
    #eKLT@{n} = eKLT;
    #eKLNT@{n} = eKLNT;
    #eKLW@{n} = eKLW;
    #varrhoKL@{n} = varrhoKL;
    #eHLXT@{n} = eHLXT;
    #eHLXNT@{n} = eHLXNT;
    #eHLXW@{n} = eHLXW;
    #varrhoHLX@{n} = varrhoHLX;
    #eYT@{n} = eYT;
    #eYNT@{n} = eYNT;
    #eYW@{n} = eYW;
    #varrhoY@{n} = varrhoY;
@#endfor

//Parameters of exogenous process are already identical across countries when declared, or used (TFPs SS), or is global (ROW VAR)
//except the followings (beta, policy responsiveness, and the extent to which a tax is true) (note that policy ss do not enter the dynamic model)
@#for n in 1:SN
    #betabar@{n}b = betabarb;
	#rhobeta@{n} = rhobeta;
	#sigmabeta@{n} = sigmabeta;
	
	#phiYtauKG@{n}       =phiYtauKG      ;    #phiLtauKG@{n} =phiLtauKG;  #phiutauKG@{n}  = phiutauKG   ;
	#phiYtauHG@{n}       =phiYtauHG      ;    #phiLtauHG@{n} =phiLtauHG;  #phiutauHG@{n}  = phiutauHG   ;
	#phiYtauCG@{n}       =phiYtauCG      ;    #phiLtauCG@{n} =phiLtauCG;  #phiutauCG@{n}  = phiutauCG   ;
	#phiYtau@{n}b        =phiYtaub       ;    #phiLtau@{n}b  =phiLtaub ;  #phiutau@{n}b   = phiutaub    ;
	#phiYtau@{n}l        =phiYtaul       ;    #phiLtau@{n}l  =phiLtaul ;  #phiutau@{n}l   = phiutaul    ;
	#phitauD@{n}         =phitauD        ;                                #phiutauD@{n}   = phiutauD    ;
	#phitauND@{n}        =phitauND       ;                                #phiutauND@{n}  = phiutauND   ;
	#phitauNT@{n}        =phitauNT       ;	                              #phiutauNT@{n}  = phiutauNT   ;
	#phitauTC@{n}        =phitauTC       ;                                #phiutauTC@{n}  = phiutauTC   ;
	#phiiotaTX@{n}       =phiiotaTX      ;                                #phiuiotaTX@{n} = phiuiotaTX  ;
	#phiiotaTM@{n}       =phiiotaTM      ;                                #phiuiotaTM@{n} = phiuiotaTM  ;
	#phiiotaWX@{n}       =phiiotaWX      ;                                #phiuiotaWX@{n} = phiuiotaWX  ;
	#phiiotaWM@{n}       =phiiotaWM      ;                                #phiuiotaWM@{n} = phiuiotaWM  ;
	#phitauL@{n}         =phitauL        ;                                #phiutauLa@{n}  = phiutauLa   ;
	                                                                      #phiutauLb@{n}  = phiutauLb   ;
	#phitauHW@{n}        =phitauHW       ;                                #phiutauHW@{n}  = phiutauHW   ;
	#phitauHT@{n}        =phitauHT       ;                                #phiutauHT@{n}  = phiutauHT   ;
	#phitauHNT@{n}       =phitauHNT      ;                                #phiutauHNT@{n} = phiutauHNT  ;
	#phitauKW@{n}        =phitauKW       ;                                #phiutauKW@{n}  = phiutauKW   ;
	#phitauKT@{n}        =phitauKT       ;                                #phiutauKT@{n}  = phiutauKT   ;
	#phitauKNT@{n}       =phitauKNT      ;                                #phiutauKNT@{n} = phiutauKNT  ;
	#phitauscriptXW@{n}  =phitauscriptXW ;                                #phiutauXW@{n}  = phiutauXW   ;
	#phitauscriptXT@{n}  =phitauscriptXT ;                                #phiutauXT@{n}  = phiutauXT   ;
	#phitauscriptXNT@{n} =phitauscriptXNT;                                #phiutauXNT@{n} = phiutauXNT  ;
	
	
	
@#endfor
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             the trend, the TFPs                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#t3 = (alphaK1 * alphaY1);
#t4 = (t3 * alphaHG1);
#t6 = (alphaHW1 * alphaKG1 * alphaKL1);
#t10 = (alphaHW1 * alphaKL1 * alphaKP1);
#t13 = (alphaY1 * alphaHG1);
#t15 = (alphaHLX1 * alphaHP1);
#t16 = (t15 * alphaHW1);
#t21 = (alphaK1 * alphaHG1);
#t26 = (alphaHW1 ^ 2);
#t31 = (alphaY1 * alphaHL1);
#t33 = (alphaKG1 * alphaKL1);
#t35 = (alphaKL1 * alphaKP1);
#t37 = (alphaK1 * alphaHW1);
#t44 = 2 * t4 * t6 - 2 * t4 * t10 - 2 * t13 * alphaHL1 * t16 + t3 * t6 - t3 * t10 - 2 * t21 * t6 + 2 * t21 * t10 - t13 * alphaHLX1 * t26 + 2 * t13 * t10 - t31 * t16 - t3 * t33 + t3 * t35 - t37 * t33 + t37 * t35 + t13 * alphaHLX1 * alphaHW1 + t13 * t26 + t31 * t15;
#t45 = alphaY1 * alphaHLX1;
#t47 = alphaY1 * alphaHW1;
#t49 = alphaHW1 * alphaHG1;
#t64 = alphaK1 * alphaKG1 * alphaKL1 - alphaK1 * alphaKL1 * alphaKP1 - alphaY1 * alphaKL1 * alphaKP1 + alphaY1 * t26 - t13 * alphaHW1 - t45 * t26 + t47 * t35 - 2 * t49 * t35 + 2 * t45 * alphaHW1 + alphaY1 - t10 + t35 - t45 - 2 * t47 + 2 * t49 + alphaHW1 - 1;
#b = (-1 + alphaHLX1) * alphaY1 / (t44 + t64) * (t49 + alphaHW1 - 1) * (-1 + alphaHW1);
#c =b*alphaHG1/(1-alphaHW1-alphaHW1*alphaHG1);
#d =(b-c*alphaHW1)/(1-alphaHW1);
#a = b+1;

@#for j in 1:MaximumLag-1
    #gII_LAG@{j}=exp(log_gII(-@{j}));
    #gB_LAG@{j}=exp(log_gB(-@{j}));
    #gYS_LAG@{j}=exp(log_gYS(-@{j}));
    #gPS_LAG@{j}=exp(log_gPS(-@{j}));
    #gYWC_LAG@{j}=exp(log_gYWC(-@{j}));
    #gX_LAG@{j}=exp(log_gX(-@{j}));
    #gKP_LAG@{j}=exp(log_gKP(-@{j}));
    #gHP_LAG@{j}=exp(log_gHP(-@{j}));
    #gPKP_LAG@{j}=exp(log_gPKP(-@{j}));
    #gPHP_LAG@{j}=exp(log_gPHP(-@{j}));
    #gKG_LAG@{j}=exp(log_gKG(-@{j}));
    #gHG_LAG@{j}=exp(log_gHG(-@{j}));
    #gPHL_LAG@{j}=exp(log_gPHL(-@{j}));
    #gPKL_LAG@{j}=exp(log_gPKL(-@{j}));
    #gKBar_LAG@{j}=exp(log_gKBar(-@{j}));
    #gPHLX_LAG@{j}=exp(log_gPHLX(-@{j}));
    #gYHLBar_LAG@{j}=exp(log_gYHLBar(-@{j}));
    #gYHLXBar_LAG@{j}=exp(log_gYHLXBar(-@{j}));
    #gCND_LAG@{j}=exp(log_gCND(-@{j}));
    #gD_LAG@{j}=exp(log_gD(-@{j}));
    #gCDBar_LAG@{j}=exp(log_gCDBar(-@{j}));
    #gCPBar_LAG@{j}=exp(log_gCPBar(-@{j}));
    #gCBar_LAG@{j}=exp(log_gCBar(-@{j}));
    #gV_LAG@{j}=exp(log_gV(-@{j}));
    #glambda_C_LAG@{j}=exp(log_glambda_C(-@{j}));
    #glambda_B_LAG@{j}=exp(log_glambda_B(-@{j}));
    #glambda_CPBar_LAG@{j}=exp(log_glambda_CPBar(-@{j}));
    #glambda_CP_LAG@{j}=exp(log_glambda_CP(-@{j}));
    #glambda_CDBar_LAG@{j}=exp(log_glambda_CDBar(-@{j}));
    #glambda_CD_LAG@{j}=exp(log_glambda_CD(-@{j}));
    #glambda_GD_LAG@{j}=exp(log_glambda_GD(-@{j}));
    #glambda_GK_LAG@{j}=exp(log_glambda_GK(-@{j}));
    #glambda_GH_LAG@{j}=exp(log_glambda_GH(-@{j}));
    #gPD_LAG@{j}=exp(log_gPD(-@{j}));
    #gPND_LAG@{j}=exp(log_gPND(-@{j}));
    #gCG_LAG@{j}=exp(log_gCG(-@{j}));
@#endfor

@#for j in 1:MaximumLead
    #gII_LEAD@{j}=exp(log_gII(@{j}));
    #gB_LEAD@{j}=exp(log_gB(@{j}));
    #gYS_LEAD@{j}=exp(log_gYS(@{j}));
    #gPS_LEAD@{j}=exp(log_gPS(@{j}));
    #gYWC_LEAD@{j}=exp(log_gYWC(@{j}));
    #gX_LEAD@{j}=exp(log_gX(@{j}));
    #gKP_LEAD@{j}=exp(log_gKP(@{j}));
    #gHP_LEAD@{j}=exp(log_gHP(@{j}));
    #gPKP_LEAD@{j}=exp(log_gPKP(@{j}));
    #gPHP_LEAD@{j}=exp(log_gPHP(@{j}));
    #gKG_LEAD@{j}=exp(log_gKG(@{j}));
    #gHG_LEAD@{j}=exp(log_gHG(@{j}));
    #gPHL_LEAD@{j}=exp(log_gPHL(@{j}));
    #gPKL_LEAD@{j}=exp(log_gPKL(@{j}));
    #gKBar_LEAD@{j}=exp(log_gKBar(@{j}));
    #gPHLX_LEAD@{j}=exp(log_gPHLX(@{j}));
    #gYHLBar_LEAD@{j}=exp(log_gYHLBar(@{j}));
    #gYHLXBar_LEAD@{j}=exp(log_gYHLXBar(@{j}));
	#gCND_LEAD@{j}=exp(log_gCND(@{j}));
	#gD_LEAD@{j}=exp(log_gD(@{j}));
	#gCDBar_LEAD@{j}=exp(log_gCDBar(@{j}));
	#gCPBar_LEAD@{j}=exp(log_gCPBar(@{j}));
	#gCBar_LEAD@{j}=exp(log_gCBar(@{j}));
    #gV_LEAD@{j}=exp(log_gV(@{j}));
    #glambda_C_LEAD@{j}=exp(log_glambda_C(@{j}));
	#glambda_B_LEAD@{j}=exp(log_glambda_B(@{j}));
	#glambda_CPBar_LEAD@{j}=exp(log_glambda_CPBar(@{j}));
	#glambda_CP_LEAD@{j}=exp(log_glambda_CP(@{j}));
	#glambda_CDBar_LEAD@{j}=exp(log_glambda_CDBar(@{j}));
	#glambda_CD_LEAD@{j}=exp(log_glambda_CD(@{j}));
	#glambda_GD_LEAD@{j}=exp(log_glambda_GD(@{j}));
	#glambda_GK_LEAD@{j}=exp(log_glambda_GK(@{j}));
	#glambda_GH_LEAD@{j}=exp(log_glambda_GH(@{j}));
	#gPD_LEAD@{j}=exp(log_gPD(@{j}));
	#gPND_LEAD@{j}=exp(log_gPND(@{j}));
	#gCG_LEAD@{j}=exp(log_gCG(@{j}));
@#endfor

    #gII=exp(log_gII);
    #gB=exp(log_gB);
    #gYS=exp(log_gYS);
    #gPS=exp(log_gPS);
    #gYWC=exp(log_gYWC);
    #gX=exp(log_gX);
    #gKP=exp(log_gKP);
    #gHP=exp(log_gHP);
    #gPKP=exp(log_gPKP);
    #gPHP=exp(log_gPHP);
    #gKG=exp(log_gKG);
    #gHG=exp(log_gHG);
    #gPHL=exp(log_gPHL);
    #gPKL=exp(log_gPKL);
    #gKBar=exp(log_gKBar);
    #gPHLX=exp(log_gPHLX);
    #gYHLBar=exp(log_gYHLBar);
    #gYHLXBar=exp(log_gYHLXBar);
	#gCND=exp(log_gCND);
	#gD=exp(log_gD);
	#gCDBar=exp(log_gCDBar);
	#gCPBar=exp(log_gCPBar);
	#gCBar=exp(log_gCBar);
    #gV=exp(log_gV);
    #glambda_C=exp(log_glambda_C);
	#glambda_B=exp(log_glambda_B);
	#glambda_CPBar=exp(log_glambda_CPBar);
	#glambda_CP=exp(log_glambda_CP);
	#glambda_CDBar=exp(log_glambda_CDBar);
	#glambda_CD=exp(log_glambda_CD);
	#glambda_GD=exp(log_glambda_GD);
	#glambda_GK=exp(log_glambda_GK);
	#glambda_GH=exp(log_glambda_GH);
	#gPD=exp(log_gPD);
	#gPND=exp(log_gPND);
	#gCG=exp(log_gCG);
@#include "InsertNewModelEquations.mod"	

log_gII = log( GN * GAs ^ b );
log_gB = log( GN * GAs ^ a );
log_gYS = log( GN * GAs ^ d );
log_gPS = log( GAs ^ ( a - d ) );
log_gYWC = log( GN * GAs ^ b );
log_gX = log( GN * GAs ^ a );
log_gKP = log( GN * GAs ^ ( d * alphaKP1 ) );
log_gHP = log( GN * GAs ^ ( d * alphaHP1 ) );
log_gPKP = log( GN * GAs ^ a / exp(log_gKP) );
log_gPHP = log( GN * GAs ^ a / exp(log_gHP) );
log_gKG = log( GN * GAs ^ ( d * alphaKG1 ) );
log_gHG = log( GN * GAs ^ ( d * alphaHG1 ) );
#log_gYHL = log( GN * GAs ^ ( d * alphaHP1 * alphaHL1 ) );
log_gPHL = log( GN * GAs ^ a / exp(log_gYHL) );
#log_gK = log( exp(log_gKG) ^ alphaK1 * exp(log_gKP) ^ ( 1 - alphaK1 ) );
#log_gYKL = log( exp(log_gK) ^ alphaKL1 * GN ^ ( 1 - alphaKL1 ) );
log_gPKL = log( GN * GAs ^ a / exp(log_gYKL) );
log_gKBar = log( exp(log_gK) / GN );
#log_gYHLX = log( exp(log_gYHL) ^ alphaHLX1 * exp(log_gX) ^ ( 1- alphaHLX1 ) );
log_gPHLX = log( GN * GAs ^ a / exp(log_gYHLX) );
log_gYHLBar = log( exp(log_gYHL) / ( GN * GAs ^ a ) );
log_gYHLXBar = log( exp(log_gYHLX) / exp(log_gYKL) );
log_gCND = log( GN * GAs ^ ( d * alphaND1 ) );
log_gD = log( GN * GAs ^ ( d * alphaD1 ) );
log_gPD = log( GN * GAs ^ a / exp(log_gD) );
log_gPND = log( GN * GAs ^ a / exp(log_gCND) );
#log_gCD = log( GN * GAs ^ ( d * alphaD1 * alphah1 ) );
log_gCDBar = log( exp(log_gCD) / exp(log_gCND) );
#log_gCP = log( exp(log_gCDBar) ^ alphaCD1 * exp(log_gCND) );
log_gCG = log( GN * GAs ^ ( d * alphaCG1 ) );
log_gCPBar = log( exp(log_gCP) / exp(log_gCG) );
log_gCBar = log( exp(log_gCPBar) ^ alphaCP1 * exp(log_gCG) );
log_gV = log( exp(log_gCBar) * GN ^ ( xi / ( 1 - sigma ) - 1 ) );
log_glambda_C = log( GN ^ ( xi / ( 1 - sigma ) - 1 ) );
log_glambda_CPBar = log( exp(log_gCBar) / exp(log_gCPBar) * exp(log_glambda_C) );
log_glambda_CP = log( exp(log_glambda_CPBar) / exp(log_gCG) );
log_glambda_CDBar = log( exp(log_glambda_CP) * exp(log_gCP) / exp(log_gCDBar) );
log_glambda_CD = log( exp(log_glambda_CDBar) / exp(log_gCND) );
log_glambda_B = log( exp(log_glambda_CP) * GAs ^ ( alphaCD1 * ( d * alphaD1 * alphah1 - d * alphaND1 ) - a + d * alphaND1 ) );
log_glambda_GD = log( exp(log_glambda_CP) * GAs ^ ( alphaCD1 * ( d * alphaD1 * alphah1 - d * alphaND1 ) + d * alphaND1 - d * alphaD1 ) );
log_glambda_GK = log( exp(log_glambda_CP) * GAs ^ ( alphaCD1 * ( d * alphaD1 * alphah1 - d * alphaND1 ) + d * alphaND1 - d * alphaKP1 ) );
log_glambda_GH = log( exp(log_glambda_CP) * GAs ^ ( alphaCD1 * ( d * alphaD1 * alphah1 - d * alphaND1 ) + d * alphaND1 - d * alphaHP1 ) );

@#for n in 1:SN
	#OmegaY@{n}_   =OmegaY_     *Ntilde@{n}_    /Ntilde1_;
    #Omegah@{n}    =Omegah_     *Omegahi@{n}    *OmegaALL@{n}                                                ;      #Omegah@{n}_LAG    =Omegah_     *Omegahi@{n}_LAG    *OmegaALL@{n}_LAG                                                            ;      #Omegah@{n}_LEAD    =Omegah_     *Omegahi@{n}_LEAD    *OmegaALL@{n}_LEAD                                                               ;
    #OmegaCP@{n}   =OmegaCP_    *OmegaCPi@{n}   *OmegaALL@{n}*OmegaDemandALL@{n}                             ;      #OmegaCP@{n}_LAG   =OmegaCP_    *OmegaCPi@{n}_LAG   *OmegaALL@{n}_LAG*OmegaDemandALL@{n}_LAG                                     ;      #OmegaCP@{n}_LEAD   =OmegaCP_    *OmegaCPi@{n}_LEAD   *OmegaALL@{n}_LEAD*OmegaDemandALL@{n}_LEAD                                       ;
    #OmegaC@{n}    =OmegaC_     *OmegaCi@{n}    *OmegaALL@{n}*OmegaDemandALL@{n}                             ;      #OmegaC@{n}_LAG    =OmegaC_     *OmegaCi@{n}_LAG    *OmegaALL@{n}_LAG*OmegaDemandALL@{n}_LAG                                     ;      #OmegaC@{n}_LEAD    =OmegaC_     *OmegaCi@{n}_LEAD    *OmegaALL@{n}_LEAD*OmegaDemandALL@{n}_LEAD                                       ;
    #OmegaKP@{n}   =OmegaKP_    *                OmegaALL@{n}*OmegaS1ALL@{n}*OmegaPALL@{n}*OmegaKALL@{n}     ;      #OmegaKP@{n}_LAG   =OmegaKP_    *                    OmegaALL@{n}_LAG*OmegaS1ALL@{n}_LAG*OmegaPALL@{n}_LAG*OmegaKALL@{n}_LAG     ;      #OmegaKP@{n}_LEAD   =OmegaKP_    *                     OmegaALL@{n}_LEAD*OmegaS1ALL@{n}_LEAD*OmegaPALL@{n}_LEAD*OmegaKALL@{n}_LEAD     ;
    #OmegaHP@{n}   =OmegaHP_    *                OmegaALL@{n}*OmegaS1ALL@{n}*OmegaPALL@{n}*OmegaHALL@{n}     ;      #OmegaHP@{n}_LAG   =OmegaHP_    *                    OmegaALL@{n}_LAG*OmegaS1ALL@{n}_LAG*OmegaPALL@{n}_LAG*OmegaHALL@{n}_LAG     ;      #OmegaHP@{n}_LEAD   =OmegaHP_    *                     OmegaALL@{n}_LEAD*OmegaS1ALL@{n}_LEAD*OmegaPALL@{n}_LEAD*OmegaHALL@{n}_LEAD     ;
    #OmegaD@{n}    =OmegaD_     *                OmegaALL@{n}*OmegaS1ALL@{n}*OmegaPALL@{n}*OmegaDi@{n}       ;      #OmegaD@{n}_LAG    =OmegaD_     *                    OmegaALL@{n}_LAG*OmegaS1ALL@{n}_LAG*OmegaPALL@{n}_LAG*OmegaDi@{n}_LAG       ;      #OmegaD@{n}_LEAD    =OmegaD_     *                     OmegaALL@{n}_LEAD*OmegaS1ALL@{n}_LEAD*OmegaPALL@{n}_LEAD*OmegaDi@{n}_LEAD       ;
    #OmegaND@{n}   =OmegaND_    *                OmegaALL@{n}*OmegaS1ALL@{n}*OmegaPALL@{n}*OmegaCALL@{n}     ;      #OmegaND@{n}_LAG   =OmegaND_    *                    OmegaALL@{n}_LAG*OmegaS1ALL@{n}_LAG*OmegaPALL@{n}_LAG*OmegaCALL@{n}_LAG     ;      #OmegaND@{n}_LEAD   =OmegaND_    *                     OmegaALL@{n}_LEAD*OmegaS1ALL@{n}_LEAD*OmegaPALL@{n}_LEAD*OmegaCALL@{n}_LEAD     ;
    #OmegaKG@{n}   =OmegaKG_    *                OmegaALL@{n}*OmegaS1ALL@{n}*OmegaGALL@{n}*OmegaKALL@{n}     ;      #OmegaKG@{n}_LAG   =OmegaKG_    *                    OmegaALL@{n}_LAG*OmegaS1ALL@{n}_LAG*OmegaGALL@{n}_LAG*OmegaKALL@{n}_LAG     ;      #OmegaKG@{n}_LEAD   =OmegaKG_    *                     OmegaALL@{n}_LEAD*OmegaS1ALL@{n}_LEAD*OmegaGALL@{n}_LEAD*OmegaKALL@{n}_LEAD     ;
    #OmegaHG@{n}   =OmegaHG_    *                OmegaALL@{n}*OmegaS1ALL@{n}*OmegaGALL@{n}*OmegaHALL@{n}     ;      #OmegaHG@{n}_LAG   =OmegaHG_    *                    OmegaALL@{n}_LAG*OmegaS1ALL@{n}_LAG*OmegaGALL@{n}_LAG*OmegaHALL@{n}_LAG     ;      #OmegaHG@{n}_LEAD   =OmegaHG_    *                     OmegaALL@{n}_LEAD*OmegaS1ALL@{n}_LEAD*OmegaGALL@{n}_LEAD*OmegaHALL@{n}_LEAD     ;
    #OmegaCG@{n}   =OmegaCG_    *                OmegaALL@{n}*OmegaS1ALL@{n}*OmegaGALL@{n}*OmegaCALL@{n}     ;      #OmegaCG@{n}_LAG   =OmegaCG_    *                    OmegaALL@{n}_LAG*OmegaS1ALL@{n}_LAG*OmegaGALL@{n}_LAG*OmegaCALL@{n}_LAG     ;      #OmegaCG@{n}_LEAD   =OmegaCG_    *                     OmegaALL@{n}_LEAD*OmegaS1ALL@{n}_LEAD*OmegaGALL@{n}_LEAD*OmegaCALL@{n}_LEAD     ;
    #OmegaY@{n}    =OmegaY@{n}_ *OmegaYi@{n}    *OmegaALL@{n}                                                ;      #OmegaY@{n}_LAG    =OmegaY@{n}_ *OmegaYi@{n}_LAG    *OmegaALL@{n}_LAG                                                            ;      #OmegaY@{n}_LEAD    =OmegaY@{n}_ *OmegaYi@{n}_LEAD    *OmegaALL@{n}_LEAD                                                               ;
    #OmegaTC@{n}   =OmegaTC_    *OmegaTCi@{n}   *OmegaALL@{n}*OmegaTradeALL@{n}                              ;      #OmegaTC@{n}_LAG   =OmegaTC_    *OmegaTCi@{n}_LAG   *OmegaALL@{n}_LAG*OmegaTradeALL@{n}_LAG                                      ;      #OmegaTC@{n}_LEAD   =OmegaTC_    *OmegaTCi@{n}_LEAD   *OmegaALL@{n}_LEAD*OmegaTradeALL@{n}_LEAD                                        ;
    #OmegaWP@{n}   =OmegaWP_    *OmegaWPi@{n}   *OmegaALL@{n}*OmegaTradeALL@{n}                              ;      #OmegaWP@{n}_LAG   =OmegaWP_    *OmegaWPi@{n}_LAG   *OmegaALL@{n}_LAG*OmegaTradeALL@{n}_LAG                                      ;      #OmegaWP@{n}_LEAD   =OmegaWP_    *OmegaWPi@{n}_LEAD   *OmegaALL@{n}_LEAD*OmegaTradeALL@{n}_LEAD                                        ;
    #OmegaWC@{n}   =OmegaWC_    *OmegaWCi@{n}   *OmegaALL@{n}                                                ;      #OmegaWC@{n}_LAG   =OmegaWC_    *OmegaWCi@{n}_LAG   *OmegaALL@{n}_LAG                                                            ;      #OmegaWC@{n}_LEAD   =OmegaWC_    *OmegaWCi@{n}_LEAD   *OmegaALL@{n}_LEAD                                                               ;
    #OmegaKT@{n}   =OmegaKT_    *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaTALL@{n}*OmegaKKALL@{n}    ;      #OmegaKT@{n}_LAG   =OmegaKT_    *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaTALL@{n}_LAG*OmegaKKALL@{n}_LAG    ;      #OmegaKT@{n}_LEAD   =OmegaKT_    *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaTALL@{n}_LEAD*OmegaKKALL@{n}_LEAD    ;
    #OmegaHLT@{n}  =OmegaHLT_   *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaTALL@{n}*OmegaHLALL@{n}    ;      #OmegaHLT@{n}_LAG  =OmegaHLT_   *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaTALL@{n}_LAG*OmegaHLALL@{n}_LAG    ;      #OmegaHLT@{n}_LEAD  =OmegaHLT_   *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaTALL@{n}_LEAD*OmegaHLALL@{n}_LEAD    ;
    #OmegaKLT@{n}  =OmegaKLT_   *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaTALL@{n}*OmegaKLALL@{n}    ;      #OmegaKLT@{n}_LAG  =OmegaKLT_   *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaTALL@{n}_LAG*OmegaKLALL@{n}_LAG    ;      #OmegaKLT@{n}_LEAD  =OmegaKLT_   *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaTALL@{n}_LEAD*OmegaKLALL@{n}_LEAD    ;
    #OmegaHLXT@{n} =OmegaHLXT_  *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaTALL@{n}*OmegaHLXALL@{n}   ;      #OmegaHLXT@{n}_LAG =OmegaHLXT_  *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaTALL@{n}_LAG*OmegaHLXALL@{n}_LAG   ;      #OmegaHLXT@{n}_LEAD =OmegaHLXT_  *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaTALL@{n}_LEAD*OmegaHLXALL@{n}_LEAD   ;
    #OmegaT@{n}    =OmegaT_     *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaTALL@{n}*OmegaHLXKLALL@{n} ;      #OmegaT@{n}_LAG    =OmegaT_     *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaTALL@{n}_LAG*OmegaHLXKLALL@{n}_LAG ;      #OmegaT@{n}_LEAD    =OmegaT_     *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaTALL@{n}_LEAD*OmegaHLXKLALL@{n}_LEAD ;
    #OmegaKNT@{n}  =OmegaKNT_   *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaNTALL@{n}*OmegaKKALL@{n}   ;      #OmegaKNT@{n}_LAG  =OmegaKNT_   *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaNTALL@{n}_LAG*OmegaKKALL@{n}_LAG   ;      #OmegaKNT@{n}_LEAD  =OmegaKNT_   *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaNTALL@{n}_LEAD*OmegaKKALL@{n}_LEAD   ;
    #OmegaHLNT@{n} =OmegaHLNT_  *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaNTALL@{n}*OmegaHLALL@{n}   ;      #OmegaHLNT@{n}_LAG =OmegaHLNT_  *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaNTALL@{n}_LAG*OmegaHLALL@{n}_LAG   ;      #OmegaHLNT@{n}_LEAD =OmegaHLNT_  *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaNTALL@{n}_LEAD*OmegaHLALL@{n}_LEAD   ;
    #OmegaKLNT@{n} =OmegaKLNT_  *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaNTALL@{n}*OmegaKLALL@{n}   ;      #OmegaKLNT@{n}_LAG =OmegaKLNT_  *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaNTALL@{n}_LAG*OmegaKLALL@{n}_LAG   ;      #OmegaKLNT@{n}_LEAD =OmegaKLNT_  *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaNTALL@{n}_LEAD*OmegaKLALL@{n}_LEAD   ;
    #OmegaHLXNT@{n}=OmegaHLXNT_ *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaNTALL@{n}*OmegaHLXALL@{n}  ;      #OmegaHLXNT@{n}_LAG=OmegaHLXNT_ *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaNTALL@{n}_LAG*OmegaHLXALL@{n}_LAG  ;      #OmegaHLXNT@{n}_LEAD=OmegaHLXNT_ *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaNTALL@{n}_LEAD*OmegaHLXALL@{n}_LEAD  ;
    #OmegaNT@{n}   =OmegaNT_    *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaNTALL@{n}*OmegaHLXKLALL@{n};      #OmegaNT@{n}_LAG   =OmegaNT_    *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaNTALL@{n}_LAG*OmegaHLXKLALL@{n}_LAG;      #OmegaNT@{n}_LEAD   =OmegaNT_    *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaNTALL@{n}_LEAD*OmegaHLXKLALL@{n}_LEAD;
    #OmegaKW@{n}   =OmegaKW_    *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaWALL@{n}*OmegaKKALL@{n}    ;      #OmegaKW@{n}_LAG   =OmegaKW_    *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaWALL@{n}_LAG*OmegaKKALL@{n}_LAG    ;      #OmegaKW@{n}_LEAD   =OmegaKW_    *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaWALL@{n}_LEAD*OmegaKKALL@{n}_LEAD    ;
    #OmegaHLW@{n}  =OmegaHLW_   *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaWALL@{n}*OmegaHLALL@{n}    ;      #OmegaHLW@{n}_LAG  =OmegaHLW_   *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaWALL@{n}_LAG*OmegaHLALL@{n}_LAG    ;      #OmegaHLW@{n}_LEAD  =OmegaHLW_   *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaWALL@{n}_LEAD*OmegaHLALL@{n}_LEAD    ;
    #OmegaKLW@{n}  =OmegaKLW_   *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaWALL@{n}*OmegaKLALL@{n}    ;      #OmegaKLW@{n}_LAG  =OmegaKLW_   *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaWALL@{n}_LAG*OmegaKLALL@{n}_LAG    ;      #OmegaKLW@{n}_LEAD  =OmegaKLW_   *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaWALL@{n}_LEAD*OmegaKLALL@{n}_LEAD    ;
    #OmegaHLXW@{n} =OmegaHLXW_  *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaWALL@{n}*OmegaHLXALL@{n}   ;      #OmegaHLXW@{n}_LAG =OmegaHLXW_  *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaWALL@{n}_LAG*OmegaHLXALL@{n}_LAG   ;      #OmegaHLXW@{n}_LEAD =OmegaHLXW_  *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaWALL@{n}_LEAD*OmegaHLXALL@{n}_LEAD   ;
    #OmegaW@{n}    =OmegaW_     *                OmegaALL@{n}*OmegaS0ALL@{n}*OmegaWALL@{n}*OmegaHLXKLALL@{n} ;      #OmegaW@{n}_LAG    =OmegaW_     *                    OmegaALL@{n}_LAG*OmegaS0ALL@{n}_LAG*OmegaWALL@{n}_LAG*OmegaHLXKLALL@{n}_LAG ;      #OmegaW@{n}_LEAD    =OmegaW_     *                     OmegaALL@{n}_LEAD*OmegaS0ALL@{n}_LEAD*OmegaWALL@{n}_LEAD*OmegaHLXKLALL@{n}_LEAD ;
@#endfor
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                      Household                                                        //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@#for n in 1:SN
//Generalized goods market clearing
	#Y@{n}_LAG = (
	@#for S in SectorsP1
		+ Y@{S}@{n}_LAG
	@#endfor
	) / ( 1 - tauKG@{n}_LAG * alphaKG@{n} - tauHG@{n}_LAG * alphaHG@{n} - tauCG@{n}_LAG * alphaCG@{n} );

	#Y@{n} = (
	@#for S in SectorsP1
		+ Y@{S}@{n}
	@#endfor
	) / ( 1 - tauKG@{n} * alphaKG@{n} - tauHG@{n} * alphaHG@{n} - tauCG@{n} * alphaCG@{n} );

	#Y@{n}_LEAD = (
	@#for S in SectorsP1
		+ Y@{S}@{n}_LEAD
	@#endfor
	) / ( 1 - tauKG@{n}_LEAD * alphaKG@{n} - tauHG@{n}_LEAD * alphaHG@{n} - tauCG@{n}_LEAD * alphaCG@{n} );

//Def. country specific population
    #N@{n}b_endo = log(V@{n}b/N@{n}b)
			-(
			@#for m in 1:SN
				+log(V@{m}b/N@{m}b)
			@#endfor
			)/@{SN};
    #N@{n}b_endo_ss=steady_state(N@{n}b_endo);

	N@{n}b=100*N*(Ntilde@{n}*varpi@{n}+psib*(N@{n}b_endo-N@{n}b_endo_ss));

    #N@{n}l_endo = log(V@{n}l/N@{n}l)
			-(
			@#for m in 1:SN
			+log(V@{m}l/N@{m}l)
			@#endfor
			)/@{SN};
    #N@{n}l_endo_ss=steady_state(N@{n}l_endo);
			
	N@{n}l=100*N*(Ntilde@{n}*(1-varpi@{n})+psil*(N@{n}l_endo-N@{n}l_endo_ss));

    #N@{n}_LAG = N@{n}l_LAG + N@{n}b_LAG;    
    #N@{n} = N@{n}l + N@{n}b;
    #N@{n}_LEAD = N@{n}l_LEAD + N@{n}b_LEAD;
@#endfor

//Population of ROW and the world except ROW
#NN_LAG = 0	
	@#for n in 1:SN
		+ N@{n}_LAG
	@#endfor
	;
#NN = 0	
	@#for n in 1:SN
		+ N@{n}
	@#endfor
	;
#NN_LEAD = 0	
	@#for n in 1:SN
		+ N@{n}_LEAD
	@#endfor
	;
	
#N0_LAG = 100*N_LAG - NN_LAG;
#N0 = 100*N - NN;
#N0_LEAD = 100*N_LEAD - NN_LEAD;

@#for n in 1:SN
	@#for m in Members
//Home production
		#CD@{n}@{m}_LAG = Omegah@{n}_LAG * ( DU@{n}@{m}_LAG * D@{n}@{m}_LAG ) ^ alphah@{n} * Lh@{n}@{m}_LAG ^ ( 1 - alphah@{n} );
		#CD@{n}@{m} = Omegah@{n} * ( DU@{n}@{m} * D@{n}@{m} ) ^ alphah@{n} * Lh@{n}@{m} ^ ( 1 - alphah@{n} );
		#CD@{n}@{m}_LEAD = Omegah@{n}_LEAD * ( DU@{n}@{m}_LEAD * D@{n}@{m}_LEAD ) ^ alphah@{n} * Lh@{n}@{m}_LEAD ^ ( 1 - alphah@{n} );
		
//auxilary of durable&nondurable composite
		CDBar@{n}@{m} = ( CD@{n}@{m} / CND@{n}@{m} ) ^ ( 1 - varrhoCD@{n} ) * CDBar@{n}@{m}_LAG ^ varrhoCD@{n};

//Production of durable&nondurable composite
		#CP@{n}@{m}_LAG = N@{n}@{m}_LAG * OmegaCP@{n}_LAG * CDBar@{n}@{m}_LAG2 ^ alphaCD@{n} * ( alphaCD@{n} * ( CD@{n}@{m}_LAG / N@{n}@{m}_LAG / CDBar@{n}@{m}_LAG2 ) ^ ( ( eCP@{n} - 1 ) / eCP@{n} )  +  ( 1 - alphaCD@{n} ) * ( CND@{n}@{m}_LAG / N@{n}@{m}_LAG ) ^ ( ( eCP@{n} - 1 ) / eCP@{n} ) ) ^ ( eCP@{n} / ( eCP@{n} - 1 ) );
		#CP@{n}@{m} = N@{n}@{m} * OmegaCP@{n} * CDBar@{n}@{m}_LAG ^ alphaCD@{n} * ( alphaCD@{n} * ( CD@{n}@{m} / N@{n}@{m} / CDBar@{n}@{m}_LAG ) ^ ( ( eCP@{n} - 1 ) / eCP@{n} )  +  ( 1 - alphaCD@{n} ) * ( CND@{n}@{m} / N@{n}@{m} ) ^ ( ( eCP@{n} - 1 ) / eCP@{n} ) ) ^ ( eCP@{n} / ( eCP@{n} - 1 ) );
		#CP@{n}@{m}_LEAD = N@{n}@{m}_LEAD * OmegaCP@{n}_LEAD * CDBar@{n}@{m} ^ alphaCD@{n} * ( alphaCD@{n} * ( CD@{n}@{m}_LEAD / N@{n}@{m}_LEAD / CDBar@{n}@{m} ) ^ ( ( eCP@{n} - 1 ) / eCP@{n} )  +  ( 1 - alphaCD@{n} ) * ( CND@{n}@{m}_LEAD / N@{n}@{m}_LEAD ) ^ ( ( eCP@{n} - 1 ) / eCP@{n} ) ) ^ ( eCP@{n} / ( eCP@{n} - 1 ) );
		
//auxilary of private&government composite
		CPBar@{n}@{m} = ( CP@{n}@{m} / CG@{n} * ( N@{n}b + N@{n}l ) / N@{n}@{m} ) ^ ( 1 - varrhoCP@{n} ) * CPBar@{n}@{m}_LAG ^ varrhoCP@{n};

//production of private&government composite
		#C@{n}@{m}_LAG = N@{n}@{m}_LAG * OmegaC@{n}_LAG * CPBar@{n}@{m}_LAG2 ^ alphaCP@{n} * ( alphaCP@{n} * ( CP@{n}@{m}_LAG / N@{n}@{m}_LAG / CPBar@{n}@{m}_LAG2 ) ^ ( ( eC@{n} - 1 ) / eC@{n} )  +  ( 1 - alphaCP@{n} ) * ( CG@{n}_LAG / ( N@{n}b_LAG + N@{n}l_LAG ) ) ^ ( ( eC@{n} - 1 ) / eC@{n} ) ) ^ ( eC@{n} / ( eC@{n} - 1 ) );
		#C@{n}@{m} = N@{n}@{m} * OmegaC@{n} * CPBar@{n}@{m}_LAG ^ alphaCP@{n} * ( alphaCP@{n} * ( CP@{n}@{m} / N@{n}@{m} / CPBar@{n}@{m}_LAG ) ^ ( ( eC@{n} - 1 ) / eC@{n} )  +  ( 1 - alphaCP@{n} ) * ( CG@{n} / ( N@{n}b + N@{n}l ) ) ^ ( ( eC@{n} - 1 ) / eC@{n} ) ) ^ ( eC@{n} / ( eC@{n} - 1 ) );
		#C@{n}@{m}_LEAD = N@{n}@{m}_LEAD * OmegaC@{n}_LEAD * CPBar@{n}@{m} ^ alphaCP@{n} * ( alphaCP@{n} * ( CP@{n}@{m}_LEAD / N@{n}@{m}_LEAD / CPBar@{n}@{m} ) ^ ( ( eC@{n} - 1 ) / eC@{n} )  +  ( 1 - alphaCP@{n} ) * ( CG@{n}_LEAD / ( N@{n}b_LEAD + N@{n}l_LEAD ) ) ^ ( ( eC@{n} - 1 ) / eC@{n} ) ) ^ ( eC@{n} / ( eC@{n} - 1 ) );
	
//def. habit stock 
		CBar@{n}@{m} / N@{n}@{m} = ( C@{n}@{m} / N@{n}@{m} ) ^ ( 1 - varrhoC@{n} ) * ( CBar@{n}@{m}_LAG / N@{n}@{m}_LAG ) ^ varrhoC@{n};

//def. one period utility
		#U@{n}@{m} = N@{n}@{m} * ( C@{n}@{m} / N@{n}@{m} - h@{n} * C@{n}@{m}_LAG / N@{n}@{m}_LAG - CBar@{n}@{m}_LAG / N@{n}@{m}_LAG * ( kappa0@{n}
		@#for S in Sectors2
			+ kappa@{S}@{n} / ( 1 + nu@{S}@{n} ) * ( L@{S}@{n}@{m} / N@{n}@{m} ) ^ ( 1 + nu@{S}@{n} )
		@#endfor
		+ kappah@{n} / ( 1 + nuh@{n} ) * ( Lh@{n}@{m} / N@{n}@{m} ) ^ ( 1 + nuh@{n} ) ) );

		#U@{n}@{m}_LEAD = N@{n}@{m}_LEAD * ( C@{n}@{m}_LEAD / N@{n}@{m}_LEAD - h@{n} * C@{n}@{m} / N@{n}@{m} - CBar@{n}@{m} / N@{n}@{m} * ( kappa0@{n}_LEAD
		@#for S in Sectors2
			+ kappa@{S}@{n}_LEAD / ( 1 + nu@{S}@{n} ) * ( L@{S}@{n}@{m}_LEAD / N@{n}@{m}_LEAD ) ^ ( 1 + nu@{S}@{n} )
		@#endfor
		+ kappah@{n}_LEAD / ( 1 + nuh@{n} ) * ( Lh@{n}@{m}_LEAD / N@{n}@{m}_LEAD ) ^ ( 1 + nuh@{n} ) ) );

//def. endogenous discount factor
		#betass@{n}@{m} = betabar@{n}@{m} - bbeta@{n} * log( ( CND@{n}b + CND@{n}l ) * steady_state (PND@{n} / Y@{n} / P@{n}) );
		log( beta@{n}@{m} / ( 1 - beta@{n}@{m} ) ) = ( 1 - rhobeta@{n} ) * log( betass@{n}@{m} / ( 1 - betass@{n}@{m} ) ) + rhobeta@{n} * log( beta@{n}@{m}_LAG / ( 1 - beta@{n}@{m}_LAG ) ) + sigmabeta@{n} * epsilon_beta@{n};

//def. country value 
		V@{n}@{m} ^ ( 1 - sigma@{n} )= ( 1 - beta@{n}@{m} ) * N@{n}@{m} ^ ( xi@{n} - 1 + sigma@{n} ) * U@{n}@{m} ^ ( 1 - sigma@{n} ) + beta@{n}@{m} * EV@{n}@{m} ^ ( 1 - sigma@{n} );

//def. risk adjusted value
		1 = V@{n}@{m}_LEAD ^ ( 1 - gammaV@{n} ) / EV@{n}@{m} ^ ( 1 - gammaV@{n} );

//def. partialV/partialV_lead
		#VV@{n}@{m}=beta@{n}@{m}_LAG * V@{n}@{m}_LAG ^ sigma@{n} * EV@{n}@{m}_LAG ^ ( gammaV@{n} - sigma@{n} ) * V@{n}@{m} ^ -gammaV@{n};
		#VV@{n}@{m}_LEAD=beta@{n}@{m} * V@{n}@{m} ^ sigma@{n} * EV@{n}@{m} ^ ( gammaV@{n} - sigma@{n} ) * V@{n}@{m}_LEAD ^ -gammaV@{n};

//def. of durable growth rate
		#GD@{n}@{m}_LAG2 = D@{n}@{m}_LAG2 / D@{n}@{m}_LAG3;
		#GD@{n}@{m}_LAG = D@{n}@{m}_LAG / D@{n}@{m}_LAG2;
        #GD@{n}@{m} = D@{n}@{m} / D@{n}@{m}_LAG;
        #GD@{n}@{m}_LEAD = D@{n}@{m}_LEAD / D@{n}@{m};
//Law of motion for durable
		#ID@{n}@{m}_LAG = ( D@{n}@{m}_LAG - ( 1 - deltaD@{n}_LAG - thetaDU0@{n} / ( 1+thetaDU1@{n} ) * DU@{n}@{m}_LAG ^ ( 1+thetaDU1@{n} ) ) * D@{n}@{m}_LAG2 ) / exp( - thetaGD@{n} / 2 * ( log( GD@{n}@{m}_LAG / GD@{n}@{m}_LAG2 ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m}_LAG / DP@{n}@{m}_LAG2 ) ) ^ 2 );
		#ID@{n}@{m} = ( D@{n}@{m} - ( 1 - deltaD@{n} - thetaDU0@{n} / ( 1+thetaDU1@{n} ) * DU@{n}@{m} ^ ( 1+thetaDU1@{n} ) ) * D@{n}@{m}_LAG ) / exp( - thetaGD@{n} / 2 * ( log( GD@{n}@{m} / GD@{n}@{m}_LAG ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m} / DP@{n}@{m}_LAG ) ) ^ 2 );
		#ID@{n}@{m}_LEAD = ( D@{n}@{m}_LEAD - ( 1 - deltaD@{n}_LEAD - thetaDU0@{n} / ( 1+thetaDU1@{n} ) * DU@{n}@{m}_LEAD ^ ( 1+thetaDU1@{n} ) ) * D@{n}@{m} ) / exp( - thetaGD@{n} / 2 * ( log( GD@{n}@{m}_LEAD / GD@{n}@{m} ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m}_LEAD / DP@{n}@{m} ) ) ^ 2 );
//def. of nondurable investment
		#IND@{n}@{m} = CND@{n}@{m};
		#IND@{n}@{m}_LAG = CND@{n}@{m}_LAG;
	@#endfor
	@#for S in Sectors0
//def. of capital growth rate
        #GKP@{S}@{n}_LAG2 = KP@{S}@{n}_LAG2 / KP@{S}@{n}_LAG3;
        #GKP@{S}@{n}_LAG = KP@{S}@{n}_LAG / KP@{S}@{n}_LAG2;
		#GKP@{S}@{n} = KP@{S}@{n} / KP@{S}@{n}_LAG;
        #GKP@{S}@{n}_LEAD = KP@{S}@{n}_LEAD / KP@{S}@{n};
//Law of motion for capital
		#IKP@{S}@{n}_LAG = ( KP@{S}@{n}_LAG - ( 1 - deltaKP@{S}@{n}_LAG - thetaKU0@{n} / ( 1+thetaKU1@{n} ) * KU@{S}@{n}_LAG ^ ( 1+thetaKU1@{n} ) ) * KP@{S}@{n}_LAG2 ) / exp( - thetaGKP@{n} / 2 * ( log( GKP@{S}@{n}_LAG / GKP@{S}@{n}_LAG2 ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n}_LAG / KPP@{S}@{n}_LAG2 ) ) ^ 2 );
		#IKP@{S}@{n} = ( KP@{S}@{n} - ( 1 - deltaKP@{S}@{n} - thetaKU0@{n} / ( 1+thetaKU1@{n} ) * KU@{S}@{n} ^ ( 1+thetaKU1@{n} ) ) * KP@{S}@{n}_LAG ) / exp( - thetaGKP@{n} / 2 * ( log( GKP@{S}@{n} / GKP@{S}@{n}_LAG ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n} / KPP@{S}@{n}_LAG ) ) ^ 2 );
		#IKP@{S}@{n}_LEAD = ( KP@{S}@{n}_LEAD - ( 1 - deltaKP@{S}@{n}_LEAD - thetaKU0@{n} / ( 1+thetaKU1@{n} ) * KU@{S}@{n}_LEAD ^ ( 1+thetaKU1@{n} ) ) * KP@{S}@{n} ) / exp( - thetaGKP@{n} / 2 * ( log( GKP@{S}@{n}_LEAD / GKP@{S}@{n} ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n}_LEAD / KPP@{S}@{n} ) ) ^ 2 );
//def. of capital growth rate
		#GHP@{S}@{n}_LAG2 = HP@{S}@{n}_LAG2 / HP@{S}@{n}_LAG3;
		#GHP@{S}@{n}_LAG = HP@{S}@{n}_LAG / HP@{S}@{n}_LAG2;
        #GHP@{S}@{n} = HP@{S}@{n} / HP@{S}@{n}_LAG;
        #GHP@{S}@{n}_LEAD = HP@{S}@{n}_LEAD / HP@{S}@{n};
//Law of motion for capital
		#IHP@{S}@{n}_LAG = ( HP@{S}@{n}_LAG - ( 1 - deltaHP@{S}@{n}_LAG ) * HP@{S}@{n}_LAG2 ) / exp( - thetaGHP@{n} / 2 * ( log( GHP@{S}@{n}_LAG / GHP@{S}@{n}_LAG2 ) ) ^ 2 - thetaPHP@{n} / 2 * ( log( HP@{S}@{n}_LAG / HPP@{S}@{n}_LAG2 ) ) ^ 2 );
		#IHP@{S}@{n} = ( HP@{S}@{n} - ( 1 - deltaHP@{S}@{n} ) * HP@{S}@{n}_LAG ) / exp( - thetaGHP@{n} / 2 * ( log( GHP@{S}@{n} / GHP@{S}@{n}_LAG ) ) ^ 2 - thetaPHP@{n} / 2 * ( log( HP@{S}@{n} / HPP@{S}@{n}_LAG ) ) ^ 2 );
		#IHP@{S}@{n}_LEAD = ( HP@{S}@{n}_LEAD - ( 1 - deltaHP@{S}@{n}_LEAD ) * HP@{S}@{n} ) / exp( - thetaGHP@{n} / 2 * ( log( GHP@{S}@{n}_LEAD / GHP@{S}@{n} ) ) ^ 2 - thetaPHP@{n} / 2 * ( log( HP@{S}@{n}_LEAD / HPP@{S}@{n} ) ) ^ 2 );
	@#endfor
	
//foc of financial asset (def. of STD)
	Xi = VV@{n}l * lambda_B@{n}l / lambda_B@{n}l_LAG;

	@#if n == 1
		Q = Xi_LEAD;
	@#endif
	
	Q = lambda_F@{n} / lambda_B@{n}b + VV@{n}b_LEAD * ( lambda_B@{n}b_LEAD / lambda_B@{n}b - lambda_F@{n}_LEAD / lambda_B@{n}b * rhoQB@{n} );

    QB@{n} = VV@{n}b_LEAD * lambda_B@{n}b_LEAD / lambda_B@{n}b;

	@#for m in Members
//FOC of final comsuption composite
		V@{n}@{m} ^ sigma@{n} * ( 1 - beta@{n}@{m} ) * N@{n}@{m} ^ ( xi@{n} - 1 + sigma@{n} ) * U@{n}@{m} ^ -sigma@{n}
        -VV@{n}@{m}_LEAD * V@{n}@{m}_LEAD ^ sigma@{n} * ( 1 - beta@{n}@{m}_LEAD ) * N@{n}@{m}_LEAD ^ ( xi@{n} - 1 + sigma@{n} ) * U@{n}@{m}_LEAD ^ -sigma@{n} * h@{n} * N@{n}@{m}_LEAD / N@{n}@{m}
		+lambda_CBar@{n}@{m} * ( 1 - varrhoC@{n} ) * ( C@{n}@{m} / N@{n}@{m} ) ^ -varrhoC@{n} * ( CBar@{n}@{m}_LAG / N@{n}@{m}_LAG ) ^ varrhoC@{n}
		+lambda_C@{n}@{m};

//FOC of final consumption habit
		- VV@{n}@{m}_LEAD * V@{n}@{m}_LEAD ^ sigma@{n} * ( 1 - beta@{n}@{m}_LEAD ) * N@{n}@{m}_LEAD ^ ( xi@{n} - 1 + sigma@{n} ) * U@{n}@{m}_LEAD ^ -sigma@{n} * N@{n}@{m}_LEAD / N@{n}@{m} * ( kappa0@{n}_LEAD
		@#for S in Sectors2
			+ kappa@{S}@{n}_LEAD / ( 1 + nu@{S}@{n} ) * ( L@{S}@{n}@{m}_LEAD / N@{n}@{m}_LEAD ) ^ ( 1 + nu@{S}@{n} )
		@#endfor
		+ kappah@{n}_LEAD / ( 1 + nuh@{n} ) * ( Lh@{n}@{m}_LEAD / N@{n}@{m}_LEAD ) ^ ( 1 + nuh@{n} ) )
		- lambda_CBar@{n}@{m}
		+ VV@{n}@{m}_LEAD * lambda_CBar@{n}@{m}_LEAD * ( C@{n}@{m}_LEAD / N@{n}@{m}_LEAD ) ^ ( 1 - varrhoC@{n} ) * ( CBar@{n}@{m} / N@{n}@{m} ) ^ ( varrhoC@{n} - 1 ) * N@{n}@{m}_LEAD / N@{n}@{m} * varrhoC@{n};

//FOC of private consumption composite
		- lambda_C@{n}@{m} * OmegaC@{n} * CPBar@{n}@{m}_LAG ^ ( ( alphaCP@{n} - 1 ) * ( eC@{n} - 1 ) / eC@{n} ) * alphaCP@{n} * ( C@{n}@{m} / CP@{n}@{m} / OmegaC@{n} ) ^ ( 1 / eC@{n} )
		- lambda_CPBar@{n}@{m} * ( 1 / CG@{n} * ( N@{n}b + N@{n}l ) / N@{n}@{m} ) ^ ( 1 - varrhoCP@{n} ) * CPBar@{n}@{m}_LAG ^ varrhoCP@{n} * ( 1 - varrhoCP@{n} ) * CP@{n}@{m} ^ ( -varrhoCP@{n} )
		+ lambda_CP@{n}@{m};

//FOC of private consumption auxilary
		- VV@{n}@{m}_LEAD * lambda_C@{n}@{m}_LEAD * ( alphaCP@{n} * C@{n}@{m}_LEAD / CPBar@{n}@{m} - OmegaC@{n}_LEAD * CPBar@{n}@{m} ^ ( ( alphaCP@{n} - 1 ) * ( 1 - 1 / eC@{n} ) - 1 ) * ( C@{n}@{m}_LEAD / OmegaC@{n}_LEAD ) ^ ( 1 / eC@{n} ) * alphaCP@{n} * CP@{n}@{m}_LEAD ^ ( 1 - 1 / eC@{n} ) )
		- VV@{n}@{m}_LEAD * lambda_CPBar@{n}@{m}_LEAD * ( CP@{n}@{m}_LEAD / CG@{n}_LEAD * ( N@{n}b_LEAD + N@{n}l_LEAD ) / N@{n}@{m}_LEAD ) ^ ( 1 - varrhoCP@{n} ) * varrhoCP@{n} * CPBar@{n}@{m} ^ ( varrhoCP@{n} - 1 )
		+ lambda_CPBar@{n}@{m};
		
//FOC of durable consumption
		- lambda_CP@{n}@{m} * OmegaCP@{n} * CDBar@{n}@{m}_LAG ^ ( ( alphaCD@{n} - 1 ) * ( eCP@{n} - 1 ) / eCP@{n} ) * alphaCD@{n} * ( CP@{n}@{m} / CD@{n}@{m} / OmegaCP@{n} ) ^ ( 1 / eCP@{n} )
		- lambda_CDBar@{n}@{m} * CND@{n}@{m} ^ ( varrhoCD@{n} - 1 ) * CDBar@{n}@{m}_LAG ^ varrhoCD@{n} * ( 1 - varrhoCD@{n} ) * CD@{n}@{m} ^ ( -varrhoCD@{n} )
		+ lambda_CD@{n}@{m};

//FOC of durable consumption auxilary
		- VV@{n}@{m}_LEAD * lambda_CP@{n}@{m}_LEAD * ( alphaCD@{n} * CP@{n}@{m}_LEAD / CDBar@{n}@{m} - OmegaCP@{n}_LEAD * CDBar@{n}@{m} ^ ( ( alphaCD@{n} - 1 ) * ( 1 - 1 / eCP@{n} ) - 1 ) * ( CP@{n}@{m}_LEAD / OmegaCP@{n}_LEAD ) ^ ( 1 / eCP@{n} ) * alphaCD@{n} * CD@{n}@{m}_LEAD ^ ( 1 - 1 / eCP@{n} ) )
		- VV@{n}@{m}_LEAD * lambda_CDBar@{n}@{m}_LEAD * ( CD@{n}@{m}_LEAD / CND@{n}@{m}_LEAD ) ^ ( 1 - varrhoCD@{n} ) * varrhoCD@{n} * CDBar@{n}@{m} ^ ( varrhoCD@{n} - 1 )
		+ lambda_CDBar@{n}@{m};
		
//FOC of nondurable consumption
		- lambda_CP@{n}@{m} * OmegaCP@{n} * CDBar@{n}@{m}_LAG ^ ( alphaCD@{n} * ( eCP@{n} - 1 ) / eCP@{n} ) * ( 1 - alphaCD@{n} ) * ( CP@{n}@{m} / CND@{n}@{m} / OmegaCP@{n} ) ^ ( 1 / eCP@{n} )
		- lambda_CDBar@{n}@{m} * CD@{n}@{m} ^ ( 1 - varrhoCD@{n} ) * CDBar@{n}@{m}_LAG ^ varrhoCD@{n} * ( varrhoCD@{n} - 1 ) * CND@{n}@{m} ^ ( varrhoCD@{n} - 2 )
		- lambda_B@{n}@{m} * PND@{n} * ( 1 + tauND@{n} );
	
//FOC of durable investment
		#lambda_D@{n}@{m} = ( 1 + tauD@{n} ) * lambda_B@{n}@{m} * PD@{n} * exp( thetaGD@{n} / 2 * ( log( GD@{n}@{m} / GD@{n}@{m}_LAG ) ) ^ 2 + thetaPD@{n} / 2 * ( log( D@{n}@{m} / DP@{n}@{m}_LAG ) ) ^ 2 );
		#lambda_D@{n}@{m}_LEAD = ( 1 + tauD@{n}_LEAD ) * lambda_B@{n}@{m}_LEAD * PD@{n}_LEAD * exp( thetaGD@{n} / 2 * ( log( GD@{n}@{m}_LEAD / GD@{n}@{m} ) ) ^ 2 + thetaPD@{n} / 2 * ( log( D@{n}@{m}_LEAD / DP@{n}@{m} ) ) ^2 );
	
//FOC of durable stock
		- lambda_CD@{n}@{m} * alphah@{n} * CD@{n}@{m} / D@{n}@{m}
		- lambda_D@{n}@{m} * ( exp( -thetaGD@{n} / 2 * ( log( GD@{n}@{m} / GD@{n}@{m}_LAG ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m} / DP@{n}@{m}_LAG ) ) ^ 2 ) * thetaPD@{n} * log( D@{n}@{m} / DP@{n}@{m}_LAG ) * ID@{n}@{m} / D@{n}@{m} + 1 )
		+ VV@{n}@{m}_LEAD * lambda_D@{n}@{m}_LEAD * ( 1 - deltaD@{n}_LEAD - thetaDU0@{n} / ( 1+thetaDU1@{n} ) * DU@{n}@{m}_LEAD ^ ( 1+thetaDU1@{n} ) )
		- lambda_GD@{n}@{m}
		+ VV@{n}@{m}_LEAD * lambda_GD@{n}@{m}_LEAD * GD@{n}@{m}_LEAD
		@#if m == "b"
		+ lambda_F@{n} * ( 1 - rhoQB@{n} ) * m@{n} * PD@{n}
		@#endif
		;

//FOC of durable stock growth
		- lambda_D@{n}@{m} * ID@{n}@{m} / GD@{n}@{m} * exp( -thetaGD@{n} / 2 * ( log( GD@{n}@{m} / GD@{n}@{m}_LAG ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m} / DP@{n}@{m}_LAG ) ) ^ 2 ) * thetaGD@{n} * log( GD@{n}@{m} / GD@{n}@{m}_LAG )
		+ VV@{n}@{m}_LEAD * lambda_D@{n}@{m}_LEAD * ID@{n}@{m}_LEAD / GD@{n}@{m} * exp( -thetaGD@{n} / 2 * ( log( GD@{n}@{m}_LEAD / GD@{n}@{m} ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m}_LEAD / DP@{n}@{m} ) ) ^ 2 ) * thetaGD@{n} * log( GD@{n}@{m}_LEAD / GD@{n}@{m} )
		+ lambda_GD@{n}@{m} * D@{n}@{m}_LAG;

//FOC of planned durable stock
		VV@{n}@{m}_LEAD * lambda_D@{n}@{m}_LEAD * ID@{n}@{m}_LEAD / DP@{n}@{m} * exp( -thetaGD@{n} / 2 * ( log( GD@{n}@{m}_LEAD / GD@{n}@{m} ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m}_LEAD / DP@{n}@{m} ) ) ^ 2 ) * thetaPD@{n} * log( D@{n}@{m}_LEAD / DP@{n}@{m} );

//FOC of durable utilization
		- lambda_CD@{n}@{m} * alphah@{n} * CD@{n}@{m} / DU@{n}@{m}
		- lambda_D@{n}@{m} * thetaDU0@{n} * DU@{n}@{m} ^ thetaDU1@{n} * D@{n}@{m}_LAG;
	
//labor supply
	- kappah@{n} * ( Lh@{n}@{m} / N@{n}@{m} ) ^ nuh@{n} * ( CBar@{n}@{m}_LAG / N@{n}@{m}_LAG ) * V@{n}@{m} ^ sigma@{n} * ( 1 - beta@{n}@{m} ) * N@{n}@{m} ^ ( xi@{n} - 1 + sigma@{n} ) * U@{n}@{m} ^ -sigma@{n}
	- lambda_CD@{n}@{m} * ( 1 - alphah@{n} ) * CD@{n}@{m} / Lh@{n}@{m};
	@#endfor

	@#for m in ["l"]
	@#for S in Sectors2
		#W@{S}@{n} = kappa@{S}@{n} * ( L@{S}@{n}@{m} / N@{n}@{m} ) ^ nu@{S}@{n} * ( CBar@{n}@{m}_LAG / N@{n}@{m}_LAG ) * V@{n}@{m} ^ sigma@{n} * ( 1 - beta@{n}@{m} ) * N@{n}@{m} ^ ( xi@{n} - 1 + sigma@{n} ) * U@{n}@{m} ^ -sigma@{n} / lambda_B@{n}@{m} / ( 1 - tauL@{S}@{n} );
	@#endfor
	@#endfor
	
	@#for m in ["b"]
	@#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
		W@{S}@{n} = kappa@{S}@{n} * ( L@{S}@{n}@{m} / N@{n}@{m} ) ^ nu@{S}@{n} * ( CBar@{n}@{m}_LAG / N@{n}@{m}_LAG ) * V@{n}@{m} ^ sigma@{n} * ( 1 - beta@{n}@{m} ) * N@{n}@{m} ^ ( xi@{n} - 1 + sigma@{n} ) * U@{n}@{m} ^ -sigma@{n} / lambda_B@{n}@{m} / ( 1 - tauL@{S}@{n} );
	@#endfor
	@#endfor
	
	@#for m in ["b"]
	@#for S in [ "W", "T", "NT" ]
		W@{S}@{n} = kappaS@{S}@{n} * ( LS@{S}@{n}@{m} / N@{n}@{m} ) ^ nuS@{S}@{n} * ( CBar@{n}@{m}_LAG / N@{n}@{m}_LAG ) * V@{n}@{m} ^ sigma@{n} * ( 1 - beta@{n}@{m} ) * N@{n}@{m} ^ ( xi@{n} - 1 + sigma@{n} ) * U@{n}@{m} ^ -sigma@{n} / lambda_B@{n}@{m} / ( 1 - tauL@{S}@{n} );
	@#endfor
	@#endfor
	
	@#for S in Sectors0
//FOC of investment
		#lambda_K@{S}@{n} = lambda_B@{n}l * PKP@{n} * exp( thetaGKP@{n} / 2 * ( log( GKP@{S}@{n} / GKP@{S}@{n}_LAG ) ) ^ 2 + thetaPKP@{n} / 2 * ( log( KP@{S}@{n} / KPP@{S}@{n}_LAG ) ) ^ 2 );
		#lambda_K@{S}@{n}_LEAD = lambda_B@{n}l_LEAD * PKP@{n}_LEAD * exp( thetaGKP@{n} / 2 * ( log( GKP@{S}@{n}_LEAD / GKP@{S}@{n} ) ) ^ 2 + thetaPKP@{n} / 2 * ( log( KP@{S}@{n}_LEAD / KPP@{S}@{n} ) ) ^2 );
		
//FOC of capital growth rate
		lambda_GK@{S}@{n}=
		+ lambda_K@{S}@{n} * IKP@{S}@{n} / KP@{S}@{n} * exp( -thetaGKP@{n} / 2 * ( log( GKP@{S}@{n} / GKP@{S}@{n}_LAG ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n} / KPP@{S}@{n}_LAG ) ) ^ 2 ) * thetaGKP@{n} * log( GKP@{S}@{n} / GKP@{S}@{n}_LAG )
		- VV@{n}l_LEAD * lambda_K@{S}@{n}_LEAD * IKP@{S}@{n}_LEAD / KP@{S}@{n} * exp( -thetaGKP@{n} / 2 * ( log( GKP@{S}@{n}_LEAD / GKP@{S}@{n} ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n}_LEAD / KPP@{S}@{n} ) ) ^ 2 ) * thetaGKP@{n} * log( GKP@{S}@{n}_LEAD / GKP@{S}@{n} );
		
//FOC of capital stock
		lambda_B@{n}l * KU@{S}@{n} * RKP@{S}@{n} * ( 1 - tauK@{S}@{n} )
		- lambda_K@{S}@{n} * ( exp( -thetaGKP@{n} / 2 * ( log( GKP@{S}@{n} / GKP@{S}@{n}_LAG ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n} / KPP@{S}@{n}_LAG ) ) ^ 2 ) * thetaPKP@{n} * log( KP@{S}@{n} / KPP@{S}@{n}_LAG ) * IKP@{S}@{n} / KP@{S}@{n} + 1 )
		+ VV@{n}l_LEAD * lambda_K@{S}@{n}_LEAD * ( 1 - deltaKP@{S}@{n}_LEAD - thetaKU0@{n} / ( 1+thetaKU1@{n} ) * KU@{S}@{n}_LEAD ^ ( 1+thetaKU1@{n} ) )
		- lambda_GK@{S}@{n}
		+ VV@{n}l_LEAD * lambda_GK@{S}@{n}_LEAD * GKP@{S}@{n}_LEAD;
		
//FOC of planned capital stock
		VV@{n}l_LEAD * lambda_K@{S}@{n}_LEAD * IKP@{S}@{n}_LEAD / KPP@{S}@{n} * exp( -thetaGKP@{n} / 2 * ( log( GKP@{S}@{n}_LEAD / GKP@{S}@{n} ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n}_LEAD / KPP@{S}@{n} ) ) ^ 2 ) * thetaPKP@{n} * log( KP@{S}@{n}_LEAD / KPP@{S}@{n} );

//FOC of capital utilization
		lambda_B@{n}l * RKP@{S}@{n} * KP@{S}@{n} * ( 1 - tauK@{S}@{n} ) = lambda_K@{S}@{n} * thetaKU0@{n} * KU@{S}@{n} ^ thetaKU1@{n} * KP@{S}@{n}_LAG;

//FOC of Human capital investment
		#lambda_H@{S}@{n} = lambda_B@{n}l * PHP@{n} * exp( thetaGHP@{n} / 2 * ( log( GHP@{S}@{n} / GHP@{S}@{n}_LAG ) ) ^ 2 + thetaPHP@{n} / 2 * ( log( HP@{S}@{n} / HPP@{S}@{n}_LAG ) ) ^ 2 );
		#lambda_H@{S}@{n}_LEAD = lambda_B@{n}l_LEAD * PHP@{n}_LEAD * exp( thetaGHP@{n} / 2 * ( log( GHP@{S}@{n}_LEAD / GHP@{S}@{n} ) ) ^ 2 + thetaPHP@{n} / 2 * ( log( HP@{S}@{n}_LEAD / HPP@{S}@{n} ) ) ^2 );

//FOC of human capital growth rate
		lambda_GH@{S}@{n}=
		+ lambda_H@{S}@{n} * IHP@{S}@{n} / HP@{S}@{n} * exp( -thetaGHP@{n} / 2 * ( log( GHP@{S}@{n} / GHP@{S}@{n}_LAG ) ) ^ 2 - thetaPHP@{n} / 2 * ( log( HP@{S}@{n} / HPP@{S}@{n}_LAG ) ) ^ 2 ) * thetaGHP@{n} * log( GHP@{S}@{n} / GHP@{S}@{n}_LAG )
		- VV@{n}l_LEAD * lambda_H@{S}@{n}_LEAD * IHP@{S}@{n}_LEAD / HP@{S}@{n} * exp( -thetaGHP@{n} / 2 * ( log( GHP@{S}@{n}_LEAD / GHP@{S}@{n} ) ) ^ 2 - thetaPHP@{n} / 2 * ( log( HP@{S}@{n}_LEAD / HPP@{S}@{n} ) ) ^ 2 ) * thetaGHP@{n} * log( GHP@{S}@{n}_LEAD / GHP@{S}@{n} );
		
//FOC of human capital stock
		lambda_B@{n}l * RHP@{S}@{n} * ( 1 - tauH@{S}@{n} )
		- lambda_H@{S}@{n} * ( exp( -thetaGHP@{n} / 2 * ( log( GHP@{S}@{n} / GHP@{S}@{n}_LAG ) ) ^ 2 - thetaPHP@{n} / 2 * ( log( HP@{S}@{n} / HPP@{S}@{n}_LAG ) ) ^ 2 ) * thetaPHP@{n} * log( HP@{S}@{n} / HPP@{S}@{n}_LAG ) * IHP@{S}@{n} / HP@{S}@{n} + 1 )
		+ VV@{n}l_LEAD * lambda_H@{S}@{n}_LEAD * ( 1 - deltaHP@{S}@{n}_LEAD )
		- lambda_GH@{S}@{n}
		+ VV@{n}l_LEAD * lambda_GH@{S}@{n}_LEAD * GHP@{S}@{n}_LEAD;
		
//FOC of human planned capital stock
		VV@{n}l_LEAD * lambda_H@{S}@{n}_LEAD * IHP@{S}@{n}_LEAD / HPP@{S}@{n} * exp( -thetaGHP@{n} / 2 * ( log( GHP@{S}@{n}_LEAD / GHP@{S}@{n} ) ) ^ 2 - thetaPHP@{n} / 2 * ( log( HP@{S}@{n}_LEAD / HPP@{S}@{n} ) ) ^ 2 ) * thetaPHP@{n} * log( HP@{S}@{n}_LEAD / HPP@{S}@{n} );
	@#endfor

//Impatient's budget and collateral constraints
	- ID@{n}b * PD@{n} * ( 1 + tauD@{n} ) - IND@{n}b * PND@{n} * ( 1 + tauND@{n} )
	- B@{n}_LAG + Q * B@{n}
	- tau@{n}b * Y@{n} * P@{n}
	@#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
		+ W@{S}@{n} * ( 1 - tauL@{S}@{n} ) * L@{S}@{n}b
	@#endfor
	@#for S in [ "W", "T", "NT" ]
		+ W@{S}@{n} * ( 1 - tauL@{S}@{n} ) * LS@{S}@{n}b
	@#endfor
	;
	rhoQB@{n} * B@{n}_LAG - B@{n} + ( 1 - rhoQB@{n} ) * m@{n} * D@{n}b * PD@{n};

//household aggregae
	@#for S in Sectors1
		#L@{S}@{n}_LAG = L@{S}@{n}b_LAG + L@{S}@{n}l_LAG;
		#L@{S}@{n} = L@{S}@{n}b + L@{S}@{n}l;
		#L@{S}@{n}_LEAD = L@{S}@{n}b_LEAD + L@{S}@{n}l_LEAD;
	@#endfor
	@#for S in  ["W", "T", "NT" ]
		#L@{S}@{n}_LAG = L@{S}@{n}b_LAG + LS@{S}@{n}b_LAG + L@{S}@{n}l_LAG;
		#L@{S}@{n} = L@{S}@{n}b + LS@{S}@{n}b + L@{S}@{n}l;
		#L@{S}@{n}_LEAD = L@{S}@{n}b_LEAD + LS@{S}@{n}b_LEAD + L@{S}@{n}l_LEAD;
	@#endfor
	@#for S in  ["SW", "ST", "SNT" ]
		#L@{S}@{n}_LAG = L@{S}@{n}l_LAG;
		#L@{S}@{n} = L@{S}@{n}l;
		#L@{S}@{n}_LEAD = L@{S}@{n}l_LEAD;
	@#endfor

	#ID@{n} = ID@{n}b + ID@{n}l;
	#IND@{n} = IND@{n}b + IND@{n}l;
	#ID@{n}_LAG = ID@{n}b_LAG + ID@{n}l_LAG;
	#IND@{n}_LAG = IND@{n}b_LAG + IND@{n}l_LAG;

//Total demand of IK
	#IKP@{n} =
	@#for S in Sectors0
		+ IKP@{S}@{n}
	@#endfor
	;
	#IKP@{n}_LAG =
	@#for S in Sectors0
		+ IKP@{S}@{n}_LAG
	@#endfor
	;

//Total demand of IH IH
	#IHP@{n} =
	@#for S in Sectors0
		+ IHP@{S}@{n}
	@#endfor
	;
	#IHP@{n}_LAG =
	@#for S in Sectors0
		+ IHP@{S}@{n}_LAG
	@#endfor
	;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                            production of final goods                                                  //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	@#for S in SectorsP1
		//can't define Y@{S}@{n} and P@{S}@{n} as MLV because
		//we need to define Y@{n}, and household take P@{S}@{n} as given
		I@{S}@{n} = Omega@{S}@{n} * Y@{S}@{n} ^ alpha@{S}@{n} * L@{S}@{n} ^ ( 1 - alpha@{S}@{n} );
		P@{S}@{n} * alpha@{S}@{n} * I@{S}@{n} / Y@{S}@{n} = P@{n};
	@#endfor
	PKP@{n} * ( 1 - alphaKP@{n} ) * IKP@{n} / LKP@{n} = WK@{n};
	PHP@{n} * ( 1 - alphaHP@{n} ) * IHP@{n} / LHP@{n} = WH@{n};
	PD@{n} * ( 1 - alphaD@{n} ) * ID@{n} / LD@{n} = WD@{n};
	PND@{n} * ( 1 - alphaND@{n} ) * IND@{n} / LND@{n} = WNDCG@{n};

	#LKG@{n} = LK@{n} - LKP@{n};
	#LHG@{n} = LH@{n} - LHP@{n};
	#LCG@{n} = LNDCG@{n} - LND@{n};
	#LKG@{n}_LAG = LK@{n}_LAG - LKP@{n}_LAG;
	#LHG@{n}_LAG = LH@{n}_LAG - LHP@{n}_LAG;
	#LCG@{n}_LAG = LNDCG@{n}_LAG - LND@{n}_LAG;

	@#for S in SectorsG1
		#Y@{S}@{n} = tau@{S}@{n} * alpha@{S}@{n} * Y@{n};
		#Y@{S}@{n}_LAG = tau@{S}@{n}_LAG * alpha@{S}@{n} * Y@{n}_LAG;
    @#endfor
    #IKG@{n} = OmegaKG@{n} * YKG@{n} ^ alphaKG@{n} * LKG@{n} ^ ( 1 - alphaKG@{n} );
    #IKG@{n}_LAG = OmegaKG@{n}_LAG * YKG@{n}_LAG ^ alphaKG@{n} * LKG@{n}_LAG ^ ( 1 - alphaKG@{n} );
    #IHG@{n} = OmegaHG@{n} * YHG@{n} ^ alphaHG@{n} * LHG@{n} ^ ( 1 - alphaHG@{n} );
    #IHG@{n}_LAG = OmegaHG@{n}_LAG * YHG@{n}_LAG ^ alphaHG@{n} * LHG@{n}_LAG ^ ( 1 - alphaHG@{n} );
    #ICG@{n} = OmegaCG@{n} * YCG@{n} ^ alphaCG@{n} * LCG@{n} ^ ( 1 - alphaCG@{n} );
    #ICG@{n}_LAG = OmegaCG@{n}_LAG * YCG@{n}_LAG ^ alphaCG@{n} * LCG@{n}_LAG ^ ( 1 - alphaCG@{n} );
	@#for S in SectorsG1	
		#P@{S}@{n} = P@{n} * Y@{S}@{n} / alpha@{S}@{n} / I@{S}@{n};
		#P@{S}@{n}_LAG = P@{n}_LAG * Y@{S}@{n}_LAG / alpha@{S}@{n} / I@{S}@{n}_LAG;
	@#endfor

	PKG@{n} * ( 1 - alphaKG@{n} ) * IKG@{n} / LKG@{n} = WK@{n};
	PHG@{n} * ( 1 - alphaHG@{n} ) * IHG@{n} / LHG@{n} = WH@{n};
	PCG@{n} * ( 1 - alphaCG@{n} ) * ICG@{n} / LCG@{n} = WNDCG@{n};
	
	#GKG@{n} = KG@{n} / KG@{n}_LAG;
	#GKG@{n}_LAG = KG@{n}_LAG / KG@{n}_LAG2;
	#GHG@{n} = HG@{n} / HG@{n}_LAG;
	#GHG@{n}_LAG = HG@{n}_LAG / HG@{n}_LAG2;
	CG@{n} = ICG@{n};
	KG@{n} = ( 1 - deltaKG@{n} ) * KG@{n}_LAG + IKG@{n} * exp( - thetaGKG@{n} / 2 * ( log( GKG@{n} / GKG@{n}_LAG ) ) ^ 2 );
	HG@{n} = ( 1 - deltaHG@{n} ) * HG@{n}_LAG + IHG@{n} * exp( - thetaGHG@{n} / 2 * ( log( GHG@{n} / GHG@{n}_LAG ) ) ^ 2 );
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                     production of almost final goods                                                  //
//                                    trade of tradable goods and widgets                                                //
//                                                 The ROW                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
//scale parameters in final good production
	#yNT@{n} = STEADY_STATE( alphaNC@{n} * P@{n} / PNT@{n} / ( 1 + tauNT@{n} ) * OmegaY@{n} );
	#yTC@{n} = STEADY_STATE( ( 1 - alphaNC@{n} ) * P@{n} / PTC@{n} / ( 1 + tauTC@{n} ) * OmegaY@{n} );

//demand of nontradable
	#YNT@{n} = ( alphaNC@{n} * OmegaY@{n} * P@{n} / ( PNT@{n} * yNT@{n} * ( 1 + tauNT@{n} ) ) ) ^ eNC@{n} * yNT@{n} * Y@{n} / OmegaY@{n};
	#YNT@{n}_LEAD = ( alphaNC@{n} * OmegaY@{n}_LEAD * P@{n}_LEAD / ( PNT@{n}_LEAD * yNT@{n} * ( 1 + tauNT@{n}_LEAD ) ) ) ^ eNC@{n} * yNT@{n} * Y@{n}_LEAD / OmegaY@{n}_LEAD;

//demand of tradable composite
	#YTC@{n}_LAG = ( ( 1 - alphaNC@{n} ) * OmegaY@{n}_LAG * P@{n}_LAG / ( PTC@{n}_LAG * yTC@{n} * ( 1 + tauTC@{n}_LAG ) ) ) ^ eNC@{n} * yTC@{n} * Y@{n}_LAG / OmegaY@{n}_LAG;
	#YTC@{n} = ( ( 1 - alphaNC@{n} ) * OmegaY@{n} * P@{n} / ( PTC@{n} * yTC@{n} * ( 1 + tauTC@{n} ) ) ) ^ eNC@{n} * yTC@{n} * Y@{n} / OmegaY@{n};
	#YTC@{n}_LEAD = ( ( 1 - alphaNC@{n} ) * OmegaY@{n}_LEAD * P@{n}_LEAD / ( PTC@{n}_LEAD * yTC@{n} * ( 1 + tauTC@{n}_LEAD ) ) ) ^ eNC@{n} * yTC@{n} * Y@{n}_LEAD / OmegaY@{n}_LEAD;

//production of final goods
	Y@{n} = OmegaY@{n} * ( alphaNC@{n} * ( YNT@{n} / yNT@{n} ) ^ ( ( eNC@{n} - 1 ) / eNC@{n} ) + ( 1 - alphaNC@{n} ) * ( YTC@{n} / yTC@{n} ) ^ ( ( eNC@{n} - 1 ) / eNC@{n} ) ) ^ ( eNC@{n} / ( eNC@{n} - 1 ) );

@#if n == 1
//ROW VAR, note that the VAR is defined on detrended PT0 and YTC0!
	#YTC0ss = steady_state(YTC1 * N0 / N1) * yTC0;
	#PT0ss = steady_state(PT1) * pT0;
	log(PT0 ) = log(PT0ss) * ( 1 - rhoPP0 ) - log(YTC0ss) * rhoPY0 + log(PT0_LAG * gPS) * rhoPP0 + log(YTC0_LAG * gYS) * rhoPY0 + sigmaP0 * epsilon_P0;
	log(YTC0) = log(PT0ss) * -rhoYP0 + ( 1 - rhoYY0 ) * log(YTC0ss) + log(PT0_LAG * gPS) * rhoYP0 + log(YTC0_LAG * gYS) * rhoYY0 + sigmaY0 * ( epsilon_P0 * rho0 + epsilon_Y0 * ( 1 - rho0 ^ 2 )^( 1 / 2 ) );

//ROW demand of tradable goods
	#iotaTM0=0; #iotaTM0_LAG=0; #iotaTM0_LEAD=0;
	#iotaTX0=0; #iotaTX0_LAG=0; #iotaTX0_LEAD=0;
	@#for m in 1:SN
		#YT0@{m}_LAG = ( PT0_LAG / ( PT@{m}_LAG * ( 1 + iotaTM@{n}_LAG + iotaTX@{m}_LAG ) ) ) ^ eT0@{m} * YTC0_LAG * steady_state(N@{m});
		#YT0@{m} = ( PT0 / ( PT@{m} * ( 1 + iotaTM@{n} + iotaTX@{m} ) ) ) ^ eT0@{m} * YTC0 * steady_state(N@{m});
		#YT0@{m}_LEAD = ( PT0_LEAD / ( PT@{m}_LEAD * ( 1 + iotaTM@{n}_LEAD + iotaTX@{m}_LEAD ) ) ) ^ eT0@{m} * YTC0_LEAD * steady_state(N@{m});
	@#endfor
@#endif

//demand of tradable goods
	@#for m in 0:SN
		#YT@{n}@{m}_LAG = ( PTC@{n}_LAG * OmegaTC@{n}_LAG / ( PT@{m}_LAG *
		@#if n == m
			1
		@#else
			( 1 + iotaTM@{n}_LAG + iotaTX@{m}_LAG )
		@#endif
		) ) ^ eT@{n} * YTC@{n}_LAG / OmegaTC@{n}_LAG * steady_state(N@{m});

		#YT@{n}@{m} = ( PTC@{n} * OmegaTC@{n} / ( PT@{m} *
		@#if n == m
			1
		@#else
			( 1 + iotaTM@{n} + iotaTX@{m} )
		@#endif
		) ) ^ eT@{n} * YTC@{n} / OmegaTC@{n} * steady_state(N@{m});

		#YT@{n}@{m}_LEAD = ( PTC@{n}_LEAD * OmegaTC@{n}_LEAD / ( PT@{m}_LEAD *
		@#if n == m
			1
		@#else
			( 1 + iotaTM@{n}_LEAD + iotaTX@{m}_LEAD )
		@#endif
		) ) ^ eT@{n} * YTC@{n}_LEAD / OmegaTC@{n}_LEAD * steady_state(N@{m});
	@#endfor
			
//production of tradable composite
	YTC@{n} = OmegaTC@{n} * ( 0 
	@#for m in 0:SN
		+ YT@{n}@{m} ^ ( ( eT@{n} - 1 ) / eT@{n} ) * steady_state(N@{m}) ^ ( 1 / eT@{n} )
	@#endfor
	) ^ ( eT@{n} / ( eT@{n} - 1 ) );
@#endfor

@#for n in 1:SN
//tradable good market clearing
	#YT@{n}_LAG = YT0@{n}_LAG * ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG )
	@#for m in 1:SN
		+ YT@{m}@{n}_LAG * 
		@#if n == m
			1
		@#else
			( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG + ( 1 - phiiotaTM@{m} ) * iotaTM@{m}_LAG )
		@#endif
	@#endfor
    ;
	#YT@{n} = YT0@{n} * ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} )
	@#for m in 1:SN
		+ YT@{m}@{n} * 
		@#if n == m
			1
		@#else
			( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} + ( 1 - phiiotaTM@{m} ) * iotaTM@{m} )
		@#endif
	@#endfor
	;
	#YT@{n}_LEAD = YT0@{n}_LEAD * ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LEAD )
	@#for m in 1:SN
		+ YT@{m}@{n}_LEAD * 
		@#if n == m
			1
		@#else
			( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LEAD + ( 1 - phiiotaTM@{m} ) * iotaTM@{m}_LEAD )
		@#endif
	@#endfor
	;
@#endfor

@#for n in 1:SN
//production of widget composite and claim
    #FWC@{n} = FWCtilde * steady_state(YWC@{n});
	YWP@{n} = ( ( YWC@{n} + FWC@{n} ) / OmegaWC@{n} / HG@{n}_LAG ^ alphaHW@{n} ) ^ ( 1 / ( 1 - alphaHW@{n} ) );
	#YX@{n} = YWC@{n};

//demand of private widget composite (and price of claim)
	#PX@{n} = PWP@{n} * YWP@{n} / ( YWC@{n} + FWC@{n} ) / ( 1 - alphaHW@{n} ) - PWC;
%   it's more nature to define PWP as MLV, but PX has steady state = 0, So I make PX MLV
	
//demand for private widget variaty
	@#for m in 1:SN
		#YW@{n}@{m}_LAG = ( PWP@{n}_LAG * OmegaWP@{n}_LAG / ( PW@{m}_LAG *
		@#if n == m
			1
		@#else
			( 1 + iotaWM@{n}_LAG + iotaWX@{m}_LAG )
		@#endif
		)) ^ eW@{n} * YWP@{n}_LAG / OmegaWP@{n}_LAG * steady_state( N@{m} / NN );

		#YW@{n}@{m} = ( PWP@{n} * OmegaWP@{n} / ( PW@{m} *
		@#if n == m
			1
		@#else
			( 1 + iotaWM@{n} + iotaWX@{m} )
		@#endif
		)) ^ eW@{n} * YWP@{n} / OmegaWP@{n} * steady_state( N@{m} / NN );

		#YW@{n}@{m}_LEAD = ( PWP@{n}_LEAD * OmegaWP@{n}_LEAD / ( PW@{m}_LEAD *
		@#if n == m
			1
		@#else
			( 1 + iotaWM@{n}_LEAD + iotaWX@{m}_LEAD )
		@#endif
		)) ^ eW@{n} * YWP@{n}_LEAD / OmegaWP@{n}_LEAD * steady_state( N@{m} / NN );
	@#endfor

//production of private widget composite	
	YWP@{n} = OmegaWP@{n} * ( 
	@#for m in 1:SN
		+ YW@{n}@{m} ^ ( ( eW@{n} - 1 ) / eW@{n} ) * steady_state( N@{m} / NN ) ^ ( 1 / eW@{n} )
	@#endfor
	 ) ^ ( eW@{n} / ( eW@{n} - 1 ) );
@#endfor

@#for n in 1:SN
//private widget trade clearing
	#YW@{n}_LAG = 0
	@#for m in 1:SN
		+ YW@{m}@{n}_LAG * 
		@#if n == m
			1
		@#else
			( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n}_LAG + ( 1 - phiiotaWM@{m} ) * iotaWM@{m}_LAG )
		@#endif
	@#endfor
	;
	#YW@{n} = 0
	@#for m in 1:SN
		+ YW@{m}@{n} * 
		@#if n == m
			1
		@#else
			( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n} + ( 1 - phiiotaWM@{m} ) * iotaWM@{m} )
		@#endif
	@#endfor
	;
	#YW@{n}_LEAD = 0
	@#for m in 1:SN
		+ YW@{m}@{n}_LEAD * 
		@#if n == m
			1
		@#else
			( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n}_LEAD + ( 1 - phiiotaWM@{m} ) * iotaWM@{m}_LEAD )
		@#endif
	@#endfor
	;
@#endfor

//global total widget supply
#YWC_LAG = 0
@#for n in 1:SN
	+ YWC@{n}_LAG
@#endfor
;
#YWC = 0
@#for n in 1:SN
	+ YWC@{n}
@#endfor
;
#YWC_LEAD = 0
@#for n in 1:SN
	+ YWC@{n}_LEAD
@#endfor
;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                             production of T/NT/W                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#X = 0
@#for n in 1:SN
+ X@{n}
@#endfor
;
#X_LEAD = 0
@#for n in 1:SN
+ X@{n}_LEAD
@#endfor
;

@#for n in 1:SN
//scriptX
	#scriptX@{n} = 0
	@#for S in Sectors0
	  + scriptX@{S}@{n}
	@#endfor
	;
	#scriptX@{n}_LEAD = 0
	@#for S in Sectors0
	  + scriptX@{S}@{n}_LEAD
	@#endfor
	;
	
	scriptX@{n} = X@{n} * exp( -o@{n} * ( log( X@{n} / X ) - log( YX@{n} / YWC ) ) ^ 2 );
	
	#PscriptX@{n} = 1 / ( exp( -o@{n} * ( log( X@{n} / X ) - log( YX@{n} / YWC ) ) ^ 2 ) - scriptX@{n} * 2 * o@{n} * ( log( X@{n} / X ) - log( YX@{n} / YWC ) ) * (X - X@{n}) / X@{n} / X );

    PscriptX@{n} * ( scriptX@{n} * 2 * o@{n} * ( log( X@{n} / X ) - log( YX@{n} / YWC ) ) * (YWC - YX@{n}) / YX@{n} / YWC ) = PX@{n};

	@#for S in Sectors0
//HL production
		#YHL@{S}@{n} = OmegaHL@{S}@{n} * HP@{S}@{n} ^ alphaHL@{n} * LS@{S}@{n} ^ ( 1 - alphaHL@{n} );
		#YHL@{S}@{n}_LEAD = OmegaHL@{S}@{n}_LEAD * HP@{S}@{n}_LEAD ^ alphaHL@{n} * LS@{S}@{n}_LEAD ^ ( 1 - alphaHL@{n} );
		
		LS@{S}@{n} = ( 1 - alphaHL@{n} ) * PHL@{S}@{n} * YHL@{S}@{n} / WS@{S}@{n};
		
		HP@{S}@{n} = alphaHL@{n} * PHL@{S}@{n} * YHL@{S}@{n} / RHP@{S}@{n};

//KGKP
//Note that FK growth at stochastic rate is detrended by the stochastic trend like other variables in the equation.
//For example, fixed cost in <Clearing Up the Fiscal Multiplier Morass> also grow at the stochastic trend (technology)
        #FK@{S}@{n} = steady_state(OmegaKW@{n} * KG@{n}_LAG ^ alphaK@{n} * ( KUW@{n} * KPW@{n} ) ^ ( 1 - alphaK@{n} )) * FKtilde / ( 1 + FKtilde );
        #FK@{S}@{n}_LEAD = steady_state(OmegaKW@{n}_LEAD * KG@{n} ^ alphaK@{n} * ( KUW@{n}_LEAD * KPW@{n}_LEAD ) ^ ( 1 - alphaK@{n} )) * FKtilde / ( 1 + FKtilde );
		#K@{S}@{n} = OmegaK@{S}@{n} * KG@{n}_LAG ^ alphaK@{n} * ( KU@{S}@{n} * KP@{S}@{n} ) ^ ( 1 - alphaK@{n} ) - FK@{S}@{n};
		#K@{S}@{n}_LEAD = OmegaK@{S}@{n}_LEAD * KG@{n} ^ alphaK@{n} * ( KU@{S}@{n}_LEAD * KP@{S}@{n}_LEAD ) ^ ( 1 - alphaK@{n} ) - FK@{S}@{n}_LEAD;
		
		#RK@{S}@{n} = RKP@{S}@{n} * KU@{S}@{n} * KP@{S}@{n} / ( 1 - alphaK@{n} ) / ( K@{S}@{n} + FK@{S}@{n} );
        #RK@{S}@{n}_LEAD = RKP@{S}@{n}_LEAD * KU@{S}@{n}_LEAD * KP@{S}@{n}_LEAD / ( 1 - alphaK@{n} ) / ( K@{S}@{n}_LEAD + FK@{S}@{n}*steady_state( exp(log_gKG) ^ alphaK1 * exp(log_gKP) ^ ( 1 - alphaK1 ) ) );
		
//KL production
		#YKL@{S}@{n} = OmegaKL@{S}@{n} * KBar@{S}@{n}_LAG ^ alphaKL@{n} * ( alphaKL@{n} * ( K@{S}@{n} / KBar@{S}@{n}_LAG ) ^ ( ( eKL@{S}@{n} - 1 ) / eKL@{S}@{n} ) + ( 1 - alphaKL@{n} ) * L@{S}@{n} ^ ( ( eKL@{S}@{n} - 1 ) / eKL@{S}@{n} ) ) ^ ( eKL@{S}@{n} / ( eKL@{S}@{n} - 1 ) );
		#YKL@{S}@{n}_LEAD = OmegaKL@{S}@{n}_LEAD * KBar@{S}@{n} ^ alphaKL@{n} * ( alphaKL@{n} * ( K@{S}@{n}_LEAD / KBar@{S}@{n} ) ^ ( ( eKL@{S}@{n} - 1 ) / eKL@{S}@{n} ) + ( 1 - alphaKL@{n} ) * L@{S}@{n}_LEAD ^ ( ( eKL@{S}@{n} - 1 ) / eKL@{S}@{n} ) ) ^ ( eKL@{S}@{n} / ( eKL@{S}@{n} - 1 ) );
		
		KBar@{S}@{n} = ( K@{S}@{n} / L@{S}@{n} ) ^ ( 1 - varrhoKL@{n} ) * KBar@{S}@{n}_LAG ^ varrhoKL@{n};

		#KTemp@{S}@{n} = K@{S}@{n} * ( alphaKL@{n} * PKL@{S}@{n} * OmegaKL@{S}@{n} * KBar@{S}@{n}_LAG ^ ( ( alphaKL@{n}  - 1 ) * ( eKL@{S}@{n} - 1 ) / eKL@{S}@{n} ) * ( YKL@{S}@{n} / K@{S}@{n} / OmegaKL@{S}@{n} ) ^ ( 1 / eKL@{S}@{n} ) - RK@{S}@{n} );

		KTemp@{S}@{n} = L@{S}@{n} * ( W@{S}@{n} - ( 1 - alphaKL@{n} ) * PKL@{S}@{n} * OmegaKL@{S}@{n} * KBar@{S}@{n}_LAG ^ ( alphaKL@{n} * ( eKL@{S}@{n} - 1 ) / eKL@{S}@{n} ) * ( YKL@{S}@{n} / L@{S}@{n} / OmegaKL@{S}@{n} ) ^ ( 1 / eKL@{S}@{n} ) );

		1 = Xi_LEAD / KTemp@{S}@{n} * ( K@{S}@{n}_LEAD * alphaKL@{n} * PKL@{S}@{n}_LEAD * OmegaKL@{S}@{n}_LEAD * KBar@{S}@{n} ^ ( ( alphaKL@{n} - 1 ) * ( eKL@{S}@{n} - 1 ) / eKL@{S}@{n} ) * ( YKL@{S}@{n}_LEAD / K@{S}@{n}_LEAD / OmegaKL@{S}@{n}_LEAD ) ^ ( 1 / eKL@{S}@{n} ) - ( 1 - varrhoKL@{n} ) * alphaKL@{n} * PKL@{S}@{n}_LEAD * YKL@{S}@{n}_LEAD - varrhoKL@{n} * RK@{S}@{n}_LEAD * K@{S}@{n}_LEAD );
		
//HLX production
		#YHLX@{S}@{n} = OmegaHLX@{S}@{n} * YHLBar@{S}@{n}_LAG ^ alphaHLX@{n} * ( alphaHLX@{n} * ( YHL@{S}@{n} / YHLBar@{S}@{n}_LAG ) ^ ( ( eHLX@{S}@{n} - 1 ) / eHLX@{S}@{n} ) + ( 1 - alphaHLX@{n} ) * scriptX@{S}@{n} ^ ( ( eHLX@{S}@{n} - 1 ) / eHLX@{S}@{n} ) ) ^ ( eHLX@{S}@{n} / ( eHLX@{S}@{n} - 1 ) );
		#YHLX@{S}@{n}_LEAD = OmegaHLX@{S}@{n}_LEAD * YHLBar@{S}@{n} ^ alphaHLX@{n} * ( alphaHLX@{n} * ( YHL@{S}@{n}_LEAD / YHLBar@{S}@{n} ) ^ ( ( eHLX@{S}@{n} - 1 ) / eHLX@{S}@{n} ) + ( 1 - alphaHLX@{n} ) * scriptX@{S}@{n}_LEAD ^ ( ( eHLX@{S}@{n} - 1 ) / eHLX@{S}@{n} ) ) ^ ( eHLX@{S}@{n} / ( eHLX@{S}@{n} - 1 ) );
		
		YHLBar@{S}@{n} = ( YHL@{S}@{n} / scriptX@{S}@{n} ) ^ ( 1 - varrhoHLX@{n} ) * YHLBar@{S}@{n}_LAG ^ varrhoHLX@{n};

		#YHLTemp@{S}@{n} = YHL@{S}@{n} * ( alphaHLX@{n} * PHLX@{S}@{n} * OmegaHLX@{S}@{n} * YHLBar@{S}@{n}_LAG ^ ( ( alphaHLX@{n}  - 1 ) * ( eHLX@{S}@{n} - 1 ) / eHLX@{S}@{n} ) * ( YHLX@{S}@{n} / YHL@{S}@{n} / OmegaHLX@{S}@{n} ) ^ ( 1 / eHLX@{S}@{n} ) - PHL@{S}@{n} );

		YHLTemp@{S}@{n} = scriptX@{S}@{n} * ( ( 1 + tauscriptX@{S}@{n} ) * PscriptX@{n} - ( 1 - alphaHLX@{n} ) * PHLX@{S}@{n} * OmegaHLX@{S}@{n} * YHLBar@{S}@{n}_LAG ^ ( alphaHLX@{n} * ( eHLX@{S}@{n} - 1 ) / eHLX@{S}@{n} ) * ( YHLX@{S}@{n} / scriptX@{S}@{n} / OmegaHLX@{S}@{n} ) ^ ( 1 / eHLX@{S}@{n} ) );

		YHLTemp@{S}@{n} = Xi_LEAD * ( YHL@{S}@{n}_LEAD * alphaHLX@{n} * PHLX@{S}@{n}_LEAD * OmegaHLX@{S}@{n}_LEAD * YHLBar@{S}@{n} ^ ( ( alphaHLX@{n} - 1 ) * ( eHLX@{S}@{n} - 1 ) / eHLX@{S}@{n} ) * ( YHLX@{S}@{n}_LEAD / YHL@{S}@{n}_LEAD / OmegaHLX@{S}@{n}_LEAD ) ^ ( 1 / eHLX@{S}@{n} ) - ( 1 - varrhoHLX@{n} ) * alphaHLX@{n} * PHLX@{S}@{n}_LEAD * YHLX@{S}@{n}_LEAD - varrhoHLX@{n} * PHL@{S}@{n}_LEAD * YHL@{S}@{n}_LEAD );

//Y production
		Y@{S}@{n} = Omega@{S}@{n} * YHLXBar@{S}@{n}_LAG ^ alphaY@{n} * ( alphaY@{n} * ( YHLX@{S}@{n} / YHLXBar@{S}@{n}_LAG ) ^ ( ( eY@{S}@{n} - 1 ) / eY@{S}@{n} ) + ( 1 - alphaY@{n} ) * YKL@{S}@{n} ^ ( ( eY@{S}@{n} - 1 ) / eY@{S}@{n} ) ) ^ ( eY@{S}@{n} / ( eY@{S}@{n} - 1 ) );

		YHLXBar@{S}@{n} = ( YHLX@{S}@{n} / YKL@{S}@{n} ) ^ ( 1 - varrhoY@{n} ) * YHLXBar@{S}@{n}_LAG ^ varrhoY@{n};

		#YHLXTemp@{S}@{n} = YHLX@{S}@{n} * ( alphaY@{n} * P@{S}@{n} * Omega@{S}@{n} * YHLXBar@{S}@{n}_LAG ^ ( ( alphaY@{n}  - 1 ) * ( eY@{S}@{n} - 1 ) / eY@{S}@{n} ) * ( Y@{S}@{n} / YHLX@{S}@{n} / Omega@{S}@{n} ) ^ ( 1 / eY@{S}@{n} ) - PHLX@{S}@{n} );

		YHLXTemp@{S}@{n} = YKL@{S}@{n} * ( PKL@{S}@{n} - ( 1 - alphaY@{n} ) * P@{S}@{n} * Omega@{S}@{n} * YHLXBar@{S}@{n}_LAG ^ ( alphaY@{n} * ( eY@{S}@{n} - 1 ) / eY@{S}@{n} ) * ( Y@{S}@{n} / YKL@{S}@{n} / Omega@{S}@{n} ) ^ ( 1 / eY@{S}@{n} ) );

		YHLXTemp@{S}@{n} = Xi_LEAD * ( YHLX@{S}@{n}_LEAD * alphaY@{n} * P@{S}@{n}_LEAD * Omega@{S}@{n}_LEAD * YHLXBar@{S}@{n} ^ ( ( alphaY@{n} - 1 ) * ( eY@{S}@{n} - 1 ) / eY@{S}@{n} ) * ( Y@{S}@{n}_LEAD / YHLX@{S}@{n}_LEAD / Omega@{S}@{n}_LEAD ) ^ ( 1 / eY@{S}@{n} ) - ( 1 - varrhoY@{n} ) * alphaY@{n} * P@{S}@{n}_LEAD * Y@{S}@{n}_LEAD - varrhoY@{n} * PHLX@{S}@{n}_LEAD * YHLX@{S}@{n}_LEAD );

	@#endfor
@#endfor

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                      Government                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@#for n in 1:SN

    #HoursWorkedPerCapita@{n} = log( ( 0
	@#for S in Sectors2
	  + L@{S}@{n}l + L@{S}@{n}b
	@#endfor
    ) / N@{n} );

    #HoursWorkedPerCapita@{n}_ss = steady_state( log( ( 0
	@#for S in Sectors2
	  + L@{S}@{n}l + L@{S}@{n}b
	@#endfor
    ) / N@{n} ) );

//spending
	log(tauKG@{n}) = log(tauKG@{n}_LAG) + phiYtauKG@{n} * ( Y@{n} / Y@{n}_LAG - steady_state( Y@{n} / Y@{n}_LAG ) ) + phiLtauKG@{n} * ( HoursWorkedPerCapita@{n} - HoursWorkedPerCapita@{n}_ss ) + phiutauKG@{n} * ( uALL@{n} + uS1ALL@{n} ) + uKG@{n};
	log(tauHG@{n}) = log(tauHG@{n}_LAG) + phiYtauHG@{n} * ( Y@{n} / Y@{n}_LAG - steady_state( Y@{n} / Y@{n}_LAG ) ) + phiLtauHG@{n} * ( HoursWorkedPerCapita@{n} - HoursWorkedPerCapita@{n}_ss ) + phiutauHG@{n} * ( uALL@{n} + uS1ALL@{n} ) + uHG@{n};
	log(tauCG@{n}) = log(tauCG@{n}_LAG) + phiYtauCG@{n} * ( Y@{n} / Y@{n}_LAG - steady_state( Y@{n} / Y@{n}_LAG ) ) + phiLtauCG@{n} * ( HoursWorkedPerCapita@{n} - HoursWorkedPerCapita@{n}_ss ) + phiutauCG@{n} * ( uALL@{n} + uS1ALL@{n} ) + uCG@{n};

//incomes
	tau@{n}b  = tau@{n}b_LAG   + phiYtau@{n}b * ( Y@{n} / Y@{n}_LAG - steady_state( Y@{n} / Y@{n}_LAG ) )  + phiLtau@{n}b * ( HoursWorkedPerCapita@{n} - HoursWorkedPerCapita@{n}_ss ) + phiutau@{n}b * ( uALL@{n} + ulbALL@{n} ) + u@{n}b;
	tau@{n}l  = tau@{n}l_LAG   + phiYtau@{n}l * ( Y@{n} / Y@{n}_LAG - steady_state( Y@{n} / Y@{n}_LAG ) )  + phiLtau@{n}l * ( HoursWorkedPerCapita@{n} - HoursWorkedPerCapita@{n}_ss ) + phiutau@{n}l * ( uALL@{n} + ulbALL@{n} ) + u@{n}l;
	tauD@{n}  = tauD@{n}_LAG   + phiutauD@{n}  * ( uALL@{n} + uCALL@{n} ) + uD@{n};
	tauND@{n} = tauND@{n}_LAG  + phiutauND@{n} * ( uALL@{n} + uCALL@{n} ) + uND@{n};
	tauNT@{n} = tauNT@{n}_LAG  + phiutauNT@{n} * ( uALL@{n} ) + uNT@{n};
	tauTC@{n} = tauTC@{n}_LAG  + phiutauTC@{n} * ( uALL@{n} ) + uTC@{n};

	iotaTX@{n} = iotaTX@{n}_LAG + phiuiotaTX@{n} * ( uALL@{n} + uiotaALL@{n} ) + uTX@{n};
	iotaTM@{n} = iotaTM@{n}_LAG + phiuiotaTM@{n} * ( uALL@{n} + uiotaALL@{n} ) + uTM@{n};
	iotaWX@{n} = iotaWX@{n}_LAG + phiuiotaWX@{n} * ( uALL@{n} + uiotaALL@{n} ) + uWX@{n};
	iotaWM@{n} = iotaWM@{n}_LAG + phiuiotaWM@{n} * ( uALL@{n} + uiotaALL@{n} ) + uWM@{n};

	@#for S in Sectors0
		tauH@{S}@{n}       = tauH@{S}@{n}_LAG       + phiutauH@{S}@{n} * ( uALL@{n} + uHALL@{n} + u@{S}ALL@{n} );
		tauK@{S}@{n}       = tauK@{S}@{n}_LAG       + phiutauK@{S}@{n} * ( uALL@{n} + uKALL@{n} + u@{S}ALL@{n} );
		tauscriptX@{S}@{n} = tauscriptX@{S}@{n}_LAG + phiutauX@{S}@{n} * ( uALL@{n} + uXALL@{n} + u@{S}ALL@{n} );
	@#endfor

	@#for S in Sectors2
		tauL@{S}@{n} = tauLa@{n} + tauLb@{n} * log( W@{S}@{n} );
	@#endfor
    tauLa@{n}      = tauLa@{n}_LAG      + phiutauLa@{n} * ( uALL@{n} + uLALL@{n} ) + uLa@{n};
    log(tauLb@{n}) = log(tauLb@{n}_LAG) + phiutauLb@{n} * ( uALL@{n} + uLALL@{n} ) + uLb@{n};

@#endfor
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                      engineering                                                      //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//markup of patent industries
#muP_LAG = lambda * eta * JP_LAG / ( JP_LAG - ( 1 - eta ) );
#muP = lambda * eta * JP / ( JP - ( 1 - eta ) );

//growth rateo of research effectiveness
#GERP_LAG = ( GAs_LAG ^ -zetaR * ( II_LAG / II_LAG2 ) ^ phiR ) ^ ( 1 / ( 1 - phiR ) );
#GERP = ( GAs ^ -zetaR * ( II / II_LAG ) ^ phiR ) ^ ( 1 / ( 1 - phiR ) );
#GERP_LEAD = ( GAs_LEAD ^ -zetaR * ( II_LEAD / II ) ^ phiR ) ^ ( 1 / ( 1 - phiR ) );

//growth rate of industry
#GII_LAG = GERP_LAG * II_LAG  / II_LAG2;
#GII = GERP * II  / II_LAG;
#GII_LEAD = GERP_LEAD * II_LEAD / II;
		
//depreciation of invented industries
#deltaI_LAG = deltaItilde * ( GII_LAG / STEADY_STATE( GII ) ) ^ psi;
#deltaI = deltaItilde * ( GII / STEADY_STATE( GII ) ) ^ psi;
#deltaI_LEAD = deltaItilde * ( GII_LEAD / STEADY_STATE( GII ) ) ^ psi;

//global total widget demand
YWC = scriptFI * II * ( scripts - ( 1 - scriptq ) * ( 1 - deltaI ) * scripts_LAG / GII ) + II * scripts * ScriptFRP * JP + X * PWC ^ ( - ( 1 + lambda ) / lambda ) * ( ( 1 - scripts_LAG ) * AN_LAG ^ ( 1 / lambda ) * ( 1 / ( 1 + eta * lambda ) ) ^ ( ( 1 + lambda ) / lambda ) + scripts_LAG * ( 1 / ( 1 + muP_LAG ) ) ^ ( ( 1 + lambda ) / lambda ) );

//free entry in inventing (I mannully detrend the ERP part of VI's trend)
#VI = scriptFI * PWC;
#VI_LEAD = scriptFI_LEAD * PWC_LEAD;

//auxilary variable in FOC of asymmetric pricing, measure of incentive to deviate from symmetric eq
#omegaP = JP * ( 1 - eta ) / ( JP - ( 1 - eta ) ) ^ 2 / ( 1 + muP );

//auxilary variable in research foc etc
#scriptdP = 1 - omegaP / ( 1 + omegaP ) * ( lambda - muP ) * ( muP - eta * lambda ) / lambda / ( 1 - eta ) / muP;

//evolving of aggregae markup
#mu_LAG = ( ( 1 - scripts_LAG ) * ( 1 / ( 1 + eta * lambda ) ) ^ ( 1 / lambda ) + scripts_LAG * ( 1 / ( 1 + muP_LAG ) ) ^ ( 1 / lambda ) ) ^ ( -lambda ) - 1;
#mu = ( ( 1 - scripts ) * ( 1 / ( 1 + eta * lambda ) ) ^ ( 1 / lambda ) + scripts * ( 1 / ( 1 + muP ) ) ^ ( 1 / lambda ) ) ^ ( -lambda ) - 1;

//engineering pricing
#A = PWC * ( 1 + mu_LAG );
#A_LEAD = PWC_LEAD * ( 1 + mu );

//growth rate of frontier technology
GAs = ( 1 + gamma * Z * ScriptFRP_LAG ) ^ ( 1 / gamma );

//aggregated productivity in engineering sector
PWC ^ ( 1 / lambda ) = ( 1 - scripts_LAG ) * ( AN_LAG / ( 1 + eta * lambda ) ) ^ ( 1 / lambda ) + scripts_LAG * ( 1 / ( 1 + muP_LAG ) ) ^ ( 1 / lambda );

//no patent industries law of motion
AN ^ ( 1 / lambda ) = ( 1 - ( 1 - deltaI ) / GII * ( 1 - scripts_LAG ) / ( 1 - scripts ) ) + ( 1 - deltaI ) / GII * ( 1 - scripts_LAG ) / ( 1 - scripts ) * AN_LAG ^ ( 1 / lambda );

//patent industries law of motion
scripts = ( 1 - ( 1 - deltaI ) / GII ) + ( 1 - deltaI ) / GII * ( 1 - scriptq ) * scripts_LAG;

//FOC of research
1 / II / JP * muP / ( 1 + muP ) * ( ( 1 + mu ) / ( 1 + muP ) ) ^ ( 1 / lambda ) * Xi_LEAD * X_LEAD * ( A_LEAD / GAs_LEAD ) ^ ( - 1 / lambda ) * scriptdP / muP * Z_LEAD / ( 1 + gamma * Z_LEAD * ScriptFRP ) = PWC;

//free entry
1 / II / JP * muP / ( 1 + muP ) * ( ( 1 + mu ) / ( 1 + muP ) ) ^ ( 1 / lambda ) * Xi_LEAD * X_LEAD * ( A_LEAD / GAs_LEAD ) ^ ( - 1 / lambda ) = ScriptFRP * PWC / scriptp;

//def. of inventor's value
VI = ( 1 - scriptp ) / scriptp * ScriptFRP * PWC * JP + ( 1 - scriptq ) * ( 1 - deltaI_LEAD ) * Xi_LEAD / GERP_LEAD * VI_LEAD;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                          estimation: measurement equations                                            //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//country1 = US
//country2 = Germany
//country3 = UK
//country4 = France
//country5 = REU(Belgium, Denmark, Finland, Italy, Netherlands, Portugal, Spain, Sweden)
//country6 = RMA(Australia, Canada, Japan, Norway, Switzerland)

@#for n in 1:SN
//GDP and deflator inflation
    #GDP@{n} =
    PKP@{n} * IKP@{n} + PHP@{n} * IHP@{n} + PD@{n} * ID@{n} + PND@{n} * IND@{n} + PKG@{n} * IKG@{n} + PHG@{n} * IHG@{n} + PCG@{n} * ICG@{n}
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} ) * YT0@{n} * PT@{n}
            - ( 1 + ( 1 - phiiotaTM@{n} ) * iotaTM@{n} ) * YT@{n}0 * PT0
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} + ( 1 - phiiotaTM@{m} ) * iotaTM@{m} ) * YT@{m}@{n} * PT@{n} + ( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n} + ( 1 - phiiotaWM@{m} ) * iotaWM@{m} ) * YW@{m}@{n} * PW@{n}
            - ( 1 + ( 1 - phiiotaTX@{m} ) * iotaTX@{m} + ( 1 - phiiotaTM@{n} ) * iotaTM@{n} ) * YT@{n}@{m} * PT@{m} - ( 1 + ( 1 - phiiotaWX@{m} ) * iotaWX@{m} + ( 1 - phiiotaWM@{n} ) * iotaWM@{n} ) * YW@{n}@{m} * PW@{m}
		@#endif
	@#endfor
    + YWC@{n} * PWC * ( scriptFI * II * ( scripts - ( 1 - scriptq ) * ( 1 - deltaI ) * scripts_LAG / GII ) + II * scripts * ScriptFRP * JP ) / YWC;
    #GDPplagqlag@{n} =
    PKP@{n}_LAG * IKP@{n}_LAG + PHP@{n}_LAG * IHP@{n}_LAG + PD@{n}_LAG * ID@{n}_LAG + PND@{n}_LAG * IND@{n}_LAG + PKG@{n}_LAG * IKG@{n}_LAG + PHG@{n}_LAG * IHG@{n}_LAG + PCG@{n}_LAG * ICG@{n}_LAG
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG ) * YT0@{n}_LAG * PT@{n}_LAG
            - ( 1 + ( 1 - phiiotaTM@{n} ) * iotaTM@{n}_LAG ) * YT@{n}0_LAG * PT0_LAG
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG + ( 1 - phiiotaTM@{m} ) * iotaTM@{m}_LAG ) * YT@{m}@{n}_LAG * PT@{n}_LAG + ( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n}_LAG + ( 1 - phiiotaWM@{m} ) * iotaWM@{m}_LAG ) * YW@{m}@{n}_LAG * PW@{n}_LAG
            - ( 1 + ( 1 - phiiotaTX@{m} ) * iotaTX@{m}_LAG + ( 1 - phiiotaTM@{n} ) * iotaTM@{n}_LAG ) * YT@{n}@{m}_LAG * PT@{m}_LAG - ( 1 + ( 1 - phiiotaWX@{m} ) * iotaWX@{m}_LAG + ( 1 - phiiotaWM@{n} ) * iotaWM@{n}_LAG ) * YW@{n}@{m}_LAG * PW@{m}_LAG
		@#endif
	@#endfor
    + YWC@{n}_LAG * PWC_LAG * ( scriptFI_LAG * II_LAG * ( scripts_LAG - ( 1 - scriptq ) * ( 1 - deltaI_LAG ) * scripts_LAG2 / GII_LAG ) + II_LAG * scripts_LAG * ScriptFRP_LAG * JP_LAG ) / YWC_LAG;
    #GDPplag@{n} =
    PKP@{n}_LAG * IKP@{n} + PHP@{n}_LAG * IHP@{n} + PD@{n}_LAG * ID@{n} + PND@{n}_LAG * IND@{n} + PKG@{n}_LAG * IKG@{n} + PHG@{n}_LAG * IHG@{n} + PCG@{n}_LAG * ICG@{n}
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} ) * YT0@{n} * PT@{n}_LAG
            - ( 1 + ( 1 - phiiotaTM@{n} ) * iotaTM@{n} ) * YT@{n}0 * PT0_LAG
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} + ( 1 - phiiotaTM@{m} ) * iotaTM@{m} ) * YT@{m}@{n} * PT@{n}_LAG + ( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n} + ( 1 - phiiotaWM@{m} ) * iotaWM@{m} ) * YW@{m}@{n} * PW@{n}_LAG
            - ( 1 + ( 1 - phiiotaTX@{m} ) * iotaTX@{m} + ( 1 - phiiotaTM@{n} ) * iotaTM@{n} ) * YT@{n}@{m} * PT@{m}_LAG - ( 1 + ( 1 - phiiotaWX@{m} ) * iotaWX@{m} + ( 1 - phiiotaWM@{n} ) * iotaWM@{n} ) * YW@{n}@{m} * PW@{m}_LAG
		@#endif
	@#endfor
    + YWC@{n} * PWC_LAG * ( scriptFI * II * ( scripts - ( 1 - scriptq ) * ( 1 - deltaI ) * scripts_LAG / GII ) + II * scripts * ScriptFRP * JP ) / YWC;
    #GDPqlag@{n} =
    PKP@{n} * IKP@{n}_LAG + PHP@{n} * IHP@{n}_LAG + PD@{n} * ID@{n}_LAG + PND@{n} * IND@{n}_LAG + PKG@{n} * IKG@{n}_LAG + PHG@{n} * IHG@{n}_LAG + PCG@{n} * ICG@{n}_LAG
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG ) * YT0@{n}_LAG * PT@{n}
            - ( 1 + ( 1 - phiiotaTM@{n} ) * iotaTM@{n}_LAG ) * YT@{n}0_LAG * PT0
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG + ( 1 - phiiotaTM@{m} ) * iotaTM@{m}_LAG ) * YT@{m}@{n}_LAG * PT@{n} + ( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n}_LAG + ( 1 - phiiotaWM@{m} ) * iotaWM@{m}_LAG ) * YW@{m}@{n}_LAG * PW@{n}
            - ( 1 + ( 1 - phiiotaTX@{m} ) * iotaTX@{m}_LAG + ( 1 - phiiotaTM@{n} ) * iotaTM@{n}_LAG ) * YT@{n}@{m}_LAG * PT@{m} - ( 1 + ( 1 - phiiotaWX@{m} ) * iotaWX@{m}_LAG + ( 1 - phiiotaWM@{n} ) * iotaWM@{n}_LAG ) * YW@{n}@{m}_LAG * PW@{m}
		@#endif
	@#endfor
    + YWC@{n}_LAG * PWC * ( scriptFI_LAG * II_LAG * ( scripts_LAG - ( 1 - scriptq ) * ( 1 - deltaI_LAG ) * scripts_LAG2 / GII_LAG ) + II_LAG * scripts_LAG * ScriptFRP_LAG * JP_LAG ) / YWC_LAG;
    #GDPInflation@{n} = log( ( GDP@{n} / GDPplag@{n} * GDPqlag@{n} / GDPplagqlag@{n} ) ^ ( 1 / 2 ) );
@#endfor

//real World GDP growth rate
#GDPW = 0
    @#for n in 1:SN
        + GDP@{n}
    @#endfor
    ;
#GDPWplagqlag = 0
    @#for n in 1:SN
        + GDPplagqlag@{n}
    @#endfor
    ;
#GDPWplag = 0
    @#for n in 1:SN
        + GDPplag@{n}
    @#endfor
    ;
#GDPWqlag = 0
    @#for n in 1:SN
        + GDPqlag@{n}
    @#endfor
    ;
#GRGDPW = log( ( GDPW / GDPWqlag * GDPWplag / GDPWplagqlag ) ^ ( 1 / 2 ) );

@#for n in 1:SN
//PCE (personal consumption expenditure + government expenditure on education) and deflator
//see BEA 2.4.5 pce include non-residential durable, nondurable, service(education) 
    #PCE@{n} = PHP@{n} * IHP@{n} + PD@{n} * ID@{n} * ( 1 - alpha_resid@{n} ) + PND@{n} * IND@{n};
    #PCEplagqlag@{n} = PHP@{n}_LAG * IHP@{n}_LAG + PD@{n}_LAG * ID@{n}_LAG * ( 1 - alpha_resid@{n} ) + PND@{n}_LAG * IND@{n}_LAG;
    #PCEplag@{n} = PHP@{n}_LAG * IHP@{n} + PD@{n}_LAG * ID@{n} * ( 1 - alpha_resid@{n} ) + PND@{n}_LAG * IND@{n};
    #PCEqlag@{n} = PHP@{n} * IHP@{n}_LAG + PD@{n} * ID@{n}_LAG * ( 1 - alpha_resid@{n} ) + PND@{n} * IND@{n}_LAG;
    #PCEInflation@{n} = log( ( PCE@{n} / PCEplag@{n} * PCEqlag@{n} / PCEplagqlag@{n} ) ^ ( 1 / 2 ) );

//DND (personal consumption expenditure except education) and deflator
//we need this because PCE include all education (private or public)
    #DND@{n} = PD@{n} * ID@{n} * ( 1 - alpha_resid@{n} ) + PND@{n} * IND@{n};
    #DNDplagqlag@{n} = PD@{n}_LAG * ID@{n}_LAG * ( 1 - alpha_resid@{n} ) + PND@{n}_LAG * IND@{n}_LAG;
    #DNDplag@{n} = PD@{n}_LAG * ID@{n} * ( 1 - alpha_resid@{n} ) + PND@{n}_LAG * IND@{n};
    #DNDqlag@{n} = PD@{n} * ID@{n}_LAG * ( 1 - alpha_resid@{n} ) + PND@{n} * IND@{n}_LAG;
    #DNDInflation@{n} = log( ( DND@{n} / DNDplag@{n} * DNDqlag@{n} / DNDplagqlag@{n} ) ^ ( 1 / 2 ) );

//PDI (private domestic investment) and deflator
//see BEA 1.1.5 and 5.3.5
    #PDI@{n} =
    PKP@{n} * IKP@{n} + PD@{n} * ID@{n} * alpha_resid@{n}
    + YWC@{n} * PWC * ( scriptFI * II * ( scripts - ( 1 - scriptq ) * ( 1 - deltaI ) * scripts_LAG / GII ) + II * scripts * ScriptFRP * JP ) / YWC;
    #PDIplagqlag@{n} =
    PKP@{n}_LAG * IKP@{n}_LAG + PD@{n}_LAG * ID@{n}_LAG * alpha_resid@{n}
    + YWC@{n}_LAG * PWC_LAG * ( scriptFI_LAG * II_LAG * ( scripts_LAG - ( 1 - scriptq ) * ( 1 - deltaI_LAG ) * scripts_LAG2 / GII_LAG ) + II_LAG * scripts_LAG * ScriptFRP_LAG * JP_LAG ) / YWC_LAG;
    #PDIplag@{n} =
    PKP@{n}_LAG * IKP@{n} + PD@{n}_LAG * ID@{n} * alpha_resid@{n}
    + YWC@{n} * PWC_LAG * ( scriptFI * II * ( scripts - ( 1 - scriptq ) * ( 1 - deltaI ) * scripts_LAG / GII ) + II * scripts * ScriptFRP * JP ) / YWC;
    #PDIqlag@{n} =
    PKP@{n} * IKP@{n}_LAG + PD@{n} * ID@{n}_LAG * alpha_resid@{n}
    + YWC@{n}_LAG * PWC * ( scriptFI_LAG * II_LAG * ( scripts_LAG - ( 1 - scriptq ) * ( 1 - deltaI_LAG ) * scripts_LAG2 / GII_LAG ) + II_LAG * scripts_LAG * ScriptFRP_LAG * JP_LAG ) / YWC_LAG;
    #PDIInflation@{n} = log( ( PDI@{n} / PDIplag@{n} * PDIqlag@{n} / PDIplagqlag@{n} ) ^ ( 1 / 2 ) );

//GCE (government consumption expenditures) and deflator
//see BEA 3.9.5
    #GCE@{n} = PCG@{n} * ICG@{n};
    #GCEplagqlag@{n} = PCG@{n}_LAG * ICG@{n}_LAG;
    #GCEplag@{n} = PCG@{n}_LAG * ICG@{n};
    #GCEqlag@{n} = PCG@{n} * ICG@{n}_LAG;
    #GCEInflation@{n} = log( ( GCE@{n} / GCEplag@{n} * GCEqlag@{n} / GCEplagqlag@{n} ) ^ ( 1 / 2 ) );

//GGI (government gross investment) and deflator
//see BEA 3.9.5
    #GGI@{n} = PKG@{n} * IKG@{n} + PHG@{n} * IHG@{n};
    #GGIplagqlag@{n} = PKG@{n}_LAG * IKG@{n}_LAG + PHG@{n}_LAG * IHG@{n}_LAG;
    #GGIplag@{n} = PKG@{n}_LAG * IKG@{n} + PHG@{n}_LAG * IHG@{n};
    #GGIqlag@{n} = PKG@{n} * IKG@{n}_LAG + PHG@{n} * IHG@{n}_LAG;
    #GGIInflation@{n} = log( ( GGI@{n} / GGIplag@{n} * GGIqlag@{n} / GGIplagqlag@{n} ) ^ ( 1 / 2 ) );

//GDI (gross domestic investment) and deflator
//our data is GROSS investment but PRIVATE consumption (JST data, following SNA)
    #GDI@{n} = GGI@{n} + PDI@{n};
    #GDIplagqlag@{n} = GGIplagqlag@{n} + PDIplagqlag@{n};
    #GDIplag@{n} = GGIplag@{n} + PDIplag@{n};
    #GDIqlag@{n} = GGIqlag@{n} + PDIqlag@{n};
    #GDIInflation@{n} = log( ( GDI@{n} / GDIplag@{n} * GDIqlag@{n} / GDIplagqlag@{n} ) ^ ( 1 / 2 ) );

//GERD (Gross domestic expenditure on R&D, or R&D intensity)
	#GERD@{n} = ( PHG@{n} * IHG@{n} + YWC@{n} * PWC * ( scriptFI * II * ( scripts - ( 1 - scriptq ) * ( 1 - deltaI ) * scripts_LAG / GII ) + II * scripts * ScriptFRP * JP ) / YWC ) / GDP@{n};

//Export and deflator
    #Export@{n} = ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} ) * YT0@{n} * PT@{n}
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} + ( 1 - phiiotaTM@{m} ) * iotaTM@{m} ) * YT@{m}@{n} * PT@{n} + ( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n} + ( 1 - phiiotaWM@{m} ) * iotaWM@{m} ) * YW@{m}@{n} * PW@{n}
		@#endif
	@#endfor
    ;
    #Exportplagqlag@{n} = ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG ) * YT0@{n}_LAG * PT@{n}_LAG
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG + ( 1 - phiiotaTM@{m} ) * iotaTM@{m}_LAG ) * YT@{m}@{n}_LAG * PT@{n}_LAG + ( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n}_LAG + ( 1 - phiiotaWM@{m} ) * iotaWM@{m}_LAG ) * YW@{m}@{n}_LAG * PW@{n}_LAG
		@#endif
	@#endfor
    ;
    #Exportplag@{n} = ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} ) * YT0@{n} * PT@{n}_LAG
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n} + ( 1 - phiiotaTM@{m} ) * iotaTM@{m} ) * YT@{m}@{n} * PT@{n}_LAG + ( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n} + ( 1 - phiiotaWM@{m} ) * iotaWM@{m} ) * YW@{m}@{n} * PW@{n}_LAG
		@#endif
	@#endfor
    ;
    #Exportqlag@{n} = ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG ) * YT0@{n}_LAG * PT@{n}
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
			+ ( 1 + ( 1 - phiiotaTX@{n} ) * iotaTX@{n}_LAG + ( 1 - phiiotaTM@{m} ) * iotaTM@{m}_LAG ) * YT@{m}@{n}_LAG * PT@{n} + ( 1 + ( 1 - phiiotaWX@{n} ) * iotaWX@{n}_LAG + ( 1 - phiiotaWM@{m} ) * iotaWM@{m}_LAG ) * YW@{m}@{n}_LAG * PW@{n}
		@#endif
	@#endfor
    ;
    #ExportInflation@{n} = log( ( Export@{n} / Exportplag@{n} * Exportqlag@{n} / Exportplagqlag@{n} ) ^ ( 1 / 2 ) );

//Import and deflator
    #Import@{n} = ( 1 + ( 1 - phiiotaTM@{n} ) * iotaTM@{n} ) * YT@{n}0 * PT0
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
            + ( 1 + ( 1 - phiiotaTX@{m} ) * iotaTX@{m} + ( 1 - phiiotaTM@{n} ) * iotaTM@{n} ) * YT@{n}@{m} * PT@{m} + ( 1 + ( 1 - phiiotaWX@{m} ) * iotaWX@{m} + ( 1 - phiiotaWM@{n} ) * iotaWM@{n} ) * YW@{n}@{m} * PW@{m}
		@#endif
	@#endfor
    ;
    #Importplagqlag@{n} = ( 1 + ( 1 - phiiotaTM@{n} ) * iotaTM@{n}_LAG ) * YT@{n}0_LAG * PT0_LAG
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
            + ( 1 + ( 1 - phiiotaTX@{m} ) * iotaTX@{m}_LAG + ( 1 - phiiotaTM@{n} ) * iotaTM@{n}_LAG ) * YT@{n}@{m}_LAG * PT@{m}_LAG + ( 1 + ( 1 - phiiotaWX@{m} ) * iotaWX@{m}_LAG + ( 1 - phiiotaWM@{n} ) * iotaWM@{n}_LAG ) * YW@{n}@{m}_LAG * PW@{m}_LAG
		@#endif
	@#endfor
    ;
    #Importplag@{n} = ( 1 + ( 1 - phiiotaTM@{n} ) * iotaTM@{n} ) * YT@{n}0 * PT0_LAG
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
            + ( 1 + ( 1 - phiiotaTX@{m} ) * iotaTX@{m} + ( 1 - phiiotaTM@{n} ) * iotaTM@{n} ) * YT@{n}@{m} * PT@{m}_LAG + ( 1 + ( 1 - phiiotaWX@{m} ) * iotaWX@{m} + ( 1 - phiiotaWM@{n} ) * iotaWM@{n} ) * YW@{n}@{m} * PW@{m}_LAG
		@#endif
	@#endfor
    ;
    #Importqlag@{n} = ( 1 + ( 1 - phiiotaTM@{n} ) * iotaTM@{n}_LAG ) * YT@{n}0_LAG * PT0
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
            + ( 1 + ( 1 - phiiotaTX@{m} ) * iotaTX@{m}_LAG + ( 1 - phiiotaTM@{n} ) * iotaTM@{n}_LAG ) * YT@{n}@{m}_LAG * PT@{m} + ( 1 + ( 1 - phiiotaWX@{m} ) * iotaWX@{m}_LAG + ( 1 - phiiotaWM@{n} ) * iotaWM@{n}_LAG ) * YW@{n}@{m}_LAG * PW@{m}
		@#endif
	@#endfor
    ;
    #ImportInflation@{n} = log( ( Import@{n} / Importplag@{n} * Importqlag@{n} / Importplagqlag@{n} ) ^ ( 1 / 2 ) );

//cfc of durable goods stock
    @#for m in Members
        Dtilde@{n}@{m} = ( 1 - deltaD@{n} ) * Dtilde@{n}@{m}_LAG + ID@{n}@{m} * exp( - thetaGD@{n} / 2 * ( log( GD@{n}@{m} / GD@{n}@{m}_LAG ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m} / DP@{n}@{m}_LAG ) ) ^ 2 );
        deltaDtildeAUXD@{n}@{m} = ID@{n}@{m} * exp( - thetaGD@{n} / 2 * ( log( GD@{n}@{m} / GD@{n}@{m}_LAG ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m} / DP@{n}@{m}_LAG ) ) ^ 2 ) + ( 1 - deltaD_ ) * deltaDtildeAUXD@{n}@{m}_LAG;
        deltaDtildeAUXN@{n}@{m} = ID@{n}@{m} * exp( - thetaGD@{n} / 2 * ( log( GD@{n}@{m} / GD@{n}@{m}_LAG ) ) ^ 2 - thetaPD@{n} / 2 * ( log( D@{n}@{m} / DP@{n}@{m}_LAG ) ) ^ 2 ) * deltaD@{n} + ( 1 - deltaD_ ) * deltaDtildeAUXN@{n}@{m}_LAG;
        #deltaDtilde@{n}@{m} = deltaDtildeAUXN@{n}@{m}_LAG / deltaDtildeAUXD@{n}@{m}_LAG;
        #Dcfc@{n}@{m} = deltaDtilde@{n}@{m} * Dtilde@{n}@{m}_LAG * PD@{n};
	@#endfor
//cfc of private physical capital stock
    @#for S in Sectors0
        KPtilde@{S}@{n} = ( 1 - deltaKP@{S}@{n} ) * KPtilde@{S}@{n}_LAG + IKP@{S}@{n} * exp( - thetaGKP@{n} / 2 * ( log( GKP@{S}@{n} / GKP@{S}@{n}_LAG ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n} / KPP@{S}@{n}_LAG) ) ^ 2 );
        deltaKPtildeAUXD@{S}@{n} = IKP@{S}@{n} * exp( - thetaGKP@{n} / 2 * ( log( GKP@{S}@{n} / GKP@{S}@{n}_LAG ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n} / KPP@{S}@{n}_LAG) ) ^ 2 ) + ( 1 - deltaK_ ) * deltaKPtildeAUXD@{S}@{n}_LAG;
        deltaKPtildeAUXN@{S}@{n} = IKP@{S}@{n} * exp( - thetaGKP@{n} / 2 * ( log( GKP@{S}@{n} / GKP@{S}@{n}_LAG ) ) ^ 2 - thetaPKP@{n} / 2 * ( log( KP@{S}@{n} / KPP@{S}@{n}_LAG) ) ^ 2 ) * deltaKP@{S}@{n} + ( 1 - deltaK_ ) * deltaKPtildeAUXN@{S}@{n}_LAG;
        #deltaKPtilde@{S}@{n} = deltaKPtildeAUXN@{S}@{n}_LAG / deltaKPtildeAUXD@{S}@{n}_LAG;
        #KPcfc@{S}@{n} = deltaKPtilde@{S}@{n} * KPtilde@{S}@{n}_LAG * PKP@{n};
	@#endfor
//cfc of public physical capital stock
    deltaKGtildeAUXD@{n} = IKG@{n} * exp( - thetaGKG@{n} / 2 * ( log( GKG@{n} / GKG@{n}_LAG ) ) ^ 2 ) + ( 1 - deltaK_ ) * deltaKGtildeAUXD@{n}_LAG;
    deltaKGtildeAUXN@{n} = IKG@{n} * exp( - thetaGKG@{n} / 2 * ( log( GKG@{n} / GKG@{n}_LAG ) ) ^ 2 ) * deltaKG@{n} + ( 1 - deltaK_ ) * deltaKGtildeAUXN@{n}_LAG;
    #deltaKGtilde@{n} = deltaKGtildeAUXN@{n}_LAG / deltaKGtildeAUXD@{n}_LAG;
    #KGcfc@{n} = deltaKGtilde@{n} * KG@{n}_LAG * PKG@{n};
//cfc of public R&D capital stock
    deltaHGtildeAUXD@{n} = IHG@{n} * exp( - thetaGHG@{n} / 2 * ( log( GHG@{n} / GHG@{n}_LAG ) ) ^ 2 ) + ( 1 - deltaH_ ) * deltaHGtildeAUXD@{n}_LAG;
    deltaHGtildeAUXN@{n} = IHG@{n} * exp( - thetaGHG@{n} / 2 * ( log( GHG@{n} / GHG@{n}_LAG ) ) ^ 2 ) * deltaHG@{n} + ( 1 - deltaH_ ) * deltaHGtildeAUXN@{n}_LAG;
    #deltaHGtilde@{n} = deltaHGtildeAUXN@{n}_LAG / deltaHGtildeAUXD@{n}_LAG;
    #HGcfc@{n} = deltaHGtilde@{n} * HG@{n}_LAG * PHG@{n};
//cfc
    #CFC@{n} = Dcfc@{n}l * alpha_resid@{n} + Dcfc@{n}b * alpha_resid@{n} + KPcfcT@{n} + KPcfcNT@{n} + KPcfcW@{n} + KGcfc@{n} + HGcfc@{n};
    #deltaALL@{n} = CFC@{n} / ( Dtilde@{n}l_LAG * PD@{n} * alpha_resid@{n} + Dtilde@{n}b_LAG * PD@{n} * alpha_resid@{n}
                              + KPtildeT@{n}_LAG * PKP@{n} + KPtildeNT@{n}_LAG * PKP@{n} + KPtildeW@{n}_LAG * PKP@{n}
                              + KG@{n}_LAG * PKG@{n} + HG@{n}_LAG * PHG@{n} );

//Labour+human capital income
    #LabourIncome@{n} = 0
	@#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
	  + W@{S}@{n} * L@{S}@{n}b
	@#endfor
	@#for S in [ "W", "T", "NT" ]
	  + W@{S}@{n} * LS@{S}@{n}b
	@#endfor
	@#for S in Sectors2
	  + W@{S}@{n} * L@{S}@{n}l
	@#endfor
    @#for S in Sectors0
      + RHP@{S}@{n} * HP@{S}@{n}
	@#endfor
    ;

//HoursWorkedPerCapita
    #Log_HoursWorkedPerCapita@{n} = log( (
	@#for S in Sectors2
	  + L@{S}@{n}l + L@{S}@{n}b
	@#endfor
    ) / N@{n} );

//ex post real exchange rate (t-1 to t)
    #ExPostR@{n} = log( 1 / Q_LAG ) - GDPInflation@{n};

//Spread
    #Spread@{n} = ( log( 1 / QB@{n} ) - log( 1 / Q ) );
	
//government revenue
	#GovRev@{n} = 
    (
	@#for m in 0:SN
		@#if n == m
			+ 0
		@#else
            + YT@{m}@{n} * PT@{n}
		@#endif
	@#endfor
    ) * iotaTX@{n} * phiiotaTX@{n}
    + (
	@#for m in 0:SN
		@#if n == m
			+ 0
		@#else
            + YT@{n}@{m} * PT@{m}
		@#endif
	@#endfor
    ) * iotaTM@{n} * phiiotaTM@{n}
    + (
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
            + YW@{m}@{n} * PW@{n}
		@#endif
	@#endfor
    ) * iotaWX@{n} * phiiotaWX@{n}
    + (
	@#for m in 1:SN
		@#if n == m
			+ 0
		@#else
            + YW@{n}@{m} * PW@{m}
		@#endif
	@#endfor
    ) * iotaWM@{n} * phiiotaWM@{n}
	+ YNT@{n} * PNT@{n} * tauNT@{n} * phitauNT@{n} + YTC@{n} * PTC@{n} * tauTC@{n} * phitauTC@{n}
	+ ID@{n}b * PD@{n} * tauD@{n} * phitauD@{n} + IND@{n}b * PND@{n} * tauND@{n} * phitauND@{n} + ID@{n}l * PD@{n} * tauD@{n} * phitauD@{n} + IND@{n}l * PND@{n} * tauND@{n} * phitauND@{n}
	@#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
	  + W@{S}@{n} * tauL@{S}@{n} * L@{S}@{n}b * phitauL@{n}
	@#endfor
	@#for S in [ "W", "T", "NT" ]
	  + W@{S}@{n} * tauL@{S}@{n} * LS@{S}@{n}b * phitauL@{n}
	@#endfor
	@#for S in Sectors2
	  + W@{S}@{n} * tauL@{S}@{n} * L@{S}@{n}l * phitauL@{n}
	@#endfor
	@#for S in Sectors0
      + RHP@{S}@{n} * HP@{S}@{n} * tauH@{S}@{n} * phitauH@{S}@{n}
      + KU@{S}@{n} * RKP@{S}@{n} * KP@{S}@{n} * tauK@{S}@{n} * phitauK@{S}@{n}
      + PscriptX@{n} * scriptX@{S}@{n} * tauscriptX@{S}@{n} * phitauscriptX@{S}@{n}
	@#endfor
	+ ( tau@{n}b + tau@{n}l ) * Y@{n} * P@{n};
@#endfor

%World
gryW    = GRGDPW  + epsilon_gryW  * sigma_gryW;
gpopW   = log(GN) + epsilon_gpopW * sigma_gpopW;
@#for n in 1:SN-1
	yshare@{n} = GDP@{n} / GDPW + epsilon_yshare@{n} * sigma_yshare;
@#endfor
@#for n in 1:SN
	popshare@{n} = N@{n} / N / 100  + epsilon_popshare@{n} * sigma_popshare;
@#endfor

@#if SN > 0
%US
ESrdy1 - epsilon_ESrdy1 * sigma_rdy = exp(rdy_) * GERD1;
(BEAcy1 - epsilon_BEAcy1 * sigma_cy) + (BEAgiy1 - epsilon_BEAgiy1 * sigma_giy + BEAgcy1 - epsilon_BEAgcy1 * sigma_gcy) * alpha_pubedu1 = PCE1 / GDP1;
OECDihy1 = PHP1 * IHP1 / GDP1 + epsilon_OECDihy1 * sigma_ihy;
JSTiy1 = GDI1 / GDP1 + epsilon_JSTiy1 * sigma_iy;
(BEAgiy1 - epsilon_BEAgiy1 * sigma_giy + BEAgcy1 - epsilon_BEAgcy1 * sigma_gcy) * ( 1 - alpha_pubedu1 ) = ( GCE1 + GGI1 ) / GDP1;
BEAgiy1 = GGI1                 / GDP1          + epsilon_BEAgiy1 * sigma_giy;
JSTxy1  = Export1              / GDP1          + epsilon_JSTxy1  * sigma_xy;
BEAgpcgpy1  = DNDInflation1    - GDPInflation1 + epsilon_BEAgpcgpy1 * sigma_gpcgpy;
BEAgpigpy1  = PDIInflation1    - GDPInflation1 + epsilon_BEAgpigpy1 * sigma_gpigpy;
BEAgpgcgpy1 = GCEInflation1    - GDPInflation1 + epsilon_BEAgpgcgpy1 * sigma_gpgcgpy;
BEAgpgigpy1 = GGIInflation1    - GDPInflation1 + epsilon_BEAgpgigpy1 * sigma_gpgigpy;
BEAgpxgpy1  = ExportInflation1 - GDPInflation1 + epsilon_BEAgpxgpy1 * sigma_gpxgpy;
BEAgpmgpy1  = ImportInflation1 - GDPInflation1 + epsilon_BEAgpmgpy1 * sigma_gpmgpy;
#Log_HoursWorkedPerCapita1_ss = steady_state(log( (
@#for S in Sectors2
  + L@{S}1l + L@{S}1b
@#endfor
) / N1 ));
BEAhpop1 = Log_HoursWorkedPerCapita1 - Log_HoursWorkedPerCapita1_ss + hpop_ + epsilon_BEAhpop1 * sigma_hpop;
BEAwhy1     = LabourIncome1 / GDP1 + epsilon_BEAwhy1     * sigma_why;
BEAcfcy1    = CFC1          / GDP1 + epsilon_BEAcfcy1    * sigma_cfcy;
JSTexpostr1 = ExPostR1             + epsilon_JSTexpostr1 * sigma_expostr;
FREDlrni1   = Spread1              + epsilon_FREDlrni1   * sigma_lrni;
JSTtauy1    = GovRev1       / GDP1 + epsilon_JSTtauy1    * sigma_tauy;
@#endif

@#if SN > 1
%Germany
ESrdy2 - epsilon_ESrdy2 * sigma_rdy = exp(rdy_) * GERD2;
( PWTcy2 - epsilon_PWTcy2 * sigma_cy ) + ( JSTgy2 - epsilon_JSTgy2 * sigma_gcy ) * alpha_pubedu2 = PCE2 / GDP2;
OECDihy2 = PHP2 * IHP2 / GDP2 + epsilon_OECDihy2 * sigma_ihy;
JSTiy2 = GDI2 / GDP2 + epsilon_JSTiy2 * sigma_iy;
( JSTgy2 - epsilon_JSTgy2 * sigma_gcy ) * ( 1 - alpha_pubedu2 ) = ( GCE2 + GGI2 ) / GDP2;
JSTxy2      = Export2          / GDP2          + epsilon_JSTxy2     * sigma_xy;
PWTgpcgpy2  = DNDInflation2    - GDPInflation2 + epsilon_PWTgpcgpy2 * sigma_gpcgpy;
PWTgpigpy2  = GDIInflation2    - GDPInflation2 + epsilon_PWTgpigpy2 * sigma_gpigpy;
PWTgpgcgpy2 = GCEInflation2    - GDPInflation2 + epsilon_PWTgpgcgpy2 * sigma_gpgcgpy;
PWTgpxgpy2  = ExportInflation2 - GDPInflation2 + epsilon_PWTgpxgpy2 * sigma_gpxgpy;
PWTgpmgpy2  = ImportInflation2 - GDPInflation2 + epsilon_PWTgpmgpy2 * sigma_gpmgpy;
#Log_HoursWorkedPerCapita2_ss = steady_state(log( (
@#for S in Sectors2
  + L@{S}2l + L@{S}2b
@#endfor
) / N2 ));
PWThpop2 = Log_HoursWorkedPerCapita2 - Log_HoursWorkedPerCapita2_ss + hpop_ + epsilon_PWThpop2 * sigma_hpop;
PWTwhy2     = LabourIncome2 / GDP2  + epsilon_PWTwhy2     * sigma_why;
PWTdelta2   = deltaALL2             + epsilon_PWTdelta2   * sigma_cfcy;
JSTexpostr2 = ExPostR2              + epsilon_JSTexpostr2 * sigma_expostr;
DBlrni2     = Spread2               + epsilon_DBlrni2     * sigma_lrni;
JSTtauy2    = GovRev2       / GDP2  + epsilon_JSTtauy2    * sigma_tauy;
@#endif

@#if SN > 2
%UK
ESrdy3 - epsilon_ESrdy3 * sigma_rdy = exp(rdy_) * GERD3;
( MILLcy3 - epsilon_MILLcy3 * sigma_cy ) + ( MILLgcy3 - epsilon_MILLgcy3 * sigma_gcy + MILLgiy3 - epsilon_MILLgiy3 * sigma_giy ) * alpha_pubedu3 = PCE3 / GDP3;
OECDihy3 = PHP3 * IHP3 / GDP3 + epsilon_OECDihy3 * sigma_ihy;
MILLiy3 = GDI3 / GDP3 + epsilon_MILLiy3 * sigma_iy;
( MILLgcy3 - epsilon_MILLgcy3 * sigma_gcy + MILLgiy3 - epsilon_MILLgiy3 * sigma_giy ) * ( 1 - alpha_pubedu3 ) = ( GCE3 + GGI3 ) / GDP3;
MILLgiy3     = GGI3             / GDP3          + epsilon_MILLgiy3 * sigma_giy;
MILLxy3      = Export3          / GDP3          + epsilon_MILLxy3  * sigma_xy;
MILLgpcgpy3  = DNDInflation3    - GDPInflation3 + epsilon_MILLgpcgpy3 * sigma_gpcgpy;
MILLgpigpy3  = GDIInflation3    - GDPInflation3 + epsilon_MILLgpigpy3 * sigma_gpigpy;
MILLgpgcgpy3 = GCEInflation3    - GDPInflation3 + epsilon_MILLgpgcgpy3 * sigma_gpgcgpy;
MILLgpxgpy3  = ExportInflation3 - GDPInflation3 + epsilon_MILLgpxgpy3 * sigma_gpxgpy;
MILLgpmgpy3  = ImportInflation3 - GDPInflation3 + epsilon_MILLgpmgpy3 * sigma_gpmgpy;
#Log_HoursWorkedPerCapita3_ss = steady_state(log( (
@#for S in Sectors2
  + L@{S}3l + L@{S}3b
@#endfor
) / N3 ));
MILLhpop3 = Log_HoursWorkedPerCapita3 - Log_HoursWorkedPerCapita3_ss + hpop_ + epsilon_MILLhpop3 * sigma_hpop;
MILLwhy3     = LabourIncome3 / GDP3 + epsilon_MILLwhy3     * sigma_why;
MILLcfcy3    = CFC3          / GDP3 + epsilon_MILLcfcy3    * sigma_cfcy;
MILLexpostr3 = ExPostR3             + epsilon_MILLexpostr3 * sigma_expostr;
MILLlrni3    = Spread3              + epsilon_MILLlrni3    * sigma_lrni;
MILLtauy3    = GovRev3       / GDP3 + epsilon_MILLtauy3    * sigma_tauy;
@#endif

@#if SN > 3
%France
ESrdy4 - epsilon_ESrdy4 * sigma_rdy = exp(rdy_) * GERD4;
( PWTcy4 - epsilon_PWTcy4 * sigma_cy ) + ( JSTgy4 - epsilon_JSTgy4 * sigma_gcy ) * alpha_pubedu4 = PCE4 / GDP4;
OECDihy4 = PHP4 * IHP4 / GDP4 + epsilon_OECDihy4 * sigma_ihy;
JSTiy4 = GDI4 / GDP4 + epsilon_JSTiy4 * sigma_iy;
( JSTgy4 - epsilon_JSTgy4 * sigma_gcy ) * ( 1 - alpha_pubedu4 ) = ( GCE4 + GGI4 ) / GDP4;
JSTxy4      = Export4          / GDP4          + epsilon_JSTxy4     * sigma_xy;
PWTgpcgpy4  = DNDInflation4    - GDPInflation4 + epsilon_PWTgpcgpy4 * sigma_gpcgpy;
PWTgpigpy4  = GDIInflation4    - GDPInflation4 + epsilon_PWTgpigpy4 * sigma_gpigpy;
PWTgpgcgpy4 = GCEInflation4    - GDPInflation4 + epsilon_PWTgpgcgpy4 * sigma_gpgcgpy;
PWTgpxgpy4  = ExportInflation4 - GDPInflation4 + epsilon_PWTgpxgpy4 * sigma_gpxgpy;
PWTgpmgpy4  = ImportInflation4 - GDPInflation4 + epsilon_PWTgpmgpy4 * sigma_gpmgpy;
#Log_HoursWorkedPerCapita4_ss = steady_state(log( (
@#for S in Sectors2
  + L@{S}4l + L@{S}4b
@#endfor
) / N4 ));
PWThpop4 = Log_HoursWorkedPerCapita4 - Log_HoursWorkedPerCapita4_ss + hpop_ + epsilon_PWThpop4 * sigma_hpop;
PWTwhy4     = LabourIncome4 / GDP4 + epsilon_PWTwhy4     * sigma_why;
PWTdelta4   = deltaALL4            + epsilon_PWTdelta4   * sigma_cfcy;
JSTexpostr4 = ExPostR4             + epsilon_JSTexpostr4 * sigma_expostr;
BDFlrni4    = Spread4              + epsilon_BDFlrni4    * sigma_lrni;
JSTtauy4    = GovRev4       / GDP4 + epsilon_JSTtauy4    * sigma_tauy;
@#endif

@#if SN > 4
%REU
ESrdy5 - epsilon_ESrdy5 * sigma_rdy = exp(rdy_) * GERD5;
( PWTcy5 - epsilon_PWTcy5 * sigma_cy ) + ( JSTgy5 - epsilon_JSTgy5 * sigma_gcy ) * alpha_pubedu5 = PCE5 / GDP5;
OECDihy5 = PHP5 * IHP5 / GDP5 + epsilon_OECDihy5 * sigma_ihy;
JSTiy5 = GDI5 / GDP5 + epsilon_JSTiy5 * sigma_iy;
( JSTgy5 - epsilon_JSTgy5 * sigma_gcy ) * ( 1 - alpha_pubedu5 ) = ( GCE5 + GGI5 ) / GDP5;
JSTxy5      = Export5          / GDP5          + epsilon_JSTxy5     * sigma_xy;
PWTgpcgpy5  = DNDInflation5    - GDPInflation5 + epsilon_PWTgpcgpy5 * sigma_gpcgpy;
PWTgpigpy5  = GDIInflation5    - GDPInflation5 + epsilon_PWTgpigpy5 * sigma_gpigpy;
PWTgpgcgpy5 = GCEInflation5    - GDPInflation5 + epsilon_PWTgpgcgpy5 * sigma_gpgcgpy;
PWTgpxgpy5  = ExportInflation5 - GDPInflation5 + epsilon_PWTgpxgpy5 * sigma_gpxgpy;
PWTgpmgpy5  = ImportInflation5 - GDPInflation5 + epsilon_PWTgpmgpy5 * sigma_gpmgpy;
#Log_HoursWorkedPerCapita5_ss = steady_state(log( (
@#for S in Sectors2
  + L@{S}5l + L@{S}5b
@#endfor
) / N5 ));
PWThpop5 = Log_HoursWorkedPerCapita5 - Log_HoursWorkedPerCapita5_ss + hpop_ + epsilon_PWThpop5 * sigma_hpop;
PWTwhy5     = LabourIncome5 / GDP5 + epsilon_PWTwhy5     * sigma_why;
PWTcfcy5    = CFC5          / GDP5 + epsilon_PWTcfcy5    * sigma_cfcy;
JSTexpostr5 = ExPostR5             + epsilon_JSTexpostr5 * sigma_expostr;
JSTtauy5    = GovRev5       / GDP5 + epsilon_JSTtauy5    * sigma_tauy;
@#endif

@#if SN > 5
%RMA
ESrdy6 - epsilon_ESrdy6 * sigma_rdy = exp(rdy_) * GERD6;
( PWTcy6 - epsilon_PWTcy6 * sigma_cy ) + ( JSTgy6 - epsilon_JSTgy6 * sigma_gcy ) * alpha_pubedu6 = PCE6 / GDP6;
OECDihy6 = PHP6 * IHP6 / GDP6 + epsilon_OECDihy6 * sigma_ihy;
JSTiy6 = GDI6 / GDP6 + epsilon_JSTiy6 * sigma_iy;
( JSTgy6 - epsilon_JSTgy6 * sigma_gcy ) * ( 1 - alpha_pubedu6 ) = ( GCE6 + GGI6 ) / GDP6;
JSTxy6      = Export6          / GDP6          + epsilon_JSTxy6     * sigma_xy;
PWTgpcgpy6  = DNDInflation6    - GDPInflation6 + epsilon_PWTgpcgpy6 * sigma_gpcgpy;
PWTgpigpy6  = GDIInflation6    - GDPInflation6 + epsilon_PWTgpigpy6 * sigma_gpigpy;
PWTgpgcgpy6 = GCEInflation6    - GDPInflation6 + epsilon_PWTgpgcgpy6 * sigma_gpgcgpy;
PWTgpxgpy6  = ExportInflation6 - GDPInflation6 + epsilon_PWTgpxgpy6 * sigma_gpxgpy;
PWTgpmgpy6  = ImportInflation6 - GDPInflation6 + epsilon_PWTgpmgpy6 * sigma_gpmgpy;
#Log_HoursWorkedPerCapita6_ss = steady_state(log( (
@#for S in Sectors2
  + L@{S}6l + L@{S}6b
@#endfor
) / N6 ));
PWThpop6 = Log_HoursWorkedPerCapita6 - Log_HoursWorkedPerCapita6_ss + hpop_ + epsilon_PWThpop6 * sigma_hpop;
PWTwhy6     = LabourIncome6 / GDP6 + epsilon_PWTwhy6     * sigma_why;
PWTcfcy6    = CFC6          / GDP6 + epsilon_PWTcfcy6    * sigma_cfcy;
JSTexpostr6 = ExPostR6             + epsilon_JSTexpostr6 * sigma_expostr;
JSTtauy6    = GovRev6       / GDP6 + epsilon_JSTtauy6    * sigma_tauy;
@#endif

@#if ExtraVariable == 1
    @#include "ExtraVariable_part2.mod"
@#endif

end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                       //
//                                                    steady state                                                       //
//                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

steady_state_model;
	@#include "step4steady_state_model.mod"
end;

shocks;
	@#include "InsertNewShockBlockLines.mod"
    
	@#for n in 1:SN
    	var epsilon_beta@{n}     = 1;
		var epsilon_popshare@{n} = 1;
	@#endfor
	@#for n in 1:SN-1
		var epsilon_yshare@{n}   = 1;
	@#endfor
	
	var epsilon_P0 = 1;
    var epsilon_Y0 = 1;
	var epsilon_gryW          = 1;
	var epsilon_gpopW         = 1;
	
    @#if SN > 0
	var epsilon_OECDihy1        = 1;
	var epsilon_ESrdy1        = 1;
	var epsilon_BEAcy1        = 1;
	var epsilon_JSTiy1        = 1;
	var epsilon_BEAgcy1       = 1;
	var epsilon_BEAgiy1       = 1;
	var epsilon_JSTxy1        = 1;
	var epsilon_BEAgpcgpy1    = 1;
	var epsilon_BEAgpigpy1    = 1;
	var epsilon_BEAgpgcgpy1   = 1;
	var epsilon_BEAgpgigpy1   = 1;
	var epsilon_BEAgpxgpy1    = 1;
	var epsilon_BEAgpmgpy1    = 1;
	var epsilon_BEAhpop1      = 1;
	var epsilon_BEAwhy1       = 1;
	var epsilon_BEAcfcy1      = 1;
	var epsilon_JSTexpostr1   = 1;
	var epsilon_FREDlrni1     = 1;
	var epsilon_JSTtauy1      = 1;
	@#endif
	
	@#if SN > 1
	var epsilon_OECDihy2        = 1;
	var epsilon_ESrdy2        = 1;
	var epsilon_PWTcy2        = 1;
	var epsilon_JSTiy2        = 1;
	var epsilon_JSTgy2        = 1;
	var epsilon_JSTxy2        = 1;
	var epsilon_PWTgpcgpy2    = 1;
	var epsilon_PWTgpigpy2    = 1;
	var epsilon_PWTgpgcgpy2   = 1;
	var epsilon_PWTgpxgpy2    = 1;
	var epsilon_PWTgpmgpy2    = 1;
	var epsilon_PWThpop2      = 1;
	var epsilon_PWTwhy2       = 1;
	var epsilon_PWTdelta2     = 1;
	var epsilon_JSTexpostr2   = 1;
	var epsilon_DBlrni2       = 1;
	var epsilon_JSTtauy2      = 1;
	@#endif
	
	@#if SN > 2
	var epsilon_OECDihy3        = 1;
	var epsilon_ESrdy3        = 1;
    var epsilon_MILLcy3       = 1;
    var epsilon_MILLiy3       = 1;
    var epsilon_MILLgcy3      = 1;
    var epsilon_MILLgiy3      = 1;
    var epsilon_MILLxy3       = 1;
    var epsilon_MILLgpcgpy3   = 1;
    var epsilon_MILLgpigpy3   = 1;
    var epsilon_MILLgpgcgpy3  = 1;
    var epsilon_MILLgpxgpy3   = 1;
    var epsilon_MILLgpmgpy3   = 1;
    var epsilon_MILLhpop3     = 1;
    var epsilon_MILLwhy3      = 1;
    var epsilon_MILLcfcy3     = 1;
    var epsilon_MILLexpostr3  = 1;
    var epsilon_MILLlrni3     = 1;
    var epsilon_MILLtauy3     = 1;
    @#endif
	
	@#if SN > 3
	var epsilon_OECDihy4        = 1;
	var epsilon_ESrdy4        = 1;
    var epsilon_PWTcy4        = 1;
    var epsilon_JSTiy4        = 1;
    var epsilon_JSTgy4        = 1;
    var epsilon_JSTxy4        = 1;
    var epsilon_PWTgpcgpy4    = 1;
    var epsilon_PWTgpigpy4    = 1;
    var epsilon_PWTgpgcgpy4   = 1;
    var epsilon_PWTgpxgpy4    = 1;
    var epsilon_PWTgpmgpy4    = 1;
    var epsilon_PWThpop4      = 1;
    var epsilon_PWTwhy4       = 1;
    var epsilon_PWTdelta4     = 1;
    var epsilon_JSTexpostr4   = 1;
    var epsilon_BDFlrni4      = 1;
    var epsilon_JSTtauy4      = 1;
    @#endif
	
	@#if SN > 4
	var epsilon_OECDihy5      = 1;
	var epsilon_ESrdy5        = 1;
	var epsilon_PWTcy5        = 1;
	var epsilon_JSTiy5        = 1;
	var epsilon_JSTgy5        = 1;
	var epsilon_JSTxy5        = 1;
	var epsilon_PWTgpcgpy5    = 1;
	var epsilon_PWTgpigpy5    = 1;
	var epsilon_PWTgpgcgpy5   = 1;
	var epsilon_PWTgpxgpy5    = 1;
	var epsilon_PWTgpmgpy5    = 1;
	var epsilon_PWThpop5      = 1;
	var epsilon_PWTwhy5       = 1;
	var epsilon_PWTcfcy5      = 1;
	var epsilon_JSTexpostr5   = 1;
	var epsilon_JSTtauy5      = 1;
	@#endif
	
	@#if SN > 5
	var epsilon_OECDihy6        = 1;
	var epsilon_ESrdy6        = 1;
	var epsilon_PWTcy6        = 1;
	var epsilon_JSTiy6        = 1;
	var epsilon_JSTgy6        = 1;
	var epsilon_JSTxy6        = 1;
	var epsilon_PWTgpcgpy6    = 1;
	var epsilon_PWTgpigpy6    = 1;
	var epsilon_PWTgpgcgpy6   = 1;
	var epsilon_PWTgpxgpy6    = 1;
	var epsilon_PWTgpmgpy6    = 1;
	var epsilon_PWThpop6      = 1;
	var epsilon_PWTwhy6       = 1;
	var epsilon_PWTcfcy6      = 1;
	var epsilon_JSTexpostr6   = 1;
	var epsilon_JSTtauy6      = 1;
	@#endif
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                       //
//                                     load estimated parameters(CurrentBest)                                            //
//                                       set priors and declare observables                                              //
//                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//the number of parameters increases along with SN only because of Ntilde
//However, Ntilde is calibrated in est_calibration.mod, so we don't need to load them from CurrentBest
//M_.params contain all parameters except measurement error declared by dynare built-in capability
//for M_.params this being passed to estimation, set initial value of prior to the parameter itself.
//if we use dynare built-in capability for specifying measurement error, we need something like 
//estim_params_.var_endo( 1:NumberOfMeasurementError, 2 ) = CurrentBest.best_xparam1( 1:NumberOfMeasurementError );
CurrentBest = load( 'CurrentBest' );
CountrySpecificParamIndices = find(~cellfun(@isempty,regexp(cellstr(M_.param_names),'^Ntilde\d+_$','once')));
EndOfFirstBlock = min( CountrySpecificParamIndices ) - 1;
LengthOfSecondBlock = length( M_.params ) - max( CountrySpecificParamIndices );
M_.params( 1 : EndOfFirstBlock ) = CurrentBest.best_M_params( 1 : EndOfFirstBlock ); 
M_.params( ( end - LengthOfSecondBlock + 1 ) : end ) = CurrentBest.best_M_params( ( end - LengthOfSecondBlock + 1 ) : end ); %all parameters except measurement error declared by dynare, for this being passed to estimation, set initial value of prior to the parameter itself.
@#include "est_prior.mod"
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                       //
//                                              start calculation                                                        //
//                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//write_latex_dynamic_model;

semaphore( 'create', 131313, 1 );
semaphore( 'wait', 131313 );
semaphore( 'post', 131313 );
 
set_dynare_seed( 'clock' );

//options_.Harvey_scale_factor = 1e6;
options_.sparse_kalman = 0;
//options_.sequential_optimization_repeats = 10000;
//options_.sequential_optimization_block_size = 16;

options_.qz_criterium = 1 + 2e-4;
options_.endogenous_qz_criterium = 1;

options_.rootF_cond_penalty = 0.00001;
options_.A_cond_penalty = 0.0001;
options_.custom_penalty_scale = 1;
options_.qz_unit_violation_penalty = 32;

// options_.mode_check.number_of_points = 200;
options_.mode_check.neighbourhood_size = 0.1;

options_.hessian.use_outer_product_gradient = 1;

options_.skip_optimisation = 0;

steady;
check;

estimation(order=1, datafile=data_@{SN}country, presample=0,prior_trunc=0,
            use_univariate_filters_if_singularity_is_detected=0,
            lyapunov = doubling,
            lik_init = 7,
            //diffuse_filter,
            cova_compute=1, //mode_check, 
            mh_replic=0, mh_nblocks=2, mh_jscale=0.20, mh_drop=0.2,
            //mode_compute=1, optim=('UseParallel',1,'Display','iter','TolX',1e-16,'TolF',1e-16,'MaxIter',32,'InitTrustRegionRadius',0.01,'FinDiffRelStep',1e-6),
            //mode_compute=9, optim=('UseParallel',1,'ResumeRun',0,'ResumeFromBest',1,'SigmaScale',1e-4,'MinSigma',1e-5,'MaxIter',1e12,'DiagonalOnly',1),
            mode_compute=1313,
            //mode_compute=0, smoother,
            plot_priors=0, graph_format=fig
            )
gryW gpopW
  @#for n in 1:SN-1
	yshare@{n}
  @#endfor
  @#for n in 1:SN
	popshare@{n}
  @#endfor
@#if SN > 0
OECDihy1 ESrdy1 BEAcy1  JSTiy1  BEAgcy1  BEAgiy1  JSTxy1  BEAgpcgpy1  BEAgpigpy1  BEAgpgcgpy1 BEAgpgigpy1 BEAgpxgpy1  BEAgpmgpy1  BEAhpop1   BEAwhy1   BEAcfcy1  JSTexpostr1  FREDlrni1 JSTtauy1
@#endif
@#if SN > 1
OECDihy2 ESrdy2 PWTcy2  JSTiy2  JSTgy2            JSTxy2  PWTgpcgpy2  PWTgpigpy2  PWTgpgcgpy2             PWTgpxgpy2  PWTgpmgpy2  PWThpop2   PWTwhy2   PWTdelta2 JSTexpostr2  DBlrni2   JSTtauy2
@#endif
@#if SN > 2
OECDihy3 ESrdy3 MILLcy3 MILLiy3 MILLgcy3 MILLgiy3 MILLxy3 MILLgpcgpy3 MILLgpigpy3 MILLgpgcgpy3            MILLgpxgpy3 MILLgpmgpy3 MILLhpop3  MILLwhy3  MILLcfcy3 MILLexpostr3 MILLlrni3 MILLtauy3
@#endif
@#if SN > 3
OECDihy4 ESrdy4 PWTcy4  JSTiy4  JSTgy4            JSTxy4  PWTgpcgpy4  PWTgpigpy4  PWTgpgcgpy4             PWTgpxgpy4  PWTgpmgpy4  PWThpop4   PWTwhy4   PWTdelta4 JSTexpostr4  BDFlrni4  JSTtauy4
@#endif
@#if SN > 4
OECDihy5 ESrdy5 PWTcy5  JSTiy5  JSTgy5            JSTxy5  PWTgpcgpy5  PWTgpigpy5  PWTgpgcgpy5             PWTgpxgpy5  PWTgpmgpy5  PWThpop5   PWTwhy5   PWTcfcy5  JSTexpostr5            JSTtauy5
@#endif
@#if SN > 5
OECDihy6 ESrdy6 PWTcy6  JSTiy6  JSTgy6            JSTxy6  PWTgpcgpy6  PWTgpigpy6  PWTgpgcgpy6             PWTgpxgpy6  PWTgpmgpy6  PWThpop6   PWTwhy6   PWTcfcy6  JSTexpostr6            JSTtauy6
@#endif
@#if ExtraVariable
As_DivFromTrend
@#if SN > 0
rGDPpc1_DivFromTrend Xpc1_DivFromTrend rPCEpc1_DivFromTrend NXY1 rPDIpc1_DivFromTrend IHPpc1_DivFromTrend PRDY1 rGSpendingpc1_DivFromTrend GovDifY1 GRDY1
@#endif
@#if SN > 1
rGDPpc2_DivFromTrend Xpc2_DivFromTrend rPCEpc2_DivFromTrend NXY2 rPDIpc2_DivFromTrend IHPpc2_DivFromTrend PRDY2 rGSpendingpc2_DivFromTrend GovDifY2 GRDY2
@#endif
@#if SN > 2
rGDPpc3_DivFromTrend Xpc3_DivFromTrend rPCEpc3_DivFromTrend NXY3 rPDIpc3_DivFromTrend IHPpc3_DivFromTrend PRDY3 rGSpendingpc3_DivFromTrend GovDifY3 GRDY3
@#endif
@#if SN > 3
rGDPpc4_DivFromTrend Xpc4_DivFromTrend rPCEpc4_DivFromTrend NXY4 rPDIpc4_DivFromTrend IHPpc4_DivFromTrend PRDY4 rGSpendingpc4_DivFromTrend GovDifY4 GRDY4
@#endif
@#if SN > 4
rGDPpc5_DivFromTrend Xpc5_DivFromTrend rPCEpc5_DivFromTrend NXY5 rPDIpc5_DivFromTrend IHPpc5_DivFromTrend PRDY5 rGSpendingpc5_DivFromTrend GovDifY5 GRDY5
@#endif
@#if SN > 5
rGDPpc6_DivFromTrend Xpc6_DivFromTrend rPCEpc6_DivFromTrend NXY6 rPDIpc6_DivFromTrend IHPpc6_DivFromTrend PRDY6 rGSpendingpc6_DivFromTrend GovDifY6 GRDY6
@#endif
@#endif
;

stoch_simul( periods = 0, irf = 0, order = 1, nocorr, nodecomposition, nofunctions, nomoments, nograph );

% note that extral final observables (rGDPpc1 rPCEpc1 rPDIpc1 Xpc1 rGCEpc1 rGGIpc1 NXY1) are in percentage, 1=1%
% observables for estimation (BEAly1 BLShourspercapita1, etc) are of 0.01=1%
