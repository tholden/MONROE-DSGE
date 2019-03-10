function [ ll, Dll ] = GetObsLL( State, ISigma2s, oOECD, oEC )

    T = length( oOECD );
    assert( T == length( oEC ) );

    State = reshape( State, T, 3 );

    x     = State( :, 1 );
    OECD  = State( :, 2 );
    EC    = State( :, 3 );
    
    oOECD = oOECD - OECD;
    oEC   = oEC   - EC;
    
    dx    = d( x );    
    OECD  = OECD - x;
    EC    = EC   - x;
    
    ddx   = d( dx );
    dOECD = d( OECD );
    dEC   = d( EC );
        
    if nargout == 1
        
        ll     = ISigma2s( 1 ) * GetNLL( ddx ) + ISigma2s( 2 ) * GetNLL( dOECD ) + ISigma2s( 3 ) * GetNLL( dEC ) + ISigma2s( 4 ) * GetNLL( oOECD ) + ISigma2s( 5 ) * GetNLL( oEC );

    else
    
        Dx     = [   eye( length( x ) ), zeros( length( OECD ) ), zeros( length( EC ) ) ];
        DOECD  = [ zeros( length( x ) ),   eye( length( OECD ) ), zeros( length( EC ) ) ];
        DEC    = [ zeros( length( x ) ), zeros( length( OECD ) ),   eye( length( EC ) ) ];

        DoOECD = -DOECD;
        DoEC   = -DEC;

        Ddx    = d( Dx );
        DOECD  = DOECD - Dx;
        DEC    = DEC   - Dx;
    
        Dll    = ISigma2s( 1 ) * GetNLL( dx, Ddx ) + ISigma2s( 2 ) * GetNLL( OECD, DOECD ) + ISigma2s( 3 ) * GetNLL( EC, DEC ) + ISigma2s( 4 ) * GetNLL( oOECD, DoOECD ) + ISigma2s( 5 ) * GetNLL( oEC, DoEC );
        
        ll     = Dll( 1 );
        Dll    = Dll( 2 : end );
    
    end

end

function ll = GetARLL( z, Dz ) %#ok<DEFNU>

    x = z( 1 : ( end - 1 ) );
    y = z( 2 : end );
    
    rho1 = x' * y;
    rho2 = x' * x;
    rho3 = rho1 / rho2;
    
    rho = max( 0, min( 1, rho3 ) );
    
    e = y - rho * x;
    
    ll = e' * e; % should really be log of this
    
    if nargin > 1
        
        Dx = Dz( 1 : ( end - 1 ), : );
        Dy = Dz( 2 : end, : );
        
        Drho1 = x' * Dy + y' * Dx;
        Drho2 = 2 * ( x' * Dx );
        Drho3 = ( rho2 * Drho1 - rho1 * Drho2 ) / ( rho2 * rho2 );
        
        if rho3 < 0 || rho3 > 1
            Drho = zeros( size( Drho3 ) );
        else
            Drho = Drho3;
        end
        
        De = Dy - rho * Dx - x * Drho;
        
        Dll = 2 * ( e' * De );
        
        ll = [ ll, Dll ];
        
    end
    
end

function ll = GetNLL( z, Dz )

    sel = isfinite( z );
    
    z = z( sel );
    ll = z' * z; % should really be log of this
    
    if nargin > 1

        Dz = Dz( sel, : );
        Dll = 2 * ( z' * Dz );
        
        ll = [ ll, Dll ];

    end
    
end
