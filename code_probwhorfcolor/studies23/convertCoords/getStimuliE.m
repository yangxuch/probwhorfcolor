function [s] = getStimuliE(stimline,coordopt)

% English stimuli
sbe = {'10G','5B'};

if coordopt == 1 %cielab
    load ../data/coordinates_S2and3.mat
    ind1 = strmatch(sbe{1},Munsellc,'exact');
    ind2 = strmatch(sbe{2},Munsellc,'exact');
    s = stimline(ind1:ind2);
end