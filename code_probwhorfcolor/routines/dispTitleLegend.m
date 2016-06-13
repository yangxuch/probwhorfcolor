function dispTitleLegend(tlab,llab)

title(tlab,'fontsize',15)

if ~isempty(llab)
    legend(llab,2)
    legend boxoff
end

end