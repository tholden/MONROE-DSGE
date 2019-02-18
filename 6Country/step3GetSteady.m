function [ JP_, WD1_, WW1_, WT1_ ,WNT1_, WSW1_ ,WST1_, WSNT1_, SOC, LW1l_, LT1l_, LNT1l_, LSW1l_, LST1l_, LSNT1l_, LNDCG1l_, Lh1l_, CD1l_, CND1l_, LNDCG1b_, Lh1b_, CD1b_, CND1b_, LKP1_, LHP1_, LND1_, LCG1_, LKG1_, LHG1_, KPT1_, KPNT1_, KPW1_, IKP1_, IHP1_, P1_, YWC1_, X1_ ] ...
    = step3GetSteady(lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaK_,deltaH_,betabarb,pT0,yTC0,m_,varpi_,eT0_, varargin )

    assert( gamma > zetaR, 'zetaR is too high.' );

    tic;

    SolutionCacheMaxSize = 1000;

    global SolutionCacheIn SolutionCacheOut

    Input = [lambda,eta,phiR,zetaR,gamma,scriptp,scriptq,alphaCP,alphaCD,alphah,alphaKP,alphaD,alphaND,alphaHP,alphaHW,alphaHL,alphaK,alphaKL,alphaHLX,alphaY,betabarl,sigma,xi,bbeta,h,varrhoC,eC,varrhoCP,eCP,varrhoCD,nuW,nuT,nuNT,nuSW,nuST,nuSNT,nuD,nuNDCG,nuK,nuH,nuh,rhoQB,thetaKU0,thetaKU1,thetaDU0,thetaDU1,alphaNC,eT,eW,FWCtilde,FKtilde,o,eKLT,eKLNT,eKLW,varrhoKL,eHLXT,eHLXNT,eHLXW,varrhoHLX,eYT,eYNT,eYW,varrhoY,tauKG_,tauHG_,tauCG_,taub_,tauD_,tauND_,tauNT_,tauTC_,iotaTX_,iotaTM_,iotaWX_,iotaWM_,tauLa_,tauLb_,tauHW_,tauHT_,tauHNT_,tauKW_,tauKT_,tauKNT_,tauscriptXW_,tauscriptXT_,tauscriptXNT_,phiiotaTX,phiiotaTM,phiiotaWX,phiiotaWM,Omegah_,OmegaCP_,OmegaC_,OmegaKP_,OmegaHP_,OmegaD_,OmegaND_,OmegaKG_,OmegaHG_,OmegaCG_,OmegaY_,OmegaTC_,OmegaWP_,OmegaWC_,OmegaKT_,OmegaHLT_,OmegaKLT_,OmegaHLXT_,OmegaT_,OmegaKNT_,OmegaHLNT_,OmegaKLNT_,OmegaHLXNT_,OmegaNT_,OmegaKW_,OmegaHLW_,OmegaKLW_,OmegaHLXW_,OmegaW_,GN_,Z_,deltaItilde_,scriptFI_,deltaD_,kappa0_,kappah_,kappaT_,kappaNT_,kappaW_,kappaST_,kappaSNT_,kappaSW_,kappaD_,kappaNDCG_,kappaK_,kappaH_,deltaK_,deltaH_,betabarb,pT0,yTC0,m_,varpi_,eT0_].';
    
    CountryInputCell = varargin;
    InputCell = num2cell( Input );

    InputInit    = [0.859352408960322;0.0871581549370331;0.00113386330775221;0.00629173442609000;10.4449075336857;0.0302015784397909;0.0536714948398978;0.875583609300847;0.648507151570704;0.605547281151002;0.315397908486944;0.603659324543817;0.561119934882717;0.463101879409952;0.0798987045108020;0.132094776758732;0.758903882365450;0.134192012725834;0.228658752520669;0.439166942814581;0.963552658534313;1.90971046768614;0.196146740709237;0.00462638010660170;0.689704071735731;0.621763731995246;0.898385546200193;0.617888197337720;1.06094893572815;0.914842552074419;0.672364983133287;0.562278700971853;0.527301283749368;0.682209456814929;0.570511339512411;0.535021798262148;0.673550540141199;0.703835725468211;0.710159257332391;0.716943609153712;0.916821058692266;0.379275445604004;0.427027440258652;0.685121865442422;0.175220701728947;1.40397234306095;0.935103884190823;0.840627170130991;1.53493185788333;0.00121565526994694;0.0134509710649734;45.4253555748327;0.656570932454807;0.585348052354750;0.604283352611818;0.358219237199221;0.213116851581102;0.211548003167083;0.229366587501162;0.921451080728433;1.01803725686648;0.954289353361026;0.969823239910287;0.774475610061036;0.0312410259102038;0.0319997858549835;0.0282027131858642;0.111235415961681;-0.0156645409122364;0.158338256181703;-0.110046049943308;0;0;0;0;0;-0.0868003096978071;0.0600686416879088;0.00139085673612255;-0.0743029943998060;-0.128428301214204;-8.39826330721253e-05;-0.0757778337690005;-0.129903140583399;0.0568277656578798;-0.0188660854780488;-0.0729913922924470;0.179341172291580;0.136544957535612;0.206618333265975;0.208274279658171;1;1;1;1;1;1;1;1;1;1;10;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1.01518264600382;1;0.0114250515997119;5.23349201713026;0.0219746789981484;0.103377604932637;0.955690212964012;1.01383163719511;1.01122604516943;0.822621354983426;0.898798901631155;1.10709855648752;1.07104138407770;1.13686381420376;1.00301070735377;0.982326815836078;1.03675546886876;0.0778904615285573;0.100089246342597;0.0717714479484016;0.0731748159853518;0.0615032779397114;0.0888450175885311;0.0829350435690710;0.101425254322363;0.892306906123970;1.13596478737676;0.643223061176575;0.136862129096986;0.106722868257944;1.43282553648725];
    SolutionInit = [-0.920205834074430;-1.34904547435603;-0.722073468882164;-2.59538373719453;-3.15656264681348;-2.46556935341596;-0.871135117113186;0.224813134237819;0.285435219494098;0.159263692712563;-4.06665918072642;-3.10783682765382;-3.04826944309213;-3.17452768214177;-4.48094065928365;-5.57644264968726;-0.834663742558242;-6.44377168661631;-5.41482559483946;-4.69280930247328;-4.12871310409441;-2.47674831806632;-3.79533139386381;-3.50545967416695;-5.05625342306899;-2.90351377225560;-1.60915906421869;-1.80141007840045];

    global WorkerNumber

    SolutionCacheFileName = 'SolutionCache.mat';

    if exist( SolutionCacheFileName, 'file' ) == 2
        try
            semaphore( 'wait', 131313 );
            MatFile = matfile( SolutionCacheFileName, 'Writable', false );
            SolutionCacheIn  = MatFile.SolutionCacheIn;
            SolutionCacheOut = MatFile.SolutionCacheOut;
            semaphore( 'post', 131313 );
        catch Error
            DisplayError( Error );
        end
    end
    
    if size( SolutionCacheIn, 2 ) > SolutionCacheMaxSize
        SolutionCacheIn( :, ( SolutionCacheMaxSize + 1 ) : end ) = [];
    elseif size( SolutionCacheIn, 2 ) < SolutionCacheMaxSize
        SolutionCacheIn( 1 : length( InputInit ), ( end + 1 ) : SolutionCacheMaxSize ) = NaN;
    end
    if size( SolutionCacheOut, 2 ) > SolutionCacheMaxSize
        SolutionCacheOut( :, ( SolutionCacheMaxSize + 1 ) : end ) = [];
    elseif size( SolutionCacheOut, 2 ) < SolutionCacheMaxSize
        SolutionCacheOut( 1 : length( SolutionInit ), ( end + 1 ) : SolutionCacheMaxSize ) = NaN;
    end
    
    fvalsTmp = Inf( SolutionCacheMaxSize, 1 );
    try
        Select = find( all( isfinite( SolutionCacheIn ) ) & all( isfinite( SolutionCacheOut ) ) );
        [ ~, SubSelect ] = sort( sum( ( Input - SolutionCacheIn( :, Select ) ) .^ 2 ) );
        Select = Select( SubSelect( 1 : ceil( 0.1 * length( Select ) ) ) );
        for Idx = Select
            fvalsTmp( Idx ) = norm( step3GetSteadyResids_log_mex( SolutionCacheOut( :, Idx ), InputCell{:}, CountryInputCell{:} ) );
        end
    catch Error
        DisplayError( Error );
    end
    
    [ MinFval, MinIdx ] = min( fvalsTmp );
    if isfinite( MinFval )
        InputGuess    = SolutionCacheIn( :, MinIdx );
        SolutionGuess = SolutionCacheOut( :, MinIdx );
    else
        InputGuess    = InputInit;
        SolutionGuess = SolutionInit;
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
        Display = 'off';%'iter-detailed';
    else
        Display = 'off';
    end

    global Solution
    
    Solution = fsolveInternal( InputGuess, SolutionGuess, 100, Display, TypicalX, Input, CountryInputCell );

    SolutionCacheWriteIndex = randi( size( SolutionCacheIn, 2 ) );
    SolutionCacheIn( :, SolutionCacheWriteIndex ) = Input;
    SolutionCacheOut( :, SolutionCacheWriteIndex ) = Solution;

    if isempty( WorkerNumber )
        SolutionCacheIn_ = SolutionCacheIn;
        SolutionCacheOut_ = SolutionCacheOut;
        spmd
            SetSteadyStateGlobals( SolutionCacheIn_, SolutionCacheOut_ );
        end

        save( SolutionCacheFileName, 'SolutionCacheIn', 'SolutionCacheOut', '-v7.3' );
    else
        semaphore( 'wait', 131313 );
        MatFile = matfile( SolutionCacheFileName, 'Writable', true );
        PauseLength = 1;
        while any( MatFile.SolutionCacheIn( :, SolutionCacheWriteIndex ) ~= Input )
            MatFile.SolutionCacheIn( :, SolutionCacheWriteIndex ) = Input;
            pause( rand * PauseLength / 1000 );
            PauseLength = 2 * PauseLength;
        end
        PauseLength = 1;
        while any( MatFile.SolutionCacheOut( :, SolutionCacheWriteIndex ) ~= Solution )
            MatFile.SolutionCacheOut( :, SolutionCacheWriteIndex ) = Solution;
            pause( rand * PauseLength / 1000 );
            PauseLength = 2 * PauseLength;
        end
        semaphore( 'post', 131313 );
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
    
    [ MaxJPResids, JP_, WD1_, WW1_, WT1_ ,WNT1_ ,WSW1_ ,WST1_ ,WSNT1_, SOC] = GetSteadyDetails( Solution, lambda, eta, phiR, zetaR, gamma, scriptp, scriptq, alphaCP, alphaCD, alphah, alphaKP, alphaD, alphaND, alphaHP, alphaHW, alphaHL, alphaK, alphaKL, alphaHLX, alphaY, betabarl, sigma, xi, bbeta, varrhoC, eC, varrhoCP, eCP, varrhoCD, nuW, nuT, nuNT, nuSW, nuST, nuSNT, nuD, nuNDCG, rhoQB, thetaDU0, thetaDU1, tauCG_, tauD_, tauLa_, tauLb_, Omegah_, OmegaCP_, OmegaC_, OmegaD_, OmegaND_, OmegaCG_, OmegaY_, GN_, Z_, deltaItilde_, scriptFI_, deltaD_, kappaT_, kappaNT_, kappaW_, kappaST_, kappaSNT_, kappaSW_, kappaD_, kappaNDCG_, betabarb, m_, varpi_, varargin{1} );

    if MaxJPResids <= 0
        error( 'The sensible solution to the steady-state of the widget sector does not exist.' );
    end
        
    if JP_ <= 1 - eta
        error( 'JP is too low in steady state.' );
    end

    if real( SOC ) <= 0
        error( 'SOC is not satisfied in steady state.' );
    end
    
    if abs( imag( SOC ) ) > 1e-6
        error( 'SOC is complex in steady state.' );
    end
    
    muP_ = lambda * eta * JP_ / ( JP_ - ( 1 - eta ) );
    
    if muP_ <= 1 / gamma
        error( 'muP is too low in steady state.' );
    end
    
    omegaP_ = JP_ * ( 1 - eta ) / ( JP_ - ( 1 - eta ) ) ^ 2 / ( 1 + muP_ );

    if 1 - eta * lambda * omegaP_ <= 0
        error( 'omegaP is too high in steady state.' );
    end

    global custom_penalty
    
    custom_penalty = max( 0, -log( real( SOC ) + abs( imag( SOC ) ) ) ) + max( 0, -log( MaxJPResids ) ) .^ 2 + max( 0, - log( JP_ - ( 1 - eta ) ) ) + max( 0, -log( muP_ - 1 / gamma ) ) + max( 0, -log( 1 - eta * lambda * omegaP_ ) );
    
    % disp( [ lambda, -log( real( SOC ) + abs( imag( SOC ) ) ), max( 0, -log( MaxJPResids ) ) .^ 2 ] );
    
    global AdditionalSolution
    AdditionalSolution = [ WD1_, WW1_, WT1_, WNT1_, WSW1_, WST1_ , WSNT1_ ];
    
    if toc > 2
        toc;
    end

