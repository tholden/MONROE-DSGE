@#define NumShockProcesses = length( ShockProcesses ) / 6
@#for ShockIndex in 1 : NumShockProcesses
    @#define IndexIntoShockProcesses = ShockIndex * 6 - 5
    @#define VariableName = ShockProcesses[IndexIntoShockProcesses]
    @#define Minimum = ShockProcesses[IndexIntoShockProcesses+1]
    @#define Maximum = ShockProcesses[IndexIntoShockProcesses+2]
    @#define SteadyState = ShockProcesses[IndexIntoShockProcesses+3]
    @#define Rho = ShockProcesses[IndexIntoShockProcesses+4]
    @#define Sigma = ShockProcesses[IndexIntoShockProcesses+5]
    @#if UsingGrowthSyntax
        @#define EndoVariables = EndoVariables + [ VariableName, Minimum, Maximum, "1" ]
    @#else
        @#define EndoVariables = EndoVariables + [ VariableName, Minimum, Maximum ]
    @#endif
    @#include "InternalClassifyDeclare.mod"
    @#define ShockName = "epsilon_" + VariableName
    @#define TransformedSteadyState = TransformationPrefix + SteadyState + TransformationSuffix
    @#define ExtraModelEquations = ExtraModelEquations + [ FullVariableName + " = (1-(" + Rho + ")) * " + TransformedSteadyState + " + (" + Rho + ") * " + FullVariableName + "(-1)" + " + (" + Sigma + ") * " + ShockName + ";" ]
    @#define ExtraStartSteadyStateEquations = ExtraStartSteadyStateEquations + [ VariableName + "_ = " + SteadyState + ";" ]
    varexo @{ShockName};
    @#define ExtraShockBlockLines = ExtraShockBlockLines + [ "var " + ShockName + " = 1;" ]
@#endfor
@#define IndicesStringArray = EmptyStringArray
@#define IndicesArray = EmptyNumericArray
@#if SpatialDimensions > 0
    @#define Indices = EmptyNumericArray
    @#define Depth = 0
    @#include "CreateIndicesArray.mod"
    @#define SpatialNumPoints = length( IndicesStringArray )
    @#for Point1 in 1 : SpatialNumPoints
        @#for Point2 in 1 : SpatialNumPoints
            @#include "GetDistance.mod"
            @#define ExtraModelEquations = ExtraModelEquations + [ "#Distance" + IndicesStringArray[Point1] + IndicesStringArray[Point2] + " = " + Distance + ";" ]
        @#endfor
    @#endfor
@#else
    @#define SpatialNumPoints = 0
@#endif
@#define NumSpatialShockProcesses = length( SpatialShockProcesses ) / 7
@#for ShockIndex in 1 : NumSpatialShockProcesses
    @#define IndexIntoShockProcesses = ShockIndex * 7 - 6
    @#define VariableName = SpatialShockProcesses[IndexIntoShockProcesses]
    @#define Minimum = SpatialShockProcesses[IndexIntoShockProcesses+1]
    @#define Maximum = SpatialShockProcesses[IndexIntoShockProcesses+2]
    @#define SteadyState = SpatialShockProcesses[IndexIntoShockProcesses+3]
    @#define Rho = SpatialShockProcesses[IndexIntoShockProcesses+4]
    @#define Sigma = SpatialShockProcesses[IndexIntoShockProcesses+5]
    @#define ShockFunction = SpatialShockProcesses[IndexIntoShockProcesses+6]
    @#if UsingGrowthSyntax
        @#for Point in 1 : SpatialNumPoints
            @#define EndoVariables = EndoVariables + [ VariableName + IndicesStringArray[Point], Minimum, Maximum, "1" ]
        @#endfor
    @#else
        @#for Point in 1 : SpatialNumPoints
            @#define EndoVariables = EndoVariables + [ VariableName + IndicesStringArray[Point], Minimum, Maximum ]
        @#endfor
    @#endif
    @#include "InternalClassifyDeclare.mod"
    @#define ShockName = "epsilon_" + VariableName
    @#define TransformedSteadyState = TransformationPrefix + SteadyState + TransformationSuffix
    @#for Point1 in 1 : SpatialNumPoints
        @#for Point2 in ( Point1 + 1 ) : SpatialNumPoints
            @#include "GetDistance.mod"
            @#define InputString = ShockFunction
            @#define ReplacementString = "( " + Distance + " )"
            @#include "PerformReplacement.mod"
            @#define ExtraShockBlockLines = ExtraShockBlockLines + [ "corr " + ShockName + IndicesStringArray[Point1] + ", " + ShockName + IndicesStringArray[Point2] + " = " + OutputString + ";" ]
        @#endfor
        @#define ExtraModelEquations = ExtraModelEquations + [ FullVariableName + IndicesStringArray[Point1] + " = (1-(" + Rho + ")) * " + TransformedSteadyState + " + (" + Rho + ") * " + FullVariableName + IndicesStringArray[Point1] + "(-1) + (" + Sigma + ") * " + ShockName + IndicesStringArray[Point1] + ";" ]
        @#define ExtraStartSteadyStateEquations = ExtraStartSteadyStateEquations + [ VariableName + IndicesStringArray[Point1] + "_ = " + SteadyState + ";" ]
        varexo @{ShockName + IndicesStringArray[Point1]};
        @#define ExtraShockBlockLines = ExtraShockBlockLines + [ "var " + ShockName + IndicesStringArray[Point1] + " = 1;" ]
    @#endfor
