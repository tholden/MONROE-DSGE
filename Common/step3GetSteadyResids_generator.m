%%
for rep=1:20
    %find which line have unused variables
    inform=mlint('step3GetSteadyResids.m','-id');
    jj=1;
    for ii=1:size(inform,1)
        if strcmp(inform(ii).id, 'NASGU')
            line(jj,1)=inform(ii).line;
            jj=jj+1;
        end
    end
    %read file into cell
    fid = fopen('step3GetSteadyResids.m','r');
    ii = 1;
    tline = fgetl(fid);
    step21GetSteadyResids{ii,1} = tline;
    while ischar(tline)
        ii = ii+1;
        tline = fgetl(fid);
        step21GetSteadyResids{ii,1} = tline;
    end
    fclose(fid);
    %delete from the line that a unused variable appear until the line that the next ";" appear
    for ii=1:size(line,1)  
        jjbegin=line(ii);

        jjend=jjbegin;
        while isempty(strfind(step21GetSteadyResids{jjend},';'))
            jjend=jjend+1;
        end

        step21GetSteadyResids(jjbegin:jjend)=cell(jjend-jjbegin+1,1);
    end
    %write cell to .m
    fid2 = fopen('step3GetSteadyResids.m', 'w');
    for ii = 1:numel(step21GetSteadyResids)
        fprintf(fid2,'%s\n', step21GetSteadyResids{ii});
    end
    fclose(fid2);
    clear all
end