function [ lP ] = fitModelNull(xs, stims, p_C_s, paramsOpt, paramsConst)
% Max model
% xs = reconstruction vector
% stims = stimulus vector
% sigm = memory sigma (scalar)


sigm = paramsOpt(1);

lP = sum(logGauBatch(xs,stims,sigm^2*length(stims)));


end