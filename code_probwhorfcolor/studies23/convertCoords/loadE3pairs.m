function [pwi,pac] = loadE3pairs(stimline,coordopt)

%english pairs study 3
wilabs{1} = {'2.5B','5B'}; 
wilabs{2} = {'10G','2.5BG'}; 
wilabs{3} = {'10BG','5B'};
wilabs{4} = {'10G','5BG'};
aclabs{1} = {'7.5BG','10BG'};
aclabs{2} = {'5BG','7.5BG'};
aclabs{3} = {'7.5BG','2.5B'};
aclabs{4} = {'5BG','10BG'};


pwi = zeros(length(wilabs),2);
pac = zeros(length(aclabs),2);

if coordopt == 1 %cielab
    load ../data/coordinates_S2and3.mat
    for i = 1:length(wilabs)
        for j = 1:2
            ind = strmatch(wilabs{i}{j},Munsellc,'exact');
            pwi(i,j) = stimline(ind);
        end
    end
    for i = 1:length(aclabs)
        for j = 1:2
            ind = strmatch(aclabs{i}{j},Munsellc,'exact');
            pac(i,j) = stimline(ind);
        end
    end
end