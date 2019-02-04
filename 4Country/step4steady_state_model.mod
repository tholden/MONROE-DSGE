//any parameter (MLV not included) that is equations of other parameters must be shown here.
//otherwise dynare will not update them during estimation.
//those comment out by %% have hierarchical structures but are not estimated
//in simulation, if we give values to final parameters (using the calibration mod file) but not to the underlying parameters, we should comment out hierarchical equations

rhoGN          = 1 / ( 1 + exp(-logit_rhoGN          ));
rhoZ           = 1 / ( 1 + exp(-logit_rhoZ           ));
rhodeltaItilde = 1 / ( 1 + exp(-logit_rhodeltaItilde ));
rhoscriptFI    = 1 / ( 1 + exp(-logit_rhoscriptFI    ));
rhodeltaD      = 1 / ( 1 + exp(-logit_rhodeltaD      ));
rhokappa0      = 1 / ( 1 + exp(-logit_rhokappa0      ));
rhokappah      = 1 / ( 1 + exp(-logit_rhokappah      ));
rhokappaT      = 1 / ( 1 + exp(-logit_rhokappaT      ));
rhokappaNT     = 1 / ( 1 + exp(-logit_rhokappaNT     ));
rhokappaW      = 1 / ( 1 + exp(-logit_rhokappaW      ));
rhokappaST     = 1 / ( 1 + exp(-logit_rhokappaST     ));
rhokappaSNT    = 1 / ( 1 + exp(-logit_rhokappaSNT    ));
rhokappaSW     = 1 / ( 1 + exp(-logit_rhokappaSW     ));
rhokappaD      = 1 / ( 1 + exp(-logit_rhokappaD      ));
rhokappaNDCG   = 1 / ( 1 + exp(-logit_rhokappaNDCG   ));
rhokappaK      = 1 / ( 1 + exp(-logit_rhokappaK      ));
rhokappaH      = 1 / ( 1 + exp(-logit_rhokappaH      ));
alphaCP  = 1 / ( 1 + exp(-logit_alphaCP ));
alphaCD  = 1 / ( 1 + exp(-logit_alphaCD ));
alphah   = 1 / ( 1 + exp(-logit_alphah  ));
alphaKP  = 1 / ( 1 + exp(-logit_alphaKP ));
alphaHP  = 1 / ( 1 + exp(-logit_alphaHP ));
alphaD   = 1 / ( 1 + exp(-logit_alphaD  ));
alphaND  = 1 / ( 1 + exp(-logit_alphaND ));
alphaHW  = 1 / ( 1 + exp(-logit_alphaHW ));
alphaHL  = 1 / ( 1 + exp(-logit_alphaHL ));
alphaK   = 1 / ( 1 + exp(-logit_alphaK  ));
alphaKL  = 1 / ( 1 + exp(-logit_alphaKL ));
alphaHLX = 1 / ( 1 + exp(-logit_alphaHLX));
alphaY   = 1 / ( 1 + exp(-logit_alphaY  ));

//nuW    = nuPriorALL * nuPriorS0ALL  * nuPriorWALL   ;
//nuT    = nuPriorALL * nuPriorS0ALL  * nuPriorTALL   ;
//nuNT   = nuPriorALL * nuPriorS0ALL  * nuPriorNTALL  ;
//nuSW   = nuPriorALL * nuPriorSS0ALL * nuPriorWALL   ;
//nuST   = nuPriorALL * nuPriorSS0ALL * nuPriorTALL   ;
//nuSNT  = nuPriorALL * nuPriorSS0ALL * nuPriorNTALL  ;
//nuD    = nuPriorALL * nuPriorS1ALL  * nuPriorDi     ;
//nuNDCG = nuPriorALL * nuPriorS1ALL  * nuPriorNDCGi  ;
//nuK    = nuPriorALL * nuPriorS1ALL  * nuPriorKi     ;
//nuH    = nuPriorALL * nuPriorS1ALL  * nuPriorHi     ;
//nuh    = nuPriorALL                 * nuPriorhi     ;
//
//eKLT      =      eKLPriorALL     *   eKLTPriori    ;
//eHLXT     =      eHLXPriorALL    *   eHLXTPriori   ;
//eYT       =      eYPriorALL      *   eYTPriori     ;
//eKLNT     =      eKLPriorALL     *   eKLNTPriori   ;
//eHLXNT    =      eHLXPriorALL    *   eHLXNTPriori  ;
//eYNT      =      eYPriorALL      *   eYNTPriori    ;
//eKLW      =      eKLPriorALL     *   eKLWPriori    ;
//eHLXW     =      eHLXPriorALL    *   eHLXWPriori   ;
//eYW       =      eYPriorALL      *   eYWPriori     ;
//
//deltaKPT_  = 1 / ( 1 + exp( - deltaKPriorALL - deltaKPTPriori_  )); rhodeltaKPT  = 1 / ( 1 + exp( - rhodeltaKPriorALL - rhodeltaKPTPriori  ));    sigmadeltaKPT  = sigmadeltaKPriorALL * sigmadeltaKPTPriori  ;
//deltaKPNT_ = 1 / ( 1 + exp( - deltaKPriorALL - deltaKPNTPriori_ )); rhodeltaKPNT = 1 / ( 1 + exp( - rhodeltaKPriorALL - rhodeltaKPNTPriori ));    sigmadeltaKPNT = sigmadeltaKPriorALL * sigmadeltaKPNTPriori ;
//deltaKPW_  = 1 / ( 1 + exp( - deltaKPriorALL - deltaKPWPriori_  )); rhodeltaKPW  = 1 / ( 1 + exp( - rhodeltaKPriorALL - rhodeltaKPWPriori  ));    sigmadeltaKPW  = sigmadeltaKPriorALL * sigmadeltaKPWPriori  ;
//deltaKG_   = 1 / ( 1 + exp( - deltaKPriorALL - deltaKGPriori_   )); rhodeltaKG   = 1 / ( 1 + exp( - rhodeltaKPriorALL - rhodeltaKGPriori   ));    sigmadeltaKG   = sigmadeltaKPriorALL * sigmadeltaKGPriori   ;
//deltaHPT_  = 1 / ( 1 + exp( - deltaHPriorALL - deltaHPTPriori_  )); rhodeltaHPT  = 1 / ( 1 + exp( - rhodeltaHPriorALL - rhodeltaHPTPriori  ));    sigmadeltaHPT  = sigmadeltaHPriorALL * sigmadeltaHPTPriori  ;
//deltaHPNT_ = 1 / ( 1 + exp( - deltaHPriorALL - deltaHPNTPriori_ )); rhodeltaHPNT = 1 / ( 1 + exp( - rhodeltaHPriorALL - rhodeltaHPNTPriori ));    sigmadeltaHPNT = sigmadeltaHPriorALL * sigmadeltaHPNTPriori ;
//deltaHPW_  = 1 / ( 1 + exp( - deltaHPriorALL - deltaHPWPriori_  )); rhodeltaHPW  = 1 / ( 1 + exp( - rhodeltaHPriorALL - rhodeltaHPWPriori  ));    sigmadeltaHPW  = sigmadeltaHPriorALL * sigmadeltaHPWPriori  ;
//deltaHG_   = 1 / ( 1 + exp( - deltaHPriorALL - deltaHGPriori_   )); rhodeltaHG   = 1 / ( 1 + exp( - rhodeltaHPriorALL - rhodeltaHGPriori   ));    sigmadeltaHG   = sigmadeltaHPriorALL * sigmadeltaHGPriori   ;
//
//rhoOmegaALL      =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorALLi      ));     sigmaOmegaALL      =sigmaOmegaPriorALL *                             sigmaOmegaPriorALLi      ;
//rhoOmegaS0ALL    =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorS0ALLi    ));     sigmaOmegaS0ALL    =sigmaOmegaPriorALL *                             sigmaOmegaPriorS0ALLi    ;
//rhoOmegaTALL     =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorS0ALL     -  rhoOmegaPriorTALLi     ));     sigmaOmegaTALL     =sigmaOmegaPriorALL * sigmaOmegaPriorS0ALL     *  sigmaOmegaPriorTALLi     ;
//rhoOmegaNTALL    =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorS0ALL     -  rhoOmegaPriorNTALLi    ));     sigmaOmegaNTALL    =sigmaOmegaPriorALL * sigmaOmegaPriorS0ALL     *  sigmaOmegaPriorNTALLi    ;
//rhoOmegaWALL     =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorS0ALL     -  rhoOmegaPriorWALLi     ));     sigmaOmegaWALL     =sigmaOmegaPriorALL * sigmaOmegaPriorS0ALL     *  sigmaOmegaPriorWALLi     ;
//rhoOmegaKKALL    =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorStepALL   -  rhoOmegaPriorKKALLi    ));     sigmaOmegaKKALL    =sigmaOmegaPriorALL * sigmaOmegaPriorStepALL   *  sigmaOmegaPriorKKALLi    ;
//rhoOmegaHLALL    =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorStepALL   -  rhoOmegaPriorHLALLi    ));     sigmaOmegaHLALL    =sigmaOmegaPriorALL * sigmaOmegaPriorStepALL   *  sigmaOmegaPriorHLALLi    ;
//rhoOmegaKLALL    =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorStepALL   -  rhoOmegaPriorKLALLi    ));     sigmaOmegaKLALL    =sigmaOmegaPriorALL * sigmaOmegaPriorStepALL   *  sigmaOmegaPriorKLALLi    ;
//rhoOmegaHLXALL   =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorStepALL   -  rhoOmegaPriorHLXALLi   ));     sigmaOmegaHLXALL   =sigmaOmegaPriorALL * sigmaOmegaPriorStepALL   *  sigmaOmegaPriorHLXALLi   ;
//rhoOmegaHLXKLALL =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorStepALL   -  rhoOmegaPriorHLXKLALLi ));     sigmaOmegaHLXKLALL =sigmaOmegaPriorALL * sigmaOmegaPriorStepALL   *  sigmaOmegaPriorHLXKLALLi ;
//rhoOmegaS1ALL    =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorS1ALLi    ));     sigmaOmegaS1ALL    =sigmaOmegaPriorALL *                             sigmaOmegaPriorS1ALLi    ;
//rhoOmegaKALL     =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorS1ALL     -  rhoOmegaPriorKALLi     ));     sigmaOmegaKALL     =sigmaOmegaPriorALL * sigmaOmegaPriorS1ALL     *  sigmaOmegaPriorKALLi     ;
//rhoOmegaHALL     =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorS1ALL     -  rhoOmegaPriorHALLi     ));     sigmaOmegaHALL     =sigmaOmegaPriorALL * sigmaOmegaPriorS1ALL     *  sigmaOmegaPriorHALLi     ;
//rhoOmegaCALL     =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorS1ALL     -  rhoOmegaPriorCALLi     ));     sigmaOmegaCALL     =sigmaOmegaPriorALL * sigmaOmegaPriorS1ALL     *  sigmaOmegaPriorCALLi     ;
//rhoOmegaDi       =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorDii       ));     sigmaOmegaDi       =sigmaOmegaPriorALL *                             sigmaOmegaPriorDii       ;
//rhoOmegaPALL     =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorPGALL     -  rhoOmegaPriorPALLi     ));     sigmaOmegaPALL     =sigmaOmegaPriorALL * sigmaOmegaPriorPGALL     *  sigmaOmegaPriorPALLi     ;
//rhoOmegaGALL     =1 / ( 1 + exp( - rhoOmegaPriorALL - rhoOmegaPriorPGALL     -  rhoOmegaPriorGALLi     ));     sigmaOmegaGALL     =sigmaOmegaPriorALL * sigmaOmegaPriorPGALL     *  sigmaOmegaPriorGALLi     ;
//rhoOmegaDemandALL=1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorDemandALLi));     sigmaOmegaDemandALL=sigmaOmegaPriorALL *                             sigmaOmegaPriorDemandALLi;
//rhoOmegahi       =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorhii       ));     sigmaOmegahi       =sigmaOmegaPriorALL *                             sigmaOmegaPriorhii       ;
//rhoOmegaCPi      =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorCPii      ));     sigmaOmegaCPi      =sigmaOmegaPriorALL *                             sigmaOmegaPriorCPii      ;
//rhoOmegaCi       =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorCii       ));     sigmaOmegaCi       =sigmaOmegaPriorALL *                             sigmaOmegaPriorCii       ;
//rhoOmegaTradeALL =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorTradeALLi ));     sigmaOmegaTradeALL =sigmaOmegaPriorALL *                             sigmaOmegaPriorTradeALLi ;
//rhoOmegaYi       =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorYii       ));     sigmaOmegaYi       =sigmaOmegaPriorALL *                             sigmaOmegaPriorYii       ;
//rhoOmegaTCi      =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorTCii      ));     sigmaOmegaTCi      =sigmaOmegaPriorALL *                             sigmaOmegaPriorTCii      ;
//rhoOmegaWPi      =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorWPii      ));     sigmaOmegaWPi      =sigmaOmegaPriorALL *                             sigmaOmegaPriorWPii      ;
//rhoOmegaWCi      =1 / ( 1 + exp( - rhoOmegaPriorALL -                           rhoOmegaPriorWCii      ));     sigmaOmegaWCi      =sigmaOmegaPriorALL *                             sigmaOmegaPriorWCii      ;
//
//phiLtauKG = phiLtauSG1PriorALL + phiLtauKGPriori ;
//phiLtauHG = phiLtauSG1PriorALL + phiLtauHGPriori ;
//phiLtauCG = phiLtauSG1PriorALL + phiLtauCGPriori ;
//phiLtaub  = phiLtaulbPriorALL  + phiLtaubPriori  ;
//phiLtaul  = phiLtaulbPriorALL  + phiLtaulPriori  ;
//
//phiYtauKG = phiYtauSG1PriorALL + phiYtauKGPriori ;
//phiYtauHG = phiYtauSG1PriorALL + phiYtauHGPriori ;
//phiYtauCG = phiYtauSG1PriorALL + phiYtauCGPriori ;
//phiYtaub  = phiYtaulbPriorALL  + phiYtaubPriori  ;
//phiYtaul  = phiYtaulbPriorALL  + phiYtaulPriori  ;
//
//phiuiotaTX   =  phiutauPriorALL     +   phiuiotaPriorALL    + phiuiotaTXPriori   ;
//phiuiotaTM   =  phiutauPriorALL     +   phiuiotaPriorALL    + phiuiotaTMPriori   ;
//phiuiotaWX   =  phiutauPriorALL     +   phiuiotaPriorALL    + phiuiotaWXPriori   ;
//phiuiotaWM   =  phiutauPriorALL     +   phiuiotaPriorALL    + phiuiotaWMPriori   ;
//phiutauKG    =                          phiutauSG1PriorALL  + phiutauKGPriori    ;
//phiutauHG    =                          phiutauSG1PriorALL  + phiutauHGPriori    ;
//phiutauCG    =                          phiutauSG1PriorALL  + phiutauCGPriori    ;
//phiutaub     =  phiutauPriorALL     +   phiutaulbPriorALL   + phiutaubPriori     ;
//phiutaul     =  phiutauPriorALL     +   phiutaulbPriorALL   + phiutaulPriori     ;
//phiutauD     =  phiutauPriorALL     +   phiutauCPriorALL    + phiutauDPriori     ;
//phiutauND    =  phiutauPriorALL     +   phiutauCPriorALL    + phiutauNDPriori    ;
//phiutauNT    =  phiutauPriorALL     +                       + phiutauNTPriori    ;
//phiutauLa    =  phiutauPriorALL     +   phiutauLPriorALL    + phiutauLaPriori    ;
//phiutauLb    =  phiutauPriorALL     +   phiutauLPriorALL    + phiutauLbPriori    ;
//phiutauHW    =  phiutauPriorALL     +   phiutauHPriorALL    + phiutauWPriorALL   ;
//phiutauHT    =  phiutauPriorALL     +   phiutauHPriorALL    + phiutauTPriorALL   ;
//phiutauHNT   =  phiutauPriorALL     +   phiutauHPriorALL    + phiutauNTPriorALL  ;
//phiutauKW    =  phiutauPriorALL     +   phiutauKPriorALL    + phiutauWPriorALL   ;
//phiutauKT    =  phiutauPriorALL     +   phiutauKPriorALL    + phiutauTPriorALL   ;
//phiutauKNT   =  phiutauPriorALL     +   phiutauKPriorALL    + phiutauNTPriorALL  ;
//phiutauXW    =  phiutauPriorALL     +   phiutauXPriorALL    + phiutauWPriorALL   ;
//phiutauXT    =  phiutauPriorALL     +   phiutauXPriorALL    + phiutauTPriorALL   ;
//phiutauXNT   =  phiutauPriorALL     +   phiutauXPriorALL    + phiutauNTPriorALL  ;
//
//phiiotaTX       = 1 / ( 1 + exp( - phiiotaPriorALL - phiiotaTXPriori ))     ;
//phiiotaTM       = 1 / ( 1 + exp( - phiiotaPriorALL - phiiotaTMPriori ))     ;
//phiiotaWX       = 1 / ( 1 + exp( - phiiotaPriorALL - phiiotaWXPriori ))     ;
//phiiotaWM       = 1 / ( 1 + exp( - phiiotaPriorALL - phiiotaWMPriori ))     ;
//phitauD         = 1 / ( 1 + exp( - phitauCPriorALL - phitauDPriori   ))     ;
//phitauND        = 1 / ( 1 + exp( - phitauCPriorALL - phitauNDPriori  ))     ;
//phitauHW        = 1 / ( 1 + exp( - phitauHPriorALL - phitauWPriorALL   ))     ;
//phitauHT        = 1 / ( 1 + exp( - phitauHPriorALL - phitauTPriorALL   ))     ;
//phitauHNT       = 1 / ( 1 + exp( - phitauHPriorALL - phitauNTPriorALL  ))     ;
//phitauKW        = 1 / ( 1 + exp( - phitauKPriorALL - phitauWPriorALL   ))     ;
//phitauKT        = 1 / ( 1 + exp( - phitauKPriorALL - phitauTPriorALL   ))     ;
//phitauKNT       = 1 / ( 1 + exp( - phitauKPriorALL - phitauNTPriorALL  ))     ;
//phitauscriptXW  = 1 / ( 1 + exp( - phitauXPriorALL - phitauWPriorALL   ))     ;
//phitauscriptXT  = 1 / ( 1 + exp( - phitauXPriorALL - phitauTPriorALL   ))     ;
//phitauscriptXNT = 1 / ( 1 + exp( - phitauXPriorALL - phitauNTPriorALL  ))     ;
//
//tauKG_          =  1 / ( 1 + exp(   -   tauSG1PriorALL_  - tauKGPriori_ ));
//tauHG_          =  1 / ( 1 + exp(   -   tauSG1PriorALL_  - tauHGPriori_ ));
//tauCG_          =  1 / ( 1 + exp(   -   tauSG1PriorALL_  - tauCGPriori_ ));
//taub_           =  tauPriorALL_     +   taulbPriorALL_   + taubPriori_     ;
//taul_           =  tauPriorALL_     +   taulbPriorALL_   + taulPriori_     ;
//tauD_           =  tauPriorALL_     +   tauCPriorALL_    + tauDPriori_     ;
//tauND_          =  tauPriorALL_     +   tauCPriorALL_    + tauNDPriori_    ;
//tauNT_          =  tauPriorALL_     +                    + tauNTPriori_    ;
//tauLa_          =  tauPriorALL_     +   tauLPriorALL_    + tauLaPriori_    ;
//tauLb_          =  1 / ( 1 + exp(   -   tauPriorALL_     - tauLPriorALL_   - tauLbPriori_ ))    ;
//tauHW_          =  tauPriorALL_     +   tauHPriorALL_    + tauWPriorALL_   ;
//tauHT_          =  tauPriorALL_     +   tauHPriorALL_    + tauTPriorALL_   ;
//tauHNT_         =  tauPriorALL_     +   tauHPriorALL_    + tauNTPriorALL_  ;
//tauKW_          =  tauPriorALL_     +   tauKPriorALL_    + tauWPriorALL_   ;
//tauKT_          =  tauPriorALL_     +   tauKPriorALL_    + tauTPriorALL_   ;
//tauKNT_         =  tauPriorALL_     +   tauKPriorALL_    + tauNTPriorALL_  ;
//tauscriptXW_    =  tauPriorALL_     +   tauXPriorALL_    + tauWPriorALL_   ;
//tauscriptXT_    =  tauPriorALL_     +   tauXPriorALL_    + tauTPriorALL_   ;
//tauscriptXNT_   =  tauPriorALL_     +   tauXPriorALL_    + tauNTPriorALL_  ;
//
//sigmauKG      = sigmauPriorALL * sigmauSG1PriorALL   * sigmauKGPriori  ;
//sigmauHG      = sigmauPriorALL * sigmauSG1PriorALL   * sigmauHGPriori  ;
//sigmauCG      = sigmauPriorALL * sigmauSG1PriorALL   * sigmauCGPriori  ;
//sigmaub       = sigmauPriorALL * sigmaulbPriorALL    * sigmaubPriori   ;
//sigmaul       = sigmauPriorALL * sigmaulbPriorALL    * sigmaulPriori   ;
//sigmauD       = sigmauPriorALL * sigmauCPriorALL     * sigmauDPriori   ;
//sigmauND      = sigmauPriorALL * sigmauCPriorALL     * sigmauNDPriori  ;
//sigmauNT      = sigmauPriorALL                       * sigmauNTPriori  ;
//sigmauTX      = sigmauPriorALL * sigmauiotaPriorALL  * sigmauTXPriori  ;
//sigmauTM      = sigmauPriorALL * sigmauiotaPriorALL  * sigmauTMPriori  ;
//sigmauWX      = sigmauPriorALL * sigmauiotaPriorALL  * sigmauWXPriori  ;
//sigmauWM      = sigmauPriorALL * sigmauiotaPriorALL  * sigmauWMPriori  ;
//sigmauLa      = sigmauPriorALL * sigmauLPriorALL     * sigmauLaPriori  ;
//sigmauLb      = sigmauPriorALL * sigmauLPriorALL     * sigmauLbPriori  ;
//sigmauALL     = sigmauPriorALL                       * sigmauALLPriori     ;
//sigmauS1ALL   = sigmauPriorALL                       * sigmauS1ALLPriori   ;
//sigmauiotaALL = sigmauPriorALL                       * sigmauiotaALLPriori ;
//sigmaulbALL   = sigmauPriorALL                       * sigmaulbALLPriori   ;
//sigmauCALL    = sigmauPriorALL                       * sigmauCALLPriori    ;
//sigmauLALL    = sigmauPriorALL                       * sigmauLALLPriori    ;
//sigmauHALL    = sigmauPriorALL * sigmauPriorHKXALL   * sigmauHALLPriori    ;
//sigmauKALL    = sigmauPriorALL * sigmauPriorHKXALL   * sigmauKALLPriori    ;
//sigmauXALL    = sigmauPriorALL * sigmauPriorHKXALL   * sigmauXALLPriori    ;
//sigmauTALL    = sigmauPriorALL * sigmauPriorS0ALL    * sigmauTALLPriori    ;
//sigmauNTALL   = sigmauPriorALL * sigmauPriorS0ALL    * sigmauNTALLPriori   ;
//sigmauWALL    = sigmauPriorALL * sigmauPriorS0ALL    * sigmauWALLPriori    ;

