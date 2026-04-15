SumM0=logspace(5,15,50);
bvalue=[0.5 1 1.4];
tiledlayout(1,1,"TileSpacing","compact","Padding","compact");
nexttile;
color=[0.1490    0.1490    0.1490;0     0     1; 1.0000    0.0745    0.6510;];
for i=1:3
    b=bvalue(i);
    delta=0.1448;
    Mmax=2/3*(log10((SumM0*(3/2-b))./(b*10^9.1))+log10(10^(b*delta)-10^(-b*delta)));
    ax=gca;
    hold(ax,"on");
    plot(SumM0,Mmax,'LineWidth',2,'Color',color(i,:),'LineStyle','-','DisplayName', ...
        sprintf('b=%.1f',b));
    legend(ax,'Location','northwest','Box','on','FontSize',26);
    ax.XScale='log';
    ax.Color='w';
    Fun_defaultAxes;
    box(ax,"off");
%     grid(ax,"on");
    xlabel(ax,'$$\sum M_0$$','Interpreter','latex');
    ylabel(ax,'$$M_w^{max}$$','Interpreter','latex');
end
set(gcf,'position',[200,100,1000,700]);