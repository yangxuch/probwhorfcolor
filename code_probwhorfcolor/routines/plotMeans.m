function plotMeans(ylim,optmeans,optvars)

yl = ylim;
for i = 1:2
    line([optmeans(i) optmeans(i)],[yl(1) yl(2)],'linestyle','--','color','b')
end
set(gca,'XTick',[])

end