log_nuW = 0.62732299999999996398258872432052157819271087646484375 + 0.057041596931537576209425566275967867113649845123291015625 * InternalPrior_8 + 0.03293298134342935445939559713224298320710659027099609375 * InternalPrior_9 + 0.0196775112981440424009260681259547709487378597259521484375 * InternalPrior_23 + 0.1135330647873120935020807564796996302902698516845703125 * InternalPrior_59 - 0.0819615006133074530669802015836467035114765167236328125 * InternalPrior_64 + 0.327584143979313291428212551181786693632602691650390625 * InternalPrior_104;
nuW = exp( log_nuW );
log_nuT = 0.62732299999999996398258872432052157819271087646484375 - 0.05704159693153758314831947018319624476134777069091796875 * InternalPrior_8 + 0.0329329813434293405816077893177862279117107391357421875 * InternalPrior_9 + 0.0196775112981440424009260681259547709487378597259521484375 * InternalPrior_23 + 0.1135330647873120935020807564796996302902698516845703125 * InternalPrior_59 - 0.0819615006133074530669802015836467035114765167236328125 * InternalPrior_64 + 0.327584143979313291428212551181786693632602691650390625 * InternalPrior_104;
nuT = exp( log_nuT );
log_nuNT = 0.62732299999999996398258872432052157819271087646484375 - 0.06586596268685872279657900207894272170960903167724609375 * InternalPrior_9 + 0.0196775112981438411730028548163318191654980182647705078125 * InternalPrior_23 + 0.11353306478731213513544417992306989617645740509033203125 * InternalPrior_59 - 0.08196150061330755021149485628484399057924747467041015625 * InternalPrior_64 + 0.327584143979313180405910088666132651269435882568359375 * InternalPrior_104;
nuNT = exp( log_nuNT );
log_nuSW = 0.62732299999999996398258872432052157819271087646484375 + 0.057041596931537590087213374090424622409045696258544921875 * InternalPrior_8 + 0.03293298134342943772612244401898351497948169708251953125 * InternalPrior_9 + 0.0196775112981440181147974044506554491817951202392578125 * InternalPrior_23 - 0.1135330647873120935020807564796996302902698516845703125 * InternalPrior_59 - 0.08196150061330743918919239376918994821608066558837890625 * InternalPrior_64 + 0.327584143979313235917061319923959672451019287109375 * InternalPrior_104;
nuSW = exp( log_nuSW );
log_nuST = 0.62732299999999996398258872432052157819271087646484375 - 0.05704159693153758314831947018319624476134777069091796875 * InternalPrior_8 + 0.032932981343429444665016347926211892627179622650146484375 * InternalPrior_9 + 0.0196775112981440181147974044506554491817951202392578125 * InternalPrior_23 - 0.11353306478731210737986856429415638558566570281982421875 * InternalPrior_59 - 0.08196150061330743918919239376918994821608066558837890625 * InternalPrior_64 + 0.327584143979313235917061319923959672451019287109375 * InternalPrior_104;
nuST = exp( log_nuST );
log_nuSNT = 0.62732299999999996398258872432052157819271087646484375 - 0.06586596268685886157445708022351027466356754302978515625 * InternalPrior_9 + 0.0196775112981439730119870290536709944717586040496826171875 * InternalPrior_23 - 0.1135330647873120935020807564796996302902698516845703125 * InternalPrior_59 - 0.08196150061330743918919239376918994821608066558837890625 * InternalPrior_64 + 0.327584143979313235917061319923959672451019287109375 * InternalPrior_104;
nuSNT = exp( log_nuSNT );
log_nuD = 0.62732299999999996398258872432052157819271087646484375 + 0.035434983320321460087409803918490069918334484100341796875 * InternalPrior_3 - 0.0035405228865649572382590104524524576845578849315643310546875 * InternalPrior_4 - 0.06010359661058763125485171485706814564764499664306640625 * InternalPrior_5 + 0.01439941153500980119961383252302766777575016021728515625 * InternalPrior_23 + 0.12395840265546796687967656680484651587903499603271484375 * InternalPrior_64 + 0.3334526967184403556387906064628623425960540771484375 * InternalPrior_104;
nuD = exp( log_nuD );
log_nuNDCG = 0.62732299999999996398258872432052157819271087646484375 + 0.03836485239785070167073399716173298656940460205078125 * InternalPrior_3 + 0.033662076269444785037165956964599899947643280029296875 * InternalPrior_4 + 0.047703442144893477838696327353318338282406330108642578125 * InternalPrior_5 + 0.01439941153500980119961383252302766777575016021728515625 * InternalPrior_23 + 0.12395840265546798075746437461930327117443084716796875 * InternalPrior_64 + 0.3334526967184403556387906064628623425960540771484375 * InternalPrior_104;
nuNDCG = exp( log_nuNDCG );
log_nuK = 0.62732299999999996398258872432052157819271087646484375 - 0.01391318535351873143801615384518299833871424198150634765625 * InternalPrior_3 - 0.06459946304271967087995420797597034834325313568115234375 * InternalPrior_4 + 0.0226704282857850027144142046608976670540869235992431640625 * InternalPrior_5 + 0.01439941153500971272871655770586585276760160923004150390625 * InternalPrior_23 + 0.1239584026554678697351619121036492288112640380859375 * InternalPrior_64 + 0.3334526967184403556387906064628623425960540771484375 * InternalPrior_104;
nuK = exp( log_nuK );
log_nuH = 0.62732299999999996398258872432052157819271087646484375 - 0.059886650364653480627108450562445796094834804534912109375 * InternalPrior_3 + 0.0344779096598398504536220343652530573308467864990234375 * InternalPrior_4 - 0.01027027382009083368574753336588400998152792453765869140625 * InternalPrior_5 + 0.0143994115350092599658893277592142112553119659423828125 * InternalPrior_23 + 0.12395840265546780034622287303136545233428478240966796875 * InternalPrior_64 + 0.33345269671844002257188321891590021550655364990234375 * InternalPrior_104;
nuH = exp( log_nuH );
log_nuh = 0.62736300000000000398614474761416204273700714111328125 - 0.186075446618824302813521853749989531934261322021484375 * InternalPrior_23 - 0.0136346732460102641748544982647217693738639354705810546875 * InternalPrior_64 + 0.311069169239061082965491777940769679844379425048828125 * InternalPrior_104;
nuh = exp( log_nuh );
log_eKLT = -0.11155199999999999838085074088667170144617557525634765625 + 0.0306145426831129496836325643016607500612735748291015625 * InternalPrior_45 + 0.11271536985424478183315244450568570755422115325927734375 * InternalPrior_46 + 0.1298459314760274929678729449733509682118892669677734375 * InternalPrior_47 - 0.027240064801643253111773645969151402823626995086669921875 * InternalPrior_48 - 0.0049361627996979511034947307734910282306373119354248046875 * InternalPrior_49 - 0.0086684304883436202882052157292491756379604339599609375 * InternalPrior_50 + 0.43790533969493139476725218628416769206523895263671875 * InternalPrior_92;
eKLT = exp( log_eKLT );
log_eHLXT = -0.11155199999999999838085074088667170144617557525634765625 + 0.08162291050727986385648904388290247879922389984130859375 * InternalPrior_45 - 0.04901282239390468420392465986878960393369197845458984375 * InternalPrior_46 + 0.036666847234142686817737200044575729407370090484619140625 * InternalPrior_47 + 0.10102706441369412038167041600900120101869106292724609375 * InternalPrior_48 - 0.034353120016665052161020099674715311266481876373291015625 * InternalPrior_49 - 0.0977132575598149977214035288852755911648273468017578125 * InternalPrior_50 - 0.437905339694931561300705880057648755609989166259765625 * InternalPrior_94;
eHLXT = exp( log_eHLXT );
log_eYT = -0.11155199999999999838085074088667170144617557525634765625 + 0.02436741344070035564239873338010511361062526702880859375 * InternalPrior_45 + 0.0218298133335490147921564840771679882891476154327392578125 * InternalPrior_46 + 0.0097695918380007844283863249756905133835971355438232421875 * InternalPrior_47 + 0.117487577978376833698348491452634334564208984375 * InternalPrior_48 + 0.057422423772800608443578340711610508151352405548095703125 * InternalPrior_49 + 0.11435504808642975305144062758699874393641948699951171875 * InternalPrior_50 + 0.437905339694931339256100955026340670883655548095703125 * InternalPrior_93;
eYT = exp( log_eYT );
log_eKLNT = -0.11155199999999999838085074088667170144617557525634765625 + 0.027812740727368411020048455384312546811997890472412109375 * InternalPrior_45 + 0.045390050993346163499264633856000727973878383636474609375 * InternalPrior_46 - 0.1624402524997984598176259396495879627764225006103515625 * InternalPrior_47 + 0.0310945424301117025189800102680237614549696445465087890625 * InternalPrior_48 - 0.028681846005596887960731322664287290535867214202880859375 * InternalPrior_49 - 0.01825758744454465676287924225107417441904544830322265625 * InternalPrior_50 + 0.43790533969493139476725218628416769206523895263671875 * InternalPrior_92;
eKLNT = exp( log_eKLNT );
log_eHLXNT = -0.11155199999999999838085074088667170144617557525634765625 + 0.083244546691033705076989690496702678501605987548828125 * InternalPrior_45 - 0.01179991739891421594077502987829575431533157825469970703125 * InternalPrior_46 - 0.0267843115944151610730017409878200851380825042724609375 * InternalPrior_47 - 0.11780599450611707601499489328489289619028568267822265625 * InternalPrior_48 + 0.02554933838407398571934692199647543020546436309814453125 * InternalPrior_49 + 0.095006243380231836237470588457654230296611785888671875 * InternalPrior_50 - 0.437905339694931561300705880057648755609989166259765625 * InternalPrior_94;
eHLXNT = exp( log_eHLXNT );
log_eYNT = -0.11155199999999999838085074088667170144617557525634765625 - 0.00153443656673739954772461846488340597716160118579864501953125 * InternalPrior_45 + 0.00130021126215426846388367732032520507345907390117645263671875 * InternalPrior_46 - 0.0190863566176166961352311801647374522872269153594970703125 * InternalPrior_47 - 0.06923786239677708065354266864233068190515041351318359375 * InternalPrior_48 + 0.10945834001415578884408574822373338975012302398681640625 * InternalPrior_49 - 0.11916440502473324425380951652186922729015350341796875 * InternalPrior_50 + 0.437905339694931339256100955026340670883655548095703125 * InternalPrior_93;
eYNT = exp( log_eYNT );
log_eKLW = -0.11155199999999999838085074088667170144617557525634765625 - 0.058427283410481374581468827500430052168667316436767578125 * InternalPrior_45 - 0.1581054208475909106379475588255445472896099090576171875 * InternalPrior_46 + 0.032594321023770959910859090769008616916835308074951171875 * InternalPrior_47 - 0.0038544776284685257350393072783845127560198307037353515625 * InternalPrior_48 + 0.033618008805294863350354717113077640533447265625 * InternalPrior_49 + 0.0269260179328882527649557943050240282900631427764892578125 * InternalPrior_50 + 0.43790533969493150578955464879982173442840576171875 * InternalPrior_92;
eKLW = exp( log_eKLW );
log_eHLXW = -0.11155199999999999838085074088667170144617557525634765625 - 0.164867457198313582811266542194061912596225738525390625 * InternalPrior_45 + 0.060812739792818877593294502048593130894005298614501953125 * InternalPrior_46 - 0.00988253563972754829614064675524787162430584430694580078125 * InternalPrior_47 + 0.0167789300924229556333244772758916951715946197509765625 * InternalPrior_48 + 0.00880378163259105950277927377101150341331958770751953125 * InternalPrior_49 + 0.002707014179583176229082486230481663369573652744293212890625 * InternalPrior_50 - 0.437905339694931228233798492510686628520488739013671875 * InternalPrior_94;
eHLXW = exp( log_eHLXW );
log_eYW = -0.11155199999999999838085074088667170144617557525634765625 - 0.02283297687396292074968329188777715899050235748291015625 * InternalPrior_45 - 0.0231300245957032669930075741149266832508146762847900390625 * InternalPrior_46 + 0.0093167647796159082373979032354327500797808170318603515625 * InternalPrior_47 - 0.048249715581599732228124111088618519715964794158935546875 * InternalPrior_48 - 0.1668807637869564042265579928425722755491733551025390625 * InternalPrior_49 + 0.004809356938303585744798329670857128803618252277374267578125 * InternalPrior_50 + 0.43790533969493150578955464879982173442840576171875 * InternalPrior_93;
eYW = exp( log_eYW );
logit_deltaKPT_ = -2.29999999999999982236431605997495353221893310546875 - 0.07044846834403196977891781216385425068438053131103515625 * InternalPrior_25 + 0.1336004092862020653509347312137833796441555023193359375 * InternalPrior_30 + 0.08478174300248365879983936110875220037996768951416015625 * InternalPrior_43 + 0.509901951359278626796367461793124675750732421875 * InternalPrior_100;
deltaKPT_ = 1 / ( 1 + exp( -( logit_deltaKPT_ ) ) );
logit_deltaKPNT_ = -2.29999999999999982236431605997495353221893310546875 - 0.0674003429087823568988113720479304902255535125732421875 * InternalPrior_25 - 0.148084512644404864278868672045064158737659454345703125 * InternalPrior_30 + 0.05939840814910445077057232765582739375531673431396484375 * InternalPrior_43 + 0.509901951359278626796367461793124675750732421875 * InternalPrior_100;
deltaKPNT_ = 1 / ( 1 + exp( -( logit_deltaKPNT_ ) ) );
logit_deltaKPW_ = -2.29999999999999982236431605997495353221893310546875 - 0.033528168040268598038000646965883788652718067169189453125 * InternalPrior_25 + 0.0148910100520692929848554086902367998845875263214111328125 * InternalPrior_30 - 0.169275278075366630847753413036116398870944976806640625 * InternalPrior_43 + 0.50990195135927873781866992430877871811389923095703125 * InternalPrior_100;
deltaKPW_ = 1 / ( 1 + exp( -( logit_deltaKPW_ ) ) );
logit_deltaKG_ = -2.29999999999999982236431605997495353221893310546875 + 0.171376979293082987165774966342723928391933441162109375 * InternalPrior_25 - 0.000406906693866497634788637061120653015677817165851593017578125 * InternalPrior_30 + 0.025095126923778597605174667251048958860337734222412109375 * InternalPrior_43 + 0.5099019513592784047517625367618165910243988037109375 * InternalPrior_100;
deltaKG_ = 1 / ( 1 + exp( -( logit_deltaKG_ ) ) );
logit_deltaHPT_ = -3.899999999999999911182158029987476766109466552734375 - 0.07044846834403196977891781216385425068438053131103515625 * InternalPrior_24 + 0.1336004092862020653509347312137833796441555023193359375 * InternalPrior_31 + 0.08478174300248365879983936110875220037996768951416015625 * InternalPrior_44 + 0.509901951359278626796367461793124675750732421875 * InternalPrior_101;
deltaHPT_ = 1 / ( 1 + exp( -( logit_deltaHPT_ ) ) );
logit_deltaHPNT_ = -3.899999999999999911182158029987476766109466552734375 - 0.0674003429087823568988113720479304902255535125732421875 * InternalPrior_24 - 0.148084512644404864278868672045064158737659454345703125 * InternalPrior_31 + 0.05939840814910445077057232765582739375531673431396484375 * InternalPrior_44 + 0.509901951359278626796367461793124675750732421875 * InternalPrior_101;
deltaHPNT_ = 1 / ( 1 + exp( -( logit_deltaHPNT_ ) ) );
logit_deltaHPW_ = -3.899999999999999911182158029987476766109466552734375 - 0.033528168040268598038000646965883788652718067169189453125 * InternalPrior_24 + 0.0148910100520692929848554086902367998845875263214111328125 * InternalPrior_31 - 0.169275278075366630847753413036116398870944976806640625 * InternalPrior_44 + 0.50990195135927873781866992430877871811389923095703125 * InternalPrior_101;
deltaHPW_ = 1 / ( 1 + exp( -( logit_deltaHPW_ ) ) );
logit_deltaHG_ = -3.899999999999999911182158029987476766109466552734375 + 0.171376979293082987165774966342723928391933441162109375 * InternalPrior_24 - 0.000406906693866497634788637061120653015677817165851593017578125 * InternalPrior_31 + 0.025095126923778597605174667251048958860337734222412109375 * InternalPrior_44 + 0.5099019513592784047517625367618165910243988037109375 * InternalPrior_101;
deltaHG_ = 1 / ( 1 + exp( -( logit_deltaHG_ ) ) );
logit_rhodeltaKPT = 0 + 0.0577350269189626230659229122466058470308780670166015625 * InternalPrior_36 - 0.14142135623730955895638317088014446198940277099609375 * InternalPrior_39 + 0.08164965809277265063048645288290572352707386016845703125 * InternalPrior_41 + 1.004987562112088728127901049447245895862579345703125 * InternalPrior_107;
rhodeltaKPT = 1 / ( 1 + exp( -( logit_rhodeltaKPT ) ) );
logit_rhodeltaKPNT = 0 + 0.0577350269189626230659229122466058470308780670166015625 * InternalPrior_36 + 0.14142135623730955895638317088014446198940277099609375 * InternalPrior_39 + 0.08164965809277265063048645288290572352707386016845703125 * InternalPrior_41 + 1.004987562112088728127901049447245895862579345703125 * InternalPrior_107;
rhodeltaKPNT = 1 / ( 1 + exp( -( logit_rhodeltaKPNT ) ) );
logit_rhodeltaKPW = 0 + 0.0577350269189626230659229122466058470308780670166015625 * InternalPrior_36 - 0.1632993161855453012609729057658114470541477203369140625 * InternalPrior_41 + 1.004987562112088728127901049447245895862579345703125 * InternalPrior_107;
rhodeltaKPW = 1 / ( 1 + exp( -( logit_rhodeltaKPW ) ) );
logit_rhodeltaKG = 0 - 0.17320508075688778593104188985307700932025909423828125 * InternalPrior_36 + 1.00498756211208917221711089950986206531524658203125 * InternalPrior_107;
rhodeltaKG = 1 / ( 1 + exp( -( logit_rhodeltaKG ) ) );
logit_rhodeltaHPT = 0 - 0.14142135623730955895638317088014446198940277099609375 * InternalPrior_37 + 0.0577350269189626230659229122466058470308780670166015625 * InternalPrior_38 + 0.08164965809277265063048645288290572352707386016845703125 * InternalPrior_42 + 1.004987562112088728127901049447245895862579345703125 * InternalPrior_108;
rhodeltaHPT = 1 / ( 1 + exp( -( logit_rhodeltaHPT ) ) );
logit_rhodeltaHPNT = 0 + 0.14142135623730955895638317088014446198940277099609375 * InternalPrior_37 + 0.0577350269189626230659229122466058470308780670166015625 * InternalPrior_38 + 0.08164965809277265063048645288290572352707386016845703125 * InternalPrior_42 + 1.004987562112088728127901049447245895862579345703125 * InternalPrior_108;
rhodeltaHPNT = 1 / ( 1 + exp( -( logit_rhodeltaHPNT ) ) );
logit_rhodeltaHPW = 0 + 0.0577350269189626230659229122466058470308780670166015625 * InternalPrior_38 - 0.1632993161855453012609729057658114470541477203369140625 * InternalPrior_42 + 1.004987562112088728127901049447245895862579345703125 * InternalPrior_108;
rhodeltaHPW = 1 / ( 1 + exp( -( logit_rhodeltaHPW ) ) );
logit_rhodeltaHG = 0 - 0.17320508075688778593104188985307700932025909423828125 * InternalPrior_38 + 1.00498756211208917221711089950986206531524658203125 * InternalPrior_108;
rhodeltaHG = 1 / ( 1 + exp( -( logit_rhodeltaHG ) ) );
log_sigmadeltaKPT = -8.2950859999999995153530107927508652210235595703125 - 0.99628912804801095237650088165537454187870025634765625 * InternalPrior_123 + 1.72562338880765064885736137512139976024627685546875 * InternalPrior_125 + 0.704482798465186466074783311341889202594757080078125 * InternalPrior_126 + 1.235580819898072224560792164993472397327423095703125 * InternalPrior_170;
sigmadeltaKPT = exp( log_sigmadeltaKPT );
log_sigmadeltaKPNT = -8.2950859999999995153530107927508652210235595703125 - 0.99628912804801095237650088165537454187870025634765625 * InternalPrior_123 - 1.72562338880765064885736137512139976024627685546875 * InternalPrior_125 + 0.704482798465186466074783311341889202594757080078125 * InternalPrior_126 + 1.235580819898072224560792164993472397327423095703125 * InternalPrior_170;
sigmadeltaKPNT = exp( log_sigmadeltaKPNT );
log_sigmadeltaKPW = -8.2950859999999995153530107927508652210235595703125 + 1.9925782560960232370206313134985975921154022216796875 * InternalPrior_123 + 0.70448279846518613300787592379492707550525665283203125 * InternalPrior_126 + 1.2355808198980720025161872399621643126010894775390625 * InternalPrior_170;
sigmadeltaKPW = exp( log_sigmadeltaKPW );
log_sigmadeltaKG = -8.2950859999999995153530107927508652210235595703125 - 2.1134483953955385260314869810827076435089111328125 * InternalPrior_126 + 1.2355808198980839929248531916528008878231048583984375 * InternalPrior_170;
sigmadeltaKG = exp( log_sigmadeltaKG );
log_sigmadeltaHPT = -8.2950859999999995153530107927508652210235595703125 + 1.72562338880765064885736137512139976024627685546875 * InternalPrior_124 + 0.704482798465186466074783311341889202594757080078125 * InternalPrior_127 - 0.99628912804801095237650088165537454187870025634765625 * InternalPrior_128 + 1.235580819898072224560792164993472397327423095703125 * InternalPrior_169;
sigmadeltaHPT = exp( log_sigmadeltaHPT );
log_sigmadeltaHPNT = -8.2950859999999995153530107927508652210235595703125 - 1.72562338880765064885736137512139976024627685546875 * InternalPrior_124 + 0.704482798465186466074783311341889202594757080078125 * InternalPrior_127 - 0.99628912804801095237650088165537454187870025634765625 * InternalPrior_128 + 1.235580819898072224560792164993472397327423095703125 * InternalPrior_169;
sigmadeltaHPNT = exp( log_sigmadeltaHPNT );
log_sigmadeltaHPW = -8.2950859999999995153530107927508652210235595703125 + 0.70448279846518613300787592379492707550525665283203125 * InternalPrior_127 + 1.9925782560960232370206313134985975921154022216796875 * InternalPrior_128 + 1.2355808198980720025161872399621643126010894775390625 * InternalPrior_169;
sigmadeltaHPW = exp( log_sigmadeltaHPW );
log_sigmadeltaHG = -8.2950859999999995153530107927508652210235595703125 - 2.1134483953955385260314869810827076435089111328125 * InternalPrior_127 + 1.2355808198980839929248531916528008878231048583984375 * InternalPrior_169;
sigmadeltaHG = exp( log_sigmadeltaHG );
logit_rhoOmegaALL = 0 - 0.1241096435678034903826727486375602893531322479248046875 * InternalPrior_66 + 0.1341554260794784736443574502118281088769435882568359375 * InternalPrior_67 - 0.0204116532916025217314626161169144324958324432373046875 * InternalPrior_68 - 0.0111048333099798800238655616112737334333360195159912109375 * InternalPrior_70 - 0.2276658347866933329584071543649770319461822509765625 * InternalPrior_72 + 0.045432226113268962819358165461380849592387676239013671875 * InternalPrior_73 + 0.29755698395095675490296116549870930612087249755859375 * InternalPrior_74 + 0.0436901494930301004249173502103076316416263580322265625 * InternalPrior_75 - 0.0144904558562925465936555013968245475552976131439208984375 * InternalPrior_77 - 0.10713246649499454099530026951470063067972660064697265625 * InternalPrior_78 + 0.0437134856892091583357995432379539124667644500732421875 * InternalPrior_79 - 0.1971937651256510104502694957773201167583465576171875 * InternalPrior_81 - 0.10715116262751607500991468668871675617992877960205078125 * InternalPrior_91 - 0.08517474249027466581818401891723624430596828460693359375 * InternalPrior_95 - 0.069141920517587107664070344981155358254909515380859375 * InternalPrior_102 + 0.9978547267248865093591803088202141225337982177734375 * InternalPrior_175;
rhoOmegaALL = 1 / ( 1 + exp( -( logit_rhoOmegaALL ) ) );
logit_rhoOmegaS0ALL = 0 - 0.1241096435678034903826727486375602893531322479248046875 * InternalPrior_66 + 0.1341554260794784736443574502118281088769435882568359375 * InternalPrior_67 - 0.0034480457959595845439382255648297359584830701351165771484375 * InternalPrior_68 - 0.04615827736211504384034043368956190533936023712158203125 * InternalPrior_70 + 0.0186695694468347293815124743332489742897450923919677734375 * InternalPrior_72 + 0.045432226113268962819358165461380849592387676239013671875 * InternalPrior_73 - 0.31323389233801524067501986792194657027721405029296875 * InternalPrior_74 + 0.0436901494930301004249173502103076316416263580322265625 * InternalPrior_75 - 0.12610090055537093167714601804618723690509796142578125 * InternalPrior_77 - 0.07007373339629317798848973097847192548215389251708984375 * InternalPrior_78 - 0.1819114798604064831000215463063796050846576690673828125 * InternalPrior_79 - 0.1971937651256510104502694957773201167583465576171875 * InternalPrior_81 - 0.10715116262751607500991468668871675617992877960205078125 * InternalPrior_91 - 0.08517474249027466581818401891723624430596828460693359375 * InternalPrior_95 - 0.069141920517587107664070344981155358254909515380859375 * InternalPrior_102 + 0.9978547267248865093591803088202141225337982177734375 * InternalPrior_175;
rhoOmegaS0ALL = 1 / ( 1 + exp( -( logit_rhoOmegaS0ALL ) ) );
logit_rhoOmegaTALL = 0 + 0.04031136664972130578821207791406777687370777130126953125 * InternalPrior_26 - 0.0463605682798584883830272929117199964821338653564453125 * InternalPrior_27 + 0.102335228554240043052914188592694699764251708984375 * InternalPrior_28 + 0.040904513099442950385675743518731906078755855560302734375 * InternalPrior_29 + 0.05536504742831342695819074606333742849528789520263671875 * InternalPrior_32 + 0.049216884922889718445571105576163972727954387664794921875 * InternalPrior_33 + 0.056542940074008986306441926217303262092173099517822265625 * InternalPrior_34 - 0.01897391210449959897399452302124700509011745452880859375 * InternalPrior_35 + 0.041255014823670832502244820716441608965396881103515625 * InternalPrior_40 + 0.077136971714884150497226755760493688285350799560546875 * InternalPrior_91 + 0.2392977228867876060558472772754612378776073455810546875 * InternalPrior_95 - 0.362859017617953749645920424882206134498119354248046875 * InternalPrior_99 - 0.175053145060481696315690669507603161036968231201171875 * InternalPrior_102 + 1.0187293803984245332827640595496632158756256103515625 * InternalPrior_175;
rhoOmegaTALL = 1 / ( 1 + exp( -( logit_rhoOmegaTALL ) ) );
logit_rhoOmegaNTALL = 0 - 0.066324468481649911932862551111611537635326385498046875 * InternalPrior_26 + 0.11072456730741163377640390308442874811589717864990234375 * InternalPrior_27 - 0.04869737892097958376069755104253999888896942138671875 * InternalPrior_28 + 0.0267191212620437774927228957722036284394562244415283203125 * InternalPrior_29 + 0.055832340288179370391130618145325570367276668548583984375 * InternalPrior_32 - 0.04840688684407627728756295937273534946143627166748046875 * InternalPrior_33 - 0.01352219286229055551784572486440083594061434268951416015625 * InternalPrior_34 + 0.0070281315555464074495972681688726879656314849853515625 * InternalPrior_35 - 0.035067568181057939824540881090797483921051025390625 * InternalPrior_40 + 0.077136971714884150497226755760493688285350799560546875 * InternalPrior_91 + 0.2392977228867876060558472772754612378776073455810546875 * InternalPrior_95 - 0.3628590176179538051570716561400331556797027587890625 * InternalPrior_99 - 0.175053145060481696315690669507603161036968231201171875 * InternalPrior_102 + 1.0187293803984245332827640595496632158756256103515625 * InternalPrior_175;
rhoOmegaNTALL = 1 / ( 1 + exp( -( logit_rhoOmegaNTALL ) ) );
logit_rhoOmegaWALL = 0 + 0.02601310183192857838907485756863025017082691192626953125 * InternalPrior_26 - 0.064363999027553131515588802358251996338367462158203125 * InternalPrior_27 - 0.05363784963326038990327759847787092439830303192138671875 * InternalPrior_28 - 0.06762363436148667583669435998672270216047763824462890625 * InternalPrior_29 - 0.11119738771649280428821526811589137651026248931884765625 * InternalPrior_32 - 0.000809998078813490597627211542430814006365835666656494140625 * InternalPrior_33 - 0.043020747211718390889956253886339254677295684814453125 * InternalPrior_34 + 0.01194578054895317938133292301472465624101459980010986328125 * InternalPrior_35 - 0.006187446642612903953406533474890238721854984760284423828125 * InternalPrior_40 + 0.07713697171488408110828771668820991180837154388427734375 * InternalPrior_91 + 0.2392977228867876060558472772754612378776073455810546875 * InternalPrior_95 - 0.3628590176179538051570716561400331556797027587890625 * InternalPrior_99 - 0.17505314506048164080453943824977613985538482666015625 * InternalPrior_102 + 1.0187293803984243112381591345183551311492919921875 * InternalPrior_175;
rhoOmegaWALL = 1 / ( 1 + exp( -( logit_rhoOmegaWALL ) ) );
logit_rhoOmegaKKALL = 0 - 0.073663772704903929255948469290160574018955230712890625 * InternalPrior_26 - 0.06900146193280758122323703673828276805579662322998046875 * InternalPrior_27 + 0.0232642297123018919335901699696478317491710186004638671875 * InternalPrior_28 + 0.11323041726985970389929292423403239808976650238037109375 * InternalPrior_29 - 0.031531785289266971161747932228536228649318218231201171875 * InternalPrior_32 - 0.040819071532292104664829679450122057460248470306396484375 * InternalPrior_33 - 0.05314548485642180131183209823575452901422977447509765625 * InternalPrior_34 + 0.052958933929427909337306346060358919203281402587890625 * InternalPrior_35 + 0.01267098003114880237773842708293159375898540019989013671875 * InternalPrior_40 + 0.0297540086643790606391046793532950687222182750701904296875 * InternalPrior_91 + 0.052856526256150455911342334047731128521263599395751953125 * InternalPrior_95 + 0.4184586803183016900931079362635500729084014892578125 * InternalPrior_102 + 1.0388518756140354692973915007314644753932952880859375 * InternalPrior_175;
rhoOmegaKKALL = 1 / ( 1 + exp( -( logit_rhoOmegaKKALL ) ) );
logit_rhoOmegaHLALL = 0 + 0.003071972241941139068754917929027214995585381984710693359375 * InternalPrior_26 - 0.047173616625549190384258935182515415363013744354248046875 * InternalPrior_27 + 0.01208561793333725632726416421292015002109110355377197265625 * InternalPrior_28 - 0.048993398686808027620021022130458732135593891143798828125 * InternalPrior_29 + 0.057764555131890472916555978599717491306364536285400390625 * InternalPrior_32 + 0.0219474786162536412981172162517395918257534503936767578125 * InternalPrior_33 + 0.000787665028417637602155265685865970226586796343326568603515625 * InternalPrior_34 - 0.0204369438239046345706650953388816560618579387664794921875 * InternalPrior_35 - 0.151598393359035188421302109418320469558238983154296875 * InternalPrior_40 + 0.0297540086643791022724681027966653346084058284759521484375 * InternalPrior_91 + 0.052856526256150511422493565305558149702847003936767578125 * InternalPrior_95 + 0.418458680318301745604259167521377094089984893798828125 * InternalPrior_102 + 1.0388518756140354692973915007314644753932952880859375 * InternalPrior_175;
rhoOmegaHLALL = 1 / ( 1 + exp( -( logit_rhoOmegaHLALL ) ) );
logit_rhoOmegaKLALL = 0 + 0.01383014254543718339618418866621141205541789531707763671875 * InternalPrior_26 - 0.03806871013853015128791668075791676528751850128173828125 * InternalPrior_27 - 0.089445246080106233232953627521055750548839569091796875 * InternalPrior_28 - 0.051434860863090160754129698261749581433832645416259765625 * InternalPrior_29 + 0.08722778048526245997518202557330369018018245697021484375 * InternalPrior_32 - 0.02581617167025467007857031376261147670447826385498046875 * InternalPrior_33 + 0.01457611982411785057911490781634711311198770999908447265625 * InternalPrior_34 - 0.010715391950845525037561145609288359992206096649169921875 * InternalPrior_35 + 0.1054090138714177948831007824992411769926548004150390625 * InternalPrior_40 + 0.0297540086643791022724681027966653346084058284759521484375 * InternalPrior_91 + 0.052856526256150511422493565305558149702847003936767578125 * InternalPrior_95 + 0.418458680318301745604259167521377094089984893798828125 * InternalPrior_102 + 1.0388518756140354692973915007314644753932952880859375 * InternalPrior_175;
rhoOmegaKLALL = 1 / ( 1 + exp( -( logit_rhoOmegaKLALL ) ) );
logit_rhoOmegaHLXALL = 0 + 0.059951950403256674959617811282441834919154644012451171875 * InternalPrior_26 + 0.0962973991753545421889981525964685715734958648681640625 * InternalPrior_27 + 0.055911095429532021994223356387010426260530948638916015625 * InternalPrior_28 - 0.0151411614142013990769175535433532786555588245391845703125 * InternalPrior_29 - 0.0237108329036267717615515948637039400637149810791015625 * InternalPrior_32 + 0.047098697046533043175653432399485609494149684906005859375 * InternalPrior_33 - 0.10554289945404089767766464547094074077904224395751953125 * InternalPrior_34 - 0.0262904573990098595903663891704127308912575244903564453125 * InternalPrior_35 + 0.034150937877706455392257112180232070386409759521484375 * InternalPrior_40 + 0.0297540086643791369669376223328072228468954563140869140625 * InternalPrior_91 + 0.0528565262561505322391752770272432826459407806396484375 * InternalPrior_95 + 0.418458680318301745604259167521377094089984893798828125 * InternalPrior_102 + 1.0388518756140354692973915007314644753932952880859375 * InternalPrior_175;
rhoOmegaHLXALL = 1 / ( 1 + exp( -( logit_rhoOmegaHLXALL ) ) );
logit_rhoOmegaHLXKLALL = 0 - 0.003190292485731088985290160309205020894296467304229736328125 * InternalPrior_26 + 0.057946389521532359889732788360561244189739227294921875 * InternalPrior_27 - 0.001815696995064941358932752990540393511764705181121826171875 * InternalPrior_28 + 0.00233900369423989222539272958556466619484126567840576171875 * InternalPrior_29 - 0.0897497174242591622128628614518675021827220916748046875 * InternalPrior_32 - 0.0024109324602399240418393322471501960535533726215362548828125 * InternalPrior_33 + 0.1433245994579271653801555430618464015424251556396484375 * InternalPrior_34 + 0.004483859244332124606435829861084130243398249149322509765625 * InternalPrior_35 - 0.00063253842123786618335812281799235279322601854801177978515625 * InternalPrior_40 + 0.029754008664379306969838268059902475215494632720947265625 * InternalPrior_91 + 0.0528565262561505877503265082850703038275241851806640625 * InternalPrior_95 + 0.418458680318301967648864092552685178816318511962890625 * InternalPrior_102 + 1.038851875614035247252786575700156390666961669921875 * InternalPrior_175;
rhoOmegaHLXKLALL = 1 / ( 1 + exp( -( logit_rhoOmegaHLXKLALL ) ) );
logit_rhoOmegaS1ALL = 0 - 0.0783376539604346555645264515987946651875972747802734375 * InternalPrior_66 + 0.1009339327611475656265582756532239727675914764404296875 * InternalPrior_67 - 0.032671846130502064931011574344665859825909137725830078125 * InternalPrior_68 + 0.058430400554179688643596790598166990093886852264404296875 * InternalPrior_70 + 0.22058864752834228539768446353264153003692626953125 * InternalPrior_72 - 0.11557401164950902028305534940955112688243389129638671875 * InternalPrior_73 + 0.00525787804655414130194923671979267965070903301239013671875 * InternalPrior_74 + 0.12842231477204035794414949123165570199489593505859375 * InternalPrior_75 + 0.187644360259284603831275717311655171215534210205078125 * InternalPrior_77 + 0.2301937392784971780912428584997542202472686767578125 * InternalPrior_78 + 0.160055552058224304090572331915609538555145263671875 * InternalPrior_79 - 0.1326998102303674487156825989586650393903255462646484375 * InternalPrior_81 - 0.10715116262751578357637072258512489497661590576171875 * InternalPrior_91 - 0.085174742490274457651366901700384914875030517578125 * InternalPrior_95 - 0.06914192051758703827513130590887158177793025970458984375 * InternalPrior_102 + 0.99785472672488639833687784630456008017063140869140625 * InternalPrior_175;
rhoOmegaS1ALL = 1 / ( 1 + exp( -( logit_rhoOmegaS1ALL ) ) );
logit_rhoOmegaKALL = 0 - 0.12275962503897418220955017886808491311967372894287109375 * InternalPrior_26 - 0.0014226416386100872168984921017909073270857334136962890625 * InternalPrior_27 + 0.04784664564380748663641185203232453204691410064697265625 * InternalPrior_28 - 0.07893073917877278800059315244652680121362209320068359375 * InternalPrior_29 - 0.004603628961506878690401745046756332158111035823822021484375 * InternalPrior_32 + 0.044613105182270622328655207411429728381335735321044921875 * InternalPrior_33 - 0.0021544460618479928382118515628462773747742176055908203125 * InternalPrior_34 - 0.003132897704650998947639717329138875356875360012054443359375 * InternalPrior_35 + 0.03239405642356048276031543764474918134510517120361328125 * InternalPrior_40 + 0.0771369717148837619191681369557045400142669677734375 * InternalPrior_91 + 0.23929772288678685665530565529479645192623138427734375 * InternalPrior_95 + 0.36285901761795458231318889374961145222187042236328125 * InternalPrior_99 - 0.1750531450604816130489638226208626292645931243896484375 * InternalPrior_102 + 1.0187293803984240891935542094870470464229583740234375 * InternalPrior_175;
rhoOmegaKALL = 1 / ( 1 + exp( -( logit_rhoOmegaKALL ) ) );
logit_rhoOmegaHALL = 0 + 0.046717316649932609518014459126789006404578685760498046875 * InternalPrior_26 + 0.0007113208193050180212779753929908110876567661762237548828125 * InternalPrior_27 - 0.0903477337830371762805725666112266480922698974609375 * InternalPrior_28 + 0.085481584669054200276150368154048919677734375 * InternalPrior_29 + 0.0023018144807534454167330384422029965207912027835845947265625 * InternalPrior_32 + 0.0927622886592562867491551514831371605396270751953125 * InternalPrior_33 + 0.00107722303092395717098728180616262761759571731090545654296875 * InternalPrior_34 + 0.00156644885221387240338553059615378515445627272129058837890625 * InternalPrior_35 - 0.0200020993511534871112100830714553012512624263763427734375 * InternalPrior_40 + 0.0771369717148837619191681369557045400142669677734375 * InternalPrior_91 + 0.23929772288678685665530565529479645192623138427734375 * InternalPrior_95 + 0.36285901761795458231318889374961145222187042236328125 * InternalPrior_99 - 0.1750531450604816130489638226208626292645931243896484375 * InternalPrior_102 + 1.0187293803984240891935542094870470464229583740234375 * InternalPrior_175;
rhoOmegaHALL = 1 / ( 1 + exp( -( logit_rhoOmegaHALL ) ) );
logit_rhoOmegaCALL = 0 + 0.07604230838904157963042962364852428436279296875 * InternalPrior_26 + 0.0007113208193050180212779753929908110876567661762237548828125 * InternalPrior_27 + 0.042501088139229613316327771599389961920678615570068359375 * InternalPrior_28 - 0.006550845490281453908920639150892384350299835205078125 * InternalPrior_29 + 0.0023018144807534454167330384422029965207912027835845947265625 * InternalPrior_32 - 0.13737539384152686050555303154396824538707733154296875 * InternalPrior_33 + 0.00107722303092395717098728180616262761759571731090545654296875 * InternalPrior_34 + 0.0015664488524371618892450097604296388453803956508636474609375 * InternalPrior_35 - 0.01239195707240699044493492664287259685806930065155029296875 * InternalPrior_40 + 0.0771369717148837619191681369557045400142669677734375 * InternalPrior_91 + 0.23929772288678685665530565529479645192623138427734375 * InternalPrior_95 + 0.36285901761795458231318889374961145222187042236328125 * InternalPrior_99 - 0.1750531450604816130489638226208626292645931243896484375 * InternalPrior_102 + 1.0187293803984240891935542094870470464229583740234375 * InternalPrior_175;
rhoOmegaCALL = 1 / ( 1 + exp( -( logit_rhoOmegaCALL ) ) );
logit_rhoOmegaDi = 0 - 0.009577586826382246398825515143471420742571353912353515625 * InternalPrior_66 + 0.06284722701245194775854230329059646464884281158447265625 * InternalPrior_67 + 0.2288404865444262636930972121263039298355579376220703125 * InternalPrior_68 + 0.01396042642166433860040353209797103772871196269989013671875 * InternalPrior_70 - 0.08504208930862526549798730002294178120791912078857421875 * InternalPrior_72 - 0.1974488849815815016963682637651800177991390228271484375 * InternalPrior_73 - 0.035009910633809281088613118981811567209661006927490234375 * InternalPrior_74 - 0.30396619585639428340329004640807397663593292236328125 * InternalPrior_75 + 0.169576686693882761058915775720379315316677093505859375 * InternalPrior_77 - 0.006248631784255986691689610523781084339134395122528076171875 * InternalPrior_78 - 0.06794744561279193739711246280421619303524494171142578125 * InternalPrior_79 + 0.0302216848289378788028347599947665003128349781036376953125 * InternalPrior_81 - 0.107151162627515283976009641264681704342365264892578125 * InternalPrior_91 - 0.0851747424902743743846400548136443831026554107666015625 * InternalPrior_95 - 0.06914192051758705215291911372332833707332611083984375 * InternalPrior_102 + 0.99785472672488595424766799624194391071796417236328125 * InternalPrior_175;
rhoOmegaDi = 1 / ( 1 + exp( -( logit_rhoOmegaDi ) ) );
logit_rhoOmegaPALL = 0 - 0.0227270286666011768483830479681273573078215122222900390625 * InternalPrior_26 - 0.0137523811785290640818946172885262058116495609283447265625 * InternalPrior_27 - 0.01008970858370594574082712568952047149650752544403076171875 * InternalPrior_28 + 0.0260588356618144563470185204323570360429584980010986328125 * InternalPrior_29 - 0.0207835727269618762702574343848027638159692287445068359375 * InternalPrior_32 - 0.019081172217079910014003729656906216405332088470458984375 * InternalPrior_33 - 0.004665211661229452973220777067808739957399666309356689453125 * InternalPrior_34 - 0.1330126716837307931928791049358551390469074249267578125 * InternalPrior_35 + 0.00181823755092024919900739465816741358139552175998687744140625 * InternalPrior_40 + 0.37857712997869541471374077445943839848041534423828125 * InternalPrior_91 - 0.313359027658599076371359615222900174558162689208984375 * InternalPrior_95 - 0.1024203208152233146588372392216115258634090423583984375 * InternalPrior_102 + 1.0089576573504255296853671097778715193271636962890625 * InternalPrior_175;
rhoOmegaPALL = 1 / ( 1 + exp( -( logit_rhoOmegaPALL ) ) );
logit_rhoOmegaGALL = 0 + 0.0227270286666011768483830479681273573078215122222900390625 * InternalPrior_26 + 0.0137523811785290432652129055668410728685557842254638671875 * InternalPrior_27 + 0.010089708583705940536656697759099188260734081268310546875 * InternalPrior_28 - 0.0260588356618144563470185204323570360429584980010986328125 * InternalPrior_29 + 0.020783572726961886678598290245645330287516117095947265625 * InternalPrior_32 + 0.0190811722170799065445567777032920275814831256866455078125 * InternalPrior_33 + 0.00466521166122942955445385138091296539641916751861572265625 * InternalPrior_34 + 0.13301267168373076543730348930694162845611572265625 * InternalPrior_35 - 0.0018182375509202494158478291552683003828860819339752197265625 * InternalPrior_40 + 0.37857712997869541471374077445943839848041534423828125 * InternalPrior_91 - 0.313359027658599076371359615222900174558162689208984375 * InternalPrior_95 - 0.10242032081522334241441285485052503645420074462890625 * InternalPrior_102 + 1.0089576573504255296853671097778715193271636962890625 * InternalPrior_175;
rhoOmegaGALL = 1 / ( 1 + exp( -( logit_rhoOmegaGALL ) ) );
logit_rhoOmegaDemandALL = 0 - 0.00969874643428390338650846302925856434740126132965087890625 * InternalPrior_66 + 0.06260440617174888033868995762531994841992855072021484375 * InternalPrior_67 - 0.058749523446320665864828214353110524825751781463623046875 * InternalPrior_68 + 0.0640836264537760491588613831481779925525188446044921875 * InternalPrior_70 + 0.2273463511258235481005129940967890433967113494873046875 * InternalPrior_72 + 0.20535183846318239009320905097411014139652252197265625 * InternalPrior_73 + 0.08452013320744899971259656012989580631256103515625 * InternalPrior_74 - 0.283253155159924496775403213177924044430255889892578125 * InternalPrior_75 - 0.1704045481091262248529716316625126637518405914306640625 * InternalPrior_77 - 0.002213138945081829546401852581993807689286768436431884765625 * InternalPrior_78 + 0.0889674802951667953454517601130646653473377227783203125 * InternalPrior_79 + 0.031750140532775479595972711877038818784058094024658203125 * InternalPrior_81 - 0.1071511626275154227538877194092492572963237762451171875 * InternalPrior_91 - 0.0851747424902743188734888235558173619210720062255859375 * InternalPrior_95 - 0.0691419205175870243973434980944148264825344085693359375 * InternalPrior_102 + 0.99785472672488595424766799624194391071796417236328125 * InternalPrior_175;
rhoOmegaDemandALL = 1 / ( 1 + exp( -( logit_rhoOmegaDemandALL ) ) );
logit_rhoOmegahi = 0 + 0.048323111215572804588713751172690535895526409149169921875 * InternalPrior_66 + 0.01514642297624670640165955859401947236619889736175537109375 * InternalPrior_67 + 0.1903079239098368347082868012876133434474468231201171875 * InternalPrior_68 + 0.08300105149117391334367965782803366892039775848388671875 * InternalPrior_70 - 0.06470910722078697385750700732387485913932323455810546875 * InternalPrior_72 - 0.06654745149269199189223655821479042060673236846923828125 * InternalPrior_73 + 0.06630087135502181483470707235028385184705257415771484375 * InternalPrior_74 + 0.12936467112593208472759442884125746786594390869140625 * InternalPrior_75 - 0.28452401300581608989404003295931033790111541748046875 * InternalPrior_77 + 0.23562142682190223563765130165847949683666229248046875 * InternalPrior_78 - 0.069272440496688236777345082373358309268951416015625 * InternalPrior_79 + 0.118665562859917972371448513513314537703990936279296875 * InternalPrior_81 - 0.10715116262751474274228513650086824782192707061767578125 * InternalPrior_91 - 0.08517474249027401356215705163776874542236328125 * InternalPrior_95 - 0.06914192051758692725282884339321753941476345062255859375 * InternalPrior_102 + 0.99785472672488584322536553372628986835479736328125 * InternalPrior_175;
rhoOmegahi = 1 / ( 1 + exp( -( logit_rhoOmegahi ) ) );
logit_rhoOmegaCPi = 0 + 0.04502306548552474640967346886100131087005138397216796875 * InternalPrior_66 + 0.0201715229448875509044025733373928233049809932708740234375 * InternalPrior_67 - 0.10129396421144683249071505315441754646599292755126953125 * InternalPrior_68 + 0.0298533361194103959157519767586563830263912677764892578125 * InternalPrior_70 - 0.264452350395396884596976860848371870815753936767578125 * InternalPrior_72 + 0.2047931594792313791941751333069987595081329345703125 * InternalPrior_73 - 0.18289819584156730147839198252768255770206451416015625 * InternalPrior_74 - 0.01758087369743439876135226995756966061890125274658203125 * InternalPrior_75 + 0.1031460175580836136077778064645826816558837890625 * InternalPrior_77 + 0.139551278443570792031636074170819483697414398193359375 * InternalPrior_78 + 0.166041997959583687016760222832090221345424652099609375 * InternalPrior_79 + 0.11774484634808186911403282692845095880329608917236328125 * InternalPrior_81 - 0.10715116262751474274228513650086824782192707061767578125 * InternalPrior_91 - 0.08517474249027401356215705163776874542236328125 * InternalPrior_95 - 0.06914192051758692725282884339321753941476345062255859375 * InternalPrior_102 + 0.99785472672488584322536553372628986835479736328125 * InternalPrior_175;
rhoOmegaCPi = 1 / ( 1 + exp( -( logit_rhoOmegaCPi ) ) );
logit_rhoOmegaCi = 0 + 0.049492644041552076583645458640603465028107166290283203125 * InternalPrior_66 + 0.0138846925612235543023853523436628165654838085174560546875 * InternalPrior_67 + 0.2350788000315591486089061845632386393845081329345703125 * InternalPrior_68 - 0.273719690246960301038825491559691727161407470703125 * InternalPrior_70 + 0.1093805434342189630836372771227615885436534881591796875 * InternalPrior_72 + 0.140719632791851456676823772795614786446094512939453125 * InternalPrior_73 + 0.0137952619801339493310621264754445292055606842041015625 * InternalPrior_74 + 0.14492648763155757674070400753407739102840423583984375 * InternalPrior_75 + 0.07785503911139686483711130904339370317757129669189453125 * InternalPrior_77 - 0.139332579160836633747067025979049503803253173828125 * InternalPrior_78 + 0.0808773892825972728903849429116235114634037017822265625 * InternalPrior_79 + 0.113869100203443485153087522121495567262172698974609375 * InternalPrior_81 - 0.107151162627514728864497328686411492526531219482421875 * InternalPrior_91 - 0.08517474249027401356215705163776874542236328125 * InternalPrior_95 - 0.0691419205175869133750410355787607841193675994873046875 * InternalPrior_102 + 0.99785472672488584322536553372628986835479736328125 * InternalPrior_175;
rhoOmegaCi = 1 / ( 1 + exp( -( logit_rhoOmegaCi ) ) );
logit_rhoOmegaTradeALL = 0 + 0.04594002593985334337300940887871547602117061614990234375 * InternalPrior_66 + 0.019701563355393393595083040281679132021963596343994140625 * InternalPrior_67 - 0.27060593791696962995274589047767221927642822265625 * InternalPrior_68 - 0.28096136233703650209037050444749183952808380126953125 * InternalPrior_70 - 0.01339164066994955569478431556262876256369054317474365234375 * InternalPrior_72 - 0.2311036415533835597369005654400098137557506561279296875 * InternalPrior_73 + 0.01840822107199115154063662203043350018560886383056640625 * InternalPrior_74 - 0.040547170326009247809384561378465150482952594757080078125 * InternalPrior_75 - 0.09145822077581193532136438761881436221301555633544921875 * InternalPrior_77 + 0.00929170859285587298626030161585731548257172107696533203125 * InternalPrior_78 + 0.0056192071620904393558504352768068201839923858642578125 * InternalPrior_79 + 0.10977272036481459938084270788749563507735729217529296875 * InternalPrior_81 - 0.107151162627514506819892403655103407800197601318359375 * InternalPrior_91 - 0.0851747424902741523400351297823362983763217926025390625 * InternalPrior_95 - 0.06914192051758689949725322776430402882397174835205078125 * InternalPrior_102 + 0.99785472672488584322536553372628986835479736328125 * InternalPrior_175;
rhoOmegaTradeALL = 1 / ( 1 + exp( -( logit_rhoOmegaTradeALL ) ) );
logit_rhoOmegaYi = 0 + 0.047119659151898328486307576667968533001840114593505859375 * InternalPrior_66 + 0.0164890621655287838986936321816756390035152435302734375 * InternalPrior_67 - 0.041230448381899799381589133417946868576109409332275390625 * InternalPrior_68 + 0.26486471557819057931482120693544857203960418701171875 * InternalPrior_70 + 0.0235602266562036262442791922921969671733677387237548828125 * InternalPrior_72 - 0.1425575391782698819742591922477004118263721466064453125 * InternalPrior_73 - 0.0660160060375035440127788888275972567498683929443359375 * InternalPrior_74 + 0.11087495207679488873342421584311523474752902984619140625 * InternalPrior_75 - 0.033403006174785053461473438574103056453168392181396484375 * InternalPrior_77 - 0.293221516707041052196558439391083084046840667724609375 * InternalPrior_78 + 0.1285476581821034525177083196467719972133636474609375 * InternalPrior_79 + 0.12359445163124764544004818844769033603370189666748046875 * InternalPrior_81 - 0.10715116262751488152016321464543580077588558197021484375 * InternalPrior_91 - 0.08517474249027401356215705163776874542236328125 * InternalPrior_95 - 0.06914192051758684398610199650647700764238834381103515625 * InternalPrior_102 + 0.99785472672488584322536553372628986835479736328125 * InternalPrior_175;
rhoOmegaYi = 1 / ( 1 + exp( -( logit_rhoOmegaYi ) ) );
logit_rhoOmegaTCi = 0 + 0.047811288155254823284412424300171551294624805450439453125 * InternalPrior_66 + 0.0169268014880828050749972391031406004913151264190673828125 * InternalPrior_67 - 0.1265577408215956822790104752129991538822650909423828125 * InternalPrior_68 + 0.090452457052881574117719765126821584999561309814453125 * InternalPrior_70 + 0.058426507291009392719427495421768981032073497772216796875 * InternalPrior_72 + 0.1069384986736764686643397226362139917910099029541015625 * InternalPrior_73 + 0.11050737204825726578416578149699489586055278778076171875 * InternalPrior_74 + 0.0687438322280624347637711935021798126399517059326171875 * InternalPrior_75 + 0.1837036907694609422225795469785225577652454376220703125 * InternalPrior_77 + 0.00892609302133608173424050846733734942972660064697265625 * InternalPrior_78 - 0.348340814284770983189076787311933003365993499755859375 * InternalPrior_79 + 0.13054941249211682308128956719883717596530914306640625 * InternalPrior_81 - 0.10715116262751477049786075212978175841271877288818359375 * InternalPrior_91 - 0.085174742490274069073308282895595766603946685791015625 * InternalPrior_95 - 0.06914192051758684398610199650647700764238834381103515625 * InternalPrior_102 + 0.99785472672488584322536553372628986835479736328125 * InternalPrior_175;
rhoOmegaTCi = 1 / ( 1 + exp( -( logit_rhoOmegaTCi ) ) );
logit_rhoOmegaWPi = 0 + 0.345317174986288055738015145834651775658130645751953125 * InternalPrior_66 - 0.209183241003786657419283301351242698729038238525390625 * InternalPrior_67 + 0.0007419495104742418641052825734050202299840748310089111328125 * InternalPrior_68 + 0.007298149584814713451696999158002654439769685268402099609375 * InternalPrior_70 - 0.0027108231009807357177188169572445985977537930011749267578125 * InternalPrior_72 + 0.0045639472209562624571699274156344472430646419525146484375 * InternalPrior_73 + 0.00081128319053131066340700527916851569898426532745361328125 * InternalPrior_74 - 0.0173973433873971204677300050889243721030652523040771484375 * InternalPrior_75 - 0.00154464991490611716455638724454502153093926608562469482421875 * InternalPrior_77 - 0.00536217966965885951824422051004148670472204685211181640625 * InternalPrior_78 - 0.006350590374317233166578944292268715798854827880859375 * InternalPrior_79 - 0.259443374958168160304694538353942334651947021484375 * InternalPrior_81 - 0.10715116262751178677348207202157936990261077880859375 * InternalPrior_91 - 0.08517474249026864285827542744300444610416889190673828125 * InternalPrior_95 - 0.06914192051758638601910433862940408289432525634765625 * InternalPrior_102 + 0.9978547267248856211807606086949817836284637451171875 * InternalPrior_175;
rhoOmegaWPi = 1 / ( 1 + exp( -( logit_rhoOmegaWPi ) ) );
logit_rhoOmegaWCi = 0 - 0.28319369461922894171124198692268691956996917724609375 * InternalPrior_66 - 0.387833242591888394112942251013009808957576751708984375 * InternalPrior_67 - 0.006967818393288099758364761981965784798376262187957763671875 * InternalPrior_75 + 0.01036279617849934255036092878299314179457724094390869140625 * InternalPrior_81 - 0.10715116262751382680828982074672239832580089569091796875 * InternalPrior_91 - 0.08517474249027444377357909388592815957963466644287109375 * InternalPrior_95 - 0.06914192051758681623052638087756349705159664154052734375 * InternalPrior_102 + 0.9978547267248856211807606086949817836284637451171875 * InternalPrior_175;
rhoOmegaWCi = 1 / ( 1 + exp( -( logit_rhoOmegaWCi ) ) );
log_sigmaOmegaALL = -8.0955422999999999689180185669101774692535400390625 - 0.63760386022244774917311360695748589932918548583984375 * InternalPrior_113 - 1.562093473958226841347141089499928057193756103515625 * InternalPrior_114 - 0.89969000413841337948639420574181713163852691650390625 * InternalPrior_115 + 1.1046104890400700870856098845251835882663726806640625 * InternalPrior_116 - 0.042834546233434141193630040334028308279812335968017578125 * InternalPrior_122 + 0.00128415015234028574708791126113283098675310611724853515625 * InternalPrior_165 - 0.00210599132874796611536449830737183219753205776214599609375 * InternalPrior_166 + 0.0038179180101794892021604965748338145203888416290283203125 * InternalPrior_168 - 0.054500793916995006471726270547151216305792331695556640625 * InternalPrior_171;
sigmaOmegaALL = exp( log_sigmaOmegaALL );
log_sigmaOmegaS0ALL = -9.2122422999999997728082234971225261688232421875 - 0.0221204908562374590041965660702771856449544429779052734375 * InternalPrior_116 + 0.0726275096981639223248095049711992032825946807861328125 * InternalPrior_122 - 0.3410086211220006990885167397209443151950836181640625 * InternalPrior_162 + 1.9688164838265505007797173675498925149440765380859375 * InternalPrior_163 + 1.1643807127091043707167727916385047137737274169921875 * InternalPrior_165 - 0.51466658645315954689891668749623931944370269775390625 * InternalPrior_166 + 0.260641735098667337577893476918688975274562835693359375 * InternalPrior_168 - 0.55514395814248029825677122062188573181629180908203125 * InternalPrior_171;
sigmaOmegaS0ALL = exp( log_sigmaOmegaS0ALL );
log_sigmaOmegaTALL = -9.2103845999999993665596775826998054981231689453125 - 0.0219383147817363809151114395490367314778268337249755859375 * InternalPrior_116 + 0.0710679714223632352787518584591452963650226593017578125 * InternalPrior_122 - 1.0179031956769259981143704862915910780429840087890625 * InternalPrior_129 + 0.24586261757634397806526749263866804540157318115234375 * InternalPrior_131 - 0.0001311957341403962814564698735608772039995528757572174072265625 * InternalPrior_132 + 0.8494761527349925511742867456632666289806365966796875 * InternalPrior_133 + 0.5915080472697196167786160003743134438991546630859375 * InternalPrior_134 - 0.62329627464676573556090488636982627213001251220703125 * InternalPrior_135 - 0.200454391422503597208759629211272113025188446044921875 * InternalPrior_136 + 1.178666599969720341078982528415508568286895751953125 * InternalPrior_137 - 0.182689343172340645793383373529650270938873291015625 * InternalPrior_165 + 0.5244367062619954555913182048243470489978790283203125 * InternalPrior_166 - 0.9998213687850225905862089348374865949153900146484375 * InternalPrior_167 + 0.576166907665466521137886957149021327495574951171875 * InternalPrior_168 - 0.6000148234953492920595863324706442654132843017578125 * InternalPrior_171;
sigmaOmegaTALL = exp( log_sigmaOmegaTALL );
log_sigmaOmegaNTALL = -9.2103845999999993665596775826998054981231689453125 - 0.0219383147817363809151114395490367314778268337249755859375 * InternalPrior_116 + 0.0710679714223632352787518584591452963650226593017578125 * InternalPrior_122 + 1.3858566721624596684847574579180218279361724853515625 * InternalPrior_129 - 1.2782051058784553720926169262384064495563507080078125 * InternalPrior_131 + 6.5597867159925208192620960101493210459011606872081756591796875e-05 * InternalPrior_132 + 0.30449963024284010248976528600906021893024444580078125 * InternalPrior_133 - 0.45427840783564565896313069970346987247467041015625 * InternalPrior_134 - 0.1185591945677015868199077885947190225124359130859375 * InternalPrior_135 + 0.2470764276855315355607700666951132006943225860595703125 * InternalPrior_136 - 0.2395893852292204362353089663884020410478115081787109375 * InternalPrior_137 - 0.182689343172340645793383373529650270938873291015625 * InternalPrior_165 + 0.5244367062619954555913182048243470489978790283203125 * InternalPrior_166 - 0.9998213687850301401027763859019614756107330322265625 * InternalPrior_167 + 0.576166907665466521137886957149021327495574951171875 * InternalPrior_168 - 0.6000148234953492920595863324706442654132843017578125 * InternalPrior_171;
sigmaOmegaNTALL = exp( log_sigmaOmegaNTALL );
log_sigmaOmegaWALL = -9.2103845999999993665596775826998054981231689453125 - 0.0219383147817363809151114395490367314778268337249755859375 * InternalPrior_116 + 0.0710679714223632352787518584591452963650226593017578125 * InternalPrior_122 - 0.367953476485548158780858329919283278286457061767578125 * InternalPrior_129 + 1.0323424883020215769846572584356181323528289794921875 * InternalPrior_131 + 6.5597867159925208192620960101493210459011606872081756591796875e-05 * InternalPrior_132 - 1.1539757829781243092526210602954961359500885009765625 * InternalPrior_133 - 0.1372296394340981884329977447123383171856403350830078125 * InternalPrior_134 + 0.7418554692140997275373592856340110301971435546875 * InternalPrior_135 - 0.04662203626330337080663213100706343539059162139892578125 * InternalPrior_136 - 0.9390772147404995440211905588512308895587921142578125 * InternalPrior_137 - 0.182689343172340645793383373529650270938873291015625 * InternalPrior_165 + 0.5244367062619954555913182048243470489978790283203125 * InternalPrior_166 - 0.9998213687850301401027763859019614756107330322265625 * InternalPrior_167 + 0.576166907665466521137886957149021327495574951171875 * InternalPrior_168 - 0.6000148234953492920595863324706442654132843017578125 * InternalPrior_171;
sigmaOmegaWALL = exp( log_sigmaOmegaWALL );
log_sigmaOmegaKKALL = -9.2103845999999993665596775826998054981231689453125 - 0.02169072967185169120707399770253687165677547454833984375 * InternalPrior_116 + 0.06901403918470376541716149176863837055861949920654296875 * InternalPrior_122 - 0.77126626614067494980275796478963457047939300537109375 * InternalPrior_129 + 0.89274993489602250118508663945249281823635101318359375 * InternalPrior_130 - 0.76340437414265338578189812324126251041889190673828125 * InternalPrior_131 - 0.92020971843430554581999558649840764701366424560546875 * InternalPrior_132 + 0.375324151286664686733018925224314443767070770263671875 * InternalPrior_133 - 0.390988616037752756415812882551108486950397491455078125 * InternalPrior_134 + 1.2842635047295691830271380240446887910366058349609375 * InternalPrior_135 - 0.11168426608873398275800781220823409967124462127685546875 * InternalPrior_136 + 0.0789286184679031943556282158169778995215892791748046875 * InternalPrior_137 - 0.07017266222297673106123028219371917657554149627685546875 * InternalPrior_165 + 0.138073242332813317378992223893874324858188629150390625 * InternalPrior_166 - 0.85003679187362735092392540536820888519287109375 * InternalPrior_168 - 0.67571093196806819580757519361213780939579010009765625 * InternalPrior_171;
sigmaOmegaKKALL = exp( log_sigmaOmegaKKALL );
log_sigmaOmegaHLALL = -9.2103845999999993665596775826998054981231689453125 - 0.02169072967185169120707399770253687165677547454833984375 * InternalPrior_116 + 0.06901403918470376541716149176863837055861949920654296875 * InternalPrior_122 + 0.0695373165390078817882368866776232607662677764892578125 * InternalPrior_129 + 0.88546812461962998153097714748582802712917327880859375 * InternalPrior_130 + 0.77191913847006798921057679763180203735828399658203125 * InternalPrior_131 + 0.432287382698674449432729716136236675083637237548828125 * InternalPrior_132 + 0.115477513716741864158166208653710782527923583984375 * InternalPrior_133 - 1.304625885475127144985663107945583760738372802734375 * InternalPrior_134 - 1.1226301788826102967533415721845813095569610595703125 * InternalPrior_135 + 0.48398007847575186257671475686947815120220184326171875 * InternalPrior_136 - 0.040775779440046122648055870740790851414203643798828125 * InternalPrior_137 - 0.07017266222297914579630884190919459797441959381103515625 * InternalPrior_165 + 0.1380732423328118463334845955614582635462284088134765625 * InternalPrior_166 - 0.85003679187362735092392540536820888519287109375 * InternalPrior_168 - 0.67571093196806819580757519361213780939579010009765625 * InternalPrior_171;
sigmaOmegaHLALL = exp( log_sigmaOmegaHLALL );
log_sigmaOmegaKLALL = -9.2103845999999993665596775826998054981231689453125 - 0.02169072967185169120707399770253687165677547454833984375 * InternalPrior_116 + 0.06901403918470376541716149176863837055861949920654296875 * InternalPrior_122 + 0.845236739914219992186872332240454852581024169921875 * InternalPrior_129 + 0.88546812461962998153097714748582802712917327880859375 * InternalPrior_130 + 0.132476138649057439966583160639856941998004913330078125 * InternalPrior_131 + 0.432287382698674449432729716136236675083637237548828125 * InternalPrior_132 - 0.45263557431254797247532906112610362470149993896484375 * InternalPrior_133 + 1.6412705119063970560233656215132214128971099853515625 * InternalPrior_134 - 0.060508789814156915820575477482634596526622772216796875 * InternalPrior_135 - 0.40903414030333495876590177431353367865085601806640625 * InternalPrior_136 + 0.10335898250628004768625345377586199901998043060302734375 * InternalPrior_137 - 0.07017266222297914579630884190919459797441959381103515625 * InternalPrior_165 + 0.1380732423328118463334845955614582635462284088134765625 * InternalPrior_166 - 0.85003679187362735092392540536820888519287109375 * InternalPrior_168 - 0.67571093196806819580757519361213780939579010009765625 * InternalPrior_171;
sigmaOmegaKLALL = exp( log_sigmaOmegaKLALL );
log_sigmaOmegaHLXALL = -9.2103845999999993665596775826998054981231689453125 - 0.02169072967185155242919591955796931870281696319580078125 * InternalPrior_116 + 0.06901403918470323806122479481928166933357715606689453125 * InternalPrior_122 - 0.930291011763229480635573054314590990543365478515625 * InternalPrior_129 - 1.149797835974976312201079053920693695545196533203125 * InternalPrior_130 - 0.91386196207657643952870785142295062541961669921875 * InternalPrior_131 + 0.385038534481896899119846011672052554786205291748046875 * InternalPrior_132 - 0.259021020462262996364444234131951816380023956298828125 * InternalPrior_133 + 0.365946663502463021000465914767119102180004119873046875 * InternalPrior_134 - 0.69209596201244616420211741569801233708858489990234375 * InternalPrior_135 + 0.2443392660523582005094311853099497966468334197998046875 * InternalPrior_136 - 0.93414147532082203451153645801241509616374969482421875 * InternalPrior_137 - 0.07017266222294367417067206815772806294262409210205078125 * InternalPrior_165 + 0.138073242332781787045092869448126293718814849853515625 * InternalPrior_166 - 0.8500367918736302375037894307752139866352081298828125 * InternalPrior_168 - 0.6757109319680643100269890055642463266849517822265625 * InternalPrior_171;
sigmaOmegaHLXALL = exp( log_sigmaOmegaHLXALL );
log_sigmaOmegaHLXKLALL = -9.2103845999999993665596775826998054981231689453125 - 0.02169072967185155242919591955796931870281696319580078125 * InternalPrior_116 + 0.06901403918470323806122479481928166933357715606689453125 * InternalPrior_122 + 0.7867832214506780275087294285185635089874267578125 * InternalPrior_129 - 1.5138883481603244707258681955863721668720245361328125 * InternalPrior_130 + 0.77287105910010467368920217268168926239013671875 * InternalPrior_131 - 0.329403581444940252165309857446118257939815521240234375 * InternalPrior_132 + 0.22085492977140364079247092377045191824436187744140625 * InternalPrior_133 - 0.311602673895979676021994464463205076754093170166015625 * InternalPrior_134 + 0.5909714259796459145945846103131771087646484375 * InternalPrior_135 - 0.20760093813604119095117539472994394600391387939453125 * InternalPrior_136 + 0.79262965378668559512931324206874705851078033447265625 * InternalPrior_137 - 0.070172662222956094790760062096524052321910858154296875 * InternalPrior_165 + 0.1380732423327941660318174399435520172119140625 * InternalPrior_166 - 0.85003679187362435332175891744554974138736724853515625 * InternalPrior_168 - 0.6757109319680643100269890055642463266849517822265625 * InternalPrior_171;
sigmaOmegaHLXKLALL = exp( log_sigmaOmegaHLXKLALL );
log_sigmaOmegaS1ALL = -9.2122422999999997728082234971225261688232421875 - 0.0221204908562374590041965660702771856449544429779052734375 * InternalPrior_116 + 0.0726275096981639223248095049711992032825946807861328125 * InternalPrior_122 - 1.534540779822346490135487329098396003246307373046875 * InternalPrior_162 - 1.2797303707144305207066281582228839397430419921875 * InternalPrior_163 + 1.1643807127091043707167727916385047137737274169921875 * InternalPrior_165 - 0.51466658645315954689891668749623931944370269775390625 * InternalPrior_166 + 0.260641735098667337577893476918688975274562835693359375 * InternalPrior_168 - 0.55514395814248029825677122062188573181629180908203125 * InternalPrior_171;
sigmaOmegaS1ALL = exp( log_sigmaOmegaS1ALL );
log_sigmaOmegaKALL = -9.2103845999999993665596775826998054981231689453125 - 0.0219383147817363809151114395490367314778268337249755859375 * InternalPrior_116 + 0.0710679714223632352787518584591452963650226593017578125 * InternalPrior_122 + 0.00366276098166450243820424503837784868665039539337158203125 * InternalPrior_129 - 0.08514244761343113532259252451694919727742671966552734375 * InternalPrior_131 + 0.1069900059467346065122939080538344569504261016845703125 * InternalPrior_133 - 0.425498706145373606357651397047447971999645233154296875 * InternalPrior_134 - 0.351449675882904932766592764892266131937503814697265625 * InternalPrior_135 - 1.881819690781103115995165353524498641490936279296875 * InternalPrior_136 - 0.34854144784957530323055152621236629784107208251953125 * InternalPrior_137 - 0.182689343172340645793383373529650270938873291015625 * InternalPrior_165 + 0.5244367062619954555913182048243470489978790283203125 * InternalPrior_166 + 0.99982136878523963918752315294113941490650177001953125 * InternalPrior_167 + 0.576166907665466521137886957149021327495574951171875 * InternalPrior_168 - 0.6000148234953492920595863324706442654132843017578125 * InternalPrior_171;
sigmaOmegaKALL = exp( log_sigmaOmegaKALL );
log_sigmaOmegaHALL = -9.2103845999999993665596775826998054981231689453125 - 0.0219383147817363809151114395490367314778268337249755859375 * InternalPrior_116 + 0.0710679714223632352787518584591452963650226593017578125 * InternalPrior_122 - 0.13484298796655647123543531051836907863616943359375 * InternalPrior_129 - 0.47065422837119097465574668603949248790740966796875 * InternalPrior_131 - 1.3268798717706591361320533906109631061553955078125 * InternalPrior_133 - 0.1249693471476648609641557641225517727434635162353515625 * InternalPrior_134 - 0.009161516949870572579239791366489953361451625823974609375 * InternalPrior_135 + 0.82422629578000172756446772837080061435699462890625 * InternalPrior_136 + 1.1360649368299415851168987501296214759349822998046875 * InternalPrior_137 - 0.182689343172340645793383373529650270938873291015625 * InternalPrior_165 + 0.5244367062619954555913182048243470489978790283203125 * InternalPrior_166 + 0.9998213687850974196180686703883111476898193359375 * InternalPrior_167 + 0.576166907665466521137886957149021327495574951171875 * InternalPrior_168 - 0.6000148234953492920595863324706442654132843017578125 * InternalPrior_171;
sigmaOmegaHALL = exp( log_sigmaOmegaHALL );
log_sigmaOmegaCALL = -9.2103845999999993665596775826998054981231689453125 - 0.0219383147817363809151114395490367314778268337249755859375 * InternalPrior_116 + 0.0710679714223632352787518584591452963650226593017578125 * InternalPrior_122 + 0.1311802269848920676764691961579956114292144775390625 * InternalPrior_129 + 0.5557966759846990623117335417191497981548309326171875 * InternalPrior_131 + 1.2198898658242114390048982386360876262187957763671875 * InternalPrior_133 + 0.55046805329306724985372056835331022739410400390625 * InternalPrior_134 + 0.360611192833132199186962907333509065210819244384765625 * InternalPrior_135 + 1.057593395001380276454483464476652443408966064453125 * InternalPrior_136 - 0.787523488980379937629550113342702388763427734375 * InternalPrior_137 - 0.182689343172340645793383373529650270938873291015625 * InternalPrior_165 + 0.5244367062619954555913182048243470489978790283203125 * InternalPrior_166 + 0.9998213687847450348300526457023806869983673095703125 * InternalPrior_167 + 0.576166907665466521137886957149021327495574951171875 * InternalPrior_168 - 0.6000148234953492920595863324706442654132843017578125 * InternalPrior_171;
sigmaOmegaCALL = exp( log_sigmaOmegaCALL );
log_sigmaOmegaDi = -9.2122422999999997728082234971225261688232421875 - 0.0221204908562374590041965660702771856449544429779052734375 * InternalPrior_116 + 0.0726275096981639223248095049711992032825946807861328125 * InternalPrior_122 + 1.875549400944346079000979443662799894809722900390625 * InternalPrior_162 - 0.6890861131121199800730892093270085752010345458984375 * InternalPrior_163 + 1.1643807127091043707167727916385047137737274169921875 * InternalPrior_165 - 0.51466658645315954689891668749623931944370269775390625 * InternalPrior_166 + 0.260641735098667337577893476918688975274562835693359375 * InternalPrior_168 - 0.55514395814248029825677122062188573181629180908203125 * InternalPrior_171;
sigmaOmegaDi = exp( log_sigmaOmegaDi );
log_sigmaOmegaPALL = -9.2103845999999993665596775826998054981231689453125 - 0.0220642390158193417437626493438074248842895030975341796875 * InternalPrior_116 + 0.07214147547972991902920369966523139737546443939208984375 * InternalPrior_122 - 0.1626374897118002815776804936831467784941196441650390625 * InternalPrior_129 - 0.1622837661218409499586101674140081740915775299072265625 * InternalPrior_131 + 1.500285128449740046363558576558716595172882080078125 * InternalPrior_132 + 0.22121686904618087510243640281260013580322265625 * InternalPrior_133 - 0.2495355493832770166218182339434861205518245697021484375 * InternalPrior_134 + 0.7179558151457146042417889475473202764987945556640625 * InternalPrior_135 - 0.0992061770308987067590322794785606674849987030029296875 * InternalPrior_136 + 0.2221525780333402366739647959548165090382099151611328125 * InternalPrior_137 - 0.921338301796001513110923042404465377330780029296875 * InternalPrior_165 - 1.313965904628831449230119687854312360286712646484375 * InternalPrior_166 + 0.313320301045553251118036541811306960880756378173828125 * InternalPrior_168 - 0.5681892925703360130995633880957029759883880615234375 * InternalPrior_171;
sigmaOmegaPALL = exp( log_sigmaOmegaPALL );
log_sigmaOmegaGALL = -9.2103845999999993665596775826998054981231689453125 - 0.0220642390158193417437626493438074248842895030975341796875 * InternalPrior_116 + 0.07214147547972991902920369966523139737546443939208984375 * InternalPrior_122 + 0.1626374897118001427998024155385792255401611328125 * InternalPrior_129 + 0.1622837661218407279140052423827000893652439117431640625 * InternalPrior_131 - 1.5002851284497420447650029018404893577098846435546875 * InternalPrior_132 - 0.2212168690461802089686216277186758816242218017578125 * InternalPrior_133 + 0.2495355493832759619099448400447727181017398834228515625 * InternalPrior_134 - 0.7179558151457119397065298471716232597827911376953125 * InternalPrior_135 + 0.09920617703089872063682008729301742278039455413818359375 * InternalPrior_136 - 0.2221525780333399036070574084078543819487094879150390625 * InternalPrior_137 - 0.921338301796001513110923042404465377330780029296875 * InternalPrior_165 - 1.313965904628831449230119687854312360286712646484375 * InternalPrior_166 + 0.313320301045553251118036541811306960880756378173828125 * InternalPrior_168 - 0.5681892925703360130995633880957029759883880615234375 * InternalPrior_171;
sigmaOmegaGALL = exp( log_sigmaOmegaGALL );
log_sigmaOmegaDemandALL = -8.76664230000000088693923316895961761474609375 - 0.03731211933952278958503967487558838911354541778564453125 * InternalPrior_116 + 1.4879043082380876139581005190848372876644134521484375 * InternalPrior_117 + 0.55058425872813610002509676633053459227085113525390625 * InternalPrior_118 - 1.014136380975398044057556035113520920276641845703125 * InternalPrior_119 - 0.873500066343205094909762919996865093708038330078125 * InternalPrior_120 - 0.55824762586258724894605620647780597209930419921875 * InternalPrior_121 - 0.9563675983150650150577121166861616075038909912109375 * InternalPrior_122 + 0.003211826560340726166575819888748810626566410064697265625 * InternalPrior_165 - 0.0052438032359266757709281847610327531583607196807861328125 * InternalPrior_166 + 0.00935860866864045119750681323012031498365104198455810546875 * InternalPrior_168 - 0.11895998519110662083875240568886511027812957763671875 * InternalPrior_171;
sigmaOmegaDemandALL = exp( log_sigmaOmegaDemandALL );
log_sigmaOmegahi = -8.0955422999999999689180185669101774692535400390625 - 0.6376054862991280547390715582878328859806060791015625 * InternalPrior_113 + 1.56034718600021182766113270190544426441192626953125 * InternalPrior_114 - 0.902714080139718877404675367870368063449859619140625 * InternalPrior_115 + 1.1046104890400700870856098845251835882663726806640625 * InternalPrior_116 - 0.04283454623343412037694832861234317533671855926513671875 * InternalPrior_122 + 0.00128415015234035665390999181312281507416628301143646240234375 * InternalPrior_165 - 0.0021059913287479769573862231624161722720600664615631103515625 * InternalPrior_166 + 0.003817918010179491804245710540044456138275563716888427734375 * InternalPrior_168 - 0.054500793916995034227301886176064726896584033966064453125 * InternalPrior_171;
sigmaOmegahi = exp( log_sigmaOmegahi );
log_sigmaOmegaCPi = -8.76664230000000088693923316895961761474609375 - 0.037312119339522768768357963153903256170451641082763671875 * InternalPrior_116 - 1.16460247678883010991057744831778109073638916015625 * InternalPrior_117 + 0.55059226166823227455182632184005342423915863037109375 * InternalPrior_118 - 1.0683141049417097523388520130538381636142730712890625 * InternalPrior_119 + 1.131085516160074799785206778324209153652191162109375 * InternalPrior_120 - 0.7348587579237475519988720407127402722835540771484375 * InternalPrior_121 - 0.95636759831506490403540965417050756514072418212890625 * InternalPrior_122 + 0.0032118265603443166104902228852324697072617709636688232421875 * InternalPrior_165 - 0.005243803235923987816902158698439961881376802921295166015625 * InternalPrior_166 + 0.00935860866864085712280019180298040737397968769073486328125 * InternalPrior_168 - 0.11895998519110662083875240568886511027812957763671875 * InternalPrior_171;
sigmaOmegaCPi = exp( log_sigmaOmegaCPi );
log_sigmaOmegaCi = -8.76664230000000088693923316895961761474609375 - 0.037312119339522768768357963153903256170451641082763671875 * InternalPrior_116 + 0.95063483965648154505601041819318197667598724365234375 * InternalPrior_117 + 0.55108716605458096804426304515800438821315765380859375 * InternalPrior_118 + 1.11119213886712042693716284702531993389129638671875 * InternalPrior_119 + 1.34202052165834917474285248317755758762359619140625 * InternalPrior_120 + 0.6139600315511983819050101374159567058086395263671875 * InternalPrior_121 - 0.9563675983150650150577121166861616075038909912109375 * InternalPrior_122 + 0.00321182656034051279558827474147619795985519886016845703125 * InternalPrior_165 - 0.0052438032359277929328467138248015544377267360687255859375 * InternalPrior_166 + 0.0093586086686397000622417152726484346203505992889404296875 * InternalPrior_168 - 0.11895998519110662083875240568886511027812957763671875 * InternalPrior_171;
sigmaOmegaCi = exp( log_sigmaOmegaCi );
log_sigmaOmegaTradeALL = -8.76664230000000088693923316895961761474609375 - 0.037312119339522852035084810040643787942826747894287109375 * InternalPrior_116 - 1.0161634407996487095005022638360969722270965576171875 * InternalPrior_117 + 1.02155600595255346973999621695838868618011474609375 * InternalPrior_118 + 0.8409046003760209941901848651468753814697265625 * InternalPrior_119 - 1.283547965193956752472104199114255607128143310546875 * InternalPrior_120 + 0.435128596774283227244239924402791075408458709716796875 * InternalPrior_121 - 0.9563675983150539128274658651207573711872100830078125 * InternalPrior_122 + 0.00321182656034390938415423732976705650798976421356201171875 * InternalPrior_165 - 0.005243803235934451668909250798833454609848558902740478515625 * InternalPrior_166 + 0.0093586086686524884437066162945484393276274204254150390625 * InternalPrior_168 - 0.1189599851911059824605132462238543666899204254150390625 * InternalPrior_171;
sigmaOmegaTradeALL = exp( log_sigmaOmegaTradeALL );
log_sigmaOmegaYi = -8.0955422999999999689180185669101774692535400390625 - 0.63688807535396019243734144765767268836498260498046875 * InternalPrior_113 + 0.0017457829423221196164794921656948645249940454959869384765625 * InternalPrior_114 + 1.802910796244204139071598547161556780338287353515625 * InternalPrior_115 + 1.1046104890400545439632651323336176574230194091796875 * InternalPrior_116 - 0.042834546233434946105322893572520115412771701812744140625 * InternalPrior_122 + 0.00128415015234101541514999400561691800248809158802032470703125 * InternalPrior_165 - 0.00210599132874831999895359757601909223012626171112060546875 * InternalPrior_166 + 0.0038179180101799892362024468894787787576206028461456298828125 * InternalPrior_168 - 0.054500793916994798304909153330299886874854564666748046875 * InternalPrior_171;
sigmaOmegaYi = exp( log_sigmaOmegaYi );
log_sigmaOmegaTCi = -8.76664230000000088693923316895961761474609375 - 0.0373121193395228034628274826900451444089412689208984375 * InternalPrior_116 - 0.176134602761766956291467067785561084747314453125 * InternalPrior_117 - 1.2477003069079601882407359880744479596614837646484375 * InternalPrior_118 - 0.77862670804765821142012782729580067098140716552734375 * InternalPrior_119 - 0.1172640791349804645360421773148118518292903900146484375 * InternalPrior_120 + 1.5531670111242104059812163541209883987903594970703125 * InternalPrior_121 - 0.95636759831510642637653063502511940896511077880859375 * InternalPrior_122 + 0.003211826560337751983176257652985441382043063640594482421875 * InternalPrior_165 - 0.0052438032359256349368425986767761060036718845367431640625 * InternalPrior_166 + 0.009358608668640154559792421196107170544564723968505859375 * InternalPrior_168 - 0.11895998519110558000466681960460846312344074249267578125 * InternalPrior_171;
sigmaOmegaTCi = exp( log_sigmaOmegaTCi );
log_sigmaOmegaWPi = -8.76664230000000088693923316895961761474609375 - 0.03731211933952378878576183751647477038204669952392578125 * InternalPrior_116 - 0.08163862754432539559079629043480963446199893951416015625 * InternalPrior_117 - 1.426119385495420832654644982540048658847808837890625 * InternalPrior_118 + 0.90898045472163169211654576429282315075397491455078125 * InternalPrior_119 - 0.1987939271462824952774184339432395063340663909912109375 * InternalPrior_120 - 1.3091492556633657073916765511967241764068603515625 * InternalPrior_121 - 0.95636759831510353979666660961811430752277374267578125 * InternalPrior_122 + 0.0032118265603412513541081718670966438367031514644622802734375 * InternalPrior_165 - 0.0052438032359249132918765923250248306430876255035400390625 * InternalPrior_166 + 0.0093586086686359253039579897404109942726790904998779296875 * InternalPrior_168 - 0.11895998519110996538561408897294313646852970123291015625 * InternalPrior_171;
sigmaOmegaWPi = exp( log_sigmaOmegaWPi );
log_sigmaOmegaWCi = -8.0955422999999999689180185669101774692535400390625 + 1.9120974218754167583966818710905499756336212158203125 * InternalPrior_113 + 5.050156924153171897448784399831112068568472750484943389892578125e-07 * InternalPrior_114 - 0.000506711966046483226755459128298753057606518268585205078125 * InternalPrior_115 + 1.104610489040134257976433218573220074176788330078125 * InternalPrior_116 - 0.042834546233434071804691001261744531802833080291748046875 * InternalPrior_122 + 0.00128415015234067410830609556882109245634637773036956787109375 * InternalPrior_165 - 0.0021059913287482562478658554283583725919015705585479736328125 * InternalPrior_166 + 0.0038179180101798591319417486289466978632844984531402587890625 * InternalPrior_168 - 0.05450079391699440278795663061828236095607280731201171875 * InternalPrior_171;
sigmaOmegaWCi = exp( log_sigmaOmegaWCi );
phiLtauKG = 0 - 0.04381514109493196695854777544809621758759021759033203125 * InternalPrior_51 + 0.1772330106879017319609914693501195870339870452880859375 * InternalPrior_56 + 0.46546051748062711173048455748357810080051422119140625 * InternalPrior_96;
phiLtauHG = 0 - 0.13158071909745572281025260963360778987407684326171875 * InternalPrior_51 - 0.12656153060256147835360707176732830703258514404296875 * InternalPrior_56 + 0.465460517480626834174728401194442994892597198486328125 * InternalPrior_96;
phiLtauCG = 0 + 0.1753958601923875926242857303805067203938961029052734375 * InternalPrior_51 - 0.050671480085340232790702685861106147058308124542236328125 * InternalPrior_56 + 0.465460517480627389286240713772713206708431243896484375 * InternalPrior_96;
phiLtaub = 0 - 0.1581090762733120269611930552855483256280422210693359375 * InternalPrior_54 + 0.474327228819936108639154781485558487474918365478515625 * InternalPrior_89;
phiLtaul = 0 + 0.1581090762733120269611930552855483256280422210693359375 * InternalPrior_54 + 0.474327228819936108639154781485558487474918365478515625 * InternalPrior_89;
phiYtauKG = 0 - 0.04381514109493196695854777544809621758759021759033203125 * InternalPrior_52 + 0.1772330106879017319609914693501195870339870452880859375 * InternalPrior_57 + 0.46546051748062711173048455748357810080051422119140625 * InternalPrior_97;
phiYtauHG = 0 - 0.13158071909745572281025260963360778987407684326171875 * InternalPrior_52 - 0.12656153060256147835360707176732830703258514404296875 * InternalPrior_57 + 0.465460517480626834174728401194442994892597198486328125 * InternalPrior_97;
phiYtauCG = 0 + 0.1753958601923875926242857303805067203938961029052734375 * InternalPrior_52 - 0.050671480085340232790702685861106147058308124542236328125 * InternalPrior_57 + 0.465460517480627389286240713772713206708431243896484375 * InternalPrior_97;
phiYtaub = 0 - 0.1581090762733120269611930552855483256280422210693359375 * InternalPrior_55 + 0.474327228819936108639154781485558487474918365478515625 * InternalPrior_88;
phiYtaul = 0 + 0.1581090762733120269611930552855483256280422210693359375 * InternalPrior_55 + 0.474327228819936108639154781485558487474918365478515625 * InternalPrior_88;
phiuiotaTX = 0 - 0.07567977788571778052784111423534341156482696533203125 * InternalPrior_16 + 0.0612797714807379600987502499265247024595737457275390625 * InternalPrior_17 + 0.10122266672943201759604647804735577665269374847412109375 * InternalPrior_18 - 0.0003603591864442535195635353151288882145308889448642730712890625 * InternalPrior_19 + 0.033354403618250656748944749097063322551548480987548828125 * InternalPrior_20 - 0.00059495138192105470782700127330144823645241558551788330078125 * InternalPrior_21 + 0.01015559889437156991520705417997305630706250667572021484375 * InternalPrior_65 + 0.0621048084268299993571105233058915473520755767822265625 * InternalPrior_84 + 0.288032227205502977529505415077437646687030792236328125 * InternalPrior_90 + 0.3772739524170745095688062065164558589458465576171875 * InternalPrior_105;
phiuiotaTM = 0 - 0.0756828781240597991963880986077128909528255462646484375 * InternalPrior_16 - 0.039696855948598307184393974011982209049165248870849609375 * InternalPrior_17 - 0.11180359484968284411454675364439026452600955963134765625 * InternalPrior_18 - 0.000360115693438703096153352678499004468903876841068267822265625 * InternalPrior_19 + 0.032208724394412240055185492337841424159705638885498046875 * InternalPrior_20 - 0.000594688922916140438705567827781806045095436275005340576171875 * InternalPrior_21 + 0.01015559889437156991520705417997305630706250667572021484375 * InternalPrior_65 + 0.0621048084268299993571105233058915473520755767822265625 * InternalPrior_84 + 0.288032227205502977529505415077437646687030792236328125 * InternalPrior_90 + 0.3772739524170745095688062065164558589458465576171875 * InternalPrior_105;
phiuiotaWX = 0 + 0.02976853955937654172547723874231451191008090972900390625 * InternalPrior_16 - 0.07832180862429612144826052144708228297531604766845703125 * InternalPrior_17 + 0.037723050842221959866318314880118123255670070648193359375 * InternalPrior_18 + 0.00173933274876759903955492081450984187540598213672637939453125 * InternalPrior_19 - 0.11121693929378183296474702501654974184930324554443359375 * InternalPrior_20 + 0.0050925845293352915710283213002185220830142498016357421875 * InternalPrior_21 + 0.01015559889437156644576010222635886748321354389190673828125 * InternalPrior_65 + 0.0621048084268299993571105233058915473520755767822265625 * InternalPrior_84 + 0.288032227205502977529505415077437646687030792236328125 * InternalPrior_90 + 0.3772739524170745095688062065164558589458465576171875 * InternalPrior_105;
phiuiotaWM = 0 + 0.12159411645040103799875197410074179060757160186767578125 * InternalPrior_16 + 0.0567388930921563783282834947385708801448345184326171875 * InternalPrior_17 - 0.0271421227219710604894320482571856700815260410308837890625 * InternalPrior_18 - 0.0010188578688846397675427102313960858737118542194366455078125 * InternalPrior_19 + 0.045653811281118984732874110932243638671934604644775390625 * InternalPrior_20 - 0.003902944224498124288491585076599221793003380298614501953125 * InternalPrior_21 + 0.01015559889437156644576010222635886748321354389190673828125 * InternalPrior_65 + 0.0621048084268299993571105233058915473520755767822265625 * InternalPrior_84 + 0.288032227205502977529505415077437646687030792236328125 * InternalPrior_90 + 0.3772739524170745095688062065164558589458465576171875 * InternalPrior_105;
phiutauKG = 0 - 0.006715152732622998998923691260642954148352146148681640625 * InternalPrior_53 + 0.1824450969208115391761992896135780028998851776123046875 * InternalPrior_58 - 0.465460517480627888886601795093156397342681884765625 * InternalPrior_98;
phiutauHG = 0 + 0.1613596650956481137750841980960103683173656463623046875 * InternalPrior_53 - 0.08540705560366179671660802341648377478122711181640625 * InternalPrior_58 - 0.465460517480627722353148101319675333797931671142578125 * InternalPrior_98;
phiutauCG = 0 - 0.1546445123630252049817812576293363235890865325927734375 * InternalPrior_53 - 0.09703804131714978409295468964046449400484561920166015625 * InternalPrior_58 - 0.465460517480627500308543176288367249071598052978515625 * InternalPrior_98;
phiutaub = 0 + 0.018095401575242413272359698339641909115016460418701171875 * InternalPrior_16 - 0.07941875039410815906304463851483887992799282073974609375 * InternalPrior_17 + 0.037245462495423715953979382220495608635246753692626953125 * InternalPrior_18 + 0.003176216637522088874490133747485742787830531597137451171875 * InternalPrior_19 + 0.07430130195044758190103806327897473238408565521240234375 * InternalPrior_20 + 0.018484242681565073163074686135587398894131183624267578125 * InternalPrior_21 + 0.032193911942004972692732422956396476365625858306884765625 * InternalPrior_65 + 0.283495857442881138421597597698564641177654266357421875 * InternalPrior_82 - 0.05474275123452942981572277858504094183444976806640625 * InternalPrior_83 - 0.1863208332966062863444989261552109383046627044677734375 * InternalPrior_84 - 0.02229336678874767330160722167420317418873310089111328125 * InternalPrior_90 + 0.341452778449306271202345897108898498117923736572265625 * InternalPrior_105;
phiutaul = 0 - 0.018095401575242399394571890525185153819620609283447265625 * InternalPrior_16 + 0.07941875039410815906304463851483887992799282073974609375 * InternalPrior_17 - 0.037245462495423715953979382220495608635246753692626953125 * InternalPrior_18 - 0.003176216637522064588361470072186421020887792110443115234375 * InternalPrior_19 - 0.07430130195044758190103806327897473238408565521240234375 * InternalPrior_20 - 0.01848424268156512173533201348618604242801666259765625 * InternalPrior_21 + 0.032193911942004972692732422956396476365625858306884765625 * InternalPrior_65 + 0.283495857442881138421597597698564641177654266357421875 * InternalPrior_82 - 0.05474275123452936042678373951275716535747051239013671875 * InternalPrior_83 - 0.1863208332966062863444989261552109383046627044677734375 * InternalPrior_84 - 0.02229336678874767330160722167420317418873310089111328125 * InternalPrior_90 + 0.341452778449306271202345897108898498117923736572265625 * InternalPrior_105;
phiutauD = 0 - 0.00192070568021930621060988642057054676115512847900390625 * InternalPrior_16 + 0.0156452023166013358401738031489003333263099193572998046875 * InternalPrior_17 - 0.007370334176453570591835973146999094751663506031036376953125 * InternalPrior_18 + 0.023120903518449552327407303664585924707353115081787109375 * InternalPrior_19 - 0.00845222305815555331742761069335756474174559116363525390625 * InternalPrior_20 + 0.11395457627561840496799305810782243497669696807861328125 * InternalPrior_21 + 0.03219391194200495187605071123471134342253208160400390625 * InternalPrior_65 - 0.1891565419635949651944173410811345092952251434326171875 * InternalPrior_82 - 0.2181432387959222063411601766347303055226802825927734375 * InternalPrior_83 - 0.1863208332966061753221964636395568959414958953857421875 * InternalPrior_84 - 0.0222933667887476837099480775350457406602799892425537109375 * InternalPrior_90 + 0.341452778449306271202345897108898498117923736572265625 * InternalPrior_105;
phiutauND = 0 + 0.00192070568021930447588641044376345234923064708709716796875 * InternalPrior_16 - 0.0156452023166013080845981875199868227355182170867919921875 * InternalPrior_17 + 0.00737033417645355758140990332094588666222989559173583984375 * InternalPrior_18 - 0.023120903518449566205195111479042680002748966217041015625 * InternalPrior_19 + 0.00845222305815552903129894701805824297480285167694091796875 * InternalPrior_20 - 0.11395457627561840496799305810782243497669696807861328125 * InternalPrior_21 + 0.03219391194200495187605071123471134342253208160400390625 * InternalPrior_65 - 0.1891565419635949651944173410811345092952251434326171875 * InternalPrior_82 - 0.218143238795922178585584561005816794931888580322265625 * InternalPrior_83 - 0.1863208332966061753221964636395568959414958953857421875 * InternalPrior_84 - 0.0222933667887476837099480775350457406602799892425537109375 * InternalPrior_90 + 0.341452778449306271202345897108898498117923736572265625 * InternalPrior_105;
phiutauNT = 0 - 0.37372882963492359831292333183228038251399993896484375 * InternalPrior_65 - 0.062063556941882667972176790271987556479871273040771484375 * InternalPrior_84 - 0.0144832618477880419038950066124016302637755870819091796875 * InternalPrior_90 + 0.32596231672645858967740650768973864614963531494140625 * InternalPrior_105;
phiutauLa = 0 + 3.7001463009246320242338901262968420269316993653774261474609375e-05 * InternalPrior_16 + 7.4162600612772379350852436363794595308718271553516387939453125e-05 * InternalPrior_17 - 3.10115277350222522047447359927474508367595262825489044189453125e-05 * InternalPrior_18 - 0.115531896125919075757337850518524646759033203125 * InternalPrior_19 - 0.00078951550778710226190237886356726448866538703441619873046875 * InternalPrior_20 + 0.0233708111091241767243165128320470103062689304351806640625 * InternalPrior_21 + 0.032193911942004993509414134678081609308719635009765625 * InternalPrior_65 - 0.09433931547928632588284614257645444013178348541259765625 * InternalPrior_82 + 0.272885990030451497379004877075203694403171539306640625 * InternalPrior_83 - 0.18632083329660620307777207926847040653228759765625 * InternalPrior_84 - 0.0222933667887476837099480775350457406602799892425537109375 * InternalPrior_90 + 0.341452778449306271202345897108898498117923736572265625 * InternalPrior_105;
phiutauLb = 0 - 3.70014630092433048050466759537613370412145741283893585205078125e-05 * InternalPrior_16 - 7.416260061276968239794837867151500176987610757350921630859375e-05 * InternalPrior_17 + 3.101152773501858624614901938087996313697658479213714599609375e-05 * InternalPrior_18 + 0.1155318961259190480017622348896111361682415008544921875 * InternalPrior_19 + 0.0007895155077870855651889225867989807738922536373138427734375 * InternalPrior_20 - 0.0233708111091241628465287050175902550108730792999267578125 * InternalPrior_21 + 0.03219391194200497963162632686362485401332378387451171875 * InternalPrior_65 - 0.09433931547928635363842175820536795072257518768310546875 * InternalPrior_82 + 0.272885990030451608401307339590857736766338348388671875 * InternalPrior_83 - 0.1863208332966062308333476948973839171230792999267578125 * InternalPrior_84 - 0.022293366788747680240501125581431551836431026458740234375 * InternalPrior_90 + 0.341452778449306271202345897108898498117923736572265625 * InternalPrior_105;
phiutauHW = 0 + 0.11770605764464391052026570605448796413838863372802734375 * InternalPrior_60 - 0.068346255643030040527463597754831425845623016357421875 * InternalPrior_61 + 0.01225244971237893394644391520387216587550938129425048828125 * InternalPrior_65 + 0.09315681215473346765687523429733118973672389984130859375 * InternalPrior_84 - 0.06424773146044744642768620224160258658230304718017578125 * InternalPrior_85 - 0.2645296498860820744170041507459245622158050537109375 * InternalPrior_86 - 0.11614101442016562526493572704566759057343006134033203125 * InternalPrior_90 + 0.367632054180990486269564598842407576739788055419921875 * InternalPrior_105;
phiutauHT = 0 - 0.11804262246273171388377676294112461619079113006591796875 * InternalPrior_60 - 0.06776330827806202605767538216241518966853618621826171875 * InternalPrior_61 + 0.01225244971237891312976220348218703293241560459136962890625 * InternalPrior_65 + 0.0931568121547335092902386577407014556229114532470703125 * InternalPrior_84 - 0.0642477314604474603054740100560593418776988983154296875 * InternalPrior_85 - 0.26452964988608174135009676319896243512630462646484375 * InternalPrior_86 - 0.116141014420165611387147919231210835278034210205078125 * InternalPrior_90 + 0.367632054180990597291867061358061619102954864501953125 * InternalPrior_105;
phiutauHNT = 0 + 0.00033656481808778623311673161566659473464824259281158447265625 * InternalPrior_60 + 0.1361095639210920527073511721027898602187633514404296875 * InternalPrior_61 + 0.0122524497123788524144405442939387285150587558746337890625 * InternalPrior_65 + 0.0931568121547335092902386577407014556229114532470703125 * InternalPrior_84 - 0.06424773146044739091653497098377556540071964263916015625 * InternalPrior_85 - 0.264529649886081907883550456972443498671054840087890625 * InternalPrior_86 - 0.11614101442016573628723818956132163293659687042236328125 * InternalPrior_90 + 0.367632054180990486269564598842407576739788055419921875 * InternalPrior_105;
phiutauKW = 0 + 0.1177060576446440631759315920135122723877429962158203125 * InternalPrior_60 - 0.0683462556430299572607367508680908940732479095458984375 * InternalPrior_61 + 0.01225244971237868067681642259003638173453509807586669921875 * InternalPrior_65 + 0.0931568121547336203125411202563554979860782623291015625 * InternalPrior_84 - 0.196965531125326720474078001643647439777851104736328125 * InternalPrior_85 + 0.1879049925233087225961980948341079056262969970703125 * InternalPrior_86 - 0.11614101442016566689829915048903785645961761474609375 * InternalPrior_90 + 0.367632054180990597291867061358061619102954864501953125 * InternalPrior_105;
phiutauKT = 0 - 0.1180426224627316444948377238688408397138118743896484375 * InternalPrior_60 - 0.06776330827806199830209976653350167907774448394775390625 * InternalPrior_61 + 0.01225244971237884027137621245628906763158738613128662109375 * InternalPrior_65 + 0.09315681215473360643475331244189874269068241119384765625 * InternalPrior_84 - 0.196965531125326609451775539127993397414684295654296875 * InternalPrior_85 + 0.18790499252330883361850055734976194798946380615234375 * InternalPrior_86 - 0.116141014420165500364845456715556792914867401123046875 * InternalPrior_90 + 0.36763205418099065280301829261588864028453826904296875 * InternalPrior_105;
phiutauKNT = 0 + 0.00033656481808768171602730401303915641619823873043060302734375 * InternalPrior_60 + 0.136109563921092135974078018989530391991138458251953125 * InternalPrior_61 + 0.01225244971237890966031525152857284410856664180755615234375 * InternalPrior_65 + 0.0931568121547335648013898889985284768044948577880859375 * InternalPrior_84 - 0.1969655311253266649629267703858204185962677001953125 * InternalPrior_85 + 0.1879049925233088613740761729786754585802555084228515625 * InternalPrior_86 - 0.116141014420165722409450381746864877641201019287109375 * InternalPrior_90 + 0.3676320541809905417807158301002345979213714599609375 * InternalPrior_105;
phiutauXW = 0 + 0.11770605764464402154256816857014200650155544281005859375 * InternalPrior_60 - 0.0683462556430305401278246790752746164798736572265625 * InternalPrior_61 + 0.01225244971237882986303535659544650116004049777984619140625 * InternalPrior_65 + 0.0931568121547335092902386577407014556229114532470703125 * InternalPrior_84 + 0.261213262585773875468220239781658165156841278076171875 * InternalPrior_85 + 0.07662465736277289385380839803474373184144496917724609375 * InternalPrior_86 - 0.11614101442016620813202365525285131298005580902099609375 * InternalPrior_90 + 0.36763205418099020871380844255327247083187103271484375 * InternalPrior_105;
phiutauXT = 0 - 0.11804262246273149183917183790981653146445751190185546875 * InternalPrior_60 - 0.0677633082780623452467949618949205614626407623291015625 * InternalPrior_61 + 0.0122524497123788385366527364794819732196629047393798828125 * InternalPrior_65 + 0.09315681215473341214572400303950416855514049530029296875 * InternalPrior_84 + 0.26121326258577359791246408349252305924892425537109375 * InternalPrior_85 + 0.0766246573627729909983230527359410189092159271240234375 * InternalPrior_86 - 0.11614101442016595833184311459262971766293048858642578125 * InternalPrior_90 + 0.367632054180989931158052286264137364923954010009765625 * InternalPrior_105;
phiutauXNT = 0 + 0.000336564818087561369586158122046981588937342166900634765625 * InternalPrior_60 + 0.1361095639210924967965610221654060296714305877685546875 * InternalPrior_61 + 0.01225244971237890272142134762134446646086871623992919921875 * InternalPrior_65 + 0.09315681215473360643475331244189874269068241119384765625 * InternalPrior_84 + 0.261213262585774430579732552359928376972675323486328125 * InternalPrior_85 + 0.0766246573627729354871718214781139977276325225830078125 * InternalPrior_86 - 0.116141014420166277520962694325135089457035064697265625 * InternalPrior_90 + 0.367632054180990708314169523873715661466121673583984375 * InternalPrior_105;
logit_phiiotaTX = 0 + 0.22418621272792382814742495611426420509815216064453125 * InternalPrior_69 + 0.363220902078889629205349365292931906878948211669921875 * InternalPrior_76 - 0.07287741979315522089510892556063481606543064117431640625 * InternalPrior_80 + 1.3238202294873728792623523986549116671085357666015625 * InternalPrior_173;
phiiotaTX = 1 / ( 1 + exp( -( logit_phiiotaTX ) ) );
logit_phiiotaTM = 0 + 0.25154981353247418685015190931153483688831329345703125 * InternalPrior_69 - 0.343323300609277903827631917010876350104808807373046875 * InternalPrior_76 - 0.07969819678342061897158288275022641755640506744384765625 * InternalPrior_80 + 1.3238202294873728792623523986549116671085357666015625 * InternalPrior_173;
phiiotaTM = 1 / ( 1 + exp( -( logit_phiiotaTM ) ) );
logit_phiiotaWX = 0 - 0.345805147596216222449783117554034106433391571044921875 * InternalPrior_69 - 0.01087892965795833784270474353661484201438724994659423828125 * InternalPrior_76 - 0.2603851930994860452983630239032208919525146484375 * InternalPrior_80 + 1.3238202294873737674407720987801440060138702392578125 * InternalPrior_173;
phiiotaWX = 1 / ( 1 + exp( -( logit_phiiotaWX ) ) );
logit_phiiotaWM = 0 - 0.129930878664181681525491285356110893189907073974609375 * InternalPrior_69 - 0.009018671811653493353144739330673473887145519256591796875 * InternalPrior_76 + 0.412960809676062023942932910358649678528308868408203125 * InternalPrior_80 + 1.323820229487372213128537623560987412929534912109375 * InternalPrior_173;
phiiotaWM = 1 / ( 1 + exp( -( logit_phiiotaWM ) ) );
logit_phitauD = 0 - 0.353553390593273675346353002169053070247173309326171875 * InternalPrior_71 + 1.3472193585307479235524397154222242534160614013671875 * InternalPrior_106;
phitauD = 1 / ( 1 + exp( -( logit_phitauD ) ) );
logit_phitauND = 0 + 0.353553390593273675346353002169053070247173309326171875 * InternalPrior_71 + 1.3472193585307479235524397154222242534160614013671875 * InternalPrior_106;
phitauND = 1 / ( 1 + exp( -( logit_phitauND ) ) );
logit_phitauHW = 0 + 0.77080099796633694264613723134971223771572113037109375 * InternalPrior_109 + 1.109878799605348742574051357223652303218841552734375 * InternalPrior_110 + 0.08291035383879084841307616215999587439000606536865234375 * InternalPrior_111 + 0.29522998653086596210215475366567261517047882080078125 * InternalPrior_112 + 0.97979589711327008672014926560223102569580078125 * InternalPrior_174;
phitauHW = 1 / ( 1 + exp( -( logit_phitauHW ) ) );
logit_phitauHT = 0 + 0.01603175290324727886304145840767887420952320098876953125 * InternalPrior_109 + 0.11480157387157551018841417089788592420518398284912109375 * InternalPrior_110 + 1.09130801390055598432127226260490715503692626953125 * InternalPrior_111 + 0.84593758654636130867032761670998297631740570068359375 * InternalPrior_112 + 0.97979589711327041978705665314919315278530120849609375 * InternalPrior_174;
phitauHT = 1 / ( 1 + exp( -( logit_phitauHT ) ) );
logit_phitauHNT = 0 - 0.9197173407852565762965468820766545832157135009765625 * InternalPrior_109 + 0.99475649995927550861551935668103396892547607421875 * InternalPrior_110 + 0.160929035320890811977534440302406437695026397705078125 * InternalPrior_111 + 0.2422423671415767365555637979923631064593791961669921875 * InternalPrior_112 + 0.9797958971132720851215935908840037882328033447265625 * InternalPrior_174;
phitauHNT = 1 / ( 1 + exp( -( logit_phitauHNT ) ) );
logit_phitauKW = 0 + 0.80069284925596451163443134646513499319553375244140625 * InternalPrior_109 - 0.114801573871574802421235972360591404139995574951171875 * InternalPrior_110 - 1.0913080139005562063658771876362152397632598876953125 * InternalPrior_111 + 0.27341978455005422343759846626198850572109222412109375 * InternalPrior_112 + 0.97979589711327008672014926560223102569580078125 * InternalPrior_174;
phitauKW = 1 / ( 1 + exp( -( logit_phitauKW ) ) );
logit_phitauKT = 0 + 0.0459236041928747507068209188219043426215648651123046875 * InternalPrior_109 - 1.1098787996053485205294464321923442184925079345703125 * InternalPrior_110 - 0.08291035383879029330156384958172566257417201995849609375 * InternalPrior_111 + 0.82412738456554957000577132930629886686801910400390625 * InternalPrior_112 + 0.97979589711327041978705665314919315278530120849609375 * InternalPrior_174;
phitauKT = 1 / ( 1 + exp( -( logit_phitauKT ) ) );
logit_phitauKNT = 0 - 0.88982548949562911833055522947688587009906768798828125 * InternalPrior_109 - 0.229923873517648313935524129192344844341278076171875 * InternalPrior_110 - 1.0132893324184559791234505610191263258457183837890625 * InternalPrior_111 + 0.2204321651607647758464025855573709122836589813232421875 * InternalPrior_112 + 0.9797958971132720851215935908840037882328033447265625 * InternalPrior_174;
phitauKNT = 1 / ( 1 + exp( -( logit_phitauKNT ) ) );
logit_phitauscriptXW = 0 + 0.87379373659238235294566266020410694181919097900390625 * InternalPrior_109 + 0.11512229964607352539207596464621019549667835235595703125 * InternalPrior_110 - 0.07801868148210011622012416410143487155437469482421875 * InternalPrior_111 - 1.0663697517071255571607935053179971873760223388671875 * InternalPrior_112 + 0.979795897113271418987778815790079534053802490234375 * InternalPrior_174;
phitauscriptXW = 1 / ( 1 + exp( -( logit_phitauscriptXW ) ) );
logit_phitauscriptXT = 0 + 0.11902449152929349407425974050056538544595241546630859375 * InternalPrior_109 - 0.87995492608769987352701491545303724706172943115234375 * InternalPrior_110 + 0.93037897857966489478798166601336561143398284912109375 * InternalPrior_111 - 0.51566215169163032161492310478934086859226226806640625 * InternalPrior_112 + 0.97979589711327264023310590346227400004863739013671875 * InternalPrior_174;
phitauscriptXT = 1 / ( 1 + exp( -( logit_phitauscriptXT ) ) );
logit_phitauscriptXNT = 0 - 0.81672460215921149906392884076922200620174407958984375 * InternalPrior_109 - 1.1193573710964146439295063828467391431331634521484375 * InternalPrior_112 + 0.9797958971132720851215935908840037882328033447265625 * InternalPrior_174;
phitauscriptXNT = 1 / ( 1 + exp( -( logit_phitauscriptXNT ) ) );
logit_tauKG_ = -1.5 - 0.17243176158582029788846057272166945040225982666015625 * InternalPrior_62 + 0.17397496255614142146583844805718399584293365478515625 * InternalPrior_63 + 0.62449979983983971987271388570661656558513641357421875 * InternalPrior_103;
tauKG_ = 1 / ( 1 + exp( -( logit_tauKG_ ) ) );
logit_tauHG_ = -1.5 - 0.06445085640315477426565138330261106602847576141357421875 * InternalPrior_62 - 0.2363177672306928933654290858612512238323688507080078125 * InternalPrior_63 + 0.62449979983983971987271388570661656558513641357421875 * InternalPrior_103;
tauHG_ = 1 / ( 1 + exp( -( logit_tauHG_ ) ) );
logit_tauCG_ = -1.5 + 0.2368826179889750582763241482098237611353397369384765625 * InternalPrior_62 + 0.062342804674551437205121118267925339750945568084716796875 * InternalPrior_63 + 0.62449979983983983089501634822227060794830322265625 * InternalPrior_103;
tauCG_ = 1 / ( 1 + exp( -( logit_tauCG_ ) ) );
taub_ = 0 + 0.049002499936227794652410238995798863470554351806640625 * InternalPrior_2 + 0.000456824536327391016003740542572586491587571799755096435546875 * InternalPrior_6 + 0.0081968203290773665459223451534853666089475154876708984375 * InternalPrior_7 + 0.01549274366283651983844382726829280727542936801910400390625 * InternalPrior_10 - 0.0169219054480464863032818101373777608387172222137451171875 * InternalPrior_11 - 0.0023500585828586137253359833465538031305186450481414794921875 * InternalPrior_12 + 0.055402464100440342031905771591482334770262241363525390625 * InternalPrior_13 - 0.00073191943651147229644993164043853539624251425266265869140625 * InternalPrior_14 - 0.061322056182180062489095462296972982585430145263671875 * InternalPrior_15 - 0.0131746472034943128137651768838622956536710262298583984375 * InternalPrior_22 - 0.000710664821755405324600618488517511650570668280124664306640625 * InternalPrior_87;
taul_ = 0 - 0.049002499936227787713516335088570485822856426239013671875 * InternalPrior_2 + 0.000456824536327391016003740542572586491587571799755096435546875 * InternalPrior_6 + 0.0081968203290773665459223451534853666089475154876708984375 * InternalPrior_7 + 0.01549274366283651983844382726829280727542936801910400390625 * InternalPrior_10 - 0.016921905448046510589410473812677082605659961700439453125 * InternalPrior_11 - 0.0023500585828586137253359833465538031305186450481414794921875 * InternalPrior_12 + 0.055402464100440342031905771591482334770262241363525390625 * InternalPrior_13 - 0.00073191943651147229644993164043853539624251425266265869140625 * InternalPrior_14 - 0.061322056182180062489095462296972982585430145263671875 * InternalPrior_15 - 0.0131746472034943128137651768838622956536710262298583984375 * InternalPrior_22 - 0.000710664821755405324600618488517511650570668280124664306640625 * InternalPrior_87;
tauD_ = 0 + 0.049002499936227787713516335088570485822856426239013671875 * InternalPrior_1 + 0.0004568245363273915581048267853248034953139722347259521484375 * InternalPrior_6 + 0.0081968203290773734848162490607137442566454410552978515625 * InternalPrior_7 - 0.01549274366283663433019324173756103846244513988494873046875 * InternalPrior_10 + 0.016921905448046718756227591029528412036597728729248046875 * InternalPrior_11 + 0.0023500585828592946043003042433383598108775913715362548828125 * InternalPrior_12 - 0.055402464100440640404343639602302573621273040771484375 * InternalPrior_13 + 0.00073191943651151371297292058670791448093950748443603515625 * InternalPrior_14 - 0.0613220561821797571777636903789243660867214202880859375 * InternalPrior_15 - 0.01317464720349431454848865286066939006559550762176513671875 * InternalPrior_22 - 0.00071066482175542212973429201383623876608908176422119140625 * InternalPrior_87;
tauND_ = 0 - 0.049002499936227794652410238995798863470554351806640625 * InternalPrior_1 + 0.00045682453632738960654091631141682228189893066883087158203125 * InternalPrior_6 + 0.0081968203290773804237101529679421219043433666229248046875 * InternalPrior_7 - 0.01549274366283662739129933783033266081474721431732177734375 * InternalPrior_10 + 0.01692190544804671181733368712230003438889980316162109375 * InternalPrior_11 + 0.00235005858285928202755510341148692532442510128021240234375 * InternalPrior_12 - 0.055402464100440508565359465364963398315012454986572265625 * InternalPrior_13 + 0.000731919436511498967823374783847611979581415653228759765625 * InternalPrior_14 - 0.061322056182179764116657594286152743734419345855712890625 * InternalPrior_15 - 0.01317464720349431454848865286066939006559550762176513671875 * InternalPrior_22 - 0.0007106648217553843994986895182819353067316114902496337890625 * InternalPrior_87;
tauNT_ = 0 + 0.06431155724294139452990037852941895835101604461669921875 * InternalPrior_6 - 0.0746238374704555063043898144314880482852458953857421875 * InternalPrior_7 - 0.013763663060568032125985382663202472031116485595703125 * InternalPrior_15 - 0.0104583253894159310115608008118215366266667842864990234375 * InternalPrior_22 - 0.000701067311476808417702866194076705141924321651458740234375 * InternalPrior_87;
tauLa_ = 0 - 0.0737000703129054024476118911479716189205646514892578125 * InternalPrior_6 - 0.0648745553744212999358609295086353085935115814208984375 * InternalPrior_7 - 0.0134330650174872175128815143807514687068760395050048828125 * InternalPrior_15 - 0.0102767766189702965118346611461674910970032215118408203125 * InternalPrior_22 - 0.00886071822166455656810679641921524307690560817718505859375 * InternalPrior_87;
logit_tauLb_ = -2.29999999999999982236431605997495353221893310546875 + 0.0010025927714958720281257509299166486016474664211273193359375 * InternalPrior_6 + 0.00097832874284784431505312962684683952829800546169281005859375 * InternalPrior_7 + 0.0004291031006972648316998009132561264777905307710170745849609375 * InternalPrior_15 + 0.00088282081805698725714137697906380708445794880390167236328125 * InternalPrior_22 - 0.60431743659978665039744782916386611759662628173828125 * InternalPrior_87;
tauLb_ = 1 / ( 1 + exp( -( logit_tauLb_ ) ) );
tauHW_ = 0 + 0.000114835363594615997803217999351232947446987964212894439697265625 * InternalPrior_6 + 0.001893534635719485402505224413971518515609204769134521484375 * InternalPrior_7 + 0.06953418543894017422868358835330582223832607269287109375 * InternalPrior_10 + 0.01487433209576463112588928794366438523866236209869384765625 * InternalPrior_11 + 0.03342260627992908739170019316588877700269222259521484375 * InternalPrior_12 - 0.013573043443285935649722517837290070019662380218505859375 * InternalPrior_13 - 0.006765588015206124017364430756060755811631679534912109375 * InternalPrior_14 + 0.00654873022372726328044212351642272551544010639190673828125 * InternalPrior_15 - 0.0596206864266367320137618435182957910001277923583984375 * InternalPrior_22 - 0.000741095065491263228774077020943877869285643100738525390625 * InternalPrior_87;
tauHT_ = 0 + 0.00011483536359461384295140018441117035763454623520374298095703125 * InternalPrior_6 + 0.0018935346357194268555879101967320821131579577922821044921875 * InternalPrior_7 - 0.0084594443955154745296010077026949147693812847137451171875 * InternalPrior_10 + 0.057491405265797983215048105876121553592383861541748046875 * InternalPrior_11 + 0.05004659871637630319529677080936380662024021148681640625 * InternalPrior_12 + 0.022123591584762625217308595892973244190216064453125 * InternalPrior_13 + 0.0056904106526320767656113019938857178203761577606201171875 * InternalPrior_14 + 0.006548730223727413334022795510236392146907746791839599609375 * InternalPrior_15 - 0.059620686426636738952655747425524168647825717926025390625 * InternalPrior_22 - 0.000741095065491280033907750546262604984804056584835052490234375 * InternalPrior_87;
tauHNT_ = 0 + 0.000114835363594600195556554023124107288822415284812450408935546875 * InternalPrior_6 + 0.00189353463571945049119527038072874347562901675701141357421875 * InternalPrior_7 + 0.027409346251217443779513160961869289167225360870361328125 * InternalPrior_10 + 0.062079510161075275587183597281182301230728626251220703125 * InternalPrior_11 - 0.036735453844888736607554591273583355359733104705810546875 * InternalPrior_12 + 0.00948812951736047703599208347213789238594472408294677734375 * InternalPrior_13 - 0.0189384261572516539307020622118216124363243579864501953125 * InternalPrior_14 + 0.006548730223726917203108666143407390336506068706512451171875 * InternalPrior_15 - 0.059620686426636697319292323982153902761638164520263671875 * InternalPrior_22 - 0.000741095065491411005530186795198233085102401673793792724609375 * InternalPrior_87;
tauKW_ = 0 + 0.0001148353635945951133588704973220728788874112069606781005859375 * InternalPrior_6 + 0.0018935346357194936424417353038052169722504913806915283203125 * InternalPrior_7 + 0.0172446348360161087753805730926615069620311260223388671875 * InternalPrior_10 - 0.057491405265797941581684682432751287706196308135986328125 * InternalPrior_11 + 0.0197487004807865192124172182275287923403084278106689453125 * InternalPrior_12 - 0.02212359158476250031721832556286244653165340423583984375 * InternalPrior_13 - 0.043831682772248713175766710037351003848016262054443359375 * InternalPrior_14 + 0.006548730223727085471285835893695548293180763721466064453125 * InternalPrior_15 - 0.05962068642663674589154965133275254629552364349365234375 * InternalPrior_22 - 0.000741095065491280033907750546262604984804056584835052490234375 * InternalPrior_87;
tauKT_ = 0 + 0.00011483536359459985674337512140397166149341501295566558837890625 * InternalPrior_6 + 0.00189353463571947130787698210241387641872279345989227294921875 * InternalPrior_7 - 0.060748994998439422021707656540456810034811496734619140625 * InternalPrior_10 - 0.01487433209576469010648747115510559524409472942352294921875 * InternalPrior_11 + 0.036372692917233738485460747824618010781705379486083984375 * InternalPrior_12 + 0.0135730434432858766691243346258488600142300128936767578125 * InternalPrior_13 - 0.0313756841044105783122830644060741178691387176513671875 * InternalPrior_14 + 0.00654873022372726674988907547003691433928906917572021484375 * InternalPrior_15 - 0.059620686426636766708231363054437679238617420196533203125 * InternalPrior_22 - 0.000741095065491280033907750546262604984804056584835052490234375 * InternalPrior_87;
tauKNT_ = 0 + 0.00011483536359459676676718353771633474025293253362178802490234375 * InternalPrior_6 + 0.00189353463571946371846177470388283836655318737030029296875 * InternalPrior_7 - 0.0248802043517065384070630074120344943366944789886474609375 * InternalPrior_10 - 0.01028622720048734222320074849221782642416656017303466796875 * InternalPrior_11 - 0.050409359644030947433801514989681891165673732757568359375 * InternalPrior_12 + 0.000937581375883824439700087172155917869531549513339996337890625 * InternalPrior_13 - 0.056004520914294093902885407487701741047203540802001953125 * InternalPrior_14 + 0.00654873022372673592450542656706602429039776325225830078125 * InternalPrior_15 - 0.05962068642663685691385211384840658865869045257568359375 * InternalPrior_22 - 0.0007410950654914163181208319741699597216211259365081787109375 * InternalPrior_87;
tauscriptXW_ = 0 + 0.00011483536359458131688622561927815013405052013695240020751953125 * InternalPrior_6 + 0.00189353463571947759624958251833959366194903850555419921875 * InternalPrior_7 + 0.033339648747222054570027438558099674992263317108154296875 * InternalPrior_10 - 0.047205178065310625379336073592639877460896968841552734375 * InternalPrior_11 + 0.00036276092765476068181806912349429694586433470249176025390625 * InternalPrior_12 - 0.023061172960646338092605134306722902692854404449462890625 * InternalPrior_13 + 0.050314110261662270406901598107651807367801666259765625 * InternalPrior_14 + 0.006548730223727002204558989006955016520805656909942626953125 * InternalPrior_15 - 0.059620686426636669563716708353240392170846462249755859375 * InternalPrior_22 - 0.000741095065491280033907750546262604984804056584835052490234375 * InternalPrior_87;
tauscriptXT_ = 0 + 0.000114835363594598650568458231280288828202174045145511627197265625 * InternalPrior_6 + 0.00189353463571942750610921368803474251762963831424713134765625 * InternalPrior_7 - 0.0446539810872335907188102055442868731915950775146484375 * InternalPrior_10 - 0.004588104895277341811754556744062938378192484378814697265625 * InternalPrior_11 + 0.0169867533641018773893360815918640582822263240814208984375 * InternalPrior_12 + 0.0126354620674020805271009493253586697392165660858154296875 * InternalPrior_13 + 0.0627701089295004399648547632750705815851688385009765625 * InternalPrior_14 + 0.006548730223727170472736158757243174477480351924896240234375 * InternalPrior_15 - 0.059620686426636648747034996631555259227752685546875 * InternalPrior_22 - 0.000741095065491477141862708410968707539723254740238189697265625 * InternalPrior_87;
tauscriptXNT_ = 0 + 0.000114835363594594408627458381744190774043090641498565673828125 * InternalPrior_6 + 0.00189353463571944702174831842711455465178005397319793701171875 * InternalPrior_7 - 0.00878519044050066720552560894930138601921498775482177734375 * InternalPrior_10 - 0.0697952991971629577161451152278459630906581878662109375 * InternalPrior_12 + 0.038141272119616646818496263904307852499186992645263671875 * InternalPrior_14 + 0.006548730223726651790416841691921945312060415744781494140625 * InternalPrior_15 - 0.0596206864266366765026106122604687698185443878173828125 * InternalPrior_22 - 0.00074109506549137403423610503949703343096189200878143310546875 * InternalPrior_87;
log_sigmauKG = -9.90364948999999938905602903105318546295166015625 + 1.729724608138532015999544455553404986858367919921875 * InternalPrior_138 - 0.99865696813270099507775512392981909215450286865234375 * InternalPrior_139 + 0.2385473258408550567555295174315688200294971466064453125 * InternalPrior_156 - 0.507928357782168493628205396817065775394439697265625 * InternalPrior_159 + 0.04474997252246844248180224212774191983044147491455078125 * InternalPrior_160 + 1.152738885320784500976287745288573205471038818359375 * InternalPrior_161 - 0.3409952690559612253906607293174602091312408447265625 * InternalPrior_164 + 0.490455960038180316384881507474347017705440521240234375 * InternalPrior_172;
sigmauKG = exp( log_sigmauKG );
log_sigmauHG = -9.90364948999999938905602903105318546295166015625 - 1.72972460813853157191033460549078881740570068359375 * InternalPrior_138 - 0.9986569681327004399662428113515488803386688232421875 * InternalPrior_139 + 0.2385473258408550567555295174315688200294971466064453125 * InternalPrior_156 - 0.507928357782168493628205396817065775394439697265625 * InternalPrior_159 + 0.04474997252246844248180224212774191983044147491455078125 * InternalPrior_160 + 1.152738885320784500976287745288573205471038818359375 * InternalPrior_161 - 0.3409952690559612253906607293174602091312408447265625 * InternalPrior_164 + 0.490455960038180316384881507474347017705440521240234375 * InternalPrior_172;
sigmauHG = exp( log_sigmauHG );
log_sigmauCG = -9.90364948999999938905602903105318546295166015625 + 1.997313936265402656289325022953562438488006591796875 * InternalPrior_139 + 0.2385473258408550567555295174315688200294971466064453125 * InternalPrior_156 - 0.507928357782168493628205396817065775394439697265625 * InternalPrior_159 + 0.04474997252246844248180224212774191983044147491455078125 * InternalPrior_160 + 1.152738885320784500976287745288573205471038818359375 * InternalPrior_161 - 0.3409952690559612253906607293174602091312408447265625 * InternalPrior_164 + 0.490455960038180316384881507474347017705440521240234375 * InternalPrior_172;
sigmauCG = exp( log_sigmauCG );
log_sigmaub = -9.90364948999999938905602903105318546295166015625 - 0.10461708065314721805005859778248122893273830413818359375 * InternalPrior_143 - 0.01163925180682932707110222025903567555360496044158935546875 * InternalPrior_149 + 0.048662251865188889399238547639470198191702365875244140625 * InternalPrior_152 - 1.724221059525265165035534664639271795749664306640625 * InternalPrior_153 - 0.074570351921338262624061599126434884965419769287109375 * InternalPrior_154 + 0.42210813657519608010915135309915058314800262451171875 * InternalPrior_156 - 0.70634387124308462002630903953104279935359954833984375 * InternalPrior_157 - 1.223423472608036188802316246437840163707733154296875 * InternalPrior_158 + 0.753851254291791672557110359775833785533905029296875 * InternalPrior_159 - 0.1474922207698979026435637251779553480446338653564453125 * InternalPrior_164 + 0.485735007811259500432043978435103781521320343017578125 * InternalPrior_172;
sigmaub = exp( log_sigmaub );
log_sigmaul = -9.90364948999999938905602903105318546295166015625 + 0.10461708065360542097010920770117081701755523681640625 * InternalPrior_143 + 0.0116392518072625690550569999004437704570591449737548828125 * InternalPrior_149 - 0.04866225186671070679356176924557075835764408111572265625 * InternalPrior_152 + 1.724221059525334442952271274407394230365753173828125 * InternalPrior_153 + 0.07457035192208431861882189650714281015098094940185546875 * InternalPrior_154 + 0.42210813657519608010915135309915058314800262451171875 * InternalPrior_156 - 0.70634387124308462002630903953104279935359954833984375 * InternalPrior_157 - 1.223423472607788387023219911498017609119415283203125 * InternalPrior_158 + 0.753851254291791672557110359775833785533905029296875 * InternalPrior_159 - 0.1474922207698979026435637251779553480446338653564453125 * InternalPrior_164 + 0.485735007811259500432043978435103781521320343017578125 * InternalPrior_172;
sigmaul = exp( log_sigmaul );
log_sigmauD = -9.90364948999999938905602903105318546295166015625 + 0.08877963076725359226060163564397953450679779052734375 * InternalPrior_143 - 0.97638350401562867819649227385525591671466827392578125 * InternalPrior_149 + 1.4157023275562929942594792009913362562656402587890625 * InternalPrior_152 + 0.0478919592530082649517453319276683032512664794921875 * InternalPrior_153 - 0.15567250958422385043178337582503445446491241455078125 * InternalPrior_154 + 0.42210813657519608010915135309915058314800262451171875 * InternalPrior_156 - 0.70634387124308462002630903953104279935359954833984375 * InternalPrior_157 + 1.2234234726068276000177093010279349982738494873046875 * InternalPrior_158 + 0.753851254291791672557110359775833785533905029296875 * InternalPrior_159 - 0.1474922207698979026435637251779553480446338653564453125 * InternalPrior_164 + 0.485735007811259500432043978435103781521320343017578125 * InternalPrior_172;
sigmauD = exp( log_sigmauD );
log_sigmauND = -9.90364948999999938905602903105318546295166015625 - 0.08877963076698032474087796117601101286709308624267578125 * InternalPrior_143 + 0.9763835040151296329469232659903354942798614501953125 * InternalPrior_149 - 1.41570232755476421715457036043517291545867919921875 * InternalPrior_152 - 0.047891959253158568332597866401556530036032199859619140625 * InternalPrior_153 + 0.155672509584329044063366609407239593565464019775390625 * InternalPrior_154 + 0.42210813657519608010915135309915058314800262451171875 * InternalPrior_156 - 0.70634387124308462002630903953104279935359954833984375 * InternalPrior_157 + 1.2234234726089951994509874566574580967426300048828125 * InternalPrior_158 + 0.753851254291791672557110359775833785533905029296875 * InternalPrior_159 - 0.1474922207698979026435637251779553480446338653564453125 * InternalPrior_164 + 0.485735007811259500432043978435103781521320343017578125 * InternalPrior_172;
sigmauND = exp( log_sigmauND );
log_sigmauNT = -9.902858099999999552665030932985246181488037109375 - 0.03937435031436666010851155306227155961096286773681640625 * InternalPrior_140 - 0.40551352644362037569436552075785584747791290283203125 * InternalPrior_141 - 0.059841202581460355147680019172184984199702739715576171875 * InternalPrior_142 - 0.259856909682954106965979690357926301658153533935546875 * InternalPrior_143 + 0.12951256610168393468285330527578480541706085205078125 * InternalPrior_144 + 0.7387700281324833806451124473824165761470794677734375 * InternalPrior_145 + 0.375777052578931236581638586358167231082916259765625 * InternalPrior_146 + 0.5676930570583891277891552817891351878643035888671875 * InternalPrior_147 + 0.7429461415398197488002551835961639881134033203125 * InternalPrior_148 + 0.8129743263453244050964485722943209111690521240234375 * InternalPrior_149 - 1.18818763618494305234207786270417273044586181640625 * InternalPrior_150 + 0.292455738974297940746538415623945184051990509033203125 * InternalPrior_151 + 0.471122591803006141031318065870436839759349822998046875 * InternalPrior_152 + 0.0643571280584242788602722384894150309264659881591796875 * InternalPrior_153 - 0.94296150028936642772947607227251864969730377197265625 * InternalPrior_154 - 0.2010587102275336601753252807611715979874134063720703125 * InternalPrior_155 - 0.78314850338565478171659606232424266636371612548828125 * InternalPrior_156 + 0.1263084275476506757041050832413020543754100799560546875 * InternalPrior_159 - 0.06908524060482613970979315354270511306822299957275390625 * InternalPrior_164 + 0.476560606679743148372807581836241297423839569091796875 * InternalPrior_172;
sigmauNT = exp( log_sigmauNT );
log_sigmauTX = -9.90364948999999938905602903105318546295166015625 - 0.2561571157390665209874214269802905619144439697265625 * InternalPrior_141 - 0.08642363755673222736053418202573084272444248199462890625 * InternalPrior_143 + 0.013691316479360358948635933984405710361897945404052734375 * InternalPrior_145 + 0.91295706668618936685533071795362047851085662841796875 * InternalPrior_149 - 0.285261019123428327670666249105124734342098236083984375 * InternalPrior_150 + 0.01195386064761918588905675875366796390153467655181884765625 * InternalPrior_151 + 0.8078586834006900030402675838558934628963470458984375 * InternalPrior_152 - 0.045473660956487242656987035616111825220286846160888671875 * InternalPrior_153 + 1.557376558890334994345039376639761030673980712890625 * InternalPrior_154 + 0.6476999791454505217558335061767138540744781494140625 * InternalPrior_155 + 0.166250503088918311078714395989663898944854736328125 * InternalPrior_156 - 0.1899665439707078906650394856114871799945831298828125 * InternalPrior_159 + 1.0930937829124227622656917446875013411045074462890625 * InternalPrior_164 + 0.495269580617178906134512317294138483703136444091796875 * InternalPrior_172;
sigmauTX = exp( log_sigmauTX );
log_sigmauTM = -9.90364948999999938905602903105318546295166015625 - 1.16809764756878831093445114674977958202362060546875 * InternalPrior_141 - 0.03439148630371983983433636922200093977153301239013671875 * InternalPrior_143 + 0.013691316479360358948635933984405710361897945404052734375 * InternalPrior_145 + 0.254458696827418950903165750787593424320220947265625 * InternalPrior_149 + 1.4315917596860201488340180731029249727725982666015625 * InternalPrior_150 + 0.01195386064761918588905675875366796390153467655181884765625 * InternalPrior_151 + 0.070617325960381116534136936024879105389118194580078125 * InternalPrior_152 + 0.043875920865291802297480927563810837455093860626220703125 * InternalPrior_153 - 0.9598876599859373914824800522183068096637725830078125 * InternalPrior_154 - 0.28187794652985831422853379990556277334690093994140625 * InternalPrior_155 + 0.166250503088918311078714395989663898944854736328125 * InternalPrior_156 - 0.1899665439707078906650394856114871799945831298828125 * InternalPrior_159 + 1.0930937829124227622656917446875013411045074462890625 * InternalPrior_164 + 0.495269580617178906134512317294138483703136444091796875 * InternalPrior_172;
sigmauTM = exp( log_sigmauTM );
log_sigmauWX = -9.90364948999999938905602903105318546295166015625 + 1.969484796008169613656946239643730223178863525390625 * InternalPrior_141 - 0.112715809323498949989783568526036106050014495849609375 * InternalPrior_143 + 0.013691316479360206292970048025381402112543582916259765625 * InternalPrior_145 + 0.17636734714113633248899759564665146172046661376953125 * InternalPrior_149 + 0.046252791091947333124156926942305290140211582183837890625 * InternalPrior_150 + 0.01195386064761933854472264471269227215088903903961181640625 * InternalPrior_151 + 0.06490630279517535516919934934776392765343189239501953125 * InternalPrior_152 + 0.032145464967931407229695395244561950676143169403076171875 * InternalPrior_153 - 0.57030957699236195512781932848156429827213287353515625 * InternalPrior_154 - 0.481945363292081818684664540342055261135101318359375 * InternalPrior_155 + 0.166250503088918311078714395989663898944854736328125 * InternalPrior_156 - 0.1899665439707078906650394856114871799945831298828125 * InternalPrior_159 + 1.0930937829124227622656917446875013411045074462890625 * InternalPrior_164 + 0.495269580617178906134512317294138483703136444091796875 * InternalPrior_172;
sigmauWX = exp( log_sigmauWX );
log_sigmauWM = -9.90364948999999938905602903105318546295166015625 - 0.5452300327003201108055918666650541126728057861328125 * InternalPrior_141 + 0.2335309331843583302568134740795358084142208099365234375 * InternalPrior_143 - 0.041073949437706376575096811620824155397713184356689453125 * InternalPrior_145 - 1.343783110654715784448853810317814350128173828125 * InternalPrior_149 - 1.192583531654531459054169317823834717273712158203125 * InternalPrior_150 - 0.03586158194254639164366693648844375275075435638427734375 * InternalPrior_151 - 0.94338231215624268610753233588184230029582977294921875 * InternalPrior_152 - 0.0305477248767635593817981742859046789817512035369873046875 * InternalPrior_153 - 0.0271793219119653185755769442266682744957506656646728515625 * InternalPrior_154 + 0.11612333067631118443951976360040134750306606292724609375 * InternalPrior_155 + 0.166250503088918311078714395989663898944854736328125 * InternalPrior_156 - 0.1899665439707078906650394856114871799945831298828125 * InternalPrior_159 + 1.0930937829124227622656917446875013411045074462890625 * InternalPrior_164 + 0.495269580617178906134512317294138483703136444091796875 * InternalPrior_172;
sigmauWM = exp( log_sigmauWM );
log_sigmauLa = -9.90364948999999938905602903105318546295166015625 - 0.25031095228379829364939723745919764041900634765625 * InternalPrior_141 - 0.0936386285860984213247348861841601319611072540283203125 * InternalPrior_143 - 0.8126546100053875232305244935560040175914764404296875 * InternalPrior_145 + 0.11981106509455256847740400871771271340548992156982421875 * InternalPrior_149 - 0.2639100259560247518919595677289180457592010498046875 * InternalPrior_150 + 0.2042819101159754902052867464590235613286495208740234375 * InternalPrior_151 + 0.1283566876577573179218916266108863055706024169921875 * InternalPrior_152 - 0.007084966229035560315863140345982174039818346500396728515625 * InternalPrior_153 + 0.360248564643635749149552793824113905429840087890625 * InternalPrior_154 - 1.409991837912048850967039470560848712921142578125 * InternalPrior_155 + 0.42210813657519608010915135309915058314800262451171875 * InternalPrior_156 + 1.4126877424865640353601747847278602421283721923828125 * InternalPrior_157 + 0.753851254291791672557110359775833785533905029296875 * InternalPrior_159 - 0.1474922207698979026435637251779553480446338653564453125 * InternalPrior_164 + 0.485735007811259500432043978435103781521320343017578125 * InternalPrior_172;
sigmauLa = exp( log_sigmauLa );
log_sigmauLb = -9.90364948999999938905602903105318546295166015625 + 0.25031095228382849171566704171709716320037841796875 * InternalPrior_141 + 0.09363862858669758093554946754011325538158416748046875 * InternalPrior_143 + 0.81265461000728833607098522406886331737041473388671875 * InternalPrior_145 - 0.1198110650948607247556765287299640476703643798828125 * InternalPrior_149 + 0.263910025956252181078554031046223826706409454345703125 * InternalPrior_150 - 0.204281910116265119636835834171506576240062713623046875 * InternalPrior_151 - 0.1283566876579584070672268580892705358564853668212890625 * InternalPrior_152 + 0.00708496622897720508549301854372970410622656345367431640625 * InternalPrior_153 - 0.36024856464320664795053517082124017179012298583984375 * InternalPrior_154 + 1.4099918379116822553243082438712008297443389892578125 * InternalPrior_155 + 0.42210813657519608010915135309915058314800262451171875 * InternalPrior_156 + 1.412687742485772890432826898177154362201690673828125 * InternalPrior_157 + 0.753851254291791672557110359775833785533905029296875 * InternalPrior_159 - 0.1474922207698979026435637251779553480446338653564453125 * InternalPrior_164 + 0.485735007811259500432043978435103781521320343017578125 * InternalPrior_172;
sigmauLb = exp( log_sigmauLb );
log_sigmauALL = -9.902858099999999552665030932985246181488037109375 - 0.11483760435493910179172161178939859382808208465576171875 * InternalPrior_140 + 0.275255421077425121989534773092600516974925994873046875 * InternalPrior_141 + 0.01562205145911219582310902609378899796865880489349365234375 * InternalPrior_142 + 0.10988072188232682335762291359060327522456645965576171875 * InternalPrior_143 - 0.0189487856109610448840374630208316375501453876495361328125 * InternalPrior_144 - 0.1061578518749730359882477159771951846778392791748046875 * InternalPrior_145 + 0.61635662797296830728299710244755260646343231201171875 * InternalPrior_146 + 0.695590361802643553090774730662815272808074951171875 * InternalPrior_147 + 0.90887967092924915046836531473672948777675628662109375 * InternalPrior_148 - 0.611759947670699855137854683562181890010833740234375 * InternalPrior_149 + 0.8266580490505688327829147965530864894390106201171875 * InternalPrior_150 + 1.2894093238891410901914014175417833030223846435546875 * InternalPrior_151 - 0.352492283616240076327130736899562180042266845703125 * InternalPrior_152 - 0.041944035485257206985476585714422981254756450653076171875 * InternalPrior_153 + 0.68113864884713459790788192549371160566806793212890625 * InternalPrior_154 + 0.1272750865781295537271233797582681290805339813232421875 * InternalPrior_155 - 0.78314850338565478171659606232424266636371612548828125 * InternalPrior_156 + 0.1263084275476506757041050832413020543754100799560546875 * InternalPrior_159 - 0.06908524060482613970979315354270511306822299957275390625 * InternalPrior_164 + 0.476560606679743148372807581836241297423839569091796875 * InternalPrior_172;
sigmauALL = exp( log_sigmauALL );
log_sigmauS1ALL = -9.902858099999999552665030932985246181488037109375 + 0.97623514579075221231363457263796590268611907958984375 * InternalPrior_140 + 0.0571513185649530353060754350735805928707122802734375 * InternalPrior_141 - 0.90885114771759634155756657492020167410373687744140625 * InternalPrior_142 - 0.55936861713381025307256777523434720933437347412109375 * InternalPrior_143 + 1.168659663888385491503640878363512456417083740234375 * InternalPrior_144 - 0.70398360307061513818638331940746866166591644287109375 * InternalPrior_145 - 0.9077618520690886594337598580750636756420135498046875 * InternalPrior_146 + 0.10916024245120527214059080733932205475866794586181640625 * InternalPrior_147 + 0.10520955583771392227721008794105728156864643096923828125 * InternalPrior_148 - 0.122285447122833346167425361272762529551982879638671875 * InternalPrior_149 + 0.1131249442968341456516867538084625266492366790771484375 * InternalPrior_150 - 0.43150306690421136313062788758543320000171661376953125 * InternalPrior_151 - 0.05338527270329584961672253484721295535564422607421875 * InternalPrior_152 + 0.0344231281654951704052081140616792254149913787841796875 * InternalPrior_153 - 0.0269290301990038651036574179897797876037657260894775390625 * InternalPrior_154 + 0.326751405146319118255604507794487290084362030029296875 * InternalPrior_155 - 0.78314850338565478171659606232424266636371612548828125 * InternalPrior_156 + 0.1263084275476506757041050832413020543754100799560546875 * InternalPrior_159 - 0.06908524060482613970979315354270511306822299957275390625 * InternalPrior_164 + 0.476560606679743148372807581836241297423839569091796875 * InternalPrior_172;
sigmauS1ALL = exp( log_sigmauS1ALL );
log_sigmauiotaALL = -9.902858099999999552665030932985246181488037109375 - 1.43865154927214433655535685829818248748779296875 * InternalPrior_140 + 0.0102670906193948370532798008980535087175667285919189453125 * InternalPrior_141 + 0.6511315095915566342199554128455929458141326904296875 * InternalPrior_142 - 0.7738975865645734142361789054120890796184539794921875 * InternalPrior_143 + 0.309631503386966377977529418785707093775272369384765625 * InternalPrior_144 + 0.6127708840660310851689018818433396518230438232421875 * InternalPrior_145 - 0.56644189134692590759101449293666519224643707275390625 * InternalPrior_146 - 0.1645004398161244996146024277550168335437774658203125 * InternalPrior_147 - 0.06885102843017432139305356031400151550769805908203125 * InternalPrior_148 - 0.324547715437850492481430819680099375545978546142578125 * InternalPrior_149 + 0.265169836262991565067892452134401537477970123291015625 * InternalPrior_150 - 0.8194701431473012664952193517819978296756744384765625 * InternalPrior_151 - 0.1286314055651394949730814687427482567727565765380859375 * InternalPrior_152 + 0.0268038137495773855223379911194570013321936130523681640625 * InternalPrior_153 + 0.4326814073539402283330446152831427752971649169921875 * InternalPrior_154 - 0.400832392392334924124952522106468677520751953125 * InternalPrior_155 - 0.78314850338565478171659606232424266636371612548828125 * InternalPrior_156 + 0.1263084275476506757041050832413020543754100799560546875 * InternalPrior_159 - 0.06908524060482613970979315354270511306822299957275390625 * InternalPrior_164 + 0.476560606679743148372807581836241297423839569091796875 * InternalPrior_172;
sigmauiotaALL = exp( log_sigmauiotaALL );
log_sigmaulbALL = -9.902858099999999552665030932985246181488037109375 + 1.189425359904237922137326677329838275909423828125 * InternalPrior_140 + 0.0038557303560713984159902256720897639752365648746490478515625 * InternalPrior_141 + 0.91585285049530107404081036293064244091510772705078125 * InternalPrior_142 - 0.7125168696007471158537782685016281902790069580078125 * InternalPrior_143 - 1.2379903101126574771484456505277194082736968994140625 * InternalPrior_144 - 0.216070619163133914586438777405419386923313140869140625 * InternalPrior_145 + 0.530868262650082467501988503499887883663177490234375 * InternalPrior_146 - 0.30513688240585945532501455090823583304882049560546875 * InternalPrior_147 - 0.36784854730201510530918085351004265248775482177734375 * InternalPrior_148 - 0.12106567892963222832225511638171155937016010284423828125 * InternalPrior_149 + 0.052855975889332530714970204144265153445303440093994140625 * InternalPrior_150 - 0.499715702266504135931057817288092337548732757568359375 * InternalPrior_151 - 0.03659639433499968508289867941130069084465503692626953125 * InternalPrior_152 + 0.041590633271431053097355601266826852224767208099365234375 * InternalPrior_153 + 0.032965380324823372049092284896687488071620464324951171875 * InternalPrior_154 + 0.083469503323420235485485818571760319173336029052734375 * InternalPrior_155 - 0.78314850338565478171659606232424266636371612548828125 * InternalPrior_156 + 0.1263084275476506757041050832413020543754100799560546875 * InternalPrior_159 - 0.06908524060482613970979315354270511306822299957275390625 * InternalPrior_164 + 0.476560606679743148372807581836241297423839569091796875 * InternalPrior_172;
sigmaulbALL = exp( log_sigmaulbALL );
log_sigmauCALL = -9.902858099999999552665030932985246181488037109375 - 0.211250092796359478786172303443890996277332305908203125 * InternalPrior_140 + 0.08718361401799777643528699400121695362031459808349609375 * InternalPrior_141 - 0.047095632015406972692428411164655699394643306732177734375 * InternalPrior_142 + 1.9106574180520394801163774900487624108791351318359375 * InternalPrior_143 - 0.11557377731752981053769957497934228740632534027099609375 * InternalPrior_144 - 0.428697095725261601018019064213149249553680419921875 * InternalPrior_145 + 0.243380161699004560205139569006860256195068359375 * InternalPrior_146 + 0.07390841539964350392910574782945332117378711700439453125 * InternalPrior_147 + 0.0746097144472469275822135159614845179021358489990234375 * InternalPrior_148 + 0.2326213802364525962129704339531599543988704681396484375 * InternalPrior_149 + 0.08235327622404829683855354005572735331952571868896484375 * InternalPrior_150 - 1.03867665516449836360379777033813297748565673828125 * InternalPrior_151 + 0.04451229686655279460527623314192169345915317535400390625 * InternalPrior_152 - 0.11622911212629975785670666255100513808429241180419921875 * InternalPrior_153 - 0.000324372429891459958251065387457856559194624423980712890625 * InternalPrior_154 - 0.036863829042361129229021798892063088715076446533203125 * InternalPrior_155 - 0.78314850338565478171659606232424266636371612548828125 * InternalPrior_156 + 0.1263084275476507034596806988702155649662017822265625 * InternalPrior_159 - 0.06908524060482613970979315354270511306822299957275390625 * InternalPrior_164 + 0.476560606679743148372807581836241297423839569091796875 * InternalPrior_172;
sigmauCALL = exp( log_sigmauCALL );
log_sigmauLALL = -9.902858099999999552665030932985246181488037109375 - 0.361546908962061153136602342783589847385883331298828125 * InternalPrior_140 - 0.0281996481921526105651754079417514731176197528839111328125 * InternalPrior_141 - 0.56681842923547709478526712700841017067432403564453125 * InternalPrior_142 + 0.28510184304503971564059838783578015863895416259765625 * InternalPrior_143 - 0.2352908603419878452722713291223044507205486297607421875 * InternalPrior_144 + 0.10336825762977501497186239021175424568355083465576171875 * InternalPrior_145 - 0.2921783614862505373821477405726909637451171875 * InternalPrior_146 - 0.97671475448966138532824743379023857414722442626953125 * InternalPrior_147 - 1.3949455070189922256673753508948720991611480712890625 * InternalPrior_148 + 0.13406308257965815489143324157339520752429962158203125 * InternalPrior_149 - 0.1519744455395029281152829980783280916512012481689453125 * InternalPrior_150 + 1.2075005046181903622937170439399778842926025390625 * InternalPrior_151 + 0.055470467550363354580778008084962493740022182464599609375 * InternalPrior_152 - 0.00900155563312469812753402464977625641040503978729248046875 * InternalPrior_153 - 0.1765705336094667565749460891311173327267169952392578125 * InternalPrior_154 + 0.10125893661739314433045677787958993576467037200927734375 * InternalPrior_155 - 0.78314850338565478171659606232424266636371612548828125 * InternalPrior_156 + 0.1263084275476506757041050832413020543754100799560546875 * InternalPrior_159 - 0.06908524060482613970979315354270511306822299957275390625 * InternalPrior_164 + 0.476560606679743148372807581836241297423839569091796875 * InternalPrior_172;
sigmauLALL = exp( log_sigmauLALL );
log_sigmauHALL = -9.90364948999999938905602903105318546295166015625 - 0.7792231008044956386271451265201903879642486572265625 * InternalPrior_140 + 0.01016808965673831645359914688242497504688799381256103515625 * InternalPrior_141 - 0.9812966493046013649603764861240051686763763427734375 * InternalPrior_142 - 0.500692192120929302490139889414422214031219482421875 * InternalPrior_143 - 1.076738253656135402280824564513750374317169189453125 * InternalPrior_144 - 0.753982423434623516556030153878964483737945556640625 * InternalPrior_145 - 0.0253383332663896197745057037309379666112363338470458984375 * InternalPrior_146 + 0.090012176785123687583478613305487670004367828369140625 * InternalPrior_147 + 0.392279948976428816109773833886720240116119384765625 * InternalPrior_148 + 0.0200715664802934533328393484907792299054563045501708984375 * InternalPrior_149 - 0.06579148234974012410258836780485580675303936004638671875 * InternalPrior_150 - 0.275556567873774638233186351499170996248722076416015625 * InternalPrior_151 + 0.0205868471576503113407152767422303440980613231658935546875 * InternalPrior_152 + 0.039989909301828684140556191550786024890840053558349609375 * InternalPrior_153 - 0.2119113509427168751120262868425925262272357940673828125 * InternalPrior_154 + 0.387634312106242273632261685634148307144641876220703125 * InternalPrior_155 + 0.238547325845268110011687667793012224137783050537109375 * InternalPrior_156 - 0.50792835778453671036203331823344342410564422607421875 * InternalPrior_159 + 0.975926172354937282449327540234662592411041259765625 * InternalPrior_160 - 0.615124055683590409415728572639636695384979248046875 * InternalPrior_161 - 0.340995269055101968280752089412999339401721954345703125 * InternalPrior_164 + 0.490455960038180316384881507474347017705440521240234375 * InternalPrior_172;
sigmauHALL = exp( log_sigmauHALL );
log_sigmauKALL = -9.90364948999999938905602903105318546295166015625 + 0.72766740278704611366578092201962135732173919677734375 * InternalPrior_140 - 0.0136417935307196376559790707005959120579063892364501953125 * InternalPrior_141 - 0.533901837417605218405469713616184890270233154296875 * InternalPrior_142 + 0.21456616677853623809113514653290621936321258544921875 * InternalPrior_143 + 0.32416282027102794049966405509621836245059967041015625 * InternalPrior_144 + 1.328687535181249046445373096503317356109619140625 * InternalPrior_145 + 0.418187770769000211057431215522228740155696868896484375 * InternalPrior_146 - 0.040301854599469784379284220676709082908928394317626953125 * InternalPrior_147 - 0.3189397774621223202728970136377029120922088623046875 * InternalPrior_148 - 0.1973741098532578452928731849169707857072353363037109375 * InternalPrior_149 + 0.2212540907220843233726981225117924623191356658935546875 * InternalPrior_150 - 0.2426198509737143294007211125062895007431507110595703125 * InternalPrior_151 - 0.09185913367384694605544126488894107751548290252685546875 * InternalPrior_152 - 0.036495796830343089911519172119369613938033580780029296875 * InternalPrior_153 + 0.51369946878678707236076661502011120319366455078125 * InternalPrior_154 - 0.74788754213234864831605364088318310678005218505859375 * InternalPrior_155 + 0.2385473258379023631103876823544851504266262054443359375 * InternalPrior_156 - 0.50792835778590694761902568643563427031040191650390625 * InternalPrior_159 + 0.9759261723554109035916326320148073136806488037109375 * InternalPrior_160 - 0.61512405568373174080676335506723262369632720947265625 * InternalPrior_161 - 0.340995269055207383956940248026512563228607177734375 * InternalPrior_164 + 0.490455960038180316384881507474347017705440521240234375 * InternalPrior_172;
sigmauKALL = exp( log_sigmauKALL );
log_sigmauXALL = -9.90364948999999938905602903105318546295166015625 + 0.0515556980177758195083015380077995359897613525390625 * InternalPrior_140 + 0.00347370387394302544692425982475469936616718769073486328125 * InternalPrior_141 + 1.5151984867223706743288857978768646717071533203125 * InternalPrior_142 + 0.286126025341882528341130864646402187645435333251953125 * InternalPrior_143 + 0.7525754333851282229517209998448379337787628173828125 * InternalPrior_144 - 0.57470511174613625460239063613698817789554595947265625 * InternalPrior_145 - 0.392849437503075105126981725334189832210540771484375 * InternalPrior_146 - 0.04971032218549688297404287595782079733908176422119140625 * InternalPrior_147 - 0.07334017151449633009629991420297301374375820159912109375 * InternalPrior_148 + 0.177302543372869048088347199154668487608432769775390625 * InternalPrior_149 - 0.1554626083723495144628401476438739337027072906494140625 * InternalPrior_150 + 0.51817641884802068119597606710158288478851318359375 * InternalPrior_151 + 0.07127228651617058263756376845776685513556003570556640625 * InternalPrior_152 - 0.0034941124714592242637978269925724816857837140560150146484375 * InternalPrior_153 - 0.301788117843981129606589774994063191115856170654296875 * InternalPrior_154 + 0.360253230025956827642374946663039736449718475341796875 * InternalPrior_155 + 0.2385473258398416451786516745414701290428638458251953125 * InternalPrior_156 - 0.5079283577849624808919770657666958868503570556640625 * InternalPrior_159 + 0.97592617235538592357357856599264778196811676025390625 * InternalPrior_160 - 0.61512405568374861619673765744664706289768218994140625 * InternalPrior_161 - 0.340995269055676397673693145407014526426792144775390625 * InternalPrior_164 + 0.490455960038180316384881507474347017705440521240234375 * InternalPrior_172;
sigmauXALL = exp( log_sigmauXALL );
log_sigmauTALL = -9.90364948999999938905602903105318546295166015625 + 0.305691061168327282704382241718121804296970367431640625 * InternalPrior_140 - 0.0062327425965987386102806766530193272046744823455810546875 * InternalPrior_141 + 0.12421758236398521002552541858676704578101634979248046875 * InternalPrior_142 + 0.348731376709167317784476836095564067363739013671875 * InternalPrior_143 - 0.82333653916125604244058422409580089151859283447265625 * InternalPrior_144 + 0.40461934149095479806845787607016973197460174560546875 * InternalPrior_145 - 1.4672227409645308693342258266056887805461883544921875 * InternalPrior_146 + 0.8134079241645257862813878091401420533657073974609375 * InternalPrior_147 + 0.0160911267619444041387932742281918763183057308197021484375 * InternalPrior_148 + 0.00910888910673783060156782909189132624305784702301025390625 * InternalPrior_149 + 0.0221926049657414949101141843357254401780664920806884765625 * InternalPrior_150 + 0.2266143210281184872112447692416026256978511810302734375 * InternalPrior_151 - 0.004074337193322200185996440069402524386532604694366455078125 * InternalPrior_152 - 0.02552414760179975983245270754196099005639553070068359375 * InternalPrior_153 + 0.096844483030027628256419802710297517478466033935546875 * InternalPrior_154 - 0.2013038042058432897096764691013959236443042755126953125 * InternalPrior_155 + 0.2385473258409013530556563864593044854700565338134765625 * InternalPrior_156 - 0.5079283577810205230207429849542677402496337890625 * InternalPrior_159 - 1.0206761448805516945270710493787191808223724365234375 * InternalPrior_160 - 0.53761482963642170940232745124376378953456878662109375 * InternalPrior_161 - 0.34099526905649046870649954144028015434741973876953125 * InternalPrior_164 + 0.49045596003817804042768102590343914926052093505859375 * InternalPrior_172;
sigmauTALL = exp( log_sigmauTALL );
log_sigmauNTALL = -9.90364948999999938905602903105318546295166015625 - 0.348818248036860512062418138157227076590061187744140625 * InternalPrior_140 + 0.006215835651654780767694230547704137279652059078216552734375 * InternalPrior_141 - 0.08252256964629052504722750427390565164387226104736328125 * InternalPrior_142 - 0.348731063598575807827018024909193627536296844482421875 * InternalPrior_143 + 0.5792160791971863176286205998621881008148193359375 * InternalPrior_144 - 0.40452776763116282676691071173991076648235321044921875 * InternalPrior_145 + 1.1413562457046764198054233929724432528018951416015625 * InternalPrior_146 + 0.83458726514153791509187385599943809211254119873046875 * InternalPrior_147 - 1.0668014988253544661489513600827194750308990478515625 * InternalPrior_148 - 0.0090978208190232445762291035862290300428867340087890625 * InternalPrior_149 - 0.0222049929200720079502939796611826750449836254119873046875 * InternalPrior_150 - 0.227167584347375106634814301287406124174594879150390625 * InternalPrior_151 + 0.004085790787712528619735063983853251556865870952606201171875 * InternalPrior_152 + 0.025522883793146204645108099384742672555148601531982421875 * InternalPrior_153 - 0.09680995375907040789709157024844898842275142669677734375 * InternalPrior_154 + 0.201186978491090184828493647728464566171169281005859375 * InternalPrior_155 + 0.2385473258403411900285817637268337421119213104248046875 * InternalPrior_156 - 0.5079283577818090034128317711292766034603118896484375 * InternalPrior_159 - 1.020676144880035440820620351587422192096710205078125 * InternalPrior_160 - 0.5376148296359399836319425958208739757537841796875 * InternalPrior_161 - 0.340995269056639960236765318768448196351528167724609375 * InternalPrior_164 + 0.490455960038183425009350457912660203874111175537109375 * InternalPrior_172;
sigmauNTALL = exp( log_sigmauNTALL );
log_sigmauWALL = -9.90364948999999938905602903105318546295166015625 + 0.04312718686903134479582178073542308993637561798095703125 * InternalPrior_140 + 1.69069449377086029081933282736116552769090048968791961669921875e-05 * InternalPrior_141 - 0.041695012717167488636160754822412854991853237152099609375 * InternalPrior_142 - 3.131103385945435805086931903284952483090819441713392734527587891e-07 * InternalPrior_143 + 0.2441204599650508566544004906972986645996570587158203125 * InternalPrior_144 - 9.1573859294553046415769681498630916394176892936229705810546875e-05 * InternalPrior_145 + 0.32586649526036015611651919243740849196910858154296875 * InternalPrior_146 - 1.6479951893068729429359109417418949306011199951171875 * InternalPrior_147 + 1.0507103720634878296635861261165700852870941162109375 * InternalPrior_148 - 1.106828774703156139692927784068388064042665064334869384765625e-05 * InternalPrior_149 + 1.238795438566573045590692159212409251267672516405582427978515625e-05 * InternalPrior_150 + 0.00055326331935562507967352186000198344117961823940277099609375 * InternalPrior_151 - 1.145359440979611892008713930346530673887173179537057876586914063e-05 * InternalPrior_152 + 1.263808631127615620941165124058169766385617549531161785125732422e-06 * InternalPrior_153 - 3.45292708010359203026941321557075070813880302011966705322265625e-05 * InternalPrior_154 + 0.000116825714489856162026960861854973927620449103415012359619140625 * InternalPrior_155 + 0.2385473258408329078061882455585873685777187347412109375 * InternalPrior_156 - 0.50792835778113343270234736337442882359027862548828125 * InternalPrior_159 - 1.0206761448796768387836664260248653590679168701171875 * InternalPrior_160 - 0.5376148296359144485023762172204442322254180908203125 * InternalPrior_161 - 0.340995269056428351728271763931843452155590057373046875 * InternalPrior_164 + 0.490455960038180760474091357536963187158107757568359375 * InternalPrior_172;
sigmauWALL = exp( log_sigmauWALL );

