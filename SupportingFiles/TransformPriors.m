%this file transform hierarchical priors such as
%a1=b+c1
%a2=b+c2
%where b, c1, c2 are priors
%into something like
%a1 = m + k11 * e1 + k12 * e2
%a2 = m + k21 * e1 + k22 * e2
%where e1 and e2 are N(0,1) and m, k1, k2 are some numbers
%so the #of parameters to estimate reduces from 3 to 2

%it takes input equation.txt and priors.txt
%and produce output.txt
%see TEST files for an example

%output has 3 block:
%The first is added to the prior file
%The second is added to the steady state file
%The third is used as a map from old priors to transformed priors
%also remember to define transformed priors in the main mod file
clear variables;

TestMode = 0;

if TestMode
    EquationsFile = 'TestEquations.txt'; %#ok<UNRCH>
    PriorsFile = 'TestPriors.txt';
else
    EquationsFile = 'equations.txt';
    PriorsFile = 'priors.txt';
end
    
Equations = fileread( EquationsFile );
Priors = fileread( PriorsFile );

Equations = strsplit( regexprep( regexprep( Equations, '\s+', '' ), ';(?!$)', ';\n' ), '\n' );
Priors = strsplit( regexprep( regexprep( Priors, '\s+', '' ), ';(?!$)', ';\n' ), '\n' );

M = length( Equations );
N = length( Priors );

SymVariableNames = cell( N, 1 );

for n = 1 : N

    Prior = Priors{ n };
    Prior = Prior( 1 : ( end - 1 ) );
    PriorParts = strsplit( Prior, ',' );
    assert( length( PriorParts ) == 5 );
    PriorVariableName = PriorParts{ 1 };
    if ~strcmp( PriorVariableName, PriorParts{2} )
        warning( 'Expected the prior to have an initial value given by its current value.' );
    end
    if strcmpi( PriorParts{3}, 'normal_pdf' )
        LogFlag = false;
    elseif strcmpi( PriorParts{3}, 'gamma_pdf' ) || strcmpi( PriorParts{3}, 'inv_gamma_pdf' )
        PriorVariableName = [ 'log_' PriorVariableName ]; %#ok<AGROW>
        LogFlag = true;
    else
        error( 'Unexpected prior shape.' );
    end
    SymVariableName = [ 'SNP_' PriorVariableName ];
    syms( SymVariableName );
    Mean = PriorParts{4};
    Std = PriorParts{5};
    Mean = eval( Mean );
    Std = eval( Std );
    if LogFlag
        mu = 2*log(Mean)-(1/2)*log(Mean^2+Std^2);
        sigma = (1/2)*sqrt(2)*sqrt(2*log(Mean^2+Std^2)-4*log(Mean));
        Mean = mu;
        Std = sigma;
    end
    eval( [ PriorVariableName '=' num2str( Mean ) '+' num2str( Std ) '*' SymVariableName ';' ] );
    SymVariableNames{ n } = SymVariableName;
    
end

EquationVariableNames = cell( M, 1 );

for m = 1 : M
    Equation = Equations{ m };
    EquationVariableName = regexprep( Equation, '=.*', '' );
    RHS = Equation( ( length( EquationVariableName ) + 2 ) : ( end - 1 ) );
    if strcmp( RHS( 1 : 9 ), '1/(1+exp(' )
        assert( strcmp( RHS( ( end - 1 ) : end ), '))' ) );
        RHS = [ '-(' RHS( 10 : ( end - 2 ) ) ')' ];
        EquationVariableName = [ 'logit_' EquationVariableName ]; %#ok<AGROW>
    end
    if ( length( RHS ) > 4 ) && strcmp( RHS( 1 : 4 ), 'exp(' )
        assert( RHS( end ) == ')' );
        RHS = RHS( 5 : ( end - 1 ) );
        EquationVariableName = [ 'log_' EquationVariableName ]; %#ok<AGROW>
    end
    if contains( RHS, '*' )
        RHSParts = strsplit( RHS, '*' );
        assert( ~any( contains( RHSParts, '+' ) | contains( RHSParts, '-' ) | contains( RHSParts, '^' ) | contains( RHSParts, '(' ) | contains( RHSParts, ')' ) ) );
        RHS = [ 'log_' strjoin( RHSParts, '+log_' ) ];
        EquationVariableName = [ 'log_' EquationVariableName ]; %#ok<AGROW>
    end
    eval( [ EquationVariableName '=' RHS ';' ] );
    EquationVariableNames{ m } = EquationVariableName;
