function [paramsInt] = initializeModelsOneparam(meanvec,sigvec,sigInitial)
% Initialize model parameters

if nargin < 3
    sigInitial = .1;
end

paramsInt.sigm = sigInitial; paramsInt.priorcats = [0.5 0.5];
paramsInt.lb = 0; paramsInt.ub = 1;

paramsInt.means = meanvec; paramsInt.sigs = sigvec;



end