JP_ = step3GetSteady( lambda, eta, phiR, zetaR, gamma, scriptp, scriptq,  
alphaCP, alphaCD, alphah, alphaKP, alphaD, alphaND, alphaHP, alphaHW, alphaHL, alphaK, alphaKL, alphaHLX, alphaY, betabarl, 
sigma, xi, bbeta, 
h, varrhoC, eC, varrhoCP, eCP, varrhoCD, 
nuW, nuT, nuNT, nuSW, nuST, nuSNT, nuD, nuNDCG, nuK, nuH, nuh, 
rhoQB, 
thetaKU0, thetaKU1, thetaDU0, thetaDU1, 
alphaNC, eT, eW, FWCtilde, FKtilde, 
o, eKLT, eKLNT, eKLW, varrhoKL, eHLXT, eHLXNT, eHLXW, varrhoHLX, eYT, eYNT, eYW, varrhoY, 
tauKG_, tauHG_, tauCG_, taub_, tauD_, tauND_, tauNT_, tauTC_, iotaTX_, iotaTM_, iotaWX_, iotaWM_, tauLa_, tauLb_, tauHW_, tauHT_, tauHNT_, tauKW_, tauKT_, tauKNT_, tauscriptXW_, tauscriptXT_, tauscriptXNT_, 
phiiotaTX ,phiiotaTM, phiiotaWX, phiiotaWM, 
Omegah_, OmegaCP_, OmegaC_, OmegaKP_, OmegaHP_, OmegaD_, OmegaND_, OmegaKG_, OmegaHG_, OmegaCG_, OmegaY_, OmegaTC_, OmegaWP_, OmegaWC_, OmegaKT_, OmegaHLT_, OmegaKLT_, OmegaHLXT_, OmegaT_, OmegaKNT_, OmegaHLNT_, OmegaKLNT_, OmegaHLXNT_, OmegaNT_, OmegaKW_, OmegaHLW_, OmegaKLW_, OmegaHLXW_, OmegaW_, 
GN_, Z_, deltaItilde_, scriptFI_, deltaD_, kappa0_, kappah_, 
kappaT_, kappaNT_, kappaW_, kappaST_, kappaSNT_, kappaSW_, kappaD_, kappaNDCG_, kappaK_, kappaH_, 
deltaKPT_, deltaHPT_, deltaKPNT_, deltaHPNT_, deltaKPW_, deltaHPW_, deltaKG_, deltaHG_, betabarb, 
pT0, yTC0, m_, varpi_, eT0_, Ntilde1_, Ntilde2_, Ntilde3_, Ntilde4_);

    LW1l_ = exp( GetSolution( 1+(1-1)*28 ) );
    LT1l_ = exp( GetSolution( 2+(1-1)*28 ) );
    LNT1l_ = exp( GetSolution( 3+(1-1)*28 ) );
    LSW1l_ = exp( GetSolution( 4+(1-1)*28 ) );
    LST1l_ = exp( GetSolution( 5+(1-1)*28 ) );
    LSNT1l_ = exp( GetSolution( 6+(1-1)*28 ) );
    LNDCG1l_ = exp( GetSolution( 7+(1-1)*28 ) );
    Lh1l_ = exp( GetSolution( 8+(1-1)*28 ) );
    CD1l_ = exp( GetSolution( 9+(1-1)*28 ) );
    CND1l_ = exp( GetSolution( 10+(1-1)*28 ) );
    LNDCG1b_ = exp( GetSolution( 11+(1-1)*28 ) );
    Lh1b_ = exp( GetSolution( 12+(1-1)*28 ) );
    CD1b_ = exp( GetSolution( 13+(1-1)*28 ) );
    CND1b_ = exp( GetSolution( 14+(1-1)*28 ) );
	LKP1_ = exp( GetSolution( 15+(1-1)*28 ) );
	LHP1_ = exp( GetSolution( 16+(1-1)*28 ) );
	LND1_ = exp( GetSolution( 17+(1-1)*28 ) );
    LCG1_ = exp( GetSolution( 18+(1-1)*28 ) );
	LKG1_ = exp( GetSolution( 19+(1-1)*28 ) );
	LHG1_ = exp( GetSolution( 20+(1-1)*28 ) );
	KPT1_ = exp( GetSolution( 21+(1-1)*28 ) );
	KPNT1_ = exp( GetSolution( 22+(1-1)*28 ) );
	KPW1_ = exp( GetSolution( 23+(1-1)*28 ) );
    IKP1_ = exp( GetSolution( 24+(1-1)*28 ) );
    IHP1_ = exp( GetSolution( 25+(1-1)*28 ) );
    P1_ = exp( GetSolution( 26+(1-1)*28 ) );
	YWC1_ = exp( GetSolution( 27+(1-1)*28 ) );
	X1_ = exp( GetSolution( 28+(1-1)*28 ) );

    WD1_ = GetAdditionalSolution( 1 +(1-1)*7 );
    WW1_ = GetAdditionalSolution( 2 +(1-1)*7 );
    WT1_ = GetAdditionalSolution( 3 +(1-1)*7 );
    WNT1_ = GetAdditionalSolution( 4 +(1-1)*7 );
    WSW1_ = GetAdditionalSolution( 5 +(1-1)*7 );
    WST1_ = GetAdditionalSolution( 6 +(1-1)*7 );
    WSNT1_ = GetAdditionalSolution( 7 +(1-1)*7 );
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

    WD@{n}_    = WD1_    ;
    WW@{n}_    = WW1_    ;
    WT@{n}_    = WT1_    ;
    WNT@{n}_   = WNT1_   ;
    WSW@{n}_   = WSW1_   ;
    WST@{n}_   = WST1_   ;
    WSNT@{n}_  = WSNT1_  ;
