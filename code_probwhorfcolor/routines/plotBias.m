function plotBias(s_reconstr,meanbias,sdbias)

errorbar(s_reconstr,meanbias,sdbias,'color','k')
ylim([-.1 .1]); xlim([0.05 .8])
box off
hold on
set(gca,'fontsize',13)

end