clear variables;
load RandDShareData RandDShareData coeff score;

Table = removevars( RandDShareData, 'Year' );

OECDTable = Table( :,  contains( Table.Properties.VariableNames, 'OECD' ) );
ECTable   = Table( :, ~contains( Table.Properties.VariableNames, 'OECD' ) );

OECD = NaN( size( OECDTable ) );
EC   = NaN( size( ECTable ) );

Variables = ECTable.Properties.VariableNames;

for i = 1 : length( Variables )
    Variable = Variables{ i };
    OECD( :, i ) = OECDTable.( [ 'OECD' Variable ] );
    EC( :, i )   = ECTable.( Variable );
end

LB = EC - 0.005;
UB = EC + 0.005;

OECD = 0.01 * OECD;
OECD = log( OECD ./ ( 1 - OECD ) );

EC = 0.01 * EC;
EC = log( EC ./ ( 1 - EC ) );

LB = 0.01 * LB;
LB = log( LB ./ ( 1 - LB ) );

LB( ~isfinite( LB ) ) = -Inf;
LB = [ -Inf( size( OECD ) ); -Inf( size( OECD ) ); LB ];

UB = 0.01 * UB;
UB = log( UB ./ ( 1 - UB ) );

UB( ~isfinite( UB ) ) = Inf;
UB = [ Inf( size( OECD ) ); Inf( size( OECD ) ); UB ];

UBmLB = UB - LB;
MinVar = ( 0.5 * max( UBmLB( isfinite( UBmLB ) ) ) ) .^ 2;

oOECD = OECD;
oEC = EC;

for i = 1 : size( EC, 2 )
    EC( :, i ) = CrudeInterp( EC( :, i ) );
    OECD( :, i ) = CrudeInterp( OECD( :, i ) );
end

x = mean( cat( 3, OECD, EC ), 3 );

seps = sqrt( eps );

ISigma2s = ones( 5, 1 );

OISigma2s = ISigma2s * Inf;

while max( abs( ISigma2s - OISigma2s ) ./ ISigma2s ) > seps

    for i = 1 : size( x, 2 )

        State = [ x( :, i ); OECD( :, i ); EC( :, i ) ];

        State = fmincon( @GetObsLL, State, [], [], [], [], LB( :, i ), UB( :, i ), [], ...
            optimoptions( @fmincon, 'Algorithm', 'trust-region-reflective', 'SpecifyObjectiveGradient', true, 'CheckGradients', false, 'ConstraintTolerance', seps, 'OptimalityTolerance', seps, 'StepTolerance', seps, 'FunctionTolerance', seps, 'MaxFunctionEvaluations', 1e12, 'MaxIterations', 1e12, 'Display', 'off' ), ...
            ISigma2s, oOECD( :, i ), oEC( :, i ) );

        State = reshape( State, size( x, 1 ), 3 );

        x( :, i )    = State( :, 1 );
        OECD( :, i ) = State( :, 2 );
        EC( :, i )   = State( :, 3 );    

    end

    OISigma2s = ISigma2s;
    ISigma2s = 0.5 * OISigma2s + 0.5 * GetISigma2s( x, OECD, EC, oOECD, oEC, MinVar );

    disp( ISigma2s );

end

aEC = 100 ./ ( 1 + exp( -EC ) );
aECTable = ECTable;
for i = 1 : size( EC, 2 )
    aECTable.( Variables{ i } ) = aEC( :, i );
end
writetable( aECTable, 'ECRD.xlsx' );
