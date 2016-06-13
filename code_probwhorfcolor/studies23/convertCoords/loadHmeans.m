function [cm] = loadHmeans(stimline,coordopt)
% Himba prototypes


cmlab = {'5Y','10G'};


cm = zeros(1,2);

if coordopt == 1 %cielab
    load ../data/coordinates_S2and3.mat
    for i = 1:2
        ind = strmatch(cmlab{i},Munsellc,'exact');
        cm(i) = stimline(ind);
    end
end