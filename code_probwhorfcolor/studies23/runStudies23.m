% Wrapper function that optimizes fit from s2 and s3 jointly

clear all
close all

addpath convertCoords\
addpath ..\routines\
addpath subroutines\

modelopt = 2; coordopt = 1;

sigmvec=.01:.01:1;

load optSigmaVals

minmse = Inf;

for i = 1:length(sigmvec)
    
    sigm = sigmvec(i);
    
    mse2a = fitS2EngBer(coordopt,modelopt,sigvec,sigm,0);
    mse2b = fitS2EngHim(coordopt,modelopt,sigvec,sigm,0);
    msenow = mean([mse2a mse2b]);
    
    if msenow < minmse
        minmse = msenow;
        sigmopt = sigm;
    end
    
end

disp('-----------------')
disp('Eng vs Ber')
[~,mseEngBer] = fitS2EngBer(coordopt,modelopt,sigvec,sigmopt,1);

disp('-----------------')
disp('Eng vs Him')
[~,mseEngHim] = fitS2EngHim(coordopt,modelopt,sigvec,sigmopt,1);

disp('-----------------')
disp('Eng vs Ber vs Him')
[~,mseEngBerHim] = fitS3(coordopt,modelopt,sigvec,sigmopt,1);


