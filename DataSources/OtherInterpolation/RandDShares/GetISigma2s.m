function ISigma2s = GetISigma2s( x, OECD, EC, oOECD, oEC, MinVar )

    oOECD = oOECD - OECD;
    oEC   = oEC   - EC;

    dx    = d( x );    
    OECD  = OECD - x;
    EC    = EC   - x;

    ddx   = d( dx );
    dOECD = d( OECD );
    dEC   = d( EC );

    % ll  = ISigma2s( 1 ) * GetNLL( ddx ) + ISigma2s( 2 ) * GetNLL( dOECD ) + ISigma2s( 3 ) * GetNLL( dEC ) + ISigma2s( 4 ) * GetNLL( oOECD ) + ISigma2s( 5 ) * GetNLL( oEC );
    
    Sigma2s = zeros( 5, 1 );
    
    Sigma2s( 1 ) = var( ddx( : ) );
    Sigma2s( 2 ) = var( dOECD( : ) );
    Sigma2s( 3 ) = var( dEC( : ) );
    Sigma2s( 4 ) = nanvar( oOECD( : ) );
    Sigma2s( 5 ) = max( nanvar( oEC( : ) ), MinVar );
    
    Sigma2s = max( Sigma2s, sqrt( eps ) );
    
    ISigma2s = 1 ./ Sigma2s;
    
end
