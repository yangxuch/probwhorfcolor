function [ pred ] = predModel1cat(stims, paramsOpt, paramsConst)
% Max model
% stims = stimulus vector
% sigm = memory sigma (scalar)
% muc = category mean
% sigc = category standard deviation

muc = paramsOpt(3);
sigc = paramsOpt(2);
sigm = paramsOpt(1);

pred = ((sigc^2)*stims+(sigm.^2)*muc) / (sigc^2 + sigm.^2);


end