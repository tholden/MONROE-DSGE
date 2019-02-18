//PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_MEAN, PRIOR_STD, PRIOR_P3, PRIOR_P4, JSCALE
//those comment out by // have hierarchical priors
//those comment out by %% are fixed parameters

estimated_params;

//initial state parameters
InitialStateLogitEigCap     , InitialStateLogitEigCap     , , , NORMAL_PDF , 5  , 5;
InitialStateAllowCorrelation, InitialStateAllowCorrelation, , , UNIFORM_PDF, 0.5, (1/12)^(0.5);
InitialStateLogPower        , InitialStateLogPower        , , , NORMAL_PDF , 0  , 5;
InitialStateLogScale        , InitialStateLogScale        , , , NORMAL_PDF , 0  , 10;

//std of measurement errors
@#if 1
sigma_gryW        ,sigma_gryW      , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_yshare      ,sigma_yshare    , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_gpopW       ,sigma_gpopW     , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_popshare    ,sigma_popshare  , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_ihy         ,sigma_ihy       , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_rdy         ,sigma_rdy       , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_cy          ,sigma_cy        , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_iy          ,sigma_iy        , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_gcy         ,sigma_gcy       , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_giy         ,sigma_giy       , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_xy          ,sigma_xy        , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_gpcgpy      ,sigma_gpcgpy    , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_gpigpy      ,sigma_gpigpy    , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_gpgcgpy     ,sigma_gpgcgpy   , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_gpgigpy     ,sigma_gpgigpy   , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_gpxgpy      ,sigma_gpxgpy    , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_gpmgpy      ,sigma_gpmgpy    , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_hpop        ,sigma_hpop      , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_why         ,sigma_why       , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_cfcy        ,sigma_cfcy      , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_expostr     ,sigma_expostr   , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_lrni        ,sigma_lrni      , , , INV_GAMMA_PDF, 0.001, 0.001;
sigma_tauy        ,sigma_tauy      , , , INV_GAMMA_PDF, 0.001, 0.001;
@#endif

@#if 1
//global parameters
lambda    ,lambda  ,       ,       ,GAMMA_PDF    ,1           ,0.1          ;
eta       ,eta     ,       ,       ,BETA_PDF     ,0.1         ,0.01         ;
phiR      ,phiR    ,       ,       ,GAMMA_PDF    ,0.0015      ,0.00075      ;
zetaR     ,zetaR   ,       ,       ,GAMMA_PDF    ,0.008       ,0.004        ;
gamma     ,gamma   ,       ,       ,GAMMA_PDF    ,5           ,5            ;
scriptp   ,scriptp ,0.0001 ,0.9999 ,BETA_PDF     ,0.1         ,0.05         ;
scriptq   ,scriptq ,0.0001 ,0.9999 ,BETA_PDF     ,0.05        ,0.01         ;
psi       ,psi     ,       ,       ,GAMMA_PDF    ,0.1         ,0.05         ;
psib      ,psib    ,       ,       ,GAMMA_PDF    ,0.00001     ,0.00001/2    ;
psil      ,psil    ,       ,       ,GAMMA_PDF    ,0.00001     ,0.00001/2    ;
hpop_     ,hpop_   ,       ,       ,GAMMA_PDF    ,6.5         ,0.1          ;
rdy_      ,rdy_    ,       ,       ,NORMAL_PDF   ,0           ,0.2          ;
@#endif

@#if 1
//country-specific parameters but must be constant across countries as required by the model
logit_alphaCP   ,logit_alphaCP  , , ,NORMAL_PDF   ,0    ,0.5  ;
logit_alphaCD   ,logit_alphaCD  , , ,NORMAL_PDF   ,0    ,0.5  ;
logit_alphah    ,logit_alphah   , , ,NORMAL_PDF   ,0    ,0.5  ;
logit_alphaKP   ,logit_alphaKP  , , ,NORMAL_PDF   ,0    ,0.5  ;
logit_alphaHP   ,logit_alphaHP  , , ,NORMAL_PDF   ,0    ,0.5  ; 
logit_alphaD    ,logit_alphaD   , , ,NORMAL_PDF   ,0    ,0.5  ; 
logit_alphaND   ,logit_alphaND  , , ,NORMAL_PDF   ,0    ,0.5  ; 
logit_alphaHW   ,logit_alphaHW  , , ,NORMAL_PDF   ,0    ,0.5  ; 
logit_alphaHL   ,logit_alphaHL  , , ,NORMAL_PDF   ,0    ,0.5  ; 
logit_alphaK    ,logit_alphaK   , , ,NORMAL_PDF   ,0    ,0.5  ; 
logit_alphaKL   ,logit_alphaKL  , , ,NORMAL_PDF   ,0    ,0.5  ; 
logit_alphaHLX  ,logit_alphaHLX , , ,NORMAL_PDF   ,0    ,0.5  ;
logit_alphaY    ,logit_alphaY   , , ,NORMAL_PDF   ,0    ,0.5  ;
betabarl  ,betabarl ,0.0001 ,0.9999 ,BETA_PDF   ,0.96   ,0.005     ;

//country-specific parameters that are assumed to be constant across countries
sigma         ,sigma       ,       ,       ,GAMMA_PDF    ,1     ,0.5;
gammaV        ,gammaV      ,       ,       ,GAMMA_PDF    ,10    ,5  ; 
logit_xi      ,logit_xi    ,       ,       ,NORMAL_PDF   ,0     ,1.1  ;
bbeta         ,bbeta       ,       ,       ,GAMMA_PDF    ,0.005 ,0.001;

h             ,h           ,0.0001 ,0.9999 ,BETA_PDF     ,0.5   ,0.05^0.5;
varrhoC       ,varrhoC     ,0.0001 ,0.9999 ,BETA_PDF     ,0.5   ,0.05^0.5;
eC            ,eC          ,       ,       ,GAMMA_PDF    ,1     ,0.5;
varrhoCP      ,varrhoCP    ,0.0001 ,0.9999 ,BETA_PDF     ,0.5   ,0.05^0.5;
eCP           ,eCP         ,       ,       ,GAMMA_PDF    ,1     ,0.5;
varrhoCD      ,varrhoCD    ,0.0001 ,0.9999 ,BETA_PDF     ,0.5   ,0.05^0.5;