end

EquationVariableVector = [ '[' strjoin( EquationVariableNames, ';' ) ']' ];
SymVariableVector = [ '[' strjoin( SymVariableNames, ';' ) ']' ];

Constant = double( eval( [ 'subs(' EquationVariableVector ',' SymVariableVector ',[' repmat( '0;', 1, N ) '])' ] ) );
Jacobian = double( eval( [ 'jacobian(' EquationVariableVector ',' SymVariableVector ')' ] ) );

Constant( abs( Constant ) < sqrt( eps ) ) = 0;

Variance = Jacobian * Jacobian.';

[ U, D ] = schur( Variance );

d = diag( D );

assert( max( max( abs( D - diag( d ) ) ) ) < sqrt( eps ) );

d( d < sqrt( eps ) ) = 0;

d = sqrt( d );

Select = d > 0;

d = d( Select );

U = U( :, Select );

NewJacobian = U * diag( d );

J = size( NewJacobian, 2 );

fprintf( '\n**************************\n\n' );

for j = 1 : J
    fprintf( 'InternalPrior_%d, InternalPrior_%d, normal_pdf, 0, 1;\n', j, j );
end

fprintf( '\n**************************\n\n' );

for m = 1 : M
    EquationVariableName = EquationVariableNames{ m };
    fprintf( '%s = %.64g', EquationVariableName, Constant( m ) );
    for j = 1 : J
        if NewJacobian( m, j ) > sqrt( eps )
            fprintf( ' + %.64g * InternalPrior_%d', NewJacobian( m, j ), j );
        elseif NewJacobian( m, j ) < -sqrt( eps )
            fprintf( ' - %.64g * InternalPrior_%d', -NewJacobian( m, j ), j );
        end
    end
    fprintf( ';\n' );
    if ( length( EquationVariableName ) > 4 ) && strcmp( EquationVariableName( 1 : 4 ), 'log_' )
        fprintf( '%s = exp( %s );\n', EquationVariableName( 5 : end ), EquationVariableName );
        EquationVariableName = EquationVariableName( 5 : end );
    end
    if ( length( EquationVariableName ) > 6 ) && strcmp( EquationVariableName( 1 : 6 ), 'logit_' )
        fprintf( '%s = 1 / ( 1 + exp( -( %s ) ) );\n', EquationVariableName( 7 : end ), EquationVariableName );
        % EquationVariableName = EquationVariableName( 7 : end );
    end
end

fprintf( '\n**************************\n\n' );

ReverseJacobian = diag( 1 ./ d ) * U';
ReverseConstant = -ReverseJacobian * Constant;

ReverseConstant( abs( ReverseConstant ) < sqrt( eps ) ) = 0;

for j = 1 : J
    fprintf( 'InternalPrior_%d = %.64g', j, ReverseConstant( j ) );
    for m = 1 : M
        EquationVariableName = EquationVariableNames{ m };
        EffectiveEquationVariableName = 'PLACEHOLDER';
        if ( length( EquationVariableName ) > 6 ) && strcmp( EquationVariableName( 1 : 6 ), 'logit_' )
            EquationVariableName = EquationVariableName( 7 : end );
            EffectiveEquationVariableName = [ '( - log( 1 / ' EffectiveEquationVariableName ' - 1 ) )' ]; %#ok<AGROW>
        end
        if ( length( EquationVariableName ) > 4 ) && strcmp( EquationVariableName( 1 : 4 ), 'log_' )
            EquationVariableName = EquationVariableName( 5 : end );
            EffectiveEquationVariableName = [ 'log( ' EffectiveEquationVariableName ' )' ]; %#ok<AGROW>
        end
        EffectiveEquationVariableName = strrep( EffectiveEquationVariableName, 'PLACEHOLDER', EquationVariableName );
        if ReverseJacobian( j, m ) > sqrt( eps )
            fprintf( ' + %.64g * %s', ReverseJacobian( j, m ), EffectiveEquationVariableName );
        elseif ReverseJacobian( j, m ) < -sqrt( eps )
            fprintf( ' - %.64g * %s', -ReverseJacobian( j, m ), EffectiveEquationVariableName );
        end
    end
    fprintf( ';\n' );
end

fprintf( '\n' );


