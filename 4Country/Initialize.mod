@#define EmptyStringArray = [ "" ] - [ "" ]
@#define EmptyNumericArray = [ 0 ] - [ 0 ]
@#include "DefineNumbers.mod"
@#ifndef MaximumLead
    @#define MaximumLead = 1
@#endif
@#ifndef MaximumLag
    @#define MaximumLag = 1
@#endif
@#ifndef EndoVariables
    @#define EndoVariables = EmptyStringArray
@#endif
@#ifndef ExtraModelEquations
    @#define ExtraModelEquations = EmptyStringArray
@#endif
@#ifndef ExtraStartSteadyStateEquations
    @#define ExtraStartSteadyStateEquations = EmptyStringArray
@#endif
@#ifndef ExtraEndSteadyStateEquations
    @#define ExtraEndSteadyStateEquations = EmptyStringArray
@#endif
@#ifndef ShockProcesses
    @#define ShockProcesses = EmptyStringArray
@#endif
@#ifndef ExtraShockBlockLines
    @#define ExtraShockBlockLines = EmptyStringArray
@#endif
@#ifndef SpatialDimensions
    @#define SpatialDimensions = 0
@#endif
@#ifndef SpatialPointsPerDimension
    @#define SpatialPointsPerDimension = 128
@#endif
@#ifndef SpatialShape
    @#define SpatialShape = "Torus"
    // The other supported option is "Plane"
@#endif
@#ifndef SpatialNorm
    @#define SpatialNorm = "2"
@#endif
@#ifndef SpatialShockProcesses
    @#define SpatialShockProcesses = EmptyStringArray
@#endif
@#ifndef SpatialDiffusionShockProcesses
    @#define SpatialDiffusionShockProcesses = EmptyStringArray
@#endif
@#ifndef SpatialFunctionLength
    @#define SpatialFunctionLength = 1024
@#endif
@#ifndef PureTrendEndoVariables
    @#define PureTrendEndoVariables = EmptyStringArray
@#endif
@#ifndef UsingGrowthSyntax
    @#define UsingGrowthSyntax = 0
@#endif
