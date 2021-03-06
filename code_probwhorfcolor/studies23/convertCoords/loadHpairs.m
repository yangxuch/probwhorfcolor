function [pwi,pac] = loadHpairs(stimline,coordopt)

%himba pairs
wilabs{1} = {'7.5Y','10Y'}; 
wilabs{2} = {'7.5Y','2.5GY'}; 
wilabs{3} = {'2.5GY','5GY'};
wilabs{4} = {'10Y','5GY'};
aclabs{1} = {'5GY','7.5GY'};
aclabs{2} = {'2.5GY','7.5GY'};
aclabs{3} = {'7.5GY','10GY'};
aclabs{4} = {'7.5GY','2.5G'};


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