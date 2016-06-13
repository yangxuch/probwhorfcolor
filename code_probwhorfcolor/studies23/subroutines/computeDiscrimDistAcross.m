function [BiasL,BiasR] = computeDiscrimDistAcross...
    (pairAcross,est,stim,cm,bound,cutpt)

np = size(pairAcross);

% Target = left
BiasL = pairAcross;
for j = 1:np
    reconstr = est(find(stim==pairAcross(j,1)));
    BiasL(j,:) = exp(-[abs(reconstr-pairAcross(j,1)) abs(reconstr-pairAcross(j,2))]);
end

% Target = right
BiasR = pairAcross;
for j = 1:np
    reconstr = est(find(stim==pairAcross(j,2)));
    BiasR(j,:) = exp(-[abs(reconstr-pairAcross(j,2)) abs(reconstr-pairAcross(j,1))]);
end

end