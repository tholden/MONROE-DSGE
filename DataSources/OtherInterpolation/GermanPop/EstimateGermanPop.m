%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'EstimateGermanPop';
M_.dynare_version = '4.5.3';
oo_.dynare_version = '4.5.3';
options_.dynare_version = '4.5.3';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('EstimateGermanPop.log');
M_.exo_names = 'DJST_TREND_EPSILON';
M_.exo_names_tex = 'DJST\_TREND\_EPSILON';
M_.exo_names_long = 'DJST_TREND_EPSILON';
M_.exo_names = char(M_.exo_names, 'JST_EPSILON');
M_.exo_names_tex = char(M_.exo_names_tex, 'JST\_EPSILON');
M_.exo_names_long = char(M_.exo_names_long, 'JST_EPSILON');
M_.exo_names = char(M_.exo_names, 'JST2_EPSILON');
M_.exo_names_tex = char(M_.exo_names_tex, 'JST2\_EPSILON');
M_.exo_names_long = char(M_.exo_names_long, 'JST2_EPSILON');
M_.endo_names = 'DJST_TREND';
M_.endo_names_tex = 'DJST\_TREND';
M_.endo_names_long = 'DJST_TREND';
M_.endo_names = char(M_.endo_names, 'DJST_TREND_SHOCK');
M_.endo_names_tex = char(M_.endo_names_tex, 'DJST\_TREND\_SHOCK');
M_.endo_names_long = char(M_.endo_names_long, 'DJST_TREND_SHOCK');
M_.endo_names = char(M_.endo_names, 'JST');
M_.endo_names_tex = char(M_.endo_names_tex, 'JST');
M_.endo_names_long = char(M_.endo_names_long, 'JST');
M_.endo_names = char(M_.endo_names, 'JST_SHOCK');
M_.endo_names_tex = char(M_.endo_names_tex, 'JST\_SHOCK');
M_.endo_names_long = char(M_.endo_names_long, 'JST_SHOCK');
M_.endo_names = char(M_.endo_names, 'JST2');
M_.endo_names_tex = char(M_.endo_names_tex, 'JST2');
M_.endo_names_long = char(M_.endo_names_long, 'JST2');
M_.endo_names = char(M_.endo_names, 'JST2_SHOCK');
M_.endo_names_tex = char(M_.endo_names_tex, 'JST2\_SHOCK');
M_.endo_names_long = char(M_.endo_names_long, 'JST2_SHOCK');
M_.endo_names = char(M_.endo_names, 'JST_TREND');
M_.endo_names_tex = char(M_.endo_names_tex, 'JST\_TREND');
M_.endo_names_long = char(M_.endo_names_long, 'JST_TREND');
M_.endo_names = char(M_.endo_names, 'PWT');
M_.endo_names_tex = char(M_.endo_names_tex, 'PWT');
M_.endo_names_long = char(M_.endo_names_long, 'PWT');
M_.endo_names = char(M_.endo_names, 'AUX_EXO_LAG_2_0');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_EXO\_LAG\_2\_0');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_EXO_LAG_2_0');
M_.endo_names = char(M_.endo_names, 'AUX_EXO_LAG_8_0');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_EXO\_LAG\_8\_0');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_EXO_LAG_8_0');
M_.endo_names = char(M_.endo_names, 'AUX_EXO_LAG_14_0');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_EXO\_LAG\_14\_0');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_EXO_LAG_14_0');
M_.endo_partitions = struct();
M_.param_names = 'DJST_TREND_rho';
M_.param_names_tex = 'DJST\_TREND\_rho';
M_.param_names_long = 'DJST_TREND_rho';
M_.param_names = char(M_.param_names, 'DJST_TREND_sigma');
M_.param_names_tex = char(M_.param_names_tex, 'DJST\_TREND\_sigma');
M_.param_names_long = char(M_.param_names_long, 'DJST_TREND_sigma');
M_.param_names = char(M_.param_names, 'DJST_TREND_theta');
M_.param_names_tex = char(M_.param_names_tex, 'DJST\_TREND\_theta');
M_.param_names_long = char(M_.param_names_long, 'DJST_TREND_theta');
M_.param_names = char(M_.param_names, 'JST_rho');
M_.param_names_tex = char(M_.param_names_tex, 'JST\_rho');
M_.param_names_long = char(M_.param_names_long, 'JST_rho');
M_.param_names = char(M_.param_names, 'JST_sigma');
M_.param_names_tex = char(M_.param_names_tex, 'JST\_sigma');
M_.param_names_long = char(M_.param_names_long, 'JST_sigma');
M_.param_names = char(M_.param_names, 'JST_theta');
M_.param_names_tex = char(M_.param_names_tex, 'JST\_theta');
M_.param_names_long = char(M_.param_names_long, 'JST_theta');
M_.param_names = char(M_.param_names, 'JST2_rho');
M_.param_names_tex = char(M_.param_names_tex, 'JST2\_rho');
M_.param_names_long = char(M_.param_names_long, 'JST2_rho');
M_.param_names = char(M_.param_names, 'JST2_sigma');
M_.param_names_tex = char(M_.param_names_tex, 'JST2\_sigma');
M_.param_names_long = char(M_.param_names_long, 'JST2_sigma');
M_.param_names = char(M_.param_names, 'JST2_theta');
M_.param_names_tex = char(M_.param_names_tex, 'JST2\_theta');
M_.param_names_long = char(M_.param_names_long, 'JST2_theta');
M_.param_names = char(M_.param_names, 'JST_INIT');
M_.param_names_tex = char(M_.param_names_tex, 'JST\_INIT');
M_.param_names_long = char(M_.param_names_long, 'JST_INIT');
M_.param_names = char(M_.param_names, 'JST2_scale');
M_.param_names_tex = char(M_.param_names_tex, 'JST2\_scale');
M_.param_names_long = char(M_.param_names_long, 'JST2_scale');
M_.param_names = char(M_.param_names, 'JST2_kappa');
M_.param_names_tex = char(M_.param_names_tex, 'JST2\_kappa');
M_.param_names_long = char(M_.param_names_long, 'JST2_kappa');
M_.param_names = char(M_.param_names, 'PWT_kappa');
M_.param_names_tex = char(M_.param_names_tex, 'PWT\_kappa');
M_.param_names_long = char(M_.param_names_long, 'PWT_kappa');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 3;
M_.endo_nbr = 11;
M_.param_nbr = 13;
M_.orig_endo_nbr = 8;
M_.aux_vars(1).endo_index = 9;
M_.aux_vars(1).type = 3;
M_.aux_vars(1).orig_index = 1;
M_.aux_vars(1).orig_lead_lag = 0;
M_.aux_vars(2).endo_index = 10;
M_.aux_vars(2).type = 3;
M_.aux_vars(2).orig_index = 2;
M_.aux_vars(2).orig_lead_lag = 0;
M_.aux_vars(3).endo_index = 11;
M_.aux_vars(3).type = 3;
M_.aux_vars(3).orig_index = 3;
M_.aux_vars(3).orig_lead_lag = 0;
options_.varobs = cell(1);
options_.varobs(1)  = {'JST'};
options_.varobs(2)  = {'JST2'};
options_.varobs(3)  = {'PWT'};
options_.varobs_id = [ 3 5 8  ];
M_.Sigma_e = zeros(3, 3);
M_.Correlation_matrix = eye(3, 3);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('EstimateGermanPop_static');
erase_compiled_function('EstimateGermanPop_dynamic');
M_.orig_eq_nbr = 8;
M_.eq_nbr = 11;
M_.ramsey_eq_nbr = 0;
M_.lead_lag_incidence = [
 1 9;
 2 10;
 0 11;
 3 12;
 0 13;
 4 14;
 5 15;
 0 16;
 6 17;
 7 18;
 8 19;]';
