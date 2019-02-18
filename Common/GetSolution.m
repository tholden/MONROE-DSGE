function out = GetSolution( index )
%We need this because this is the only way to return multiple results in dynare
    global Solution
    out = Solution( index );
end
