function [paramsNull,params1catG,params1catB] =...
    initializeModelsBaselineOneparam(meanvec,sigvec,sigInitial)
% Initialize baseline model parameters

if nargin < 3
    sigInitial = .1;
end

paramsNull.sigm = sigInitial; paramsNull.lb = 0; paramsNull.ub = 1;

params1catG.sigm = sigInitial; params1catG.means = meanvec(1);
params1catG.sigs = sigvec(1);
params1catG.lb = 0; params1catG.ub = 1;

params1catB.sigm = sigInitial; params1catB.means = meanvec(2);
params1catB.sigs = sigvec(2);
params1catB.lb = 0; params1catB.ub = 1;


end