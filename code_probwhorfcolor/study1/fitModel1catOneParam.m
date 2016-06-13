function [ lP ] = fitModel1catOneParam(xs, stims,p_C_s, paramsOpt, paramsConst)
% Max model
% xs = reconstruction vector
% stims = stimulus vector
% sigm = memory sigma (scalar)
% muc = category mean
% sigc =category standard deviation

muc = paramsConst(1);
sigc = paramsConst(2);
sigm = paramsOpt(1);

sigsumsqr = ( sigc^2 + sigm^2 );
SigVal = ( sigc^2 * sigm^2 ) / sigsumsqr;
MUvec = ( (sigc^2)*stims + (sigm^2)*muc ) / sigsumsqr;

lP = sum(logGauBatch(xs,MUvec,SigVal*ones(length(stims),1)));


end