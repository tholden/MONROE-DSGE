function [ JP_, WD1_, WW1_, WT1_ ,WNT1_, WSW1_ ,WST1_, WSNT1_, SOC, LW1l_, LT1l_, LNT1l_, LSW1l_, LST1l_, LSNT1l_, LNDCG1l_, Lh1l_, CD1l_, CND1l_, LNDCG1b_, Lh1b_, CD1b_, CND1b_, LKP1_, LHP1_, LND1_, LCG1_, LKG1_, LHG1_, KPT1_, KPNT1_, KPW1_, IKP1_, IHP1_, P1_, YWC1_, X1_ ] ...
    = step3GetSteadyBackup(lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ )

%This is Tom's old parallel computation, which works for me

    SolutionCacheMaxSize = 1000;

    global SolutionCacheIn SolutionCacheOut SolutionCacheLastWritten

    Input = [lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_].';

    SolutionInit = [-0.915430056369696;-2.22915785534769;-0.810661842401985;-2.28358238726045;-3.74193739094909;-2.24065052491404;-0.388531546840020;0.418676844537437;1.24504258832877;0.512208858701443;-3.01693400751875;-2.83598130020550;-2.31075353303518;-3.26910713704998;-2.52574738256730;-3.80821057247077;-0.335040059502388;-4.44872450316207;-2.94358585907475;-2.62160148767232;-4.38137242256300;-1.45384997101805;-2.45156424461058;-2.37510184368123;-3.75581460961329;-2.77162497611606;-1.36669513446848;-1.45059183981780];
    
    SolutionGuess = SolutionInit;

    global WorkerNumber

    SolutionCacheFileName = [ 'SolutionCache' num2str( WorkerNumber ) '.mat' ];

    if exist( SolutionCacheFileName, 'file' ) == 2
        load( SolutionCacheFileName, 'SolutionCacheIn', 'SolutionCacheOut', 'SolutionCacheLastWritten' );
    end
    
    if ~isempty( SolutionCacheOut )
        SolutionGuess = SolutionCacheOut( :, SolutionCacheLastWritten );
    end

    % if ~isempty( SolutionCacheOut )
    %     TypicalX = abs( SolutionGuess );
    %     Select = TypicalX < 1;
    %     TypicalX( Select ) = max( TypicalX( Select ), max( 1e-4, max( abs( SolutionCacheOut( Select, : ) ), [], 2 ) ) );
    %     Select = TypicalX > 1;
    %     TypicalX( Select ) = min( TypicalX( Select ), min( 1e4, min( abs( SolutionCacheOut( Select, : ) ), [], 2 ) ) );
    % else
    %     TypicalX = ones( size( SolutionGuess ) );
    % end
    TypicalX = ones( size( SolutionGuess ) );

    if isempty( WorkerNumber )
        Display = 'iter-detailed';
    else
        Display = 'off';
    end

    global Solution
    
    [ Solution1, fval1, exitflag ] = fsolveInternal( SolutionGuess, 100, Display, TypicalX,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );

    if exitflag > 0
        Solution = Solution1;
    else
        if ~isempty( SolutionCacheOut )
            fvalsTmp = Inf( size( SolutionCacheOut, 2 ), 1 );
            try
                for Idx = 1 : size( SolutionCacheOut, 2 )
                    fvalsTmp( Idx ) = norm( step3GetSteadyResids_log_mex( SolutionCacheOut( :, Idx ),lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ ) );
                end
            catch Error
                DisplayError( Error );
            end
            [ ~, MinIdx ] = min( fvalsTmp );
            SolutionGuess = SolutionCacheOut( :, MinIdx );
        else
            SolutionGuess = SolutionInit;
        end
        
        [ Solution2, fval2, exitflag ] = fsolveInternal( SolutionGuess, 100, Display, TypicalX,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );

        if exitflag > 0
            Solution = Solution2;
        else
            SolutionGuess = SolutionInit;

            [ Solution3, fval3, exitflag ] = fsolveInternal( SolutionGuess, 100, Display, TypicalX,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );

            if exitflag > 0
                Solution = Solution3;
            else
                SolutionGuess = [-5.67310915033666;-6.62525430399550;-5.31439849514665;-6.39580620841364;-7.46152265081160;-6.00271793417242;-4.95991200511485;-4.63967737894556;-1.42620653764562;-0.435138908450370;-9.04199325304064;-9.31560206456343;-6.44692424160182;-5.86920607988260;-6.33614944631402;-10.1034294171494;-4.99555918765325;-7.91851000699766;-6.02398214464575;-6.50854349632889;-7.07725122354714;-4.31663541126656;-5.30083434020114;-5.72945364968172;-5.32177338129882;-4.84098819271934;-3.41321523055269;-3.53875343763139];
                
                [ Solution4, fval4, exitflag ] = fsolveInternal( SolutionGuess, 100, Display, TypicalX,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );

                if exitflag > 0
                    Solution = Solution4;
                else
                    fvals = [ fval1, fval2, fval3, fval4 ];
                    [ ~, min_fval_index ] = min( fvals );
                    if min_fval_index == 1
                        SolutionGuess = Solution1;
                    elseif min_fval_index == 2
                        SolutionGuess = Solution2;
                    elseif min_fval_index == 3
                        SolutionGuess = Solution3;
                    else
                        SolutionGuess = Solution4;
                    end
                    [ Solution, ~, exitflag ] = fsolveInternal( SolutionGuess, 500, Display, TypicalX,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );
                end

            end

        end

    end

    if exitflag > 0
        if size( SolutionCacheIn, 2 ) < SolutionCacheMaxSize
            SolutionCacheLastWritten = size( SolutionCacheIn, 2 ) + 1;
        else
            SolutionCacheLastWritten = SolutionCacheLastWritten + 1;
            if SolutionCacheLastWritten > SolutionCacheMaxSize
                SolutionCacheLastWritten = 1;
            end
        end
        SolutionCacheIn( :, SolutionCacheLastWritten ) = Input;
        SolutionCacheOut( :, SolutionCacheLastWritten ) = Solution;

        if isempty( WorkerNumber )
            SolutionCacheIn_ = SolutionCacheIn;
            SolutionCacheOut_ = SolutionCacheOut;
            SolutionCacheLastWritten_ = SolutionCacheLastWritten;
            spmd
                SetSteadyStateGlobals( SolutionCacheIn_, SolutionCacheOut_, SolutionCacheLastWritten_ );
            end
        end

        save( SolutionCacheFileName, 'SolutionCacheIn', 'SolutionCacheOut', 'SolutionCacheLastWritten' );
    else
        disp( 'Failed to solve, with exitflag:' );
        disp( exitflag );
    end

    if nargout > 1
        LW1l_ = exp( Solution( 1+(1-1)*28 ) );
        LT1l_ = exp( Solution( 2+(1-1)*28 ) );
        LNT1l_ = exp( Solution( 3+(1-1)*28 ) );
        LSW1l_ = exp( Solution( 4+(1-1)*28 ) );
        LST1l_ = exp( Solution( 5+(1-1)*28 ) );
        LSNT1l_ = exp( Solution( 6+(1-1)*28 ) );
        LNDCG1l_ = exp( Solution( 7+(1-1)*28 ) );
        Lh1l_ = exp( Solution( 8+(1-1)*28 ) );
        CD1l_ = exp( Solution( 9+(1-1)*28 ) );
        CND1l_ = exp( Solution( 10+(1-1)*28 ) );
        LNDCG1b_ = exp( Solution( 11+(1-1)*28 ) );
        Lh1b_ = exp( Solution( 12+(1-1)*28 ) );
        CD1b_ = exp( Solution( 13+(1-1)*28 ) );
        CND1b_ = exp( Solution( 14+(1-1)*28 ) );
        LKP1_ = exp( Solution( 15+(1-1)*28 ) );
        LHP1_ = exp( Solution( 16+(1-1)*28 ) );
        LND1_ = exp( Solution( 17+(1-1)*28 ) );
        LCG1_ = exp( Solution( 18+(1-1)*28 ) );
        LKG1_ = exp( Solution( 19+(1-1)*28 ) );
        LHG1_ = exp( Solution( 20+(1-1)*28 ) );
        KPT1_ = exp( Solution( 21+(1-1)*28 ) );
        KPNT1_ = exp( Solution( 22+(1-1)*28 ) );
        KPW1_ = exp( Solution( 23+(1-1)*28 ) );
        IKP1_ = exp( Solution( 24+(1-1)*28 ) );
        IHP1_ = exp( Solution( 25+(1-1)*28 ) );
        P1_ = exp( Solution( 26+(1-1)*28 ) );
        YWC1_ = exp( Solution( 27+(1-1)*28 ) );
        X1_ = exp( Solution( 28+(1-1)*28 ) );
    end
    
    [~, JP_, WD1_, WW1_, WT1_ ,WNT1_, WSW1_ ,WST1_, WSNT1_, SOC ] = ...
    step3GetSteadyResids_log_mex( Solution,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );

    if SOC <= 0
        error( 'SOC not satisfied at steady state.' );
    end
    
    global AdditionalSolution
    AdditionalSolution = [ WD1_, WW1_, WT1_, WNT1_, WSW1_, WST1_ , WSNT1_ ];

