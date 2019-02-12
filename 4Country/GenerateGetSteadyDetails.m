%useful when investigating SS
clear variables;

InFileName  = 'step3GetSteadyResids.m';
OutFileName = 'GetSteadyDetails.m';

FileText = fileread( InFileName );

FileText = replace( FileText, InFileName( 1 : ( end - 2 ) ), OutFileName( 1 : ( end - 2 ) ) );
FileText = replace( FileText, 'function [Resids', 'function [ MaxJPResids' );
FileText = replace( FileText, 'JP_ = GetJP', '[ JP_, MaxJPResids ] = GetJPSlow' );

File = fopen( OutFileName, 'w' );
fprintf( File, '%s', FileText );
fclose( File );

OptimiseFile( OutFileName );
