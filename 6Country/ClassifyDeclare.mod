@#if UsingGrowthSyntax
    @#define NumEndoVariables = length( EndoVariables ) / 4
    @#define NumPureTrendEndoVariables = length( PureTrendEndoVariables ) / 2
@#else
    @#define NumEndoVariables = length( EndoVariables ) / 3
@#endif
@#for VariableIndex in 1 : NumEndoVariables
    @#if UsingGrowthSyntax
        @#define IndexIntoEndoVariables = VariableIndex * 4 - 3
    @#else
        @#define IndexIntoEndoVariables = VariableIndex * 3 - 2
    @#endif
    @#define VariableName = EndoVariables[IndexIntoEndoVariables]
    @#define Minimum = EndoVariables[IndexIntoEndoVariables+1]
    @#define Maximum = EndoVariables[IndexIntoEndoVariables+2]
    @#if UsingGrowthSyntax
        @#define GrowthRate = EndoVariables[IndexIntoEndoVariables+3]
    @#else
        @#define GrowthRate = "1"
    @#endif
    @#if GrowthRate == "1"
        @#include "InternalClassifyDeclare.mod"
        var @{FullVariableName};
        @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + " = " + InverseTransformationPrefix + FullVariableName + InverseTransformationSuffix + ";" ]
        @#define ExtraEndSteadyStateEquations = ExtraEndSteadyStateEquations + [ FullVariableName + " = " + TransformationPrefix + VariableName + "_" + TransformationSuffix + ";" ]
        @#define LagString = ""
        @#for Lag in 1 : MaximumLag
            @#define LagString = LagString + "_LAG"
            @#define CurrentLag = Numbers[ Lag + 1 ]
            @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + LagString + " = "  + InverseTransformationPrefix + FullVariableName + "(-" + CurrentLag + ")" + InverseTransformationSuffix + ";" ]
            @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + "_LAG" + CurrentLag + " = " + VariableName + LagString + ";" ]
        @#endfor
        @#define LeadString = ""
        @#for Lead in 1 : MaximumLead
            @#define LeadString = LeadString + "_LEAD"
            @#define CurrentLead = Numbers[ Lead + 1 ]
            @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + LeadString + " = " + InverseTransformationPrefix + FullVariableName + "(" + CurrentLead + ")" + InverseTransformationSuffix + ";" ]
            @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + "_LEAD" + CurrentLead + " = " + VariableName + LeadString + ";" ]
        @#endfor
    @#endif
@#endfor
@#if UsingGrowthSyntax
    @#for VariableIndex in 1 : NumEndoVariables
        @#define IndexIntoEndoVariables = VariableIndex * 4 - 3
        @#define VariableName = EndoVariables[IndexIntoEndoVariables]
        @#define Minimum = EndoVariables[IndexIntoEndoVariables+1]
        @#define Maximum = EndoVariables[IndexIntoEndoVariables+2]
        @#define GrowthRate = EndoVariables[IndexIntoEndoVariables+3]
        @#if GrowthRate != "1"
            @#include "InternalClassifyDeclare.mod"
            var @{FullVariableName};
            @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + " = " + InverseTransformationPrefix + FullVariableName + InverseTransformationSuffix + ";" ]
            @#define ExtraEndSteadyStateEquations = ExtraEndSteadyStateEquations + [ FullVariableName + " = " + TransformationPrefix + VariableName + "_" + TransformationSuffix + ";" ]
            @#define LagString = ""
            @#for Lag in 1 : MaximumLag
                @#define LagString = LagString + "_LAG"
                @#define CurrentLag = Numbers[ Lag + 1 ]
                @#if Lag > 1
                    @#define CurrentLagM1 = Numbers[ Lag ]
                    @#define GrowthRateProduct = GrowthRateProduct + "*" + GrowthRate + "_LAG" + CurrentLagM1
                @#else
                    @#define GrowthRateProduct = GrowthRate
                @#endif
                @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + LagString + " = ( "  + InverseTransformationPrefix + FullVariableName + "(-" + CurrentLag + ")" + InverseTransformationSuffix + " ) / ( " + GrowthRateProduct + " );" ]
                @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + "_LAG" + CurrentLag + " = " + VariableName + LagString + ";" ]
            @#endfor
            @#define LeadString = ""
            @#for Lead in 1 : MaximumLead
                @#define LeadString = LeadString + "_LEAD"
                @#define CurrentLead = Numbers[ Lead + 1 ]
                @#if Lead > 1
                    @#define GrowthRateProduct = GrowthRateProduct + "*" + GrowthRate + "_LEAD" + CurrentLead
                @#else
                    @#define GrowthRateProduct = GrowthRate + "_LEAD" + CurrentLead
                @#endif
                @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + LeadString + " = ( " + InverseTransformationPrefix + FullVariableName + "(" + CurrentLead + ")" + InverseTransformationSuffix + " ) * ( " + GrowthRateProduct + " );" ]
                @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + "_LEAD" + CurrentLead + " = " + VariableName + LeadString + ";" ]
            @#endfor
        @#endif
    @#endfor
    @#for VariableIndex in 1 : NumPureTrendEndoVariables
        @#define IndexIntoEndoVariables = VariableIndex * 2 - 1
        @#define VariableName = PureTrendEndoVariables[IndexIntoEndoVariables]
        @#define Minimum = "0"
        @#define Maximum = "Inf"
        @#define GrowthRate = PureTrendEndoVariables[IndexIntoEndoVariables+1]
        @#if GrowthRate != "1"
            @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + " = 1;" ]
            @#define LagString = ""
            @#for Lag in 1 : MaximumLag
                @#define LagString = LagString + "_LAG"
                @#define CurrentLag = Numbers[ Lag + 1 ]
                @#if Lag > 1
                    @#define CurrentLagM1 = Numbers[ Lag ]
                    @#define GrowthRateProduct = GrowthRateProduct + "*" + GrowthRate + "_LAG" + CurrentLagM1
                @#else
                    @#define GrowthRateProduct = GrowthRate
                @#endif
                @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + LagString + " = 1 / ( " + GrowthRateProduct + " );" ]
                @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + "_LAG" + CurrentLag + " = " + VariableName + LagString + ";" ]
            @#endfor
            @#define LeadString = ""
            @#for Lead in 1 : MaximumLead
                @#define LeadString = LeadString + "_LEAD"
                @#define CurrentLead = Numbers[ Lead + 1 ]
                @#if Lead > 1
                    @#define GrowthRateProduct = GrowthRateProduct + "*" + GrowthRate + "_LEAD" + CurrentLead
                @#else
                    @#define GrowthRateProduct = GrowthRate + "_LEAD" + CurrentLead
                @#endif
                @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + LeadString + " = " + GrowthRateProduct + ";" ]
                @#define ExtraModelEquations = ExtraModelEquations + [ "#" + VariableName + "_LEAD" + CurrentLead + " = " + VariableName + LeadString + ";" ]
            @#endfor
        @#endif
    @#endfor
@#endif
