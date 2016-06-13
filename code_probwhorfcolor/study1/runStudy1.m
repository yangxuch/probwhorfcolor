
close all
clear all

addpath ../routines/

load ../fit_naming/fitted_naming.mat

% Get data from the experiments
[s_name,s_reconstr,rSim,rDel,nsubj,nrun,sinds,p_C_s] = getExpData(1);

% Reorganize stimuli for all subjects and runs
s_reconstr_aug = repmat(s_reconstr,nsubj * nrun,1);
npt = length(s_reconstr);

[paramsInt] = initializeModelsOneparam(meanvec,sigvec);
[paramsNull,params1catG,params1catB] = initializeModelsBaselineOneparam(meanvec,sigvec);

% Loop over simul and delay conditions
for i = 1:2
    
    if i == 1 disp('_________'); disp('Simultaneous condition')
    else disp('_________'); disp('Delayed condition');  end
    
    if i == 1
        Re = reshape(rSim,nsubj*nrun*npt,1);
        p_C_s = repmat(p_C_s,1,nsubj*nrun);
    else
        Re = reshape(rDel,nsubj*nrun*npt,1);
    end
    
    meanbias = mean(reshape(Re-s_reconstr_aug,npt,nsubj*nrun),2);
    sdbias = std((reshape(Re-s_reconstr_aug,npt,nsubj*nrun))')'/sqrt(nsubj*nrun)*2;
    
    % Null
    [loglikeNull,optparamsNull] = fitModelOneparam...
        (Re,s_reconstr_aug,p_C_s,[paramsNull.sigm],...
        paramsNull.lb,paramsNull.ub,0,@fitModelNull);
    loglikeNull = - loglikeNull;
    
    figure(1)
    subplot(2,2,i)
    plotBias(s_reconstr,meanbias,sdbias)
    [ pred ] = predModelNull(s_reconstr_aug,[optparamsNull]);
    predbias=plotPredMeanVar(s_reconstr,s_reconstr_aug,pred,1,0,nsubj,nrun,npt);
    plotMeans(ylim,meanvec,sigvec)
    if i == 1
        dispTitleLegend('Null',{'Empirical','Fitted'})
    else
        dispTitleLegend('Null','')
    end
    
    % 1cat (green)
    [loglike1catG,optparams1catG] = fitModelOneparam...
        (Re,s_reconstr_aug,p_C_s,[params1catG.sigm],...
        params1catG.lb,params1catG.ub,[meanvec(1) sigvec(1)],@fitModel1catOneParam);
    loglike1catG = - loglike1catG;
    
    figure(2)
    subplot(2,2,i)
    plotBias(s_reconstr,meanbias,sdbias)
    [ pred ] = predModel1cat(s_reconstr_aug,[optparams1catG sigvec(1) meanvec(1)]);
    predbias=plotPredMeanVar(s_reconstr,s_reconstr_aug,pred,1,0,nsubj,nrun,npt);
    plotMeans(ylim,meanvec,sigvec)
    dispTitleLegend('1cat(G)','')
    
    % 1cat (blue)
    [loglike1catB,optparams1catB] = fitModelOneparam...
        (Re,s_reconstr_aug,p_C_s,[params1catB.sigm],...
        params1catB.lb,params1catB.ub,[meanvec(2) sigvec(2)],@fitModel1catOneParam);
    loglike1catB = - loglike1catB;
    
    figure(2)
    subplot(2,2,i+2)
    plotBias(s_reconstr,meanbias,sdbias)
    [ pred ] = predModel1cat(s_reconstr_aug,[optparams1catB sigvec(2) meanvec(2)]);
    predbias=plotPredMeanVar(s_reconstr,s_reconstr_aug,pred,1,0,nsubj,nrun,npt);
    plotMeans(ylim,meanvec,sigvec)
    dispTitleLegend('1cat(B)','')
    
    figure(1)
    
    % Int
    [loglikeInt,optparamsInt] = fitModelOneparam...
        (Re,s_reconstr_aug,p_C_s,[paramsInt.sigm],...
        paramsInt.lb,paramsInt.ub,[paramsInt.priorcats paramsInt.means paramsInt.sigs],@fitModelIntOneparam);
    loglikeInt = - loglikeInt;
    
    subplot(2,2,i + 2)
    plotBias(s_reconstr,meanbias,sdbias)
    [ pred,pred_ub,pred_lb ] = predModelInt(s_reconstr_aug,p_C_s, [optparamsInt sigvec meanvec],paramsInt.priorcats);
    predbias=plotPredMeanVar(s_reconstr,s_reconstr_aug,pred,pred_ub,pred_lb,nsubj,nrun,npt);
    plotMeans(ylim,meanvec,sigvec)
    dispTitleLegend('Int','')
    
end
