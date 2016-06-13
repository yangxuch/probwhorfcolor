function [ pred,pred_ub,pred_lb ] = predModelInt(stims, p_C_s, paramsOpt, paramsConst)
% Integration model
% stims = stimulus vector
% sigm = memory sigma (scalar)
% muCs = vector of category means
% sigCs = vector of category standard deviations
% pCs = priors of categories

muCs = paramsOpt(4:5);
sigCs = paramsOpt(2:3);
sigm = paramsOpt(1);
pCs = paramsConst(1:2);


npt = length(stims);

Pi1 = p_C_s(1,:)';
Pi2 = p_C_s(2,:)';

% Compute log probability of data given each category
mus = muCs'; sigs = sigCs';

for cc = 1:2
    
    cinds = cc * ones(npt,1);
    
    % Denominators
    sigSumSqr = sigs(cinds).^2 + sigm^2;
    
    SigVec{cc} = ( (sigs(cinds).^2) * (sigm^2) ) ./ sigSumSqr;%(cinds);
    MUvec{cc} = ( (sigs(cinds).^2).*stims + sigm^2 * mus(cinds) ) ./ ...
        sigSumSqr;
    
end

varvec = SigVec{1} .* (Pi1.^2) + SigVec{2} .* (Pi2.^2);

pred = MUvec{1}.* Pi1 + MUvec{2} .* Pi2;
pred_ub = pred + sqrt(varvec);
pred_lb = pred - sqrt(varvec);

%}
end