//nuW           ,nuW       ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuT           ,nuT       ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuNT          ,nuNT      ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuSW          ,nuSW      ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuST          ,nuST      ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuSNT         ,nuSNT     ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuD           ,nuD       ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuNDCG        ,nuNDCG    ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuK           ,nuK       ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuH           ,nuH       ,       ,       ,GAMMA_PDF    ,2     ,0.75; 
//nuh           ,nuh       ,       ,       ,GAMMA_PDF    ,2     ,0.75; 

rhoQB         ,rhoQB       ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5); 

thetaGKP      ,thetaGKP    ,       ,       ,GAMMA_PDF    ,10    ,5;
thetaPKP      ,thetaPKP    ,       ,       ,GAMMA_PDF    ,10    ,5;
thetaKU0      ,thetaKU0    ,       ,       ,GAMMA_PDF    ,0.2   ,0.1;
thetaKU1      ,thetaKU1    ,       ,       ,GAMMA_PDF    ,1     ,0.5;
thetaGHP      ,thetaGHP    ,       ,       ,GAMMA_PDF    ,10    ,5;
thetaPHP      ,thetaPHP    ,       ,       ,GAMMA_PDF    ,10    ,5;
thetaGD       ,thetaGD     ,       ,       ,GAMMA_PDF    ,10    ,5;
thetaPD       ,thetaPD     ,       ,       ,GAMMA_PDF    ,10    ,5;
thetaDU0      ,thetaDU0    ,       ,       ,GAMMA_PDF    ,0.2   ,0.1;
thetaDU1      ,thetaDU1    ,       ,       ,GAMMA_PDF    ,1     ,0.5;

eNC           ,eNC         ,       ,       ,GAMMA_PDF    ,1     ,0.5;
alphaNC       ,alphaNC     ,0.0001 ,0.9999 ,BETA_PDF     ,0.5   ,0.05^0.5;
eT            ,eT          ,       ,       ,GAMMA_PDF    ,1     ,0.5;
eW            ,eW          ,       ,       ,GAMMA_PDF    ,1     ,0.5;
FWCtilde      ,FWCtilde    ,       ,       ,GAMMA_PDF    ,1     ,1  ;
FKtilde       ,FKtilde     ,       ,       ,GAMMA_PDF    ,1     ,1  ;

  o             ,o           ,       ,       ,GAMMA_PDF    ,100   ,70 ;
//eKLT          ,eKLT        ,       ,       ,GAMMA_PDF    ,1     ,0.5;
//eKLNT         ,eKLNT       ,       ,       ,GAMMA_PDF    ,1     ,0.5;
//eKLW          ,eKLW        ,       ,       ,GAMMA_PDF    ,1     ,0.5;
  varrhoKL      ,varrhoKL    ,0.0001 ,0.9999 ,BETA_PDF     ,0.5   ,0.05^0.5;
//eHLXT         ,eHLXT       ,       ,       ,GAMMA_PDF    ,1     ,0.5;
//eHLXNT        ,eHLXNT      ,       ,       ,GAMMA_PDF    ,1     ,0.5;
//eHLXW         ,eHLXW       ,       ,       ,GAMMA_PDF    ,1     ,0.5;
  varrhoHLX     ,varrhoHLX   ,0.0001 ,0.9999 ,BETA_PDF     ,0.5   ,0.05^0.5;
//eYT           ,eYT         ,       ,       ,GAMMA_PDF    ,1     ,0.5;
//eYNT          ,eYNT        ,       ,       ,GAMMA_PDF    ,1     ,0.5;
//eYW           ,eYW         ,       ,       ,GAMMA_PDF    ,1     ,0.5;
  varrhoY       ,varrhoY     ,0.0001 ,0.9999 ,BETA_PDF     ,0.5   ,0.05^0.5;

//Policy (unit roots): SS, std, responsiveness, and the extent to which taxes are true taxes, fixed across countries
//tauKG_        ,tauKG_          ,0.001 ,0.999 ,BETA_PDF   ,0.2 ,0.1; 
//tauHG_        ,tauHG_          ,0.001 ,0.999 ,BETA_PDF   ,0.2 ,0.1; 
//tauCG_        ,tauCG_          ,0.001 ,0.999 ,BETA_PDF   ,0.2 ,0.1; 
//taub_         ,taub_           ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//taul_         ,taul_           ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauD_         ,tauD_           ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauND_        ,tauND_          ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauNT_        ,tauNT_          ,      ,      ,NORMAL_PDF ,0   ,0.1; 
%%tauTC_        ,tauTC_          ,      ,      ,NORMAL_PDF ,0   ,0.1; 
%%iotaTX_       ,iotaTX_         ,      ,      ,NORMAL_PDF ,0   ,0.1; 
%%iotaTM_       ,iotaTM_         ,      ,      ,NORMAL_PDF ,0   ,0.1; 
%%iotaWX_       ,iotaWX_         ,      ,      ,NORMAL_PDF ,0   ,0.1; 
%%iotaWM_       ,iotaWM_         ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauLa_        ,tauLa_          ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauLb_        ,tauLb_          ,      ,      ,GAMMA_PDF  ,0.1 ,0.05;
//tauHW_        ,tauHW_          ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauHT_        ,tauHT_          ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauHNT_       ,tauHNT_         ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauKW_        ,tauKW_          ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauKT_        ,tauKT_          ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauKNT_       ,tauKNT_         ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauscriptXW_  ,tauscriptXW_    ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauscriptXT_  ,tauscriptXT_    ,      ,      ,NORMAL_PDF ,0   ,0.1; 
//tauscriptXNT_ ,tauscriptXNT_   ,      ,      ,NORMAL_PDF ,0   ,0.1; 

//phiLtauKG       ,phiLtauKG       ,    ,      ,NORMAL_PDF ,0   ,0.5;   
//phiLtauHG       ,phiLtauHG       ,    ,      ,NORMAL_PDF ,0   ,0.5;   
//phiLtauCG       ,phiLtauCG       ,    ,      ,NORMAL_PDF ,0   ,0.5;   
//phiLtaub        ,phiLtaub        ,    ,      ,NORMAL_PDF ,0   ,0.5;   
//phiLtaul        ,phiLtaul        ,    ,      ,NORMAL_PDF ,0   ,0.5;   
  
