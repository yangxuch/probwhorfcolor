
clear all
close all

addpath convertCoords\
addpath subroutines\
addpath ..\routines\

siginit = [0.1    0.1];

stimfinegrain = 0:.0001:1;

coordopt = 1;
[stimline] = getStimline(1);

% Load data from Roberson's empirical studies
cmEng = loadEmeans(stimline,coordopt);
cmBer = loadBmeans(stimline,coordopt);
cmHim = loadHmeans(stimline,coordopt);
bndEng = loadEbnd(stimline,coordopt);
bndBer = loadBbnd(stimline,coordopt);
bndHim = loadHbnd(stimline,coordopt);


% Infer best sigma vector for each lg
for i = 1:3
    if i == 1
        cm = cmEng; bnd = bndEng;
    elseif i == 2
        cm = cmBer; bnd = bndBer;
    else
        cm = cmHim; bnd = bndHim;
    end
    [csig, mincutptdiff] = ...
        fminsearchbnd(@(z) (fitCatSigma(cm,bnd,stimfinegrain,z)),...
        siginit,[0 0],[1 1],optimset('MaxIter',1e3,'MaxFunEvals',1e3,'TolX',1e-8));
    sigvec{i} = csig;
    mincutptdiff
end

for j = 1:2
    
    for i = 1:3
        if i == 1
            cm = cmEng; bnd = bndEng; c = 'k';
        elseif i == 2
            cm = cmBer; bnd = bndBer; c = 'k';
        else
            cm = cmHim; bnd = bndHim; c = 'k';
        end
        subplot(3,1,i)
        hold on
        line([cm(j) cm(j)],[0 1],'color',c,'linestyle','-.')
        if j == 2
            line([bnd bnd],[0 1],'color',c,'linestyle','--')
        end
    end
    
end

for i = 1:3
    subplot(3,1,i)
    ylim([0 1]); xlim([-.1 1.1])
end

for i = 1:3
    subplot(3,1,i)
    if i == 1
        cm = cmEng; c = 'k'; title('English','fontsize',15);
    elseif i == 2
        cm = cmBer; c = 'k'; title('Berinmo','fontsize',15);
    else
        cm = cmHim; c = 'k'; title('Himba','fontsize',15);
    end
    
    gauvec = [];
    for j = 1:2
        gauvec = [gauvec; exp(-(stimline-cm(j)).^2/(2*sigvec{i}(j)^2))];
    end
    for j = 1:2
        plot(stimline,gauvec(j,:)./sum(gauvec,1),'s-','color',c,'linewidth',1.5)
    end
    if i == 1
        legend('prototype (category 1)','prototype (category 2)','boundary',3)
        legend boxoff
        ylabel('p(c|i)','fontsize',15)
    end
    set(gca,'fontsize',12)
    set(gca,'XTick',[])
end

disp(['Optimal english sigmas: ',num2str(sigvec{1}(1)),' ',num2str(sigvec{1}(2))])
disp(['Optimal berinmo sigmas: ',num2str(sigvec{2}(1)),' ',num2str(sigvec{2}(2))])
disp(['Optimal himba sigmas: ',num2str(sigvec{3}(1)),' ',num2str(sigvec{3}(2))])

%save('optSigmaVals.mat','sigvec');
