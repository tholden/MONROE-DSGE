function [ JP, MaxJPResids ] = GetJPSlow( betanl, Z, deltaItilde, eta, gamma, lambda, phiR, scriptp, scriptq, zetaR, GN, scriptFI, sigma, xi, d, b, alphaND, alphaD, alphah, alphaCD, alphaCG, alphaCP )
%This is a slightly modified version so that it can be compiled. see extension5 for the original version
    betanl=real(betanl);
    %guess JP (jp)
    jP = log( GetApproxJP( betanl, Z, deltaItilde, eta, gamma, lambda, phiR, scriptp, scriptq, zetaR, GN, scriptFI, sigma, xi, d, b, alphaND, alphaD, alphah, alphaCD, alphaCG, alphaCP ) );
    if imag( jP ) ~= 0
        JP = NaN;
        MaxJPResids = NaN;
        return
    end
    jP=real(jP);
    
    %prepare a range of JP
    Width = 5;
    StartIndex = nan;
    EndIndex = nan;
    jPG=0;
    while isnan( StartIndex ) || isnan( EndIndex )
        jPG = (jP-Width) : 0.01 : (jP+Width);
        Indexes = 1 : length( jPG );
        Resids = GetResid( exp( jPG ), betanl, Z, deltaItilde, eta, gamma, lambda, phiR, scriptp, scriptq, zetaR, GN, scriptFI, sigma, xi, d, b, alphaND, alphaD, alphah, alphaCD, alphaCG, alphaCP );
        if ~isempty( max(find( Resids > 0, 1, 'last' )) )
            StartIndex = max(find( Resids > 0, 1, 'last' ));
        end
        if ~isempty( max(find( Resids < 0 & Indexes > StartIndex, 1, 'first' )) )
            EndIndex = max(find( Resids < 0 & Indexes > StartIndex, 1, 'first' )); 
        end
        Width = 2 * Width;
        if Width > 1000
            JP = NaN;
            MaxJPResids = NaN;
            return
        end
    end
    jPL = jPG( StartIndex );
    jPU = jPG( EndIndex );
    
    dResids = diff( Resids );
    
    if all( dResids < 0 )
        MaxJPResids = Inf;
    else
        MaximaStartIndex = max( find( dResids > 0, 1, 'last' ) );
        [ ~, MaxJPResids ] = fminbnd( @( jP ) -GetResid( exp( jP ), betanl, Z, deltaItilde, eta, gamma, lambda, phiR, scriptp, scriptq, zetaR, GN, scriptFI, sigma, xi, d, b, alphaND, alphaD, alphah, alphaCD, alphaCG, alphaCP ), jPG( MaximaStartIndex ), jPG( min( end, MaximaStartIndex + 2 ) ), optimset( 'display', 'off' ) ); %JP=root of resid, using jp as start point
        MaxJPResids = -MaxJPResids;
    end
    
    %solve JP_ in [ jpL jpU ] as root of GetResid
    JP = fzero( @( jP ) GetResid( exp( jP ), betanl, Z, deltaItilde, eta, gamma, lambda, phiR, scriptp, scriptq, zetaR, GN, scriptFI, sigma, xi, d, b, alphaND, alphaD, alphah, alphaCD, alphaCG, alphaCP ), [ jPL jPU ], optimset( 'display', 'off' ) ); %JP=root of resid, using jp as start point
    JP=complex(exp(JP));
%     %to examine multiple steady state, plot resid as a function of jp around JP(the one we solved), we are only interested in resid between (-1,1)
%     if isempty( get( 0, 'children' ) )
%         figure( 1 ); 
%         fplot( @( jP ) max( -1, min( 1, GetResid( exp( jP ), betanl, Z, deltaItilde, eta, gamma, lambda, phiR, scriptp, scriptq, zetaR, GN, scriptFI, sigma, xi, d, b, alphaND, alphaD, alphah, alphaCD, alphaCG, alphaCP ) ) ), [ log( JP ) - 5, log( JP ) + 5 ] );
%         drawnow;
%     end
end