M_.nstatic = 3;
M_.nfwrd   = 0;
M_.npred   = 8;
M_.nboth   = 0;
M_.nsfwrd   = 0;
M_.nspred   = 8;
M_.ndynamic   = 8;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:3];
M_.maximum_lag = 1;
M_.maximum_lead = 0;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 0;
oo_.steady_state = zeros(11, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(3, 1);
M_.params = NaN(13, 1);
M_.NNZDerivatives = [34; -1; -1];
M_.params( 1 ) = 0.5;
DJST_TREND_rho = M_.params( 1 );
M_.params( 2 ) = 0.001;
DJST_TREND_sigma = M_.params( 2 );
M_.params( 3 ) = 0.5;
DJST_TREND_theta = M_.params( 3 );
M_.params( 4 ) = 0.5;
JST_rho = M_.params( 4 );
M_.params( 5 ) = 0.001;
JST_sigma = M_.params( 5 );
M_.params( 6 ) = 0.5;
JST_theta = M_.params( 6 );
M_.params( 7 ) = 0.5;
JST2_rho = M_.params( 7 );
M_.params( 8 ) = 0.001;
JST2_sigma = M_.params( 8 );
M_.params( 9 ) = 0.5;
JST2_theta = M_.params( 9 );
M_.params( 10 ) = 10.61654;
JST_INIT = M_.params( 10 );
M_.params( 11 ) = 1;
JST2_scale = M_.params( 11 );
M_.params( 12 ) = 0.9;
JST2_kappa = M_.params( 12 );
M_.params( 13 ) = 0.9;
PWT_kappa = M_.params( 13 );
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = 1;
M_.Sigma_e(2, 2) = 1;
M_.Sigma_e(3, 3) = 1;
estim_params_.var_exo = [];
estim_params_.var_endo = [];
estim_params_.corrx = [];
estim_params_.corrn = [];
estim_params_.param_vals = [];
estim_params_.param_vals = [estim_params_.param_vals; 11, M_.params(11), 0, 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 12, M_.params(12), 0, 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 13, M_.params(13), 0, 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 1, M_.params(1), 0, 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 2, M_.params(2), 0, 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 3, M_.params(3), (-1), 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 4, M_.params(4), 0, 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 5, M_.params(5), 0, 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 6, M_.params(6), (-1), 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 7, M_.params(7), 0, 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 8, M_.params(8), 0, 1, 0, NaN, NaN, NaN, NaN, NaN ];
estim_params_.param_vals = [estim_params_.param_vals; 9, M_.params(9), (-1), 1, 0, NaN, NaN, NaN, NaN, NaN ];
options_.qz_criterium = 1 + 1e-6;
steady;
oo_.dr.eigval = check(M_,options_,oo_);
options_.cova_compute = 1;
options_.diffuse_filter = 1;
options_.mh_nblck = 0;
options_.mh_replic = 0;
options_.mode_check.status = 1;
options_.mode_check.symmetric_plots = 0;
options_.mode_compute = 1;
options_.order = 1;
options_.smoother = 1;
options_.use_univariate_filters_if_singularity_is_detected = 0;
options_.datafile = 'GermanPop.xlsx';
options_.optim_opt = '''Display'',''Iter'',''MaxFunEvals'',1e12,''MaxIter'',1e12,''TolFun'',1e-12,''TolX'',1e-12,''FinDiffType'',''central''';
options_.xls_sheet = 'Data';
options_.steadystate.nocheck = 1;
var_list_ = char('JST');
oo_recursive_=dynare_estimation(var_list_);
save('EstimateGermanPop_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('EstimateGermanPop_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('EstimateGermanPop_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('EstimateGermanPop_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('EstimateGermanPop_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('EstimateGermanPop_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('EstimateGermanPop_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