//phiYtauKG       ,phiYtauKG       ,    ,      ,NORMAL_PDF ,0   ,0.5;   
//phiYtauHG       ,phiYtauHG       ,    ,      ,NORMAL_PDF ,0   ,0.5;   
//phiYtauCG       ,phiYtauCG       ,    ,      ,NORMAL_PDF ,0   ,0.5;   
//phiYtaub        ,phiYtaub        ,    ,      ,NORMAL_PDF ,0   ,0.5;   
//phiYtaul        ,phiYtaul        ,    ,      ,NORMAL_PDF ,0   ,0.5;   

//phiutauKG       ,phiutauKG       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauHG       ,phiutauHG       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauCG       ,phiutauCG       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutaub        ,phiutaub        ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutaul        ,phiutaul        ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauD        ,phiutauD        ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauND       ,phiutauND       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauNT       ,phiutauNT       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
%%phiutauTC       ,phiutauTC       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiuiotaTX      ,phiuiotaTX      ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiuiotaTM      ,phiuiotaTM      ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiuiotaWX      ,phiuiotaWX      ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiuiotaWM      ,phiuiotaWM      ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauLa       ,phiutauLa       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauLb       ,phiutauLb       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauHW       ,phiutauHW       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauHT       ,phiutauHT       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauHNT      ,phiutauHNT      ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauKW       ,phiutauKW       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauKT       ,phiutauKT       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauKNT      ,phiutauKNT      ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauXW       ,phiutauXW       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauXT       ,phiutauXT       ,       ,   ,NORMAL_PDF ,0   ,0.5; 
//phiutauXNT      ,phiutauXNT      ,       ,   ,NORMAL_PDF ,0   ,0.5; 
  
//phitauD         ,phitauD         ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauND        ,phitauND        ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
  phitauNT        ,phitauNT        ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
%%phitauTC        ,phitauTC        ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phiiotaTX       ,phiiotaTX       ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phiiotaTM       ,phiiotaTM       ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phiiotaWX       ,phiiotaWX       ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phiiotaWM       ,phiiotaWM       ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
  phitauL         ,phitauL         ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauHW        ,phitauHW        ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauHT        ,phitauHT        ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauHNT       ,phitauHNT       ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauKW        ,phitauKW        ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauKT        ,phitauKT        ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauKNT       ,phitauKNT       ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauscriptXW  ,phitauscriptXW  ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauscriptXT  ,phitauscriptXT  ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5);                
//phitauscriptXNT ,phitauscriptXNT ,0.0001 ,0.9999 ,uniform_pdf  ,0.5   ,(1/12)^(0.5); 
  
//sigmauKG        ,sigmauKG        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauHG        ,sigmauHG        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauCG        ,sigmauCG        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmaub         ,sigmaub         ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmaul         ,sigmaul         ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauD         ,sigmauD         ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauND        ,sigmauND        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauNT        ,sigmauNT        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
%%sigmauTC        ,sigmauTC        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauTX        ,sigmauTX        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauTM        ,sigmauTM        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauWX        ,sigmauWX        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauWM        ,sigmauWM        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauLa        ,sigmauLa        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauLb        ,sigmauLb        ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauS1ALL     ,sigmauS1ALL     ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauALL       ,sigmauALL       ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;         //note that policy shocks are additive      
//sigmaulbALL     ,sigmaulbALL     ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;         
//sigmauCALL      ,sigmauCALL      ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauiotaALL   ,sigmauiotaALL   ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;   
//sigmauLALL      ,sigmauLALL      ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauHALL      ,sigmauHALL      ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauKALL      ,sigmauKALL      ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauXALL      ,sigmauXALL      ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauWALL      ,sigmauWALL      ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauTALL      ,sigmauTALL      ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
//sigmauNTALL     ,sigmauNTALL     ,       ,       ,INV_GAMMA_PDF,0.001 ,0.02;
  
//TFPs: parameters fixedd across countries                                         note that these shocks are additive (after log of Omega)
//rhoOmegaALL       ,rhoOmegaALL        ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaALL       , sigmaOmegaALL        , , , INV_GAMMA_PDF, 0.0035, 0.0035 *20;
//rhoOmegaS0ALL     ,rhoOmegaS0ALL      ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaS0ALL     , sigmaOmegaS0ALL      , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaTALL      ,rhoOmegaTALL       ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaTALL      , sigmaOmegaTALL       , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaNTALL     ,rhoOmegaNTALL      ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaNTALL     , sigmaOmegaNTALL      , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaWALL      ,rhoOmegaWALL       ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaWALL      , sigmaOmegaWALL       , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaKKALL     ,rhoOmegaKKALL      ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaKKALL     , sigmaOmegaKKALL      , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaHLALL     ,rhoOmegaHLALL      ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaHLALL     , sigmaOmegaHLALL      , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaKLALL     ,rhoOmegaKLALL      ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaKLALL     , sigmaOmegaKLALL      , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaHLXALL    ,rhoOmegaHLXALL     ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaHLXALL    , sigmaOmegaHLXALL     , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaHLXKLALL  ,rhoOmegaHLXKLALL   ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaHLXKLALL  , sigmaOmegaHLXKLALL   , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaS1ALL     ,rhoOmegaS1ALL      ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaS1ALL     , sigmaOmegaS1ALL      , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaKALL      ,rhoOmegaKALL       ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaKALL      , sigmaOmegaKALL       , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaHALL      ,rhoOmegaHALL       ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaHALL      , sigmaOmegaHALL       , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaCALL      ,rhoOmegaCALL       ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaCALL      , sigmaOmegaCALL       , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaDi        ,rhoOmegaDi         ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaDi        , sigmaOmegaDi         , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaPALL      ,rhoOmegaPALL       ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaPALL      , sigmaOmegaPALL       , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaGALL      ,rhoOmegaGALL       ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaGALL      , sigmaOmegaGALL       , , , INV_GAMMA_PDF, 0.0020, 0.0020 *20;
//rhoOmegaDemandALL ,rhoOmegaDemandALL  ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaDemandALL , sigmaOmegaDemandALL  , , , INV_GAMMA_PDF, 0.0025, 0.0025 *20;
//rhoOmegahi        ,rhoOmegahi         ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegahi        , sigmaOmegahi         , , , INV_GAMMA_PDF, 0.0035, 0.0035 *20;
//rhoOmegaCPi       ,rhoOmegaCPi        ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaCPi       , sigmaOmegaCPi        , , , INV_GAMMA_PDF, 0.0025, 0.0025 *20;
//rhoOmegaCi        ,rhoOmegaCi         ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaCi        , sigmaOmegaCi         , , , INV_GAMMA_PDF, 0.0025, 0.0025 *20;
//rhoOmegaTradeALL  ,rhoOmegaTradeALL   ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaTradeALL  , sigmaOmegaTradeALL   , , , INV_GAMMA_PDF, 0.0025, 0.0025 *20;
//rhoOmegaYi        ,rhoOmegaYi         ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaYi        , sigmaOmegaYi         , , , INV_GAMMA_PDF, 0.0035, 0.0035 *20;
//rhoOmegaTCi       ,rhoOmegaTCi        ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaTCi       , sigmaOmegaTCi        , , , INV_GAMMA_PDF, 0.0025, 0.0025 *20;
//rhoOmegaWPi       ,rhoOmegaWPi        ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaWPi       , sigmaOmegaWPi        , , , INV_GAMMA_PDF, 0.0025, 0.0025 *20;
//rhoOmegaWCi       ,rhoOmegaWCi        ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;    sigmaOmegaWCi       , sigmaOmegaWCi        , , , INV_GAMMA_PDF, 0.0035, 0.0035 *20;
%%Omegah_       
%%OmegaCP_      
%%OmegaC_       
%%OmegaKP_      
%%OmegaHP_      
%%OmegaD_       
%%OmegaND_      
%%OmegaKG_      
%%OmegaHG_      
%%OmegaCG_      
%%OmegaY_       
%%OmegaTC_      
%%OmegaWP_      
%%OmegaWC_      
%%OmegaKT_      
%%OmegaHLT_     
%%OmegaKLT_     
%%OmegaHLXT_    
%%OmegaT_       
%%OmegaKNT_     
%%OmegaHLNT_    
%%OmegaKLNT_    
%%OmegaHLXNT_   
%%OmegaNT_      
%%OmegaKW_      
%%OmegaHLW_     
%%OmegaKLW_     
%%OmegaHLXW_    
%%OmegaW_       

