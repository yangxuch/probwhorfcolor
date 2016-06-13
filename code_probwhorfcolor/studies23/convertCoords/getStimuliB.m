function [s] = getStimuliB(stimline,coordopt)

% Berinmo stimuli
sbe = {'7.5Y','2.5G'};

if coordopt == 1 %cielab
    load ../data/coordinates_S2and3.mat
    ind1 = strmatch(sbe{1},Munsellc,'exact');
    ind2 = strmatch(sbe{2},Munsellc,'exact');
    s = stimline(ind1:ind2);
end