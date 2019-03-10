@#define Variables = [ "DJST_TREND", "JST", "JST2" ]
@#for Variable in Variables
    var @{Variable} @{Variable}_SHOCK;
    varexo @{Variable}_EPSILON;
    parameters @{Variable}_rho @{Variable}_sigma @{Variable}_theta;
    @{Variable}_rho = 0.5;
    @{Variable}_sigma = 0.001;
    @{Variable}_theta = 0.5;
@#endfor

var JST_TREND PWT;

varobs JST JST2 PWT;

parameters JST_INIT;
parameters JST2_scale JST2_kappa PWT_kappa;

JST_INIT = 10.61654;

JST2_scale = 1;
JST2_kappa = 0.9;
PWT_kappa = 0.9;

model;
    @#for Variable in Variables
        @{Variable}_SHOCK = @{Variable}_rho * @{Variable}_SHOCK(-1) + @{Variable}_sigma * @{Variable}_EPSILON + @{Variable}_sigma * @{Variable}_theta * @{Variable}_EPSILON(-1);
    @#endfor
    
    JST = JST_TREND + JST_SHOCK;
    
    JST_TREND = JST_TREND(-1) + DJST_TREND; // + JST_TREND_SHOCK;
    DJST_TREND = DJST_TREND(-1) + DJST_TREND_SHOCK;
    
    JST2 = JST2_scale * ( JST2_kappa * JST + ( 1 - JST2_kappa ) * JST_TREND ) + JST2_SHOCK;
    PWT = ( PWT_kappa * JST + ( 1 - PWT_kappa ) * JST_TREND ); // + PWT_SHOCK;
end;

steady_state_model;
    @#for Variable in Variables
        @{Variable}_SHOCK = 0;
    @#endfor

    JST = JST_INIT;
    
    JST_TREND = JST;
    DJST_TREND = 0;

    JST2 = JST2_scale * JST;
    PWT = JST;
end;

shocks;
    @#for Variable in Variables
        var @{Variable}_EPSILON = 1;
    @#endfor
end;

estimated_params;
    JST2_scale, JST2_scale, 0, 1;
    JST2_kappa, JST2_kappa, 0, 1;
    PWT_kappa, PWT_kappa, 0, 1;
    @#for Variable in Variables
        @{Variable}_rho, @{Variable}_rho, 0, 1;
        @{Variable}_sigma, @{Variable}_sigma, 0, 1;
        @{Variable}_theta, @{Variable}_theta, -1, 1;
    @#endfor
end;

options_.qz_criterium = 1 + 1e-6;

steady;
check;

estimation( datafile = 'GermanPop.xlsx', xls_sheet = Data, diffuse_filter, mh_replic = 0, mh_nblocks = 0, mode_compute = 1, mode_check, mode_check_symmetric_plots = 0, optim = ( 'Display', 'Iter', 'MaxFunEvals', 1e12, 'MaxIter', 1e12, 'TolFun', 1e-12, 'TolX', 1e-12, 'FinDiffType', 'central' ), smoother, cova_compute = 1, order = 1, use_univariate_filters_if_singularity_is_detected = 0 ) JST;