//stationary processes: parameters fixedd across countries
//note that the processes of beta and ROW are defined manually (not by transformation engine)
logit_rhoGN          ,logit_rhoGN          , , ,NORMAL_PDF   ,0    ,1.1  ;   sigmaGN          ,sigmaGN          , , ,INV_GAMMA_PDF ,0.005 ,0.1;    GN_           ,GN_          ,      ,      ,GAMMA_PDF  ,1.013   ,0.01, 1;
logit_rhoZ           ,logit_rhoZ           , , ,NORMAL_PDF   ,0    ,1.1  ;   sigmaZ           ,sigmaZ           , , ,INV_GAMMA_PDF ,0.005 ,0.1;  %%Z_                                                            
logit_rhodeltaItilde ,logit_rhodeltaItilde , , ,NORMAL_PDF   ,0    ,1.1  ;   sigmadeltaItilde ,sigmadeltaItilde , , ,INV_GAMMA_PDF ,0.005 ,0.1;    deltaItilde_  ,deltaItilde_ ,      ,      ,GAMMA_PDF  ,0.01   ,0.005   ;
logit_rhoscriptFI    ,logit_rhoscriptFI    , , ,NORMAL_PDF   ,0    ,1.1  ;   sigmascriptFI    ,sigmascriptFI    , , ,INV_GAMMA_PDF ,0.005 ,0.1;    scriptFI_     ,scriptFI_    ,      ,      ,GAMMA_PDF  ,5      ,5       ;
logit_rhodeltaD      ,logit_rhodeltaD      , , ,NORMAL_PDF   ,0    ,1.1  ;   sigmadeltaD      ,sigmadeltaD      , , ,INV_GAMMA_PDF ,0.005 ,0.1;    deltaD_       ,deltaD_      ,0.001 ,0.999 ,BETA_PDF   ,0.05   ,0.025   ;
logit_rhokappa0      ,logit_rhokappa0      , , ,NORMAL_PDF   ,0    ,1.1  ;   sigmakappa0      ,sigmakappa0      , , ,INV_GAMMA_PDF ,0.005 ,0.1;    kappa0_       ,kappa0_      ,      ,      ,NORMAL_PDF ,0      ,0.1     ;
logit_rhokappah      ,logit_rhokappah      , , ,NORMAL_PDF   ,0    ,1.1  ;   sigmakappah      ,sigmakappah      , , ,INV_GAMMA_PDF ,0.005 ,0.1;    kappah_       ,kappah_      ,      ,      ,GAMMA_PDF  ,1      ,0.1     ;
@#for S in Sectors2                                                                                                                                                                                            
logit_rhokappa@{S}   ,logit_rhokappa@{S}   , , ,NORMAL_PDF   ,0    ,1.1  ;   sigmakappa@{S}   ,sigmakappa@{S}   , , ,INV_GAMMA_PDF ,0.005 ,0.1;    kappa@{S}_    ,kappa@{S}_  ,      ,      ,GAMMA_PDF  ,1      ,0.1     ;
@#endfor
rhodeltaK      ,rhodeltaK      ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;  sigmadeltaK      ,sigmadeltaK      , , ,INV_GAMMA_PDF ,0.005 ,0.1;    deltaK_      ,deltaK_       ,0.001 ,0.999 ,BETA_PDF   ,0.1    ,0.05;
rhodeltaH      ,rhodeltaH      ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;  sigmadeltaH      ,sigmadeltaH      , , ,INV_GAMMA_PDF ,0.005 ,0.1;    deltaH_      ,deltaH_       ,0.001 ,0.999 ,BETA_PDF   ,0.0228 ,0.0128;
rhobeta        ,rhobeta        ,0.0001 ,0.9999 ,BETA_PDF ,0.5 ,0.05^0.5;  sigmabeta        ,sigmabeta        , , ,INV_GAMMA_PDF ,0.005 ,0.1;    betabarb     ,betabarb      ,0.001 ,0.999 ,BETA_PDF   ,0.89   ,0.005;
rhoPP0  ,rhoPP0  ,  ,0.999 ,BETA_PDF      ,0.5   ,0.05^0.5;
rhoPY0  ,rhoPY0  ,  ,0.999 ,BETA_PDF      ,0.5   ,0.05^0.5;
rhoYP0  ,rhoYP0  ,  ,0.999 ,BETA_PDF      ,0.5   ,0.05^0.5;
rhoYY0  ,rhoYY0  ,  ,0.999 ,BETA_PDF      ,0.5   ,0.05^0.5;
rho0    ,rho0    ,  ,0.999 ,BETA_PDF      ,0.5   ,0.05^0.5;
sigmaY0 ,sigmaY0 ,  ,      ,INV_GAMMA_PDF ,0.005 ,0.1;
sigmaP0 ,sigmaP0 ,  ,      ,INV_GAMMA_PDF ,0.005 ,0.1;
pT0     ,pT0     ,  ,      ,GAMMA_PDF     ,1     ,0.5;
yTC0    ,yTC0    ,  ,      ,GAMMA_PDF     ,1     ,0.5;

