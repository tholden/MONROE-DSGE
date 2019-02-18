function OptimiseFile( FileName, Comment )
% Optimises an arbitrary Matlab file.

    if nargin < 2
        Comment = '';
    end

    Changed = true;

    while Changed

        Messages = checkcode( FileName );

        FileLines = strsplit( fileread( FileName ), '\n', 'CollapseDelimiters', false );
        FileLines = regexprep( FileLines, '\s*\%.*$', '' );
        FileLines = regexprep( FileLines, '\s*\.\.\..*$', '...' );
        FileLines = regexprep( FileLines, '\s+', ' ' );
        FileLines = regexprep( FileLines, '^ ', '' );
        FileLines = regexprep( FileLines, ' $', '' );

        Comparison1 = 'The value assigned to variable';
        Comparison2 = 'Input argument ''';
        Comparison3 = 'Parse error';

        LengthComparison1 = length( Comparison1 );
        LengthComparison2 = length( Comparison2 );
        LengthComparison3 = length( Comparison3 );

        Changed = false;
        for i = 1 : length( Messages )
            Message = Messages( i );
            if length( Message.message ) > LengthComparison1 && all( Message.message( 1 : LengthComparison1 ) == Comparison1 )
                Changed = true;
                LineNumber = Message.line;
                while true
                    Line = FileLines{ LineNumber };
                    FileLines{ LineNumber } = '';
                    if contains( Line, '...' )
                        LineNumber = LineNumber + 1;
                    else
                        break
                    end
                end
            elseif length( Message.message ) > LengthComparison2 && all( Message.message( 1 : LengthComparison2 ) == Comparison2 )
                Changed = true;
                VariableName = regexprep( Message.message( ( LengthComparison2 + 1 ) : end ), '''.*$', '' );
                LineNumber = Message.line;
                FileLines{ LineNumber } = regexprep( FileLines{ LineNumber }, [ '\s*\<' VariableName '\>\s*' ], '' );
            elseif length( Message.message ) > LengthComparison3 && all( Message.message( 1 : LengthComparison3 ) == Comparison3 )
                error( 'Parse error.' );
            end
        end

        FileLines( cellfun( @isempty, FileLines ) ) = [];
        
        FileText = strjoin( FileLines, '\n' );
        FileText = regexprep( FileText, '\s*\.\.\.\s*', ' ' );
        FileText = regexprep( FileText, ',(\s*,)+', ',' );
        FileText = regexprep( FileText, '\(\s*,', '(' );
        FileText = regexprep( FileText, ',\s*\)', ')' );
        FileText = regexprep( FileText, '\(\s*\)', '' );
        
        File = fopen( FileName, 'w' );
        if isempty( Comment )
            fprintf( File, '%s', FileText );
        else
            fprintf( File, '%% %s\n\n%s', Comment, FileText );
        end
        fclose( File );
        
    end

end