end

function Solution = fsolveInternal( InputGuess, SolutionGuess, MaxIterations, Display, TypicalX, Input, CountryInputCell, Depth )

    if nargin < 8
        Depth = 0;
    end
    
    if Depth > 10
        error( 'Failed to find a steady-state.' );
    end

    InputCell = num2cell( Input );
    
    tmp = step3GetSteadyResids_log_mex( SolutionGuess, InputCell{:}, CountryInputCell{:} );
    
    if all( tmp( ( 28 + 1 ) : end ) == 0 )
        Minimand = @( InVec ) real_step3GetSteadyResids_mex( InVec, InputCell{:}, CountryInputCell{:} );
        Options = optimoptions( @fsolve, 'Algorithm', 'trust-region-dogleg', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
    else
        Minimand = @( InVec ) step3GetSteadyResids_mex( InVec, InputCell{:}, CountryInputCell{:} );
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
    
    tmp = step3GetSteadyResids_log_mex( SolutionGuess, InputCell{:}, CountryInputCell{:} );
    
    if all( tmp( ( 28 + 1 ) : end ) == 0 )
        Minimand = @( InVec ) real_step3GetSteadyResids_log_mex( InVec, InputCell{:}, CountryInputCell{:} );
        Options = optimoptions( @fsolve, 'Algorithm', 'trust-region-dogleg', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
    else
        Minimand = @( InVec ) step3GetSteadyResids_log_mex( InVec, InputCell{:}, CountryInputCell{:} );
        % Options = optimoptions( @fsolve, 'Algorithm', 'levenberg-marquardt', 'ScaleProblem', 'jacobian', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
        Options = optimoptions( @fsolve, 'Algorithm', 'trust-region', 'Display', Display, 'OptimalityTolerance',1e-12,'FunctionTolerance',1e-12,'StepTolerance',1e-12,'MaxIterations',MaxIterations,'MaxFunctionEvaluations',Inf,'TypicalX',TypicalX,'FiniteDifferenceType','central' );
    end
    
    try
        [ Solution, fval, exitflag ] = fsolve( Minimand, SolutionGuess, Options );
        fval = norm( fval );
        if fval < 1e-6
            exitflag = 50;
        end
    catch Error
        DisplayError( Error );
        exitflag = -1000;
        Solution = SolutionGuess;
    end
    
    if exitflag <= 0
        InputGuess2    = 0.5 * Input + 0.5 * InputGuess;
        SolutionGuess2 = fsolveInternal( InputGuess, SolutionGuess, MaxIterations, Display, TypicalX, InputGuess2, CountryInputCell, Depth + 1 );
        Solution       = fsolveInternal( InputGuess2, SolutionGuess2, MaxIterations, Display, TypicalX, Input, CountryInputCell, Depth + 1 );
    end
    
end

function out = real_step3GetSteadyResids_log_mex( InVec, varargin )
    out = step3GetSteadyResids_log_mex( InVec, varargin{:} );
    if all( out( ( 28 + 1 ) : end ) == 0 )
        out = out( 1 : 28 );
    else
        out = NaN( 28, 1 );
    end
end

function out = real_step3GetSteadyResids_mex( InVec, varargin )
    out = step3GetSteadyResids_mex( InVec, varargin{:} );
    if all( out( ( 28 + 1 ) : end ) == 0 )
        out = out( 1 : 28 );
    else
        out = NaN( 28, 1 );
    end
end
