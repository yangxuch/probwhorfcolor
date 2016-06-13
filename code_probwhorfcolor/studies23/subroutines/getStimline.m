function [stimline] = getStimline(coordopt)

if nargin < 1
    coordopt = 1;
end

if coordopt == 1
    
    load ../data/coordinates_S2and3.mat
    nstim = size(Clabc,1);
    pairwise_dist = sqrt(sum((Clabc(1:nstim-1,:) - Clabc(2:nstim,:)).^2,2));
    
    % Define stimulus (cumulative) distance
    stimline = [0; cumsum(pairwise_dist)]';
    stimline = stimline / max(stimline); % Ensure 0-1 scale
    
end

end