@#endfor

@#for n in 1:SN
	tauKG@{n}_        = tauKG_       ;
	tauHG@{n}_        = tauHG_       ;
	tauCG@{n}_        = tauCG_       ;
	tau@{n}b_         = taub_        ;
	tau@{n}l_         = taul_        ;
	tauD@{n}_         = tauD_        ;
	tauND@{n}_        = tauND_       ;
	tauNT@{n}_        = tauNT_       ;
	tauTC@{n}_        = tauTC_       ;
	iotaTX@{n}_       = iotaTX_      ;
	iotaTM@{n}_       = iotaTM_      ;
	iotaWX@{n}_       = iotaWX_      ;
	iotaWM@{n}_       = iotaWM_      ;
	tauLa@{n}_        = tauLa_       ;
	tauLb@{n}_        = tauLb_       ;
	tauHW@{n}_        = tauHW_       ;
	tauHT@{n}_        = tauHT_       ;
	tauHNT@{n}_       = tauHNT_      ;
	tauKW@{n}_        = tauKW_       ;
	tauKT@{n}_        = tauKT_       ;
	tauKNT@{n}_       = tauKNT_      ;
	tauscriptXW@{n}_  = tauscriptXW_ ;
	tauscriptXT@{n}_  = tauscriptXT_ ;
	tauscriptXNT@{n}_ = tauscriptXNT_;
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

