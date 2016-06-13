function [BiasGE,BiasPE] = computeDiscrimDistWithin...
    (pairWithin,est,stim,cm,bound)

% GE: target closer to prototype
% PE: target further to prototype

BiasGE = pairWithin; BiasPE = pairWithin; np = size(pairWithin,1);

for i = 1:np
    
    p = pairWithin(i,:);
    [~,catind] = min([mean(abs(p-cm(1))) mean(abs(p-cm(2)))]);
    
    % Near-prototype as target
    [~,tind] = min([abs(p(1)-cm(catind)) abs(p(2)-cm(catind))]);
    dind = setdiff([1 2],tind);
    reconstr = est(find(stim==p(tind)));
    % Compute target and distract abs. distances to reconstructed
    BiasGE(i,:) = exp(-[abs(reconstr-p(tind)) abs(reconstr-p(dind))]);
    
    % Near-prototype as distractor
    [~,tind1] = max([abs(p(1)-cm(catind)) abs(p(2)-cm(catind))]);
    dind1 = setdiff([1 2],tind1);
    reconstr1 = est(find(stim==p(tind1)));
    BiasPE(i,:) = exp(-[abs(reconstr1-p(tind1)) abs(reconstr1-p(dind1))]);
    
end



end