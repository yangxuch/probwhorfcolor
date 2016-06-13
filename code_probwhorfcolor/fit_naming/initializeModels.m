function [paramsInitial,paramsLB,paramsUB] = initializeModels()
% Initialize model parameters

% meanG meanB sigG sigB p(G) 
paramsInitial = [ .3 .6 .1 .1 .5]; 

paramsLB = [0 0 0 0 0]; 
paramsUB = [1 1 1 1 1];


end