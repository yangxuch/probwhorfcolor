function [ pred ] = predModelNull(stims, paramsOpt, paramsConst)
% Null model
% stims = stimulus vector
% sigm = memory sigma (scalar)

sigm = paramsOpt(1);


pred = stims;

end