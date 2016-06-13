function [mseval,msevec] = fitS2EngBer(coordopt,modelopt,sigvec,sigm,plotopt)

meanAcrossAggre = zeros(1,4);

res = 1;

[stimline] = getStimline(1);

mseval = [];

for EB = [3 2 1 4] % 1 - Ber-GB; 2 - Ber-NW; 3 - Eng-GB; 4 - Eng-NW
    
    stim = stimline;
    
    if EB == 3
        bound = loadEbnd(stimline,coordopt);
        cm = loadEmeans(stimline,coordopt);
        csig = sigvec{1};
        [pairWithin,pairAcross] = loadE2pairs(stimline,coordopt);
        tlabel = 'English (GB)';
    elseif EB == 2
        bound = loadBbnd(stimline,coordopt);
        cm = loadBmeans(stimline,coordopt);
        csig = sigvec{2};
        [pairWithin,pairAcross] = loadBpairs(stimline,coordopt);
        tlabel = 'Berinmo (NW)';
    elseif EB == 1
        bound = loadEbnd(stimline,coordopt);
        cm = loadBmeans(stimline,coordopt); % Berinmo prototypes
        csig = sigvec{2};
        [pairWithin,pairAcross] = loadE2pairs(stimline,coordopt);
        tlabel = 'Berinmo (GB)';
    elseif EB == 4
        bound = loadBbnd(stimline,coordopt);
        cm = loadEmeans(stimline,coordopt); % English prototypes
        csig = sigvec{1};
        [pairWithin,pairAcross] = loadBpairs(stimline,coordopt);
        tlabel = 'English (NW)';
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
    
    meanAcrossAggre(EB) = meanAcross;
    meanWithinAggre(EB) = meanWithin;
    
end


% Visualize results
modBer = [meanAcrossAggre(1) meanWithinAggre(1) meanAcrossAggre(2) meanWithinAggre(2)];
modEng = [meanAcrossAggre(3) meanWithinAggre(3) meanAcrossAggre(4) meanWithinAggre(4)];

empBer = [9.5 8.88 12.63 10.25];
empEng = [13.38 11.38 11.50 12.63];
empBerSE = [.38 .52 .26 .73];
empEngSE = [.71 .42 .42 .53];

for j = 1:2
    
    if j == 1
        if res == 1
            m = rescaleRange(modBer,empBer);
        else
            m = modBer;
        end
        e = empBer; t = 'Berinmo'; se = empBerSE;
    else
        if res == 1
            m = rescaleRange(modEng,empEng);
        else
            m = modEng; se = empEngSE;
        end
        e = empEng; t = 'English';
    end
    if plotopt == 1
        figure(1)
        subplot(1,2,j)
    end
    if res == 1
        if plotopt == 1
            bar([e/16; m/16])
        end
        mse = mean((e/16-m/16).^2);
        mseval = [mseval mse];
        if plotopt == 1
            hold on
            for ii = 1:length(e)
                ll = line([.52+.191*ii,.52+.191*ii],[e(ii)+se(ii),e(ii)-se(ii)]/16);
                set(ll,'color','k');
            end
        end
    else
        if plotopt == 1
            bar([e/16; m])
        end
    end
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
            legend('Cross (Green-Blue)','Within (Green-Blue)','Cross (Nol-Wor)','Within (Nol-Wor)',1)
            legend boxoff
        end
    end
end

msevec = mseval;
mseval = mean(mseval);