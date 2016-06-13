function [s_name,s_reconstr,rSim,rDel,nsubj,nrun,sinds,p_C_s] = getExpData...
    (trunc)

load ../data/S1Data.mat;
load ../fit_naming/fitted_naming;

s_name = s_name_1d; s_reconstr = s_1d; sinds = 5:23;
rSim = rSimGrp; rDel = rDelGrp; nsubj = 20; nrun = 5;

p_C_s = p_C_given_s;

if trunc > 0
    sinds = 1:15; %+/- 3pts from the means
    s_reconstr = s_reconstr(sinds);
    p_C_s = p_C_given_s(:,sinds+offset);
    rSim = rSim(sinds,:);
    rDel = rDel(sinds,:);
    sinds = sinds + offset; % sinds should be in naming index space
end
