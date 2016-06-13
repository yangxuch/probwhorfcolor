function [scaledv] = rescaleRange(originalv,rnge)
% f(x)= (mx-mn)(x-min(x))/(max(x)-min(x)) + mn

mn = min(rnge);
mx = max(rnge);
normv = (originalv-min(originalv)) / (max(originalv)-min(originalv));
scaledv = (mx-mn) * normv + mn;

end