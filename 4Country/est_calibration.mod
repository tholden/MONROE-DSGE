//global parameters
lambda       =0.927;                             %engineering sector, Markup upper bound (1 means price double of marginal cost) 
eta          =0.10;                              %engineering sector, eta*lambda=markup lower bound
phiR         =0.0016;                            %engineering sector, spill over from product innovation to research
zetaR        =0.0057;                            %engineering sector, increasing difficuties in research relative to spill over from process innovation 
gamma        =9.6;                               %engineering sector, parallelizability of research
scriptp      =0.09;                              %engineering sector, bargaining power of engineering firms
scriptq      =0.17;                              %engineering sector, probability of losing patent
psi          =0.1;                               %engineering sector, elasticity of product depreciation with respect to product growth
psib         =0.1;                               %welfare elasticity of borrower immigration
psil         =0.1;                               %welfare elasticity of lender immigration
hpop_        =6.5;                               %transforming the unit of hours in data to the unit of hours in model

//country-specific parameters but must be constant across countries as required by the model
alphaCP      =0.98;                               %share of CP in C
alphaCD      =0.51;                               %share of CD in CP
alphah       =0.44;                               %Share of durable goods in home production
alphaKP      =0.17;                               %Share of generalized goods in producing KP, KG
alphaHP      =0.88;                               %Share of generalized goods in producing HP, HG
alphaD       =0.88;                               %Share of generalized goods in producing D
alphaND      =0.68;                               %Share of generalized goods in producing ND, CG
alphaHW      =0.29;                               %share of gov R&D capital in widget.
alphaHL      =0.01;                               %share of human capital
alphaK       =0.82;                               %share of gov capital
alphaKL      =0.46;                               %share of capital
alphaHLX     =0.12;                               %share of HL
alphaY       =0.50;                               %share of HLX
betabarl     =0.99;                               %endogenous discount factor

