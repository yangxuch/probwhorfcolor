% Visualize naming (4afc) and bias data

clear all
close all

load ..\data\S1Data.mat
load ..\fit_naming\fitted_naming.mat

pts = .01:.01:1;

s_name = s_name_1d; s_reconstr = s_1d; sinds = 5:23;
nsubj = 20; nrun = 5;

rSim = collapseTrials(rSimGrp,nrun,nsubj);
rDel = collapseTrials(rDelGrp,nrun,nsubj);

ns = length(sinds);

figure(1)
subplot(2,4,6:7)

load ..\data\S1Data

biasSim = rSim - repmat(s_name(sinds),1,size(rSim,2)) ;
biasDel = rDel - repmat(s_name(sinds),1,size(rDel,2)) ;

% Get raw pvalues
pvec = zeros(1,ns);
for j = 1:ns
    [h,pvec(j)] = ttest2(abs(biasSim(j,:))',abs(biasDel(j,:))');
end

meanS = mean(biasSim,2); meanD = mean(biasDel,2);
sdS = std(biasSim')/sqrt(nsubj); sdD = std(biasDel')/sqrt(nsubj);
errorbar(s_name(sinds),meanS,sdS,'k','linewidth',1.5)
hold on
errorbar(s_name(sinds),meanD,sdD,'r','linewidth',1.5)
xlim([0 1])
box off
set(gca,'fontsize',12)
ylabel('Bias','fontsize',15)
for k = 1:2
    line([meanvec(k) meanvec(k)],[-.1 .1],'linestyle',':','color','k','linewidth',1.5)
end
line([0 1],[0 0],'color',[.5 .5 .5])
legend('Simultaneous','Delayed',4); legend boxoff

text(0,-.115,'Yellow','fontsize',15); text(.9,-.115,'Purple','fontsize',15)

% Bonf corr tests on pts used for modeling
for j = 1:ns
    if pvec(j) < .05/ns & j <= 15
        plot(s_name(sinds(j)),.093,'*')
    end
end

set(gca,'XTick',[])

subplot(2,4,2:3)
hold on
for k = 1:2
    if k == 1 c = 'g'; else c = 'b'; end
    errorbar(s_name,mean(CGrp{k},2),std(CGrp{k}')/sqrt(nsubj),[c,'-'],'linewidth',1.5)
    plot(pts, likelihood{k},[c,'--'],'linewidth',2)
    line([meanvec(k) meanvec(k)],[0 1],'linestyle',':','color','k','linewidth',1.5)
end
box off
set(gca,'fontsize',12)
ylabel('Goodness rating','fontsize',15)
set(gca,'XTick',[])
xlim([0 1])
text(0,-.1,'Yellow','fontsize',15); text(.9,-.1,'Purple','fontsize',15)

xlabel('Target hue','fontsize',15); set(gca,'XTick',[])