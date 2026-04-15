data=readtable('Data_McGarr.txt');
M0max=data.Var2;
Volume=data.Var3;
Mwmax=data.Var5;
G=3e10;
dV=logspace(0,7.5,100);
Mtheory=G*dV;
hold on;
scatter(Volume,M0max,140,'Marker','diamond','MarkerFaceColor','k','MarkerEdgeColor','k', ...
    'LineWidth',1,'DisplayName','18 Observe');
plot(dV,Mtheory,'LineWidth',2.5,'Color','b','DisplayName','$$M_{max}(McGarr)$$');
ax=gca;
ax.YScale="log";
ax.XScale="log";
Fun_defaultAxes;
legend('Location','northwest','FontSize',22,'Interpreter','latex');
grid;