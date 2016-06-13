function [b] = loadBbnd(stimline,coordopt)

% Berinmo boundary
bndlab = '5GY';

if coordopt == 1 %cielab
    load ../data/coordinates_S2and3.mat
    ind = strmatch(bndlab,Munsellc,'exact');
    b = stimline(ind);
end