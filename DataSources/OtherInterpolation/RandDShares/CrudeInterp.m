function z = CrudeInterp( z )

    Finite = isfinite( z );

    First = find( Finite, 1, 'first' );
    Last  = find( Finite, 1, 'last' );
    
    z( 1 : ( First - 1 ) ) = z( First );
    z( ( Last + 1 ) : end ) = z( Last );
    
    NonFinite = find( ~isfinite( z ) );
    
    for i = 1 : length( NonFinite )
        j = NonFinite( i );
        Prev = find( Finite( 1 : j ), 1, 'last' );
        Next = j + find( Finite( ( j + 1 ) : end ), 1, 'first' );
        z( j ) = ( z( Prev ) * ( Next - j ) + z( Next ) * ( j - Prev ) ) / ( Next - Prev );
    end

end
