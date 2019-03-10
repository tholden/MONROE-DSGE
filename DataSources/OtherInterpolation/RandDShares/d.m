function dz = d( z )

    dz = z( 2 : end, : ) - z( 1 : ( end - 1 ), : );

end
