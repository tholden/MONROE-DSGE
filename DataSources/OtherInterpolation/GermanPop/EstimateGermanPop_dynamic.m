function [residual, g1, g2, g3] = EstimateGermanPop_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(11, 1);
lhs =y(10);
rhs =params(1)*y(2)+params(2)*x(it_, 1)+params(2)*params(3)*y(6);
residual(1)= lhs-rhs;
lhs =y(12);
rhs =params(4)*y(3)+params(5)*x(it_, 2)+params(5)*params(6)*y(7);
residual(2)= lhs-rhs;
lhs =y(14);
rhs =params(7)*y(4)+params(8)*x(it_, 3)+params(8)*params(9)*y(8);
residual(3)= lhs-rhs;
lhs =y(11);
rhs =y(12)+y(15);
residual(4)= lhs-rhs;
lhs =y(15);
rhs =y(5)+y(9);
residual(5)= lhs-rhs;
lhs =y(9);
rhs =y(10)+y(1);
residual(6)= lhs-rhs;
lhs =y(13);
rhs =y(14)+params(11)*(y(11)*params(12)+y(15)*(1-params(12)));
residual(7)= lhs-rhs;
lhs =y(16);
rhs =y(11)*params(13)+y(15)*(1-params(13));
residual(8)= lhs-rhs;
lhs =y(17);
rhs =x(it_, 1);
residual(9)= lhs-rhs;
lhs =y(18);
rhs =x(it_, 2);
residual(10)= lhs-rhs;
lhs =y(19);
rhs =x(it_, 3);
residual(11)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(11, 22);

  %
  % Jacobian matrix
  %

  g1(1,2)=(-params(1));
  g1(1,10)=1;
  g1(1,20)=(-params(2));
  g1(1,6)=(-(params(2)*params(3)));
  g1(2,3)=(-params(4));
  g1(2,12)=1;
  g1(2,21)=(-params(5));
  g1(2,7)=(-(params(5)*params(6)));
  g1(3,4)=(-params(7));
  g1(3,14)=1;
  g1(3,22)=(-params(8));
  g1(3,8)=(-(params(8)*params(9)));
  g1(4,11)=1;
  g1(4,12)=(-1);
  g1(4,15)=(-1);
  g1(5,9)=(-1);
  g1(5,5)=(-1);
  g1(5,15)=1;
  g1(6,1)=(-1);
  g1(6,9)=1;
  g1(6,10)=(-1);
  g1(7,11)=(-(params(11)*params(12)));
  g1(7,13)=1;
  g1(7,14)=(-1);
  g1(7,15)=(-(params(11)*(1-params(12))));
  g1(8,11)=(-params(13));
  g1(8,15)=(-(1-params(13)));
  g1(8,16)=1;
  g1(9,20)=(-1);
  g1(9,17)=1;
  g1(10,21)=(-1);
  g1(10,18)=1;
  g1(11,22)=(-1);
  g1(11,19)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],11,484);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],11,10648);
end
end
end
end
