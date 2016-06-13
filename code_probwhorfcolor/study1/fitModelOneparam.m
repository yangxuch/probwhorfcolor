function [loglike, paramsOpt] = fitModelOneparam...
    (Re,St,p_C_s,paramsInitial,paramsLB,paramsUB,paramsConst,LogProbComp,paramsOptional)
% Generic linker function to fit models
% Re = reconstruction data
% St = stimulus data
% paramsInitial = initialization for parameters
% paramsLB = lower bounds for optimized parameters
% paramsUB = upper bounds for optimized parameters
% paramsConst = constant parameters (those not to be optimized)
% LogProbComp = link function to compute log probabilities of models
% paramsOptional = convergence parameters for optimization


if nargin < 9
    paramsOptional = optimset('MaxIter',1e3,'MaxFunEvals',1e3,'TolX',1e-8);
end

[paramsOpt, loglike] = ...
    fminsearchbnd(@(z) (-LogProbComp(Re,St,p_C_s,z,paramsConst)),paramsInitial,paramsLB,paramsUB,paramsOptional);

end