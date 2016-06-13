function [pwi,pac] = loadE2pairs(stimline,coordopt)

%english pairs study 2
wilabs{1} = {'2.5B','5B'}; 
wilabs{2} = {'10BG','5B'}; 
wilabs{3} = {'2.5B','5BG'};
wilabs{4} = {'10G','5BG'};
aclabs{1} = {'5BG','7.5BG'};
aclabs{2} = {'2.5B','7.5BG'};
aclabs{3} = {'7.5BG','10BG'};
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