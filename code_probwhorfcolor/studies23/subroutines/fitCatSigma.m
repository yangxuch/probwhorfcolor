function [cutptdiff,ind] = fitCatSigma(cm,bound,stim,optparam)
% Fit variances/sds based on boundary and prototypes

sig1 = optparam(1);
sig2 = optparam(2);

cat1pdf = exp(-(stim-cm(1)).^2/(2*sig1^2));
cat2pdf = exp(-(stim-cm(2)).^2/(2*sig2^2));
catsum = cat1pdf+cat2pdf;
cat1pdf = cat1pdf./catsum; cat2pdf = cat2pdf./catsum;
ind = stim(find((cat1pdf-cat2pdf)<0,1));
cutptdiff = abs(ind-bound);

end