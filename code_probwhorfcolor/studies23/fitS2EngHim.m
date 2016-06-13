function [mseval,msevec] = fitS2EngHim(coordopt,modelopt,sigvec,sigm,plotopt)

meanAcrossAggre = zeros(1,4);

res = 1;

[stimline] = getStimline(1);

mseval = [];

for EH = [3 2 1 4] % 1 - Him-GB; 2 - Him-DH; 3 - Eng-GB; 4 - Eng-DH
    
    stim = stimline;
    
    if EH == 3
        bound = loadEbnd(stimline,coordopt);
        cm = loadEmeans(stimline,coordopt);
        csig = sigvec{1};
        [pairWithin,pairAcross] = loadE2pairs(stimline,coordopt);
        tlabel = 'English (GB)';
    elseif EH == 2
        bound = loadHbnd(stimline,coordopt);
        cm = loadHmeans(stimline,coordopt);
        csig = sigvec{3};
        [pairWithin,pairAcross] = loadHpairs(stimline,coordopt);
        tlabel = 'Himba (DB)';
    elseif EH == 1
        bound = loadEbnd(stimline,coordopt);
        cm = loadHmeans(stimline,coordopt); % Himba prototypes
        csig = sigvec{3};
        [pairWithin,pairAcross] = loadE2pairs(stimline,coordopt);
        tlabel = 'Himba (GB)';
    elseif EH == 4
        bound = loadHbnd(stimline,coordopt);
        cm = loadEmeans(stimline,coordopt); % English prototypes
        csig = sigvec{1};
        [pairWithin,pairAcross] = loadHpairs(stimline,coordopt);
        tlabel = 'English (DB)';
    end
    
    [est] = simulReconstruct2cat(cm,csig,sigm,stim,modelopt);
    
    % Compute discrimination distances
    [pairAcrossBiasL,pairAcrossBiasR] = computeDiscrimDistAcross(pairAcross,...
        est,stim,cm,bound);
    
    [pairWithin1,pairWithin2] = computeDiscrimDistWithin(pairWithin,est,...
        stim,cm,bound);
    
    dvec = [((pairAcrossBiasL(:,1)./sum(pairAcrossBiasL,2))); ((pairAcrossBiasR(:,1)./sum(pairAcrossBiasR,2)))];
    meanAcross = mean(dvec); %sdAcross = std(dvec)/sqrt(length(dvec));
    
    pairWithin = [pairWithin1; pairWithin2];
    dvec = ((pairWithin(:,1)./sum(pairWithin,2)));
    meanWithin = mean(dvec);
    
    meanAcrossAggre(EH) = meanAcross;
    meanWithinAggre(EH) = meanWithin;
    
end


% Visualize results
modHim = [meanAcrossAggre(1) meanWithinAggre(1) meanAcrossAggre(2) meanWithinAggre(2)];
modEng = [meanAcrossAggre(3) meanWithinAggre(3) meanAcrossAggre(4) meanWithinAggre(4)];

empHim = [.59 .61 .81 .65];
empEng = [.74 .63 .73 .70];

for j = 1:2
    
    if j == 1
        if res == 1
            m = rescaleRange(modHim,empHim);
        else
            m = modHim;
        end
        e = empHim; t = 'Himba';
    else
        if res == 1
            m = rescaleRange(modEng,empEng);
        else
            m = modEng;
        end
        e = empEng; t = 'English';
    end
    if plotopt == 1
        figure(2)
        subplot(1,2,j)
        bar([ e; m])
        hold on
        
    end
    mse = mean((e-m).^2);
    mseval = [mseval mse];
    if plotopt == 1
        set(gca,'XTick',[])
        set(gca,'YTick',0:.2:1)
        box off
        set(gca,'fontsize',15)
        if j == 1
            ylabel('Proportion correct','fontsize',15)
        end
        colormap gray
        set(gca,'xtick',[])
        title(t,'fontsize',15)
        ylim([0.4 1])
        if res == 1
            text(1.9,-.03+.4,'Model','fontsize',15)
            text(.8,-.03+.4,'Empirical','fontsize',15)
        else
            text(1.9,-.03,'Model','fontsize',15)
            text(.8,-.03,'Empirical','fontsize',15)
        end
        
        line([0.5 2.5],[.4 .4],'color','k')
        
        if j == 1
            legend('Cross (Green-Blue)','Within (Green-Blue)','Cross (Dumbu-Burou)','Within (Dumbu-Burou)',1)
            legend boxoff
        end
    end
end

msevec = mseval;
mseval = mean(mseval);