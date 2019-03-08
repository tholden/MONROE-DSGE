%gdp                private consumption    private toatal investment      government spending, 
%As					hours worked           human capital investment       Gov deficit/GDP
%engineering usage	trade balance/GDP	   private RD/GDP                 Gov RD/GDP

close all;

t0 = 2017;
T = ( 2000 : 2120 ).';

CountryNames = { 'US', 'Germany', 'UK', 'France', 'REU', 'RMA' };

for ii = 1 : 6
    
    Figure = figure( ii );
    
    sii = int2str( ii );
    CountryName = CountryNames{ ii };
    
    if ii == 1
        Provider1 = 'BEA';
        Provider2 = 'JST';
        Provider3 = 'BEA';
    elseif ii == 3
        Provider1 = 'MILL';
        Provider2 = 'MILL';
        Provider3 = 'MILL';
    else
        Provider1 = 'PWT';
        Provider2 = 'JST';
        Provider3 = 'JST';
    end
    
    mkdir( [ 'TextConditionalForecasts' CountryName ] );
    cd( [ 'TextConditionalForecasts' CountryName ] );
    
    subplot(3,4,1)
    PlotForecast( 'Real GDP Per Capita', [ 'rGDPpc' sii '_DivFromTrend' ], Steady.( [ 'steady_state_GrGDPpc' sii '__' ] ), 1, t0, T, oo_, cond );
    
    subplot(3,4,2)
    PlotForecast( 'Private Consumption / GDP', [ Provider1 'cy' sii ], 0, 100, t0, T, oo_, cond, [ 0, 100 ] );
    
    subplot(3,4,3)
    PlotForecast( 'Private Investment / GDP', [ Provider2 'iy' sii ], 0, 100, t0, T, oo_, cond, [ 0, 100 ] );
    
    subplot(3,4,4)
    PlotForecast( 'Government Spending / GDP', [ Provider3 'gy' sii ], 0, 100, t0, T, oo_, cond, [ 0, 100 ] );
    
    subplot(3,4,5)
    PlotForecast( 'Frontier Productivity', 'As_DivFromTrend', 100 * oo_.steady_state( ismember( cellstr( M_.endo_names ), 'log_GAs' ) ), 1, t0, T, oo_, cond );
    
    ylabel( 'Percentage points (ratios) or log points (growing variables). Level in 2017 is normalized to 0 for growing variables.' );
    
    subplot(3,4,6)
    PlotForecast( 'Net Exports / GDP', [ 'NXY' sii ], 0, 1, t0, T, oo_, cond );
    
    subplot(3,4,7)
    PlotForecast( 'Hours Worked Per Capita', [ Provider1 'hpop' sii ], 0, 100, t0, T, oo_, cond );
    
    subplot(3,4,8)
    PlotForecast( 'Government Deficit / GDP', [ 'GovDifY' sii ], 0, 1, t0, T, oo_, cond );
    
    subplot(3,4,9)
    PlotForecast( 'Engineering Per Capita', [ 'Xpc' sii '_DivFromTrend' ], Steady.( [ 'steady_state_GrXpc' sii '__' ] ), 1, t0, T, oo_, cond );
    
    subplot(3,4,10)
    PlotForecast( 'Labour Income / GDP', [ Provider1 'why' sii ], 0, 100, t0, T, oo_, cond, [ 0, 100 ] );
    
    xlabel( [ 'Forecasts for ' CountryName ] );
    
    subplot(3,4,11)
    PlotForecast(  'Total Human Capital Investment / GDP', [ 'OECDihy' sii ], 0, 100, t0, T, oo_, cond, [ 0, 100 ] );
    
    subplot(3,4,12)
    PlotForecast( 'Total R&D / GDP', [ 'ESrdy' sii ], 0, 100, t0, T, oo_, cond, [ 0, 100 ] );
    
    cd ..
    
    Figure.Children(1).Position=[0.08*4+0.6/4*3, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    Figure.Children(2).Position=[0.08*3+0.6/4*2, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    Figure.Children(3).Position=[0.08*2+0.6/4*1, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    Figure.Children(4).Position=[0.08*1+0.6/4*0, 0.08*1+0.68/3*0, 0.6/4, 0.68/3];
    Figure.Children(5).Position=[0.08*4+0.6/4*3, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    Figure.Children(6).Position=[0.08*3+0.6/4*2, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    Figure.Children(7).Position=[0.08*2+0.6/4*1, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    Figure.Children(8).Position=[0.08*1+0.6/4*0, 0.08*2+0.68/3*1, 0.6/4, 0.68/3];
    Figure.Children(9).Position=[0.08*4+0.6/4*3, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    Figure.Children(10).Position=[0.08*3+0.6/4*2, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    Figure.Children(11).Position=[0.08*2+0.6/4*1, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    Figure.Children(12).Position=[0.08*1+0.6/4*0, 0.08*3+0.68/3*2, 0.6/4, 0.68/3];
    
    drawnow;
    
    Figure.Position = [200 200 1920 1080];
    Figure.Children(3).XLabel.Position(1) = T(end) + 50;
    
    drawnow;
    
    savefig( [ 'Conditional Forecasts for ' CountryName ] );    
    saveas( Figure, [ 'Conditional Forecasts for ' CountryName ], 'emf' );

end

function PlotForecast( Title, VariableName, GrowthRate, Scale, t0, T, oo_, cond, Limits )

    if nargin < 9
        Limits = [ -Inf, Inf ];
    end
    
    Smoothed = oo_.SmoothedVariables.( VariableName );
    Cond     = cond.forecasts.cond.Mean.( VariableName );
    Uncond   = cond.forecasts.uncond.Mean.( VariableName );
    UncondAlt = oo_.forecast.Mean.( VariableName )( 1 : length( Cond ) );
    
    tIndex = find( T == t0, 1 );
    
    Initial = Smoothed( ( end - tIndex + 1 ) : end );
    Cond    = [ Initial; Cond ];
    Uncond  = [ Initial; Uncond  ];
    UncondAlt = [ Initial; UncondAlt  ];
    
    if GrowthRate ~= 0
        
        Base = ( 0 : ( length( Cond ) - 1 ) ).' .* GrowthRate;
        
        Cond   = Cond + Base;
        Uncond = Uncond  + Base;
        UncondAlt = UncondAlt  + Base;
        
        Cond   = Cond - Cond( tIndex );
        Uncond = Uncond  - Uncond( tIndex );
        UncondAlt = UncondAlt  - UncondAlt( tIndex );
        
    end
    
    L = length( T );
    
    plot( T, Cond( 1 : L ) * Scale, '-b' );
    hold on;
    plot( T, Uncond( 1 : L )  * Scale, '-g' );
    plot( T, UncondAlt( 1 : L )  * Scale, '-r' );
    hold off;
    title( Title );
    
    OriginalLimits = get( gca, 'YLim' );
    Limits( 1 ) = max( Limits( 1 ), OriginalLimits( 1 ) );
    Limits( 2 ) = min( Limits( 2 ), OriginalLimits( 2 ) );
    set( gca, 'YLim', Limits );
    
    ToSave = [ T, Uncond( 1 : L ), Cond( 1 : L ), UncondAlt( 1 : L ) ];
    csvwrite( [ strrep( Title, '/', 'over' ) '.csv' ], ToSave );

end