//RW: fixedd across countries except the SS of population shares
sigmam             ,sigmam            , , ,INV_GAMMA_PDF ,0.005 ,0.1;    m_            ,m_             ,0.001  ,0.999  ,uniform_pdf ,0.5  ,(1/12)^(0.5);        
sigmavarpi         ,sigmavarpi        , , ,INV_GAMMA_PDF ,0.005 ,0.1;    varpi_        ,varpi_         ,0.001  ,0.999  ,BETA_PDF    ,0.5  ,0.05^0.5;    
sigmaeT0           ,sigmaeT0          , , ,INV_GAMMA_PDF ,0.005 ,0.1;    eT0_          ,eT0_           ,       ,       ,GAMMA_PDF   ,1    ,0.5;      
sigmaalpha_resid   ,sigmaalpha_resid  , , ,INV_GAMMA_PDF ,0.005 ,0.1;    alpha_resid_  ,alpha_resid_   ,0.0001 ,0.9999 ,BETA_pdf    ,0.25 ,0.05;
sigmaalpha_pubedu  ,sigmaalpha_pubedu , , ,INV_GAMMA_PDF ,0.005 ,0.1;    alpha_pubedu_ ,alpha_pubedu_  ,0.0001 ,0.9999 ,BETA_pdf    ,0.0615 ,0.01;
sigmaNtilde        ,sigmaNtilde       , , ,INV_GAMMA_PDF ,0.005 ,0.1;  %%Ntilde1_       Ntilde2_             

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                       //
//                                              hierarchical priors                                                      //
//                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//nuPriorALL     ,  nuPriorALL      , , , GAMMA_PDF, 1, 0.1616*2;
//nuPriorS0ALL   ,  nuPriorS0ALL    , , , GAMMA_PDF, 1, 0.1616;
//nuPriorSS0ALL  ,  nuPriorSS0ALL   , , , GAMMA_PDF, 1, 0.1616;
//nuPriorS1ALL   ,  nuPriorS1ALL    , , , GAMMA_PDF, 1, 0.1616;
//nuPriorWALL    ,  nuPriorWALL     , , , GAMMA_PDF, 2, 0.1616;
//nuPriorTALL    ,  nuPriorTALL     , , , GAMMA_PDF, 2, 0.1616;
//nuPriorNTALL   ,  nuPriorNTALL    , , , GAMMA_PDF, 2, 0.1616;
//nuPriorDi      ,  nuPriorDi       , , , GAMMA_PDF, 2, 0.1616;
//nuPriorNDCGi   ,  nuPriorNDCGi    , , , GAMMA_PDF, 2, 0.1616;
//nuPriorKi      ,  nuPriorKi       , , , GAMMA_PDF, 2, 0.1616;
//nuPriorHi      ,  nuPriorHi       , , , GAMMA_PDF, 2, 0.1616;
//nuPriorhi      ,  nuPriorhi       , , , GAMMA_PDF, 2, 0.3619;
//
//eKLTPriori   ,eKLTPriori     , , ,GAMMA_PDF ,1 ,0.2194;
//eHLXTPriori  ,eHLXTPriori    , , ,GAMMA_PDF ,1 ,0.2194;
//eYTPriori    ,eYTPriori      , , ,GAMMA_PDF ,1 ,0.2194;
//eKLNTPriori  ,eKLNTPriori    , , ,GAMMA_PDF ,1 ,0.2194;
//eHLXNTPriori ,eHLXNTPriori   , , ,GAMMA_PDF ,1 ,0.2194;
//eYNTPriori   ,eYNTPriori     , , ,GAMMA_PDF ,1 ,0.2194;
//eKLWPriori   ,eKLWPriori     , , ,GAMMA_PDF ,1 ,0.2194;
//eHLXWPriori  ,eHLXWPriori    , , ,GAMMA_PDF ,1 ,0.2194;
//eYWPriori    ,eYWPriori      , , ,GAMMA_PDF ,1 ,0.2194;
//eKLPriorALL  ,eKLPriorALL    , , ,GAMMA_PDF ,1 ,0.2194*2;
//eHLXPriorALL ,eHLXPriorALL   , , ,GAMMA_PDF ,1 ,0.2194*2;
//eYPriorALL   ,eYPriorALL     , , ,GAMMA_PDF ,1 ,0.2194*2;
//
//rhoOmegaPriorALL          ,rhoOmegaPriorALL          , , ,NORMAL_PDF ,0 ,1;           sigmaOmegaPriorALL        ,sigmaOmegaPriorALL         , , ,GAMMA_PDF     ,1      ,0.0397*2;
//rhoOmegaPriorS0ALL        ,rhoOmegaPriorS0ALL        , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorS0ALL      ,sigmaOmegaPriorS0ALL       , , ,GAMMA_PDF     ,1      ,0.0397*2;
//rhoOmegaPriorStepALL      ,rhoOmegaPriorStepALL      , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorStepALL    ,sigmaOmegaPriorStepALL     , , ,GAMMA_PDF     ,1      ,0.0397*2;
//rhoOmegaPriorS1ALL        ,rhoOmegaPriorS1ALL        , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorS1ALL      ,sigmaOmegaPriorS1ALL       , , ,GAMMA_PDF     ,1      ,0.0397*2;
//rhoOmegaPriorPGALL        ,rhoOmegaPriorPGALL        , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorPGALL      ,sigmaOmegaPriorPGALL       , , ,GAMMA_PDF     ,1      ,0.0397*2;
//rhoOmegaPriorALLi         ,rhoOmegaPriorALLi         , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorALLi       ,sigmaOmegaPriorALLi        , , ,INV_GAMMA_PDF ,0.0035 ,0.0399;
//rhoOmegaPriorS0ALLi       ,rhoOmegaPriorS0ALLi       , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorS0ALLi     ,sigmaOmegaPriorS0ALLi      , , ,INV_GAMMA_PDF ,0.0020 ,0.0399;
//rhoOmegaPriorTALLi        ,rhoOmegaPriorTALLi        , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorTALLi      ,sigmaOmegaPriorTALLi       , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorNTALLi       ,rhoOmegaPriorNTALLi       , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorNTALLi     ,sigmaOmegaPriorNTALLi      , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorWALLi        ,rhoOmegaPriorWALLi        , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorWALLi      ,sigmaOmegaPriorWALLi       , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorKKALLi       ,rhoOmegaPriorKKALLi       , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorKKALLi     ,sigmaOmegaPriorKKALLi      , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorHLALLi       ,rhoOmegaPriorHLALLi       , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorHLALLi     ,sigmaOmegaPriorHLALLi      , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorKLALLi       ,rhoOmegaPriorKLALLi       , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorKLALLi     ,sigmaOmegaPriorKLALLi      , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorHLXALLi      ,rhoOmegaPriorHLXALLi      , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorHLXALLi    ,sigmaOmegaPriorHLXALLi     , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorHLXKLALLi    ,rhoOmegaPriorHLXKLALLi    , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorHLXKLALLi  ,sigmaOmegaPriorHLXKLALLi   , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorS1ALLi       ,rhoOmegaPriorS1ALLi       , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorS1ALLi     ,sigmaOmegaPriorS1ALLi      , , ,INV_GAMMA_PDF ,0.0020 ,0.0399;
//rhoOmegaPriorKALLi        ,rhoOmegaPriorKALLi        , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorKALLi      ,sigmaOmegaPriorKALLi       , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorHALLi        ,rhoOmegaPriorHALLi        , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorHALLi      ,sigmaOmegaPriorHALLi       , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorCALLi        ,rhoOmegaPriorCALLi        , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorCALLi      ,sigmaOmegaPriorCALLi       , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorDii          ,rhoOmegaPriorDii          , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorDii        ,sigmaOmegaPriorDii         , , ,INV_GAMMA_PDF ,0.0020 ,0.0399;
//rhoOmegaPriorPALLi        ,rhoOmegaPriorPALLi        , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorPALLi      ,sigmaOmegaPriorPALLi       , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorGALLi        ,rhoOmegaPriorGALLi        , , ,NORMAL_PDF ,0 ,0.2;         sigmaOmegaPriorGALLi      ,sigmaOmegaPriorGALLi       , , ,INV_GAMMA_PDF ,0.0020 ,0.0397;
//rhoOmegaPriorDemandALLi   ,rhoOmegaPriorDemandALLi   , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorDemandALLi ,sigmaOmegaPriorDemandALLi  , , ,INV_GAMMA_PDF ,0.0025 ,0.0399;
//rhoOmegaPriorhii          ,rhoOmegaPriorhii          , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorhii        ,sigmaOmegaPriorhii         , , ,INV_GAMMA_PDF ,0.0035 ,0.0399;
//rhoOmegaPriorCPii         ,rhoOmegaPriorCPii         , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorCPii       ,sigmaOmegaPriorCPii        , , ,INV_GAMMA_PDF ,0.0025 ,0.0399;
//rhoOmegaPriorCii          ,rhoOmegaPriorCii          , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorCii        ,sigmaOmegaPriorCii         , , ,INV_GAMMA_PDF ,0.0025 ,0.0399;
//rhoOmegaPriorTradeALLi    ,rhoOmegaPriorTradeALLi    , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorTradeALLi  ,sigmaOmegaPriorTradeALLi   , , ,INV_GAMMA_PDF ,0.0025 ,0.0399;
//rhoOmegaPriorYii          ,rhoOmegaPriorYii          , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorYii        ,sigmaOmegaPriorYii         , , ,INV_GAMMA_PDF ,0.0035 ,0.0399;
//rhoOmegaPriorTCii         ,rhoOmegaPriorTCii         , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorTCii       ,sigmaOmegaPriorTCii        , , ,INV_GAMMA_PDF ,0.0025 ,0.0399;
//rhoOmegaPriorWPii         ,rhoOmegaPriorWPii         , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorWPii       ,sigmaOmegaPriorWPii        , , ,INV_GAMMA_PDF ,0.0025 ,0.0399;
//rhoOmegaPriorWCii         ,rhoOmegaPriorWCii         , , ,NORMAL_PDF ,0 ,0.5;         sigmaOmegaPriorWCii       ,sigmaOmegaPriorWCii        , , ,INV_GAMMA_PDF ,0.0035 ,0.0399;
//
//phiLtauSG1PriorALL ,phiLtauSG1PriorALL   , , ,NORMAL_PDF ,0 ,0.2236*2;
//phiLtaulbPriorALL  ,phiLtaulbPriorALL    , , ,NORMAL_PDF ,0 ,0.2236*2;
//phiLtauKGPriori    ,phiLtauKGPriori      , , ,NORMAL_PDF ,0 ,0.2236;
//phiLtauHGPriori    ,phiLtauHGPriori      , , ,NORMAL_PDF ,0 ,0.2236;
//phiLtauCGPriori    ,phiLtauCGPriori      , , ,NORMAL_PDF ,0 ,0.2236;
//phiLtaubPriori     ,phiLtaubPriori       , , ,NORMAL_PDF ,0 ,0.2236;
//phiLtaulPriori     ,phiLtaulPriori       , , ,NORMAL_PDF ,0 ,0.2236;
//
//phiYtauSG1PriorALL ,phiYtauSG1PriorALL   , , ,NORMAL_PDF ,0 ,0.2236*2;
//phiYtaulbPriorALL  ,phiYtaulbPriorALL    , , ,NORMAL_PDF ,0 ,0.2236*2;                                                            
//phiYtauKGPriori    ,phiYtauKGPriori      , , ,NORMAL_PDF ,0 ,0.2236;
//phiYtauHGPriori    ,phiYtauHGPriori      , , ,NORMAL_PDF ,0 ,0.2236;
//phiYtauCGPriori    ,phiYtauCGPriori      , , ,NORMAL_PDF ,0 ,0.2236;
//phiYtaubPriori     ,phiYtaubPriori       , , ,NORMAL_PDF ,0 ,0.2236;
//phiYtaulPriori     ,phiYtaulPriori       , , ,NORMAL_PDF ,0 ,0.2236;
//
//phiutauSG1PriorALL ,phiutauSG1PriorALL   , , ,NORMAL_PDF ,0 ,0.2236*2;
//phiutauKGPriori    ,phiutauKGPriori      , , ,NORMAL_PDF ,0 ,0.2236;
//phiutauHGPriori    ,phiutauHGPriori      , , ,NORMAL_PDF ,0 ,0.2236;
//phiutauCGPriori    ,phiutauCGPriori      , , ,NORMAL_PDF ,0 ,0.2236;
//phiutauPriorALL    ,phiutauPriorALL      , , ,NORMAL_PDF ,0 ,0.1667*2;       
//phiuiotaPriorALL   ,phiuiotaPriorALL     , , ,NORMAL_PDF ,0 ,0.1667*2;             
//phiutaulbPriorALL  ,phiutaulbPriorALL    , , ,NORMAL_PDF ,0 ,0.1667*2;             
//phiutauCPriorALL   ,phiutauCPriorALL     , , ,NORMAL_PDF ,0 ,0.1667*2;             
//phiutauLPriorALL   ,phiutauLPriorALL     , , ,NORMAL_PDF ,0 ,0.1667*2;             
//phiutauHPriorALL   ,phiutauHPriorALL     , , ,NORMAL_PDF ,0 ,0.1667*2;             
//phiutauKPriorALL   ,phiutauKPriorALL     , , ,NORMAL_PDF ,0 ,0.1667*2;             
//phiutauXPriorALL   ,phiutauXPriorALL     , , ,NORMAL_PDF ,0 ,0.1667*2;             
//phiutauWPriorALL   ,phiutauWPriorALL     , , ,NORMAL_PDF ,0 ,0.1667;             
//phiutauTPriorALL   ,phiutauTPriorALL     , , ,NORMAL_PDF ,0 ,0.1667;             
//phiutauNTPriorALL  ,phiutauNTPriorALL    , , ,NORMAL_PDF ,0 ,0.1667;         
//phiuiotaTXPriori   ,phiuiotaTXPriori     , , ,NORMAL_PDF ,0 ,0.1667;          
//phiuiotaTMPriori   ,phiuiotaTMPriori     , , ,NORMAL_PDF ,0 ,0.1667;          
//phiuiotaWXPriori   ,phiuiotaWXPriori     , , ,NORMAL_PDF ,0 ,0.1667;          
//phiuiotaWMPriori   ,phiuiotaWMPriori     , , ,NORMAL_PDF ,0 ,0.1667;         
//phiutaubPriori     ,phiutaubPriori       , , ,NORMAL_PDF ,0 ,0.1667;          
//phiutaulPriori     ,phiutaulPriori       , , ,NORMAL_PDF ,0 ,0.1667;          
//phiutauDPriori     ,phiutauDPriori       , , ,NORMAL_PDF ,0 ,0.1667;          
//phiutauNDPriori    ,phiutauNDPriori      , , ,NORMAL_PDF ,0 ,0.1667;          
//phiutauNTPriori    ,phiutauNTPriori      , , ,NORMAL_PDF ,0 ,0.3726;          
//phiutauLaPriori    ,phiutauLaPriori      , , ,NORMAL_PDF ,0 ,0.1667;   
//phiutauLbPriori    ,phiutauLbPriori      , , ,NORMAL_PDF ,0 ,0.1667;   
//
//phiiotaPriorALL    ,phiiotaPriorALL      ,       ,       ,NORMAL_PDF   ,0     ,1.3;
//phitauCPriorALL    ,phitauCPriorALL      ,       ,       ,NORMAL_PDF   ,0     ,1.3;
//phiiotaTXPriori    ,phiiotaTXPriori      ,       ,       ,NORMAL_PDF   ,0     ,0.5; 
//phiiotaTMPriori    ,phiiotaTMPriori      ,       ,       ,NORMAL_PDF   ,0     ,0.5; 
//phiiotaWXPriori    ,phiiotaWXPriori      ,       ,       ,NORMAL_PDF   ,0     ,0.5; 
//phiiotaWMPriori    ,phiiotaWMPriori      ,       ,       ,NORMAL_PDF   ,0     ,0.5; 
//phitauDPriori      ,phitauDPriori        ,       ,       ,NORMAL_PDF   ,0     ,0.5; 
//phitauNDPriori     ,phitauNDPriori       ,       ,       ,NORMAL_PDF   ,0     ,0.5; 
//phitauHPriorALL    ,phitauHPriorALL      ,       ,       ,NORMAL_PDF   ,0     ,1.2; 
//phitauKPriorALL    ,phitauKPriorALL      ,       ,       ,NORMAL_PDF   ,0     ,1.2; 
//phitauXPriorALL    ,phitauXPriorALL      ,       ,       ,NORMAL_PDF   ,0     ,1.2; 
//phitauWPriorALL    ,phitauWPriorALL      ,       ,       ,NORMAL_PDF   ,0     ,1.2; 
//phitauTPriorALL    ,phitauTPriorALL      ,       ,       ,NORMAL_PDF   ,0     ,1.2; 
//phitauNTPriorALL   ,phitauNTPriorALL     ,       ,       ,NORMAL_PDF   ,0     ,1.2; 
//
//tauSG1PriorALL_    ,tauSG1PriorALL_      , , ,NORMAL_PDF ,-1   ,0.6;
//tauKGPriori_       ,tauKGPriori_         , , ,NORMAL_PDF ,-0.5 ,0.3;
//tauHGPriori_       ,tauHGPriori_         , , ,NORMAL_PDF ,-0.5 ,0.3;
//tauCGPriori_       ,tauCGPriori_         , , ,NORMAL_PDF ,-0.5 ,0.3;
//tauPriorALL_       ,tauPriorALL_         , , ,NORMAL_PDF ,0    ,0.02;
//taulbPriorALL_     ,taulbPriorALL_       , , ,NORMAL_PDF ,0    ,0.0693;
//tauCPriorALL_      ,tauCPriorALL_        , , ,NORMAL_PDF ,0    ,0.0693;
//tauLPriorALL_      ,tauLPriorALL_        , , ,NORMAL_PDF ,0    ,0.0693;
//tauHPriorALL_      ,tauHPriorALL_        , , ,NORMAL_PDF ,0    ,0.0693;
//tauKPriorALL_      ,tauKPriorALL_        , , ,NORMAL_PDF ,0    ,0.0693;
//tauXPriorALL_      ,tauXPriorALL_        , , ,NORMAL_PDF ,0    ,0.0693;
//tauWPriorALL_      ,tauWPriorALL_        , , ,NORMAL_PDF ,0    ,0.0693;
//tauTPriorALL_      ,tauTPriorALL_        , , ,NORMAL_PDF ,0    ,0.0693;
//tauNTPriorALL_     ,tauNTPriorALL_       , , ,NORMAL_PDF ,0    ,0.0693;
//taubPriori_        ,taubPriori_          , , ,NORMAL_PDF ,0    ,0.0693;
//taulPriori_        ,taulPriori_          , , ,NORMAL_PDF ,0    ,0.0693;
//tauDPriori_        ,tauDPriori_          , , ,NORMAL_PDF ,0    ,0.0693;
//tauNDPriori_       ,tauNDPriori_         , , ,NORMAL_PDF ,0    ,0.0693;
//tauNTPriori_       ,tauNTPriori_         , , ,NORMAL_PDF ,0    ,0.0980;
//tauLaPriori_       ,tauLaPriori_         , , ,NORMAL_PDF ,0    ,0.0693;
//tauLbPriori_       ,tauLbPriori_         , , ,NORMAL_PDF ,-2.3 ,0.6;
//
//sigmauPriorALL         ,sigmauPriorALL      , , ,GAMMA_PDF     ,1     ,0.0199*4;
//sigmauSG1PriorALL      ,sigmauSG1PriorALL   , , ,GAMMA_PDF     ,1     ,0.0199*2;
//sigmaulbPriorALL       ,sigmaulbPriorALL    , , ,GAMMA_PDF     ,1     ,0.0199*2;
//sigmauCPriorALL        ,sigmauCPriorALL     , , ,GAMMA_PDF     ,1     ,0.0199*2;
//sigmauiotaPriorALL     ,sigmauiotaPriorALL  , , ,GAMMA_PDF     ,1     ,0.0199*2;
//sigmauLPriorALL        ,sigmauLPriorALL     , , ,GAMMA_PDF     ,1     ,0.0199*2;
//sigmauPriorHKXALL      ,sigmauPriorHKXALL   , , ,GAMMA_PDF     ,1     ,0.0199*2;
//sigmauPriorS0ALL       ,sigmauPriorS0ALL    , , ,GAMMA_PDF     ,1     ,0.0199*2;
//sigmauKGPriori         ,sigmauKGPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauHGPriori         ,sigmauHGPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauCGPriori         ,sigmauCGPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmaubPriori          ,sigmaubPriori       , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmaulPriori          ,sigmaulPriori       , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauDPriori          ,sigmauDPriori       , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauNDPriori         ,sigmauNDPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauNTPriori         ,sigmauNTPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauTXPriori         ,sigmauTXPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauTMPriori         ,sigmauTMPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauWXPriori         ,sigmauWXPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauWMPriori         ,sigmauWMPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauLaPriori         ,sigmauLaPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauLbPriori         ,sigmauLbPriori      , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauALLPriori        ,sigmauALLPriori     , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauS1ALLPriori      ,sigmauS1ALLPriori   , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauiotaALLPriori    ,sigmauiotaALLPriori , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmaulbALLPriori      ,sigmaulbALLPriori   , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauCALLPriori       ,sigmauCALLPriori    , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauLALLPriori       ,sigmauLALLPriori    , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauHALLPriori       ,sigmauHALLPriori    , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauKALLPriori       ,sigmauKALLPriori    , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauXALLPriori       ,sigmauXALLPriori    , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauTALLPriori       ,sigmauTALLPriori    , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauNTALLPriori      ,sigmauNTALLPriori   , , ,INV_GAMMA_PDF ,0.001 ,0.0199;
//sigmauWALLPriori       ,sigmauWALLPriori    , , ,INV_GAMMA_PDF ,0.001 ,0.0199;