@#endfor
@#define NumSpatialDiffusionShockProcesses = length( SpatialDiffusionShockProcesses ) / 9
@#for ShockIndex in 1 : NumSpatialDiffusionShockProcesses
    @#define IndexIntoShockProcesses = ShockIndex * 9 - 8
    @#define VariableName = SpatialDiffusionShockProcesses[IndexIntoShockProcesses]
    @#define Minimum = SpatialDiffusionShockProcesses[IndexIntoShockProcesses+1]
    @#define Maximum = SpatialDiffusionShockProcesses[IndexIntoShockProcesses+2]
    @#define SteadyState = SpatialDiffusionShockProcesses[IndexIntoShockProcesses+3]
    @#define Rho = SpatialDiffusionShockProcesses[IndexIntoShockProcesses+4]
    @#define Sigma = SpatialDiffusionShockProcesses[IndexIntoShockProcesses+5]
    @#define DiffusionAmount = SpatialDiffusionShockProcesses[IndexIntoShockProcesses+6]
    @#define DiffusionFunction = SpatialDiffusionShockProcesses[IndexIntoShockProcesses+7]
    @#define ShockFunction = SpatialDiffusionShockProcesses[IndexIntoShockProcesses+8]
    @#if UsingGrowthSyntax
        @#for Point in 1 : SpatialNumPoints
            @#define EndoVariables = EndoVariables + [ VariableName + IndicesStringArray[Point], Minimum, Maximum, "1" ]
        @#endfor
    @#else
        @#for Point in 1 : SpatialNumPoints
            @#define EndoVariables = EndoVariables + [ VariableName + IndicesStringArray[Point], Minimum, Maximum ]
        @#endfor
    @#endif
    @#include "InternalClassifyDeclare.mod"
    @#define ShockName = "epsilon_" + VariableName
    @#define TransformedSteadyState = TransformationPrefix + SteadyState + TransformationSuffix
    @#for Point1 in 1 : SpatialNumPoints
        @#define Integral = "( 0"
        @#if ( SpatialShape[1] == "P" ) || ( Point1 == 1 )
            @#define DefineKappa = 1
            @#define KappaIndicesString = IndicesStringArray[Point1]
            @#define NewModelEquation = "#kappa_" + FullVariableName + KappaIndicesString + " = ( 0"
        @#else
            @#define DefineKappa = 0
        @#endif
        @#for Point2 in 1 : SpatialNumPoints
            @#define InputString = DiffusionFunction
            @#define ReplacementString = "Distance" + IndicesStringArray[Point1] + IndicesStringArray[Point2]
            @#include "PerformReplacement.mod"
            @#define Integral = Integral + " + ( " + OutputString + " ) * " + FullVariableName + IndicesStringArray[Point2] + "(-1)"
            @#if DefineKappa
                @#define NewModelEquation = NewModelEquation + " + ( " + OutputString + " )"
            @#endif
            @#if Point1 < Point2
                @#include "GetDistance.mod"
                @#define InputString = ShockFunction
                @#define ReplacementString = "( " + Distance + " )"
                @#include "PerformReplacement.mod"
                @#define ExtraShockBlockLines = ExtraShockBlockLines + [ "corr " + ShockName + IndicesStringArray[Point1] + ", " + ShockName + IndicesStringArray[Point2] + " = " + OutputString + ";" ]
            @#endif
        @#endfor
        @#define Integral = Integral + " ) / ( " + Numbers[SpatialPointsPerDimension+1] + " ^ " + Numbers[SpatialDimensions+1] + " )"
        @#if DefineKappa
            @#define NewModelEquation = NewModelEquation + " ) / ( " + Numbers[SpatialPointsPerDimension+1] + " ^ " + Numbers[SpatialDimensions+1] + " );"
            @#define ExtraModelEquations = ExtraModelEquations + [ NewModelEquation ]
        @#endif
        @#define ExtraModelEquations = ExtraModelEquations + [ FullVariableName + IndicesStringArray[Point1] + " = (1-(" + Rho + ")) * " + TransformedSteadyState + " + (" + Rho + ") * ( (1-(" + DiffusionAmount + ")) * " + FullVariableName + IndicesStringArray[Point1] + "(-1) + (" + DiffusionAmount + ") * ( " + Integral + " ) / kappa_" + FullVariableName + KappaIndicesString + " ) " + " + (" + Sigma + ") * " + ShockName + IndicesStringArray[Point1] + ";" ]
        @#define ExtraStartSteadyStateEquations = ExtraStartSteadyStateEquations + [ VariableName + IndicesStringArray[Point1] + "_ = " + SteadyState + ";" ]
        varexo @{ShockName + IndicesStringArray[Point1]};
        @#define ExtraShockBlockLines = ExtraShockBlockLines + [ "var " + ShockName + IndicesStringArray[Point1] + " = 1;" ]
    @#endfor
@#endfor
