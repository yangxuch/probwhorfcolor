function [mseval,msevec] = fitS3(coordopt,modelopt,sigvec,sigm,plotopt)

EmpResults = [[.78 .80 .63]; [.81 .79 .65];  [.84 .8 .55]];
EmpSE = [[.04 .04 .05]; [.02 .02 .03]; [.02 .02 .04]];

load optSigmaVals

res = 1;

[stimline] = getStimline(1);

mseval = [];

for EBH = 1:3
    
    stim = stimline;
    
    if EBH == 1
        bound = loadEbnd(stimline,coordopt);
        cm = loadEmeans(stimline,coordopt);
        csig = sigvec{1};
        [pairWithin,pairAcross] = loadE3pairs(stimline,coordopt);
        tlabel = 'English';
    elseif EBH == 2
        bound = loadBbnd(stimline,coordopt);
        cm = loadBmeans(stimline,coordopt);
        csig = sigvec{2};
        [pairWithin,pairAcross] = loadBpairs(stimline,coordopt);
        tlabel = 'Berinmo';
    else
        bound = loadHbnd(stimline,coordopt);
        cm = loadHmeans(stimline,coordopt);
        csig = sigvec{3};
        [pairWithin,pairAcross] = loadHpairs(stimline,coordopt);
        tlabel = 'Himba';
    end
    
    % Test
    [est] = simulReconstruct2cat(cm,csig,sigm,stim,modelopt);
    
    
    % Compute discrimination distances
    [pairAcrossBiasL,pairAcrossBiasR] = computeDiscrimDistAcross(pairAcross,...
        est,stim,cm,bound);
    
    [pairWithinGE,pairWithinPE] = computeDiscrimDistWithin(pairWithin,est,...
        stim,cm,bound);
    
    % Visualize results
    [macross mge mpe] = computeAcWiStats(pairAcrossBiasL,pairAcrossBiasR,...
        pairWithinGE,pairWithinPE);
    
    modelResults = [macross mge mpe];
    
    % Rescaling
    if res == 1
        modelResultScaled = rescaleRange(modelResults,EmpResults(EBH,:));
    else
        modelResultScaled = modelResults;
    end
    if plotopt == 1
        figure(3)
        subplot(1,3,EBH)
        bar([ EmpResults(EBH,:); modelResultScaled]);
    end
    mse = mean((EmpResults(EBH,:)-modelResultScaled).^2);
    
    mseval = [mseval mse];
    if plotopt == 1
        hold on
        for ii = 1:length(EmpResults(EBH,:))
            ll = line([.57+.22*ii,.57+.22*ii],...
                [EmpResults(EBH,ii)+EmpSE(EBH,ii),...
                EmpResults(EBH,ii)-EmpSE(EBH,ii)]);
            set(ll,'color','k');
        end
        if res == 1
            ylim([.4 1])
        else
            ylim([0 1]);
        end
        set(gca,'XTick',[])
        set(gca,'YTick',0:.2:1)
        if EBH == 1
            legend('Across','GE','PE'); legend boxoff
        end
        box off
        set(gca,'fontsize',15)
        if EBH == 1
            ylabel('Proportion correct','fontsize',15)
        end
        colormap gray
        title(tlabel,'fontsize',15)
        
        if res == 1
            text(1.8,-.03+.4,'Model','fontsize',15)
            text(.75,-.03+.4,'Empirical','fontsize',15)
        else
            text(1.8,-.03,'Model','fontsize',15)
            text(.75,-.03,'Empirical','fontsize',15)
        end
        
        if res == 1
            line([0.5 2.5],[.4 .4],'color','k')
        end
    end
end

msevec = mseval;
mseval = mean(mseval);