@#for n in 1:151
    InternalPrior_@{n} ,InternalPrior_@{n} , , ,normal_pdf ,0 ,1;
@#endfor
@#endif
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                       //
//                                              declare observables                                                      //
//                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
varobs
gryW gpopW
  @#for n in 1:SN-1
	yshare@{n}
  @#endfor
  @#for n in 1:SN
	popshare@{n}
  @#endfor
OECDihy1 ESrdy1 BEAcy1  JSTiy1  BEAgcy1  BEAgiy1  JSTxy1  BEAgpcgpy1  BEAgpigpy1  BEAgpgcgpy1 BEAgpgigpy1 BEAgpxgpy1  BEAgpmgpy1  BEAhpop1   BEAwhy1   BEAcfcy1  JSTexpostr1  FREDlrni1 JSTtauy1
OECDihy2 ESrdy2 PWTcy2  JSTiy2  JSTgy2            JSTxy2  PWTgpcgpy2  PWTgpigpy2  PWTgpgcgpy2             PWTgpxgpy2  PWTgpmgpy2  PWThpop2   PWTwhy2   PWTdelta2 JSTexpostr2  DBlrni2   JSTtauy2
OECDihy3 ESrdy3 MILLcy3 MILLiy3 MILLgcy3 MILLgiy3 MILLxy3 MILLgpcgpy3 MILLgpigpy3 MILLgpgcgpy3            MILLgpxgpy3 MILLgpmgpy3 MILLhpop3  MILLwhy3  MILLcfcy3 MILLexpostr3 MILLlrni3 MILLtauy3
OECDihy4 ESrdy4 PWTcy4  JSTiy4  JSTgy4            JSTxy4  PWTgpcgpy4  PWTgpigpy4  PWTgpgcgpy4             PWTgpxgpy4  PWTgpmgpy4  PWThpop4   PWTwhy4   PWTdelta4 JSTexpostr4  BDFlrni4  JSTtauy4
OECDihy5 ESrdy5 PWTcy5  JSTiy5  JSTgy5            JSTxy5  PWTgpcgpy5  PWTgpigpy5  PWTgpgcgpy5             PWTgpxgpy5  PWTgpmgpy5  PWThpop5   PWTwhy5   PWTcfcy5  JSTexpostr5            JSTtauy5
OECDihy6 ESrdy6 PWTcy6  JSTiy6  JSTgy6            JSTxy6  PWTgpcgpy6  PWTgpigpy6  PWTgpgcgpy6             PWTgpxgpy6  PWTgpmgpy6  PWThpop6   PWTwhy6   PWTcfcy6  JSTexpostr6            JSTtauy6
;