function [tc] = collapseTrials(D,nrun,nsubj)

cuminds = [1:nrun:nsubj*nrun nsubj*nrun+1];
tc = [];

for i = 1:nsubj
    tc = [tc mean(D(:,cuminds(i):cuminds(i+1)-1),2)];
end


end