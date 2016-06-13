% Fit naming data

close all
clear all

addpath ../routines/


% Get naming data
load('../data/S1Data.mat');
s_name = s_name_1d;

goodexampleRaw = CGrp;

% Input parameter initializations
[paramsInitial,paramsLB,paramsUB] = initializeModels;

paramsOptional = optimset('MaxIter',1e3,'MaxFunEvals',1e3,'TolX',1e-8);

[paramsOpt, minnlP] = ...
    fminsearchbnd(@(z) (fitModel(s_name,goodexampleRaw,z)),...
    paramsInitial,paramsLB,paramsUB,paramsOptional);

meanvec = paramsOpt(1:2);
sigvec = paramsOpt(3:4);

for i = 1:2
    fitcurves{i} =exp(-(s_name-meanvec(i)).^2/(2*sigvec(i)^2));
end
NC = fitcurves{1} + fitcurves{2};
for i = 1:2
    fitP_C_s{i} = fitcurves{i} ./ NC;
end

p_C_given_s = [fitP_C_s{1}'; fitP_C_s{2}'];


for i = 1:2
    likelihood{i} = exp(-(.01:.01:1-meanvec(i)).^2/(2*sigvec(i)^2));
end


%save('fitted_naming.mat','p_C_given_s','meanvec','sigvec','likelihood')
