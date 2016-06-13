function [b] = loadHbnd(stimline,coordopt)

% Himba boundary
bndlab = '7.5GY';

if coordopt == 1 %cielab
    load ../data/coordinates_S2and3.mat
    ind = strmatch(bndlab,Munsellc,'exact');
    b = stimline(ind);
end