//country-specific parameters that are assumed to be constant across countries
sigma        =1.2;                                %intertemporal elasticity of substitution (inverse)
gammaV       =2.1;                                %risk aversion (large value of this parameter will amplified any small error in the def. of EV so that dynare can't varify steady state)
xi           =0;                                  %between average utilitarian and total utilitarian 
bbeta        =0.004;                              %endogenous discount factor (elasticity, can't be too large, say 0.01, otherwise can't find steady state; can't be too small otherwise eigenvalue is nearly 1)

h            =0.87;                              %intensity of standard habit
varrhoC      =0.53;                              %persistence of consumption habit
eC           =0.98;                              %substitution between CP and CG
varrhoCP     =0.49;                              %persistence of CPBar
eCP          =0.27;                              %substitution CD and CND
varrhoCD     =0.84;                              %persistence of CDBar

nuW          =1.17;                              %disutility curvature of labor in W
nuT          =1.03;                              %disutility curvature of labor in T
nuNT         =1.05;                              %disutility curvature of labor in NT
nuSW         =1.00;                              %disutility curvature of labor in SW
nuST         =0.88;                              %disutility curvature of labor in ST
nuSNT        =0.90;                              %disutility curvature of labor in SNT
nuD          =1.32;                              %disutility curvature of labor in D
nuNDCG       =1.26;                              %disutility curvature of labor in NDCG
nuK          =1.33;                              %disutility curvature of labor in K
nuH          =1.38;                              %disutility curvature of labor in H
nuh          =1.26;                              %disutility curvature of labor in home production

rhoQB        =0.34;                              %collateral constraint inertia

thetaGKP     =10;                                %capital adjustment cost
thetaPKP     =6.8;                               %time to build friction
thetaKU0     =0.18;                              %parameter of capital depreciation
thetaKU1     =0.52;                              %elasticity of depreciation to capital utilization
thetaGHP     =7.72;                              %Human capital adjustment cost
thetaPHP     =7.76;                              %time to build friction
thetaGD      =4.18;                              %durable adjustment cost
thetaPD      =3.89;                              %time to build friction
thetaDU0     =0.14;                              %parameter of durable depreciation
thetaDU1     =1.60;                              %elasticity of depreciation to capital utilization

eNC          =0.90;                              %substitution elasticity between tradable composite and nontradable
alphaNC      =0.95;                              %share of nontradable in production of generalized goods
eT           =0.09;                              %substitution elasticity among tradable variety 
eW           =1.11;                              %substitution elasticity among widget variety
FWCtilde     =alphaHW/(1-alphaHW);               %fixed costs: alpha/(1-alpha)*output ensure zero profits
FKtilde      =alphaK/(1-alphaK);                 %fixed costs: alpha/(1-alpha)*output ensure zero profits
                                            
o            =47.6;                              %friction in adopting engineering
eKLT         =0.22;                              %substitution elasticity between K and L
eKLNT        =0.22;                              %substitution elasticity between K and L
eKLW         =0.22;                              %substitution elasticity between K and L
varrhoKL     =0.24;                              %persistence KBar
eHLXT        =0.07;                              %substitution elasticity between HL and scriptX
eHLXNT       =0.07;                              %substitution elasticity between HL and scriptX
eHLXW        =0.07;                              %substitution elasticity between HL and scriptX
varrhoHLX    =0.90;                              %persistence of YHLBar
eYT          =0.63;                              %substitution elasticity between KL and HLX
eYNT         =0.63;                              %substitution elasticity between KL and HLX
eYW          =0.63;                              %substitution elasticity between KL and HLX
varrhoY      =0.79;                              %persistence of YHLXBar

//Policy (unit roots): SS, std, responsiveness, and the extent to which taxes are true taxes, fixed across countries
tauKG_        = 0.044;  phiYtauKG       =0;  phiLtauKG =0;  phiutauKG  =0;  sigmauKG =0.001;   sigmauS1ALL=0.001;   sigmauALL  =0.001;  
tauHG_        = 0.037;  phiYtauHG       =0;  phiLtauHG =0;  phiutauHG  =0;  sigmauHG =0.001;                              
tauCG_        = 0.043;  phiYtauCG       =0;  phiLtauCG =0;  phiutauCG  =0;  sigmauCG =0.001;                              
taub_         = 0.01;   phiYtaub        =0;  phiLtaub  =0;  phiutaub   =0;  sigmaub  =0.001;   sigmaulbALL=0.001;                
taul_         = -0.01;  phiYtaul        =0;  phiLtaul  =0;  phiutaul   =0;  sigmaul  =0.001;                              
tauD_         = -0.04;  phitauD         =1;                 phiutauD   =0;  sigmauD  =0.001;   sigmauCALL =0.001;                
tauND_        = 0.08;   phitauND        =1;                 phiutauND  =0;  sigmauND =0.001;                              
tauNT_        = 0.23;   phitauNT        =1;                 phiutauNT  =0;  sigmauNT =0.001;                              
tauTC_        = 0;      phitauTC        =1;                 phiutauTC  =0;  sigmauTC =0    ;                              
iotaTX_       = 0;      phiiotaTX       =1;                 phiuiotaTX =0;  sigmauTX =0.001;   sigmauiotaALL=0.001;              
iotaTM_       = 0;      phiiotaTM       =1;                 phiuiotaTM =0;  sigmauTM =0.001;                              
iotaWX_       = 0;      phiiotaWX       =1;                 phiuiotaWX =0;  sigmauWX =0.001;                              
iotaWM_       = 0;      phiiotaWM       =1;                 phiuiotaWM =0;  sigmauWM =0.001;                              
tauLa_        = -0.05;  phitauL         =1;                 phiutauLa  =0;  sigmauLa =0.001;   sigmauLALL=0.001;                 
tauLb_        = 0.07;                                       phiutauLb  =0;  sigmauLb =0.001;                              
tauHW_        = 0.05;   phitauHW        =1;                 phiutauHW  =0;                     sigmauHALL=0.001;    sigmauWALL  =0.001; 
tauHT_        = 0.02;   phitauHT        =1;                 phiutauHT  =0;                                          sigmauTALL  =0.001; 
tauHNT_       = 0.17;   phitauHNT       =1;                 phiutauHNT =0;                                          sigmauNTALL =0.001; 
tauKW_        = 0.15;   phitauKW        =1;                 phiutauKW  =0;                     sigmauKALL=0.001;                 
tauKT_        = 0.12;   phitauKT        =1;                 phiutauKT  =0;                                                
tauKNT_       = 0.27;   phitauKNT       =1;                 phiutauKNT =0;                                                
tauscriptXW_  = 0.09;   phitauscriptXW  =1;                 phiutauXW  =0;                     sigmauXALL=0.001;                 
tauscriptXT_  = 0.068;  phitauscriptXT  =1;                 phiutauXT  =0;                                                
tauscriptXNT_ = 0.21;   phitauscriptXNT =1;                 phiutauXNT =0;                                                

//TFPs: parameters fixedd across countries
rhoOmegaALL       =0.9;  sigmaOmegaALL        =0.001;
rhoOmegaS0ALL     =0.9;  sigmaOmegaS0ALL      =0.001;
rhoOmegaTALL      =0.9;  sigmaOmegaTALL       =0.001;
rhoOmegaNTALL     =0.9;  sigmaOmegaNTALL      =0.001;
rhoOmegaWALL      =0.9;  sigmaOmegaWALL       =0.001;
rhoOmegaKKALL     =0.9;  sigmaOmegaKKALL      =0.001;
rhoOmegaHLALL     =0.9;  sigmaOmegaHLALL      =0.001;
rhoOmegaKLALL     =0.9;  sigmaOmegaKLALL      =0.001;
rhoOmegaHLXALL    =0.9;  sigmaOmegaHLXALL     =0.001;
rhoOmegaHLXKLALL  =0.9;  sigmaOmegaHLXKLALL   =0.001;
rhoOmegaS1ALL     =0.9;  sigmaOmegaS1ALL      =0.001;
rhoOmegaKALL      =0.9;  sigmaOmegaKALL       =0.001;
rhoOmegaHALL      =0.9;  sigmaOmegaHALL       =0.001;
rhoOmegaCALL      =0.9;  sigmaOmegaCALL       =0.001;
rhoOmegaDi        =0.9;  sigmaOmegaDi         =0.001;
rhoOmegaPALL      =0.9;  sigmaOmegaPALL       =0.001;
rhoOmegaGALL      =0.9;  sigmaOmegaGALL       =0.001;
rhoOmegaDemandALL =0.9;  sigmaOmegaDemandALL  =0.001;
rhoOmegahi        =0.9;  sigmaOmegahi         =0.001;
rhoOmegaCPi       =0.9;  sigmaOmegaCPi        =0.001;
rhoOmegaCi        =0.9;  sigmaOmegaCi         =0.001;
rhoOmegaTradeALL  =0.9;  sigmaOmegaTradeALL   =0.001;
rhoOmegaYi        =0.9;  sigmaOmegaYi         =0.001;
rhoOmegaTCi       =0.9;  sigmaOmegaTCi        =0.001;
rhoOmegaWPi       =0.9;  sigmaOmegaWPi        =0.001;
rhoOmegaWCi       =0.9;  sigmaOmegaWCi        =0.001;
Omegah_       =1;
OmegaCP_      =1;
OmegaC_       =1;
OmegaKP_      =1;
OmegaHP_      =1;
OmegaD_       =1;
OmegaND_      =1;
OmegaKG_      =1;
OmegaHG_      =1;
OmegaCG_      =1;
OmegaY_       =10;
OmegaTC_      =1;
OmegaWP_      =1;
OmegaWC_      =1;
OmegaKT_      =1;
OmegaHLT_     =1;
OmegaKLT_     =1;
OmegaHLXT_    =1;
OmegaT_       =1;
OmegaKNT_     =1;
OmegaHLNT_    =1;
OmegaKLNT_    =1;
OmegaHLXNT_   =1;
OmegaNT_      =1;
OmegaKW_      =1;
OmegaHLW_     =1;
OmegaKLW_     =1;
OmegaHLXW_    =1;
OmegaW_       =1;

//stationary processes: parameters fixedd across countries
//note that the processes of beta and ROW are defined manually (not by transformation engine)
rhoGN          =0.9;   sigmaGN         =0.001;  GN_          = 1.0137;
rhoZ           =0.9;   sigmaZ          =0.001;  Z_           = 1;
rhodeltaItilde =0.9;   sigmadeltaItilde=0.001;  deltaItilde_ = 0.01;
rhoscriptFI    =0.9;   sigmascriptFI   =0.001;  scriptFI_    = 4.82;
rhodeltaD      =0.9;   sigmadeltaD     =0.001;  deltaD_      = 0.037;
rhokappa0      =0.9;   sigmakappa0     =0.001;  kappa0_      = 0;
rhokappah      =0.9;   sigmakappah     =0.001;  kappah_      = 1;
@#for S in Sectors2
rhokappa@{S}   =0.9;   sigmakappa@{S}  =0.001;  kappa@{S}_   = 1 ;
@#endfor
rhodeltaK      =0.9;   sigmadeltaK     =0.001;  deltaK_      =0.05;
rhodeltaH      =0.9;   sigmadeltaH     =0.001;  deltaH_      =0.1;
rhobeta        =0.9;   sigmabeta       =0.001;  betabarb     =0.98;
rhoPP0 = 0.8; rhoPY0 = 0.1; rhoYP0 = 0.1; rhoYY0 = 0.8; rho0 = 0.9; sigmaP0 = 0.001; sigmaY0 = 0.001;
pT0 = 1; yTC0 = 1;

//RW: fixedd across countries except the SS of population shares
sigmam             =0.001;  m_            =0.5;           
sigmavarpi         =0.001;  varpi_        =0.1;       
sigmaeT0           =0.001;  eT0_          =1.5;         
sigmaalpha_resid   =0.001;  alpha_resid_  =0.25; 
sigmaalpha_pubedu  =0.001;  alpha_pubedu_ =0.35;
sigmaNtilde        =0.001;  Ntilde1_      =0.0543; Ntilde2_=0.0283; Ntilde3_=0.0200; Ntilde4_=0.0203; Ntilde5_=0.0457; Ntilde6_=0.0408;            
