function [lvec] = logGauBatch(x,mn,ss)
% Return log likelihood of normals for a vector of observations x
% m and s being mean and sigma^2 vectors

lvec = -log(sqrt(ss*2*pi)) - (0.5./ss) .* (x-mn).^2;

end