end

function [ Solution, fval, exitflag ] = fsolveInternal( SolutionGuess, MaxIterations, Display, TypicalX,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ )

    tmp = step3GetSteadyResids_log_mex( SolutionGuess,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );
    
    if all( tmp( ( 28 + 1 ) : end ) == 0 )
        Minimand = @( InVec ) real_step3GetSteadyResids_mex( InVec,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );
        Options = optimoptions( @fsolve, 'Algorithm', 'trust-region-dogleg', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
    else
        Minimand = @( InVec ) step3GetSteadyResids_mex( InVec,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );
        % Options = optimoptions( @fsolve, 'Algorithm', 'levenberg-marquardt', 'ScaleProblem', 'jacobian', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
        Options = optimoptions( @fsolve, 'Algorithm', 'trust-region', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
    end
    
    try
        [ Solution, ~, ~, fsolveOutput ] = fsolve( Minimand, SolutionGuess, Options );
        MaxIterations = max( 10, MaxIterations - fsolveOutput.iterations );
        SolutionGuess = Solution;
    catch Error
        DisplayError( Error );
    end
    
    tmp = step3GetSteadyResids_log_mex( SolutionGuess,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );
    
    if all( tmp( ( 28 + 1 ) : end ) == 0 )
        Minimand = @( InVec ) real_step3GetSteadyResids_log_mex( InVec,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );
        Options = optimoptions( @fsolve, 'Algorithm', 'trust-region-dogleg', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
    else
        Minimand = @( InVec ) step3GetSteadyResids_log_mex( InVec,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );
        % Options = optimoptions( @fsolve, 'Algorithm', 'levenberg-marquardt', 'ScaleProblem', 'jacobian', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
        Options = optimoptions( @fsolve, 'Algorithm', 'trust-region', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
    end
    
    try
        [ Solution, fval, exitflag ] = fsolve( Minimand, SolutionGuess, Options );
        fval = norm( fval );
        if fval < 1e-6
            exitflag = 100;
        end
    catch Error
        DisplayError( Error );
        fval = Inf;
        exitflag = -1000;
        Solution = SolutionGuess;
    end
    
end

function out = real_step3GetSteadyResids_log_mex( InVec,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ )
    out = step3GetSteadyResids_log_mex( InVec,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );
    if all( out( ( 28 + 1 ) : end ) == 0 )
        out = out( 1 : 28 );
    else
        out = NaN( 28, 1 );
    end
end

function out = real_step3GetSteadyResids_mex( InVec,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ )
    out = step3GetSteadyResids_mex( InVec,lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaKPT_,deltaHPT_,deltaKPNT_,deltaHPNT_,deltaKPW_,deltaHPW_,deltaKG_,deltaHG_,betabarb,pT0,yTC0,m_,varpi_,eT0_,Ntilde1_,Ntilde2_, Ntilde3_, Ntilde4_, Ntilde5_, Ntilde6_ );
    if all( out( ( 28 + 1 ) : end ) == 0 )
        out = out( 1 : 28 );
    else
        out = NaN( 28, 1 );
    end
end
