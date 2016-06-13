function [macross mge mpe] = computeAcWiStats(pairAcrossBiasL,pairAcrossBiasR,...
    pairWithinGE,pairWithinPE)

macross = mean([((pairAcrossBiasL(:,1)./sum(pairAcrossBiasL,2))); ((pairAcrossBiasR(:,1)./sum(pairAcrossBiasR,2)))]);

mge = mean(((pairWithinGE(:,1)./sum(pairWithinGE,2))));

mpe = mean(((pairWithinPE(:,1)./sum(pairWithinPE,2))));


end