function [m] = computeMSE(x,y)


m = mean((x-y).^2);

end