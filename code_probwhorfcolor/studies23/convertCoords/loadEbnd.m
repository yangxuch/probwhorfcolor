function [b] = loadEbnd(stimline,coordopt)

% English boundary
bndlab = '7.5BG';

if coordopt == 1 %cielab
    load ../data/coordinates_S2and3.mat
    ind = strmatch(bndlab,Munsellc,'exact');
    b = stimline(ind);
end