function Resid = GetResid( JP, betanl, Z, deltaItilde, eta, gamma, lambda, phiR, scriptp, scriptq, zetaR, GN, scriptFI, sigma, xi, d, b, alphaND, alphaD, alphah, alphaCD, alphaCG, alphaCP )
    muP = lambda .* eta .* JP ./ ( JP - ( 1 - eta ) );                                                                              %mark-up
    omegaP = JP .* ( 1 - eta ) ./ ( JP - ( 1 - eta ) ) .^ 2 ./ ( 1 + muP );                                                         %auxilary variable in FOC of asymmetric pricing, measure of incentive to deviate from symmetric eq
    scriptdP = 1 - omegaP ./ ( 1 + omegaP ) .* ( lambda - muP ) .* ( muP - eta .* lambda ) ./ lambda ./ ( 1 - eta ) ./ muP;         %auxilary variable in research foc etc
    ScriptFRP = muP .* scriptp ./ ( scriptdP - muP .* scriptp .* gamma ) ./ Z;                                                      %research foc and free entry of engineering
    GAs = ( 1 + gamma .* Z .* ScriptFRP ) .^ ( 1 ./ gamma );                                                                        %research output
    GERP = ( GAs .^ ( b * phiR - zetaR ) .* GN .^ phiR ) .^ ( 1 ./ ( 1 - phiR ) );                                                  %def

    a=b+1;
    gCDn = GN .* GAs .^ ( d .* alphaD .* alphah );
    gCNDn = GN .* GAs .^ ( d .* alphaND );
    gCDBarn = gCDn ./ gCNDn;
    gCPn = gCDBarn .^ alphaCD .* gCNDn;
    gCGn = GN .* GAs .^ ( d .* alphaCG );
    gCPBarn = gCPn ./ gCGn;
    gCn = gCPBarn .^ alphaCP .* gCGn;
    gVn = gCn .* GN .^ ( xi ./ ( 1 - sigma ) - 1 );
    glambda_Cn = GN .^ ( xi ./ ( 1 - sigma ) - 1 );
    glambda_CPBarn = gCn ./ gCPBarn * glambda_Cn;
    glambda_CPn = glambda_CPBarn ./ gCGn;
    glambda_Bn = glambda_CPn .* GAs .^ ( alphaCD .* ( d .* alphaD .* alphah - d .* alphaND ) - a + d .* alphaND );
    Xi = betanl .* gVn .^ -sigma .* glambda_Bn;
    
    Resid = ( 1 - ( 1 - scriptq ) .* ( 1 - deltaItilde ) .* Xi .* GAs ./ GERP ) .* scriptFI - ( 1 - scriptp ) ./ scriptp .* ScriptFRP .* JP; %inventor's value and zero profit of invention
end

function JP = GetApproxJP( betanl, Z, deltaItilde, eta, gamma, lambda, phiR, scriptp, scriptq, zetaR, GN, scriptFI, sigma, xi, d, b, alphaND, alphaD, alphah, alphaCD, alphaCG, alphaCP )
    muP = lambda * eta;
    ScriptFRP = muP * scriptp / ( 1 - muP * scriptp * gamma ) ./ Z;
    GAs = ( 1 + gamma .* Z .* ScriptFRP ) .^ ( 1 ./ gamma );
    GERP = ( GAs .^ ( b * phiR - zetaR ) .* GN .^ phiR ) .^ ( 1 ./ ( 1 - phiR ) );

    a=b+1;
    gCDn = GN .* GAs .^ ( d .* alphaD .* alphah );
    gCNDn = GN .* GAs .^ ( d .* alphaND );
    gCDBarn = gCDn ./ gCNDn;
    gCPn = gCDBarn .^ alphaCD .* gCNDn;
    gCGn = GN .* GAs .^ ( d .* alphaCG );
    gCPBarn = gCPn ./ gCGn;
    gCn = gCPBarn .^ alphaCP .* gCGn;
    gVn = gCn .* GN .^ ( xi ./ ( 1 - sigma ) - 1 );
    glambda_Cn = GN .^ ( xi ./ ( 1 - sigma ) - 1 );
    glambda_CPBarn = gCn ./ gCPBarn * glambda_Cn;
    glambda_CPn = glambda_CPBarn ./ gCGn;
    glambda_Bn = glambda_CPn .* GAs .^ ( alphaCD .* ( d .* alphaD .* alphah - d .* alphaND ) - a + d .* alphaND );
    Xi = betanl .* gCn .^ -sigma .* glambda_Bn;
    
    JP = ( 1 - ( 1 - scriptq ) * ( 1 - deltaItilde ) * Xi * GAs / GERP ) * scriptFI / ( 1 - scriptp ) * scriptp / ScriptFRP;

end
