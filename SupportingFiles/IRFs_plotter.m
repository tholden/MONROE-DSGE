%gdp                private consumption    private toatal investment      government spending, 
%As					hours worked           human capital investment       Gov deficit/GDP
%engineering usage	trade balance/GDP	   private RD/GDP                 Gov RD/GDP

%Home means the country hit by shocks (Germany)
%Foreign means the country not hit by shocks (US and the rest)
ShockList=["epsilon_P0" "epsilon_Y0" "epsilon_beta2" "epsilon_eT02" "epsilon_GN" "epsilon_Ntilde2" "epsilon_varpi2" "epsilon_Z" "epsilon_deltaItilde" "epsilon_scriptFI" "epsilon_deltaD2" "epsilon_kappa02" "epsilon_kappah2" "epsilon_kappaT2" "epsilon_kappaNT2" "epsilon_kappaW2" "epsilon_kappaST2" "epsilon_kappaSNT2" "epsilon_kappaSW2" "epsilon_kappaD2" "epsilon_kappaNDCG2" "epsilon_kappaK2" "epsilon_kappaH2" "epsilon_deltaKPT2" "epsilon_deltaHPT2" "epsilon_deltaKPNT2" "epsilon_deltaHPNT2" "epsilon_deltaKPW2" "epsilon_deltaHPW2" "epsilon_m2" "epsilon_deltaKG2" "epsilon_deltaHG2" "epsilon_OmegaALL2" "epsilon_OmegaS0ALL2" "epsilon_OmegaTALL2" "epsilon_OmegaNTALL2" "epsilon_OmegaWALL2" "epsilon_OmegaKKALL2" "epsilon_OmegaHLALL2" "epsilon_OmegaKLALL2" "epsilon_OmegaHLXALL2" "epsilon_OmegaHLXKLALL2" "epsilon_OmegaS1ALL2" "epsilon_OmegaKALL2" "epsilon_OmegaHALL2" "epsilon_OmegaCALL2" "epsilon_OmegaDi2" "epsilon_OmegaPALL2" "epsilon_OmegaGALL2" "epsilon_OmegaDemandALL2" "epsilon_Omegahi2" "epsilon_OmegaCPi2" "epsilon_OmegaCi2" "epsilon_OmegaTradeALL2" "epsilon_OmegaYi2" "epsilon_OmegaTCi2" "epsilon_OmegaWPi2" "epsilon_OmegaWCi2" "epsilon_uKG2" "epsilon_uHG2" "epsilon_uCG2" "epsilon_u2b" "epsilon_u2l" "epsilon_uD2" "epsilon_uND2" "epsilon_uNT2" "epsilon_uTC2" "epsilon_uTX2" "epsilon_uTM2" "epsilon_uWX2" "epsilon_uWM2" "epsilon_uLa2" "epsilon_uLb2" "epsilon_uALL2" "epsilon_uS1ALL2" "epsilon_uiotaALL2" "epsilon_ulbALL2" "epsilon_uCALL2" "epsilon_uLALL2" "epsilon_uHALL2" "epsilon_uKALL2" "epsilon_uXALL2" "epsilon_uTALL2" "epsilon_uNTALL2" "epsilon_uWALL2"]';
ShockNames=["ROW price" "ROW demand" "Home discount factor" "Home's trade elasticity with ROW" "Global population" "Home population" "Home impatient household shares" "Engineering research idea" "Engineering Patient depreciation" "Engineering invention" "Home durable depreciation" "Home disutility" "Home labour supply in home production" "Home low skilled labour supply in tradeable goods sector" "Home low skilled labour supply in nontradeable goods sector" "Home low skilled labour supply in widget sector" "Home high skilled labour supply in tradeable goods sector" "Home high skilled labour supply in nontradeable goods sector" "Home high skilled labour supply in widget sector" "Home labour supply in durable good sector" "Home labour supply in nondurable good sector" "Home labour supply in capital good sector" "Home labour supply in human capital good sector" "Home capital depreciation in tradeable goods sector" "Home human capital depreciation in tradeable goods sector" "Home capital depreciation in nontradeable goods sector" "Home human capital depreciation in nontradeable goods sector" "Home capital depreciation in widget sector" "Home human capital depreciation in widget sector" "Home loan-to-value ratio" "Home government capital depreciation" "Home government human capital depreciation" "Home OmegaALL2" "Home OmegaS0ALL2" "Home OmegaTALL2" "Home OmegaNTALL2" "Home OmegaWALL2" "Home OmegaKKALL2" "Home OmegaHLALL2" "Home OmegaKLALL2" "Home OmegaHLXALL2" "Home OmegaHLXKLALL2" "Home OmegaS1ALL2" "Home OmegaKALL2" "Home OmegaHALL2" "Home OmegaCALL2" "Home OmegaDi2" "Home OmegaPALL2" "Home OmegaGALL2" "Home OmegaDemandALL2" "Home Omegahi2" "Home OmegaCPi2" "Home OmegaCi2" "Home OmegaTradeALL2" "Home OmegaYi2" "Home OmegaTCi2" "Home OmegaWPi2" "Home OmegaWCi2" "Home government physical capital investment" "Home government R&D capital investment" "Home government consumption" "Home lump sum tax on impatient households" "Home lump sum tax on patient households" "Home tax on durable goods" "Home tax on nondurable goods" "Home tax on non tradeable goods" "Home tax on tradeable composites" "Home tax on tradeable export" "Home tax on tradeable import" "Home tax on widget export" "Home tax on widget import" "Home basic labour tax" "Home labour tax incremental rate" "Home general fiscal stance" "Home government spending" "Home tariff" "Home lump sum tax" "Home consumption tax" "Home labour tax" "Home tax on human capital" "Home tax physical capital" "Home tax on engineering" "Home tax on tradeable sector" "Home tax on non tradeable sector" "Home tax on widget sector"]';
NShock=length(ShockList);
param_names=cellstr(M_.param_names);
T=40;
mkdir 1PercentShock
cd 1PercentShock
for ii=1:NShock
    Shockii = ShockList{ii}(9:end);
    if length( Shockii ) > 1
        Shockii = regexprep( Shockii, '[1-9](?!.*\d.*)', '' );
    end
    
    if ( length( Shockii ) > 5 ) && strcmp( Shockii( 1:5 ), 'delta' ) && ismember( Shockii(6), {'D','K','H'} )
        Shockii = Shockii( 1 : 6 );
    end
    
    sigma = M_.params( ismember( param_names, [ 'sigma', Shockii ] ) );
    
    if ( Shockii( 1 ) == 'u' ) && ( length( Shockii ) > 4 ) && strcmp( Shockii( ( end - 2 ) : end ), 'ALL' )
        Variant = Shockii( 2 : ( end - 3 ) );
        ExtraScale = true;
        if ismember( Variant, { 'H', 'K', 'X' } )
            sigmaScales = [ M_.params( ismember( param_names, [ 'phiutau', Variant, 'W' ] ) ), M_.params( ismember( param_names, [ 'phiutau', Variant, 'T' ] ) ), M_.params( ismember( param_names, [ 'phiutau', Variant, 'NT' ] ) ) ];
        elseif ismember( Variant, { 'W', 'T', 'NT' } )
            sigmaScales = [ M_.params( ismember( param_names, [ 'phiutauH', Variant ] ) ), M_.params( ismember( param_names, [ 'phiutauK', Variant ] ) ), M_.params( ismember( param_names, [ 'phiutauX', Variant ] ) ) ];
        else
            ExtraScale = false;
        end
        if ExtraScale
            [ sigmaScale, sigmaScaleIndex ] = max( abs( sigmaScales ) );
            sigmaScale = sigmaScale * sign( sigmaScales( sigmaScaleIndex ) );
            disp( Shockii );
            disp( sigmaScales );
            disp( sigmaScale );
            sigma = sigma * sigmaScale;
        end
    end
    
    f1n=figure(1+2*(ii-1));
    subplot(3,4,1)
    eval(['plot(oo_.irfs.rGDPpc1_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('GDP')
    subplot(3,4,2)
    eval(['plot(oo_.irfs.rPCEpc1_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Private Consumption')
    subplot(3,4,3)
    eval(['plot(oo_.irfs.rPDIpc1_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Private Investment')
    subplot(3,4,4)
    eval(['plot(oo_.irfs.rGSpendingpc1_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Government Spending')
    subplot(3,4,5)
    eval(['plot(oo_.irfs.As_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Frontier Productivity')
    ylabel('Foreign, real per capita, % deviations from SS or trend')
    subplot(3,4,6)
    eval(['plot(oo_.irfs.BEAhpop1_',ShockList{ii},'(1:T)*100/100/sigma)'])
    title('Hours Worked')
    subplot(3,4,7)
    eval(['plot(oo_.irfs.IHPpc1_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Private H Investment')
    subplot(3,4,8)
    eval(['plot(oo_.irfs.GovDifY1_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Government Deficit / GDP')
    subplot(3,4,9)
    eval(['plot(oo_.irfs.Xpc1_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Engineering')
    subplot(3,4,10)
    eval(['plot(oo_.irfs.NXY1_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Net Export / GDP')
    xlabel(['Shock: ',ShockNames{ii},', 1%'])
    subplot(3,4,11)
    eval(['plot(oo_.irfs.PRDY1_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Private R&D / GDP')
    subplot(3,4,12)
    eval(['plot(oo_.irfs.GRDY1_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Government R&D / GDP')
    f1n.Children(1).Position=[0.08*4+0.6/4*3, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f1n.Children(2).Position=[0.08*3+0.6/4*2, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f1n.Children(3).Position=[0.08*2+0.6/4*1, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f1n.Children(4).Position=[0.08*1+0.6/4*0, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f1n.Children(5).Position=[0.08*4+0.6/4*3, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f1n.Children(6).Position=[0.08*3+0.6/4*2, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f1n.Children(7).Position=[0.08*2+0.6/4*1, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f1n.Children(8).Position=[0.08*1+0.6/4*0, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f1n.Children(9).Position=[0.08*4+0.6/4*3, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f1n.Children(10).Position=[0.08*3+0.6/4*2, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f1n.Children(11).Position=[0.08*2+0.6/4*1, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f1n.Children(12).Position=[0.08*1+0.6/4*0, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    drawnow;
    f1n.Children(3).XLabel.Position(1)=T*1.125;
    f1n.Children(8).YLabel.Position(1)=f1n.Children(8).YLabel.Position(1)*1.1;
    f1n.Position=[200 200 1920 1080];
    drawnow;
    if eval(['max(abs(oo_.irfs.rGDPpc1_DivFromTrend_',ShockList{ii},'(1:40)))>=0.01'])
        savefig(['sig Foreign responses to a ',ShockNames{ii},' shock'])    
        saveas(gcf,['sig Foreign responses to a ',ShockNames{ii},' shock'],'emf')
    else
        savefig(['Foreign responses to a ',ShockNames{ii},' shock'])    
        saveas(gcf,['Foreign responses to a ',ShockNames{ii},' shock'],'emf')
    end


    f2n=figure(2+2*(ii-1));
    subplot(3,4,1)
    eval(['plot(oo_.irfs.rGDPpc2_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('GDP')
    subplot(3,4,2)
    eval(['plot(oo_.irfs.rPCEpc2_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Private Consumption')
    subplot(3,4,3)
    eval(['plot(oo_.irfs.rPDIpc2_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Private Investment')
    subplot(3,4,4)
    eval(['plot(oo_.irfs.rGSpendingpc2_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Government Spending')
    subplot(3,4,5)
    eval(['plot(oo_.irfs.As_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Frontier Productivity')
    ylabel('Home, real per capita, % deviations from SS or trend')
    subplot(3,4,6)
    eval(['plot(oo_.irfs.PWThpop2_',ShockList{ii},'(1:T)*100/100/sigma)'])
    title('Hours Worked')
    subplot(3,4,7)
    eval(['plot(oo_.irfs.IHPpc2_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Private H Investment')
    subplot(3,4,8)
    eval(['plot(oo_.irfs.GovDifY2_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Government Deficit / GDP')
    subplot(3,4,9)
    eval(['plot(oo_.irfs.Xpc2_DivFromTrend_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Engineering')
    subplot(3,4,10)
    eval(['plot(oo_.irfs.NXY2_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Net Export / GDP')
    xlabel(['Shock: ',ShockNames{ii},', 1%'])
    subplot(3,4,11)
    eval(['plot(oo_.irfs.PRDY2_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Private R&D / GDP')
    subplot(3,4,12)
    eval(['plot(oo_.irfs.GRDY2_',ShockList{ii},'(1:T)/100/sigma)'])
    title('Government R&D / GDP')
    f2n.Children(1).Position=[0.08*4+0.6/4*3, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f2n.Children(2).Position=[0.08*3+0.6/4*2, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f2n.Children(3).Position=[0.08*2+0.6/4*1, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f2n.Children(4).Position=[0.08*1+0.6/4*0, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f2n.Children(5).Position=[0.08*4+0.6/4*3, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f2n.Children(6).Position=[0.08*3+0.6/4*2, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f2n.Children(7).Position=[0.08*2+0.6/4*1, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f2n.Children(8).Position=[0.08*1+0.6/4*0, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f2n.Children(9).Position=[0.08*4+0.6/4*3, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f2n.Children(10).Position=[0.08*3+0.6/4*2, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f2n.Children(11).Position=[0.08*2+0.6/4*1, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f2n.Children(12).Position=[0.08*1+0.6/4*0, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    drawnow;
    f2n.Children(3).XLabel.Position(1)=T*1.125;
    f2n.Children(8).YLabel.Position(1)=f2n.Children(8).YLabel.Position(1)*1.1;
    f2n.Position=[200 200 1920 1080];
    drawnow;
    if eval(['max(abs(oo_.irfs.rGDPpc1_DivFromTrend_',ShockList{ii},'(1:40)))>=0.01'])
        savefig(['sig Home responses to a ',ShockNames{ii},' shock'])    
        saveas(gcf,['sig Home responses to a ',ShockNames{ii},' shock'],'emf')
    else
        savefig(['Home responses to a ',ShockNames{ii},' shock'])    
        saveas(gcf,['Home responses to a ',ShockNames{ii},' shock'],'emf')
    end
end

cd ..
mkdir 1StdDevShock
cd 1StdDevShock
for ii=1:NShock
    f1n=figure(1+2*(ii-1));
    subplot(3,4,1)
    eval(['plot(oo_.irfs.rGDPpc1_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('GDP')
    subplot(3,4,2)
    eval(['plot(oo_.irfs.rPCEpc1_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Private Consumption')
    subplot(3,4,3)
    eval(['plot(oo_.irfs.rPDIpc1_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Private Investment')
    subplot(3,4,4)
    eval(['plot(oo_.irfs.rGSpendingpc1_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Government Spending')
    subplot(3,4,5)
    eval(['plot(oo_.irfs.As_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Frontier Productivity')
    ylabel('Foreign, real per capita, % deviations from SS or trend')
    subplot(3,4,6)
    eval(['plot(oo_.irfs.BEAhpop1_',ShockList{ii},'(1:T)*100)'])
    title('Hours Worked')
    subplot(3,4,7)
    eval(['plot(oo_.irfs.IHPpc1_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Private H Investment')
    subplot(3,4,8)
    eval(['plot(oo_.irfs.GovDifY1_',ShockList{ii},'(1:T))'])
    title('Government Deficit / GDP')
    subplot(3,4,9)
    eval(['plot(oo_.irfs.Xpc1_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Engineering')
    subplot(3,4,10)
    eval(['plot(oo_.irfs.NXY1_',ShockList{ii},'(1:T))'])
    title('Net Export / GDP')
    xlabel(['Shock: ',ShockNames{ii},', 1 StD'])
    subplot(3,4,11)
    eval(['plot(oo_.irfs.PRDY1_',ShockList{ii},'(1:T))'])
    title('Private R&D / GDP')
    subplot(3,4,12)
    eval(['plot(oo_.irfs.GRDY1_',ShockList{ii},'(1:T))'])
    title('Government R&D / GDP')
    f1n.Children(1).Position=[0.08*4+0.6/4*3, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f1n.Children(2).Position=[0.08*3+0.6/4*2, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f1n.Children(3).Position=[0.08*2+0.6/4*1, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f1n.Children(4).Position=[0.08*1+0.6/4*0, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f1n.Children(5).Position=[0.08*4+0.6/4*3, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f1n.Children(6).Position=[0.08*3+0.6/4*2, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f1n.Children(7).Position=[0.08*2+0.6/4*1, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f1n.Children(8).Position=[0.08*1+0.6/4*0, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f1n.Children(9).Position=[0.08*4+0.6/4*3, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f1n.Children(10).Position=[0.08*3+0.6/4*2, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f1n.Children(11).Position=[0.08*2+0.6/4*1, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f1n.Children(12).Position=[0.08*1+0.6/4*0, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    drawnow;
    f1n.Children(3).XLabel.Position(1)=T*1.125;
    f1n.Children(8).YLabel.Position(1)=f1n.Children(8).YLabel.Position(1)*1.1;
    f1n.Position=[200 200 1920 1080];
    drawnow;
    if eval(['max(abs(oo_.irfs.rGDPpc1_DivFromTrend_',ShockList{ii},'(1:40)))>=0.01'])
        savefig(['sig Foreign responses to a ',ShockNames{ii},' shock'])    
        saveas(gcf,['sig Foreign responses to a ',ShockNames{ii},' shock'],'emf')
    else
        savefig(['Foreign responses to a ',ShockNames{ii},' shock'])    
        saveas(gcf,['Foreign responses to a ',ShockNames{ii},' shock'],'emf')
    end


    f2n=figure(2+2*(ii-1));
    subplot(3,4,1)
    eval(['plot(oo_.irfs.rGDPpc2_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('GDP')
    subplot(3,4,2)
    eval(['plot(oo_.irfs.rPCEpc2_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Private Consumption')
    subplot(3,4,3)
    eval(['plot(oo_.irfs.rPDIpc2_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Private Investment')
    subplot(3,4,4)
    eval(['plot(oo_.irfs.rGSpendingpc2_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Government Spending')
    subplot(3,4,5)
    eval(['plot(oo_.irfs.As_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Frontier Productivity')
    ylabel('Home, real per capita, % deviations from SS or trend')
    subplot(3,4,6)
    eval(['plot(oo_.irfs.PWThpop2_',ShockList{ii},'(1:T)*100)'])
    title('Hours Worked')
    subplot(3,4,7)
    eval(['plot(oo_.irfs.IHPpc2_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Private H Investment')
    subplot(3,4,8)
    eval(['plot(oo_.irfs.GovDifY2_',ShockList{ii},'(1:T))'])
    title('Government Deficit / GDP')
    subplot(3,4,9)
    eval(['plot(oo_.irfs.Xpc2_DivFromTrend_',ShockList{ii},'(1:T))'])
    title('Engineering')
    subplot(3,4,10)
    eval(['plot(oo_.irfs.NXY2_',ShockList{ii},'(1:T))'])
    title('Net Export / GDP')
    xlabel(['Shock: ',ShockNames{ii},', 1 StD'])
    subplot(3,4,11)
    eval(['plot(oo_.irfs.PRDY2_',ShockList{ii},'(1:T))'])
    title('Private R&D / GDP')
    subplot(3,4,12)
    eval(['plot(oo_.irfs.GRDY2_',ShockList{ii},'(1:T))'])
    title('Government R&D / GDP')
    f2n.Children(1).Position=[0.08*4+0.6/4*3, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f2n.Children(2).Position=[0.08*3+0.6/4*2, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f2n.Children(3).Position=[0.08*2+0.6/4*1, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f2n.Children(4).Position=[0.08*1+0.6/4*0, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    f2n.Children(5).Position=[0.08*4+0.6/4*3, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f2n.Children(6).Position=[0.08*3+0.6/4*2, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f2n.Children(7).Position=[0.08*2+0.6/4*1, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f2n.Children(8).Position=[0.08*1+0.6/4*0, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    f2n.Children(9).Position=[0.08*4+0.6/4*3, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f2n.Children(10).Position=[0.08*3+0.6/4*2, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f2n.Children(11).Position=[0.08*2+0.6/4*1, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    f2n.Children(12).Position=[0.08*1+0.6/4*0, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    drawnow;
    f2n.Children(3).XLabel.Position(1)=T*1.125;
    f2n.Children(8).YLabel.Position(1)=f2n.Children(8).YLabel.Position(1)*1.1;
    f2n.Position=[200 200 1920 1080];
    drawnow;
    if eval(['max(abs(oo_.irfs.rGDPpc1_DivFromTrend_',ShockList{ii},'(1:40)))>=0.01'])
        savefig(['sig Home responses to a ',ShockNames{ii},' shock'])    
        saveas(gcf,['sig Home responses to a ',ShockNames{ii},' shock'],'emf')
    else
        savefig(['Home responses to a ',ShockNames{ii},' shock'])    
        saveas(gcf,['Home responses to a ',ShockNames{ii},' shock'],'emf')
    end
end
cd ..
