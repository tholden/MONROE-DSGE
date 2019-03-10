clear variables;
load RandDShareData RandDShareData coeff score;

TData = removevars( RandDShareData, 'Year' );

Data = table2array( TData );
Data = 0.01 * Data;
Data = log( Data ./ ( 1 - Data ) );

MeanData = nanmean( Data );
StdData  = nanstd( Data );
Data = ( Data - MeanData ) ./ StdData;

[ coeff, score, latent, tsquared, explained ] = ...
    pca( Data, 'NumComponents', 17, 'Algorithm', 'als', 'Centered', false, 'Coeff0', coeff, 'Score0', score, 'Options', statset( 'Display', 'iter', 'MaxIter', 1e12, 'TolFun', sqrt( eps ), 'TolX', sqrt( eps ) ) );

save RandDShareData RandDShareData coeff score;

NData = score * coeff';
NData = MeanData + StdData .* NData;

