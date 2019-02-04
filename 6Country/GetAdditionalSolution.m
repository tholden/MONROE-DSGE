function out = GetAdditionalSolution( index )
%We need this because this is the only way to return multiple results in dynare
    global AdditionalSolution
    out = AdditionalSolution( index );
end
