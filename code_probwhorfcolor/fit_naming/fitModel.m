function [nlP] = fitModel(s_name,goodexample,paramsOpt)
% Fit Gaussian models

addpath ../routines/

muvec = paramsOpt(1:2); sigvec = paramsOpt(3:4);
priors = [paramsOpt(5) 1-sum(paramsOpt(5))];
Xs = s_name;

% Representativeness fit
for i = 1:2
    fitGauss{i} = exp(-(Xs-muvec(i)).^2/(2*sigvec(i)^2));
end

% Compute log likelihood
lP = 0;
for i = 1:2
    MUg = mean(goodexample{i},2);
    SIG2g = ((std(goodexample{i}'))').^2;
    X = [fitGauss{i}];
    M = [MUg]; S = [SIG2g];
    lP = lP + sum(logGauBatch(X,M,S));
end
nlP = -lP;

end