NN_ = 0	
	@#for n in 1:SN
		+ N@{n}_
	@#endfor
	;

N0_ = 100 - NN_;

X_ = 0 
@#for n in 1:SN
	+ X@{n}_ 
@#endfor
;
YWC_ = 0 
@#for n in 1:SN
	+ YWC@{n}_ 
@#endfor
;

@#for n in 1:SN
    OmegaY@{n}__ = OmegaY_ *Ntilde@{n}_ /Ntilde1_;
@#endfor

%a few equations from the production of IND and CG, in order to get beta first.
%also the production of public goods
@#for n in 1:SN
    Y@{n}_ = OmegaY@{n}__;
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
%engineering sector
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
		KU@{S}@{n}_ = ( ( 1 - VV@{n}l_ * glambda_K_ * ( 1 - deltaKP@{S}_ ) ) / ( thetaKU0 / gKP_ - VV@{n}l_ * glambda_K_ * thetaKU0 / ( 1+thetaKU1 ) ) ) ^ ( 1 / ( 1+thetaKU1 ) );
		RKP@{S}@{n}_DIVIDEDPKP@{n}_ = thetaKU0 * KU@{S}@{n}_ ^ thetaKU1 / gKP_ / ( 1 - tauK@{S}_ );
		RHP@{S}@{n}_DIVIDEDPHP@{n}_ = ( 1 - VV@{n}l_ * glambda_H_ * ( 1 - deltaHP@{S}_ ) ) / ( 1 - tauH@{S}_ );
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
%	WD@{n}_ = (( 
%		( 1 - tauLD@{n}_ ) ^ ( 1 / nuD ) * ( 
%		( lambda_B@{n}l_ / ( V@{n}l_DIVIDEDU@{n}l_ ) ^ sigma / ( 1 - beta@{n}l_ ) / N@{n}l_ ^ ( xi - 1 + sigma ) / ( CBar@{n}l_ / gCBar_ / ( N@{n}l_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N@{n}l_ + 
%		( lambda_B@{n}b_ / ( V@{n}b_DIVIDEDU@{n}b_ ) ^ sigma / ( 1 - beta@{n}b_ ) / N@{n}b_ ^ ( xi - 1 + sigma ) / ( CBar@{n}b_ / gCBar_ / ( N@{n}b_ / GN_ ) ) / kappaD_ ) ^ ( 1 / nuD ) * N@{n}b_ 
%		) * OmegaD_ / ID@{n}_ / ( ( 1 - alphaD ) / alphaD ) ^ alphaD / P@{n}_ ^ alphaD 
%		) ^ ( -1 / ( alphaD + 1 / nuD ) ));	
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
	HG@{n}_ = IHG@{n}_ / ( 1 - ( 1 - deltaHG_ ) / gHG_ );
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
	KG@{n}_ = IKG@{n}_ / ( 1 - ( 1 - deltaKG_ ) / gKG_ );
	PKG@{n}_ = P@{n}_ * YKG@{n}_ / alphaKG / IKG@{n}_;
@#endfor

%Labor supply in W/T/NT, SW/ST/SNT, h
@#for n in 1:SN
	@#for S in [ "W", "T", "NT", "SW", "ST", "SNT" ]
		%W@{S}@{n}_ = ( V@{n}l_DIVIDEDU@{n}l_ ) ^ sigma  * ( 1 - beta@{n}l_ ) * N@{n}l_ ^ ( xi - 1 + sigma ) * kappa@{S}_ * L@{S}@{n}l_ ^ nu@{S} * CBar@{n}l_ / N@{n}l_ ^ ( 1 + nu@{S} ) / ( gCBar_ / GN_ ) / lambda_B@{n}l_ / ( 1 - tauL@{S}@{n}_ );
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
		kappaTemp@{n}@{m}_ = kappa0_ + kappaW_ / ( 1 + nuW ) * ( LW@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuW ) + kappaT_ / ( 1 + nuT ) * ( LT@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuT ) + kappaNT_ / ( 1 + nuNT ) * ( LNT@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuNT )
			+ kappaSW_ / ( 1 + nuSW ) * ( LSW@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuSW ) + kappaST_ / ( 1 + nuST ) * ( LST@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuST ) + kappaSNT_ / ( 1 + nuSNT ) * ( LSNT@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuSNT )
			+ kappaD_ / ( 1 + nuD ) * ( LD@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuD )	+ kappaNDCG_ / ( 1 + nuNDCG ) * ( LNDCG@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuNDCG ) + kappaK_ / ( 1 + nuK ) * ( LK@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuK ) + kappaH_ / ( 1 + nuH ) * ( LH@{n}@{m}_ / N@{n}@{m}_ ) ^ ( 1 + nuH )
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
        lambda_CPBar@{n}@{m}_ = VV@{n}@{m}_ * lambda_C@{n}@{m}_ * glambda_C_ * ( alphaCP * C@{n}@{m}_ * gC_ / CPBar@{n}@{m}_ - OmegaC_ * CPBar@{n}@{m}_ ^ ( ( alphaCP - 1 ) * ( 1 - 1 / eC ) - 1 ) * ( C@{n}@{m}_ * gC_ / OmegaC_ ) ^ ( 1 / eC ) * alphaCP * ( CP@{n}@{m}_ * gCP_ ) ^ ( 1 - 1 / eC ) )
            / ( 1 - VV@{n}@{m}_ * glambda_CPBar_ * ( CP@{n}@{m}_ * gCP_ / CG@{n}_ / gCG_ * ( N@{n}b_ + N@{n}l_ ) / N@{n}@{m}_ ) ^ ( 1 - varrhoCP ) * varrhoCP * CPBar@{n}@{m}_ ^ ( varrhoCP - 1 ) );
		%FOC of CP
		lambda_CP@{n}@{m}_ = lambda_C@{n}@{m}_ * OmegaC_ * ( CPBar@{n}@{m}_ / gCPBar_ ) ^ ( ( alphaCP - 1 ) * ( eC - 1 ) / eC ) * alphaCP * ( C@{n}@{m}_ / CP@{n}@{m}_ / OmegaC_ ) ^ ( 1 / eC ) + lambda_CPBar@{n}@{m}_ * ( ( N@{n}b_ + N@{n}l_ ) / N@{n}@{m}_ / CG@{n}_ ) ^ ( 1 - varrhoCP ) * ( CPBar@{n}@{m}_ / gCPBar_ ) ^ varrhoCP * ( 1 - varrhoCP ) * CP@{n}@{m}_ ^ ( -varrhoCP );
		%FOC of CDBar
        lambda_CDBar@{n}@{m}_ = VV@{n}@{m}_ * lambda_CP@{n}@{m}_ * glambda_CP_ * ( alphaCD * CP@{n}@{m}_ * gCP_ / CDBar@{n}@{m}_ - OmegaCP_ * CDBar@{n}@{m}_ ^ ( ( alphaCD - 1 ) * ( 1 - 1 / eCP ) - 1 ) * ( CP@{n}@{m}_ * gCP_ / OmegaCP_ ) ^ ( 1 / eCP ) * alphaCD * ( CD@{n}@{m}_ * gCD_ ) ^ ( 1 - 1 / eCP ) )
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
		PKLTemp@{S}@{n}_ = OmegaKL@{S}_ ^ ( 1 - 1 / eKL@{S} ) * gKBar_ ^ ( -1 / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKL@{S} - 1 ) / eKL@{S} ) * YKLTemp@{S}@{n}_ ^ ( 1/ eKL@{S} - 1 )
			- Xi@{n}_ * OmegaKL@{S}_ ^ ( 1 - 1 / eKL@{S} ) * gK_ * gPKL_ * gKBar_ ^ ( -varrhoKL / ( 1 - varrhoKL ) * ( alphaKL - 1 ) * ( eKL@{S} - 1 ) / eKL@{S} ) * ( gYKL_ / gK_ ) ^ ( 1 / eKL@{S} ) * YKLTemp@{S}@{n}_ ^ ( 1/ eKL@{S} - 1 )
			+ Xi@{n}_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoKL );
		
		PKL@{S}@{n}_ = 1 / ( ( PKLTemp@{S}@{n}_ * alphaKL / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / RK@{S}@{n}_ ) ^ alphaKL * ( 1 / W@{S}@{n}_ - PKLTemp@{S}@{n}_ * alphaKL / ( 1 - varrhoKL * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / W@{S}@{n}_ ) ^ ( 1 - alphaKL ) * YKLTemp@{S}@{n}_ );

		%HLX in @{S}@{n}
		YHLXTemp@{S}@{n}_ = OmegaHLX@{S}_ * gYHLBar_ ^ ( -alphaHLX / ( 1 - varrhoHLX ) ) * ( alphaHLX * gYHLBar_ ^ ( 1 / ( 1 - varrhoHLX ) * ( eHLX@{S} - 1 ) / eHLX@{S} ) + 1 - alphaHLX ) ^ ( eHLX@{S} / ( eHLX@{S} - 1 ) );
		PHLXTemp@{S}@{n}_ = OmegaHLX@{S}_ ^ ( 1 - 1 / eHLX@{S} ) * gYHLBar_ ^ ( -1 / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLX@{S} - 1 ) / eHLX@{S} ) * YHLXTemp@{S}@{n}_ ^ ( 1/ eHLX@{S} - 1 )
			- Xi@{n}_ * OmegaHLX@{S}_ ^ ( 1 - 1 / eHLX@{S} ) * gYHL_ * gPHLX_ * gYHLBar_^ ( -varrhoHLX / ( 1 - varrhoHLX ) * ( alphaHLX - 1 ) * ( eHLX@{S} - 1 ) / eHLX@{S} ) *  ( gYHLX_ / gYHL_ ) ^ ( 1 / eHLX@{S}  ) * YHLXTemp@{S}@{n}_ ^ ( 1/ eHLX@{S} - 1 )
			+ Xi@{n}_ * GN_ * GAs_ ^ a_ * ( 1 - varrhoHLX );
		
		PHLX@{S}@{n}_ = 1 / ( ( PHLXTemp@{S}@{n}_ * alphaHLX / ( 1 - varrhoHLX * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / PHL@{S}@{n}_ ) ^ alphaHLX * ( 1 / ( 1 + tauscriptX@{S}_ ) / PscriptX@{n}_ - PHLXTemp@{S}@{n}_ * alphaHLX / ( 1 - varrhoHLX * Xi@{n}_ * GN_ * GAs_ ^ a_ ) / ( 1 + tauscriptX@{S}_ )  / PscriptX@{n}_ ) ^ ( 1 - alphaHLX ) * YHLXTemp@{S}@{n}_ );

		%Y in @{S}@{n}
		YTemp@{S}@{n}_ = Omega@{S}_ * gYHLXBar_ ^ ( -alphaY / ( 1 - varrhoY ) ) * ( alphaY * gYHLXBar_ ^ ( 1 / ( 1 - varrhoY ) * ( eY@{S} - 1 ) / eY@{S} ) + 1 - alphaY ) ^ ( eY@{S} / ( eY@{S} - 1 ) );
		PTemp@{S}@{n}_ = Omega@{S}_ ^ ( 1 - 1 / eY@{S} ) * gYHLXBar_ ^ ( -1 / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eY@{S} - 1 ) / eY@{S} ) * YTemp@{S}@{n}_ ^ ( 1/ eY@{S} - 1 )
			- Xi@{n}_ * Omega@{S}_ ^ ( 1 - 1 / eY@{S} ) * gYHLX_ * gPS_ * gYHLXBar_ ^ (  -varrhoY / ( 1 - varrhoY ) * ( alphaY - 1 ) * ( eY@{S} - 1 ) / eY@{S} ) *  ( gYS_ / gYHLX_ ) ^ ( 1 / eY@{S}  ) * YTemp@{S}@{n}_ ^ ( 1/ eY@{S} - 1 )
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
	PTC@{n}_ = ( 
		@#for m in 0:SN
			+ N@{m}_ * ( PT@{m}_ * ( 
			@#if n == m
				1 
			@#else
				1 + iotaTM_ + iotaTX_ 
			@#endif
			) ) ^ ( 1 - eT ) 
		@#endfor
	) ^ ( 1 / ( 1 - eT ) ) / OmegaTC_;
	
	PWP@{n}_ = ( 
		@#for m in 1:SN
			+ N@{m}_ / NN_ * ( PW@{m}_ * ( 
			@#if n == m
				1 
			@#else
				1 + iotaWM_ + iotaWX_ 
			@#endif
			) ) ^ ( 1 - eW ) 
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
		YT@{n}@{m}_ = ( PTC@{n}_ * OmegaTC_ / ( PT@{m}_ * ( 
		@#if n == m
			1 
		@#else
			1 + iotaTM_ + iotaTX_ 
		@#endif
		) ) ) ^ eT * YTC@{n}_ / OmegaTC_ * N@{m}_;
	@#endfor
	
	@#for m in 1:SN
        YW@{n}@{m}_ = ( PWP@{n}_ * OmegaWP_/ ( PW@{m}_ * ( 
        @#if n == m
            1 
        @#else
            1 + iotaWM_ + iotaWX_ 
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
	YT@{n}_ = YT0@{n}_ * ( 1 + ( 1 - phiiotaTX ) * iotaTX_ )
	@#for m in 1:SN
		+ YT@{m}@{n}_ * 
		@#if n == m
			1 
		@#else
			( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) 
		@#endif
	@#endfor
	;
	
	YW@{n}_ = 0 
	@#for m in 1:SN
		+ YW@{m}@{n}_ * 
		@#if n == m
			1 
		@#else
			( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) 
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
    IKP@{S}@{n}_ = ( 1 - ( 1 - deltaKP@{S}_ - thetaKU0 / ( 1+thetaKU1 ) * KU@{S}@{n}_ ^ ( 1+thetaKU1 ) ) / gKP_ ) * KP@{S}@{n}_;

%demand of H in @{S}@{n}
    HP@{S}@{n}_ = PHL@{S}@{n}_ * YHL@{S}@{n}_ * alphaHL / RHP@{S}@{n}_;
	HPP@{S}@{n}_ = HP@{S}@{n}_ * gHP_;
    IHP@{S}@{n}_ = ( 1 - ( 1 - deltaHP@{S}_ ) / gHP_ ) * HP@{S}@{n}_;

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
    GDP@{n}_ = 
    PKP@{n}_ * IKP@{n}_ + PHP@{n}_ * IHP@{n}_ + PD@{n}_ * ID@{n}_ + PND@{n}_ * CND@{n}_ + PKG@{n}_ * IKG@{n}_ + PHG@{n}_ * IHG@{n}_ + PCG@{n}_ * CG@{n}_ 
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_
            - ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ * PT@{n}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ * PW@{n}_ 
            - ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ * PT@{m}_ - ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ * PW@{m}_ 
		@#endif
	@#endfor
    + YWC@{n}_ * PWC_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_;
    GDPplagqlag@{n}_ = GDP@{n}_ / gB_;
    GDPplag@{n}_ = 
    PKP@{n}_ / gPKP_ * IKP@{n}_ + PHP@{n}_ / gPHP_ * IHP@{n}_ + PD@{n}_ / gPD_ * ID@{n}_ + PND@{n}_ / gPND_ * CND@{n}_ + PKG@{n}_ / (gB_ / gKG_) * IKG@{n}_ + PHG@{n}_ / (gB_ / gHG_) * IHG@{n}_ + PCG@{n}_ / (gB_ / gCG_) * CG@{n}_ 
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ / gPS_
            - ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ / gPS_
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ * PT@{n}_ / gPS_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ * PW@{n}_ / gPS_ 
            - ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ * PT@{m}_ / gPS_ - ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ * PW@{m}_ / gPS_ 
		@#endif
	@#endfor
    + YWC@{n}_ * PWC_ / GAs_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_;
    GDPqlag@{n}_ = 
    PKP@{n}_ * IKP@{n}_ / gKP_ + PHP@{n}_ * IHP@{n}_ / gHP_ + PD@{n}_ * ID@{n}_ / gD_ + PND@{n}_ * CND@{n}_ / gCND_ + PKG@{n}_ * IKG@{n}_ / gKG_ + PHG@{n}_ * IHG@{n}_ / gHG_ + PCG@{n}_ * CG@{n}_ / gCG_ 
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ / gYS_
            - ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ / gYS_
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ / gYS_ * PT@{n}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ / gYS_ * PW@{n}_ 
            - ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ / gYS_ * PT@{m}_ - ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ / gYS_ * PW@{m}_ 
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
        KPtilde@{S}@{n}_ = IKP@{S}@{n}_ / ( 1 - ( 1 - deltaKP@{S}_ ) / gKP_ );
        deltaKPtildeAUXD@{S}@{n}_ = KPtilde@{S}@{n}_;
        deltaKPtildeAUXN@{S}@{n}_ = KPtilde@{S}@{n}_ * deltaKP@{S}_;
	@#endfor

    deltaKGtildeAUXD@{n}_ = IKG@{n}_ / ( 1- ( 1 - deltaKG_ ) / gKG_ );
    deltaKGtildeAUXN@{n}_ = deltaKGtildeAUXD@{n}_ * deltaKG_;

    deltaHGtildeAUXD@{n}_ = IHG@{n}_ / ( 1 - ( 1 - deltaHG_ ) / gHG_ );
    deltaHGtildeAUXN@{n}_ = deltaHGtildeAUXD@{n}_ * deltaHG_;
@#endfor

GDPW_ = 0 
    @#for n in 1:SN
        + GDP@{n}_ 
    @#endfor
    ;
GDPWplagqlag_ = 0 
    @#for n in 1:SN
        + GDPplagqlag@{n}_ 
    @#endfor
    ;
GDPWplag_ = 0 
    @#for n in 1:SN
        + GDPplag@{n}_ 
    @#endfor
    ;
GDPWqlag_ = 0 
    @#for n in 1:SN
        + GDPqlag@{n}_ 
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
    PDI@{n}_ = 
    PKP@{n}_ * IKP@{n}_ + PD@{n}_ * ID@{n}_ * alpha_resid_ 
    + YWC@{n}_ * PWC_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_;
    PDIplagqlag@{n}_ = PDI@{n}_ / gB_;
    PDIplag@{n}_ = 
    PKP@{n}_ / gPKP_ * IKP@{n}_ + PD@{n}_ / gPD_ * ID@{n}_ * alpha_resid_ 
    + YWC@{n}_ * PWC_ / GAs_ * ( scriptFI_ * II_ * ( scripts_ - ( 1 - scriptq ) * ( 1 - deltaItilde_ ) * scripts_ / GII_ ) + II_ * scripts_ * ScriptFRP_ * JP_ ) / YWC_;
    PDIqlag@{n}_ = 
    PKP@{n}_ * IKP@{n}_ / gKP_ + PD@{n}_ * ID@{n}_ / gD_ * alpha_resid_ 
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

%Export and deflator
    Export@{n}_ = ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ * PT@{n}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ * PW@{n}_ 
		@#endif
	@#endfor
    ;
    Exportplagqlag@{n}_ = Export@{n}_ / gB_;
    Exportplag@{n}_ = ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ / gPS_
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ * PT@{n}_ / gPS_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ * PW@{n}_ / gPS_ 
		@#endif
	@#endfor
    ;
    Exportqlag@{n}_ = ( 1 + ( 1 - phiiotaTX ) * iotaTX_ ) * YT0@{n}_ * PT@{n}_ / gYS_
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
			+ ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{m}@{n}_ / gYS_ * PT@{n}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{m}@{n}_ / gYS_ * PW@{n}_ 
		@#endif
	@#endfor
    ;
    ExportInflation@{n}_ = log( ( Export@{n}_ / Exportplag@{n}_ * Exportqlag@{n}_ / Exportplagqlag@{n}_ ) ^ ( 1 / 2 ) );

%Import and deflator
    Import@{n}_ = ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
            + ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ * PT@{m}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ * PW@{m}_ 
		@#endif
	@#endfor
    ;
    Importplagqlag@{n}_ = Import@{n}_ / gB_;
    Importplag@{n}_ = ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ / gPS_
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
            + ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ * PT@{m}_ / gPS_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ * PW@{m}_ / gPS_ 
		@#endif
	@#endfor
    ;
    Importqlag@{n}_ = ( 1 + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}0_ * PT0_ / gYS_
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
            + ( 1 + ( 1 - phiiotaTX ) * iotaTX_ + ( 1 - phiiotaTM ) * iotaTM_ ) * YT@{n}@{m}_ / gYS_ * PT@{m}_ + ( 1 + ( 1 - phiiotaWX ) * iotaWX_ + ( 1 - phiiotaWM ) * iotaWM_ ) * YW@{n}@{m}_ / gYS_ * PW@{m}_ 
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
        deltaKPtilde@{S}@{n}_ = deltaKP@{S}_;
        KPcfc@{S}@{n}_ = deltaKPtilde@{S}@{n}_ * KPtilde@{S}@{n}_ / gKP_ * PKP@{n}_;
	@#endfor
%cfc of public physical capital stock
    deltaKGtilde@{n}_ = deltaKG_;
    KGcfc@{n}_ = deltaKGtilde@{n}_ * KG@{n}_ / gKG_ * PKG@{n}_;
%cfc of public R&D capital stock
    deltaHGtilde@{n}_ = deltaHG_;
    HGcfc@{n}_ = deltaHGtilde@{n}_ * HG@{n}_ / gHG_ * PHG@{n}_;
%cfc
    CFC@{n}_ = Dcfc@{n}l_ * alpha_resid_ + Dcfc@{n}b_ * alpha_resid_ + KPcfcT@{n}_ + KPcfcNT@{n}_ + KPcfcW@{n}_ + KGcfc@{n}_ + HGcfc@{n}_;
    deltaALL@{n}_ = CFC@{n}_ / ( Dtilde@{n}l_ / gD_ * PD@{n}_ * alpha_resid_ + Dtilde@{n}b_ / gD_ * PD@{n}_ * alpha_resid_ 
                              + KPtildeT@{n}_ / gKP_ * PKP@{n}_ + KPtildeNT@{n}_ / gKP_ * PKP@{n}_ + KPtildeW@{n}_ / gKP_ * PKP@{n}_ 
                              + KG@{n}_ / gKG_ * PKG@{n}_ + HG@{n}_ / gHG_ * PHG@{n}_ );

%Labour income
    LabourIncome@{n}_ = 0 
	@#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
	  + W@{S}@{n}_ * L@{S}@{n}b_ 
	@#endfor
	@#for S in [ "W", "T", "NT" ]
	  + W@{S}@{n}_ * LS@{S}@{n}b_ 
	@#endfor
	@#for S in Sectors2
	  + W@{S}@{n}_ * L@{S}@{n}l_ 
	@#endfor
    @#for S in Sectors0
      + RHP@{S}@{n}_ * HP@{S}@{n}_
	@#endfor
    ;

%HoursWorkedPerCapita
    Log_HoursWorkedPerCapita@{n}_ = log( ( 
	@#for S in Sectors2
	  + L@{S}@{n}l_ + L@{S}@{n}b_ 
	@#endfor
    ) / ( N@{n}l_ + N@{n}b_ ) );

%ex post real exchange rate (t-1 to t)
    ExPostR@{n}_ = log( 1 / Q_ ) - GDPInflation@{n}_;

%Spread
    Spread@{n}_ = ( log( 1 / QB@{n}_ ) - log( 1 / Q_ ) );
	
%government revenue
    GovRev@{n}_ =
    ( 
	@#for m in 0:SN
		@#if n == m
			+ 0 
		@#else
            + YT@{m}@{n}_ * PT@{n}_ 
		@#endif
	@#endfor
    ) * iotaTX_ * phiiotaTX 
    + ( 
	@#for m in 0:SN
		@#if n == m
			+ 0 
		@#else
            + YT@{n}@{m}_ * PT@{m}_ 
		@#endif
	@#endfor
    ) * iotaTM_ * phiiotaTM 
    + ( 
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
            + YW@{m}@{n}_ * PW@{n}_ 
		@#endif
	@#endfor
    ) * iotaWX_ * phiiotaWX 
    + ( 
	@#for m in 1:SN
		@#if n == m
			+ 0 
		@#else
            + YW@{n}@{m}_ * PW@{m}_ 
		@#endif
	@#endfor
    ) * iotaWM_ * phiiotaWM 
    + YNT@{n}_ * PNT@{n}_ * tauNT_ * phitauNT + YTC@{n}_ * PTC@{n}_ * tauTC_ * phitauTC 
    + ID@{n}b_ * PD@{n}_ * tauD_ * phitauD + CND@{n}b_ * PND@{n}_ * tauND_ * phitauND + ID@{n}l_ * PD@{n}_ * tauD_ * phitauD + CND@{n}l_ * PND@{n}_ * tauND_ * phitauND 
    @#for S in [ "W", "T", "NT", "D", "NDCG", "K", "H" ]
      + W@{S}@{n}_ * tauL@{S}@{n}_ * L@{S}@{n}b_ * phitauL 
    @#endfor
    @#for S in [ "W", "T", "NT" ]
      + W@{S}@{n}_ * tauL@{S}@{n}_ * LS@{S}@{n}b_ * phitauL 
    @#endfor
    @#for S in Sectors2
      + W@{S}@{n}_ * tauL@{S}@{n}_ * L@{S}@{n}l_ * phitauL 
    @#endfor
    @#for S in Sectors0
      + RHP@{S}@{n}_ * HP@{S}@{n}_ * tauH@{S}_ * phitauH@{S} 
      + KU@{S}@{n}_ * RKP@{S}@{n}_ * KP@{S}@{n}_ * tauK@{S}_ * phitauK@{S} 
      + PscriptX@{n}_ * scriptX@{S}@{n}_ * tauscriptX@{S}_ * phitauscriptX@{S} 
    @#endfor
    + ( taub_ + taul_ ) * Y@{n}_ * P@{n}_;
@#endfor

%observable
%World
gryW = GRGDPW_;
yshare1 = GDP1_ / GDPW_;
yshare2 = GDP2_ / GDPW_;
yshare3 = GDP3_ / GDPW_;

gpopW = log( GN_ );
popshare1 = Ntilde1_;
popshare2 = Ntilde2_;
popshare3 = Ntilde3_;
popshare4 = Ntilde4_;

%US
BEAgiy1 = GGI1_ / GDP1_;
BEAgcy1 = ( GCE1_ + GGI1_ ) / GDP1_  / ( 1 - alpha_pubedu_ ) - BEAgiy1;
BEAcy1 = PCE1_ / GDP1_ - BEAgcy1 * alpha_pubedu_;
JSTiy1 = GDI1_ / GDP1_;
JSTxy1 = Export1_ / GDP1_;
BEAgpcgpy1 = DNDInflation1_ - GDPInflation1_;
BEAgpigpy1 = PDIInflation1_ - GDPInflation1_;
BEAgpgcgpy1 = GCEInflation1_ - GDPInflation1_;
BEAgpgigpy1 = GGIInflation1_ - GDPInflation1_;
BEAgpxgpy1 = ExportInflation1_ - GDPInflation1_;
BEAgpmgpy1 = ImportInflation1_ - GDPInflation1_;
BEAhpop1 = hpop_;
BEAwhy1 = LabourIncome1_ / GDP1_;
BEAcfcy1 = CFC1_ / GDP1_;
JSTexpostr1 = ExPostR1_;
FREDlrni1 = Spread1_;
JSTtauy1 = GovRev1_ / GDP1_;

%UK
MILLgiy3 = GGI3_ / GDP3_;
MILLgcy3 = ( GCE3_ + GGI3_ ) / GDP3_ / ( 1 - alpha_pubedu_ ) - MILLgiy3;
MILLcy3 = PCE3_ / GDP3_ - MILLgcy3 * alpha_pubedu_;
MILLiy3 = GDI3_ / GDP3_;
MILLxy3 = Export3_ / GDP3_;
MILLgpcgpy3 = DNDInflation3_ - GDPInflation3_;
MILLgpigpy3 = GDIInflation3_ - GDPInflation3_;
MILLgpgcgpy3 = GCEInflation3_ - GDPInflation3_;
MILLgpxgpy3 = ExportInflation3_ - GDPInflation3_;
MILLgpmgpy3 = ImportInflation3_ - GDPInflation3_;
MILLhpop3 = hpop_;
MILLwhy3 = LabourIncome3_ / GDP3_;
MILLcfcy3 = CFC3_ / GDP3_;
MILLexpostr3 = ExPostR3_;
MILLlrni3 = Spread3_;
MILLtauy3 = GovRev3_ / GDP3_;

%Germany
JSTgy2 = ( GCE2_ + GGI2_ ) / GDP2_ / ( 1 - alpha_pubedu_ );
PWTcy2 = PCE2_ / GDP2_ - JSTgy2 * alpha_pubedu_;
JSTiy2 = GDI2_ / GDP2_;
JSTxy2 = Export2_ / GDP2_;
PWTgpcgpy2 = DNDInflation2_ - GDPInflation2_;
PWTgpigpy2 = GDIInflation2_ - GDPInflation2_;
PWTgpgcgpy2 = GCEInflation2_ - GDPInflation2_;
PWTgpxgpy2 = ExportInflation2_ - GDPInflation2_;
PWTgpmgpy2 = ImportInflation2_ - GDPInflation2_;
PWThpop2 = hpop_;
PWTwhy2 = LabourIncome2_ / GDP2_;
PWTdelta2 = deltaALL2_;
JSTexpostr2 = ExPostR2_;
DBlrni2 = Spread2_;
JSTtauy2 = GovRev2_ / GDP2_;

%France
JSTgy4 = ( GCE4_ + GGI4_ ) / GDP4_ / ( 1 - alpha_pubedu_ );
PWTcy4 = PCE4_ / GDP4_ - JSTgy4 * alpha_pubedu_;
JSTiy4 = GDI4_ / GDP4_;
JSTxy4 = Export4_ / GDP4_;
PWTgpcgpy4 = DNDInflation4_ - GDPInflation4_;
PWTgpigpy4 = GDIInflation4_ - GDPInflation4_;
PWTgpgcgpy4 = GCEInflation4_ - GDPInflation4_;
PWTgpxgpy4 = ExportInflation4_ - GDPInflation4_;
PWTgpmgpy4 = ImportInflation4_ - GDPInflation4_;
PWThpop4 = hpop_;
PWTwhy4 = LabourIncome4_ / GDP4_;
PWTdelta4 = deltaALL4_;
JSTexpostr4 = ExPostR4_;
BDFlrni4 = Spread4_;
JSTtauy4 = GovRev4_ / GDP4_;

%%EURO
%JSTgy5 = ( GCE5_ + GGI5_ ) / GDP5_ / ( 1 - alpha_pubedu_ );
%PWTcy5 = PCE5_ / GDP5_ - JSTgy5 * alpha_pubedu_;
%JSTiy5 = GDI5_ / GDP5_;
%JSTxy5 = Export5_ / GDP5_;
%PWTgpcgpy5 = DNDInflation5_ - GDPInflation5_;
%PWTgpigpy5 = GDIInflation5_ - GDPInflation5_;
%PWTgpgcgpy5 = GCEInflation5_ - GDPInflation5_;
%PWTgpxgpy5 = ExportInflation5_ - GDPInflation5_;
%PWTgpmgpy5 = ImportInflation5_ - GDPInflation5_;
%PWThpop5 = hpop_;
%PWTwhy5 = LabourIncome5_ / GDP5_;
%PWTcfcy5 = CFC5_ / GDP5_;
%JSTexpostr5 = ExPostR5_;
%JSTtauy5 = GovRev5_ / GDP5_;

%%ROW
%JSTgy6 = ( GCE6_ + GGI6_ ) / GDP6_ / ( 1 - alpha_pubedu_ );
%PWTcy6 = PCE6_ / GDP6_ - JSTgy6 * alpha_pubedu_;
%JSTiy6 = GDI6_ / GDP6_;
%JSTxy6 = Export6_ / GDP6_;
%PWTgpcgpy6 = DNDInflation6_ - GDPInflation6_;
%PWTgpigpy6 = GDIInflation6_ - GDPInflation6_;
%PWTgpgcgpy6 = GCEInflation6_ - GDPInflation6_;
%PWTgpxgpy6 = ExportInflation6_ - GDPInflation6_;
%PWTgpmgpy6 = ImportInflation6_ - GDPInflation6_;
%PWThpop6 = hpop_;
%PWTwhy6 = LabourIncome6_ / GDP6_;
%PWTcfcy6 = CFC6_ / GDP6_;
%JSTexpostr6 = ExPostR6_;
%JSTtauy6 = GovRev6_ / GDP6_;

log_gII=log(gII_);
log_gB=log(gB_);
log_gYS=log(gYS_);
log_gPS=log(gPS_);
log_gYWC=log(gYWC_);
log_gX=log(gX_);
log_gKP=log(gKP_);
log_gHP=log(gHP_);
log_gPKP=log(gPKP_);
log_gPHP=log(gPHP_);
log_gKG=log(gKG_);
log_gHG=log(gHG_);
log_gPHL=log(gPHL_);
log_gPKL=log(gPKL_);
log_gKBar=log(gKBar_);
log_gPHLX=log(gPHLX_);
log_gYHLBar=log(gYHLBar_);
log_gYHLXBar=log(gYHLXBar_);
log_gCND=log(gCND_);
log_gD=log(gD_);
log_gCDBar=log(gCDBar_);
log_gCPBar=log(gCPBar_);
log_gCBar=log(gCBar_);
log_gV=log(gV_);
log_glambda_C=log(glambda_C_);
log_glambda_B=log(glambda_B_);
log_glambda_CPBar=log(glambda_CPBar_);
log_glambda_CP=log(glambda_CP_);
log_glambda_CDBar=log(glambda_CDBar_);
log_glambda_CD=log(glambda_CD_);
log_glambda_GD=log(glambda_GD_);
log_glambda_GK=log(glambda_GK_);
log_glambda_GH=log(glambda_GH_);
log_gPD=log(gPD_);
log_gPND=log(gPND_);
log_gCG=log(gCG_);

@#include "InsertNewSteadyStateEquations.mod"

@#if ExtraVariable == 1
    @#include "ExtraVariable_part3.mod"
@#endif
