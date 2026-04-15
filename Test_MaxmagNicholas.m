% =========================================================================
% Figure 1                     PDF of Max-mag
b = 1;
Mc =2;
Ni =[5,  10,  100 , 1000];
% Ni=10;
q =0.95;
Mi =linspace(Mc, Mc + 6, 200);
% =========================================================================
arr=tiledlayout(2,1,"TileSpacing","compact","Padding","compact");
nexttile;
Fun_defaultAxes;
hold on;
colors=lines(length(Ni));

for i = 1:length(Ni)
    N = Ni(i);
    % CDF and PDF
    FM = 1 - 10.^(-b * (Mi - Mc));
    fM = b * log(10) * 10.^(-b * (Mi - Mc));
    % For largest event Mmax's PDF
    f_Mmax = N * (FM).^(N-1) .* fM;
    % Max-mag mode
    Mmax_Nicholas = Mc+(1/b)*log10(N);

    %     xline(Mi((f_Mmax==max(f_Mmax))),'LineWidth',2,'Color',colors(i,:), ...
    %         'LineStyle','-.','HandleVisibility','off');
    xline(Mmax_Nicholas,'LineWidth',2,'Color','r', ...
        'LineStyle','--','HandleVisibility','off');
    if i==1
        xline(Mmax_Nicholas,'LineWidth',2,'Color','r', ...
            'LineStyle','--','DisplayName','$$\hat M_{max}$$');
    end
    plot(Mi, f_Mmax, 'Color', colors(i, :), 'LineWidth', 2, ...
        'DisplayName', ['N = ', num2str(N)]);
end
xlabel('$$M_{max}$$','FontSize',22,'Interpreter','latex');
ylabel('$$PDF$$','FontSize',22,'Interpreter','latex');
title(arr,sprintf('b-value=%.1f',b),'fontsize',22);
legend('Interpreter','latex');
% =========================================================================
nexttile;
hold on;
Fun_defaultAxes;
for i = 1:length(Ni)
    N = Ni(i);
    Mmax_Nicholas = Mc+(1/b)*log10(N);
    dM = Mi-Mmax_Nicholas;

    FM = 1 - 10.^(-b * (Mi - Mc));
    fM = b * log(10) * 10.^(-b * (Mi - Mc));
    f_Mmax = N * (FM).^(N-1) .* fM;
    plot(dM, f_Mmax, 'Color', colors(i, :), 'LineWidth', 2, ...
        'DisplayName', ['N = ', num2str(N)],'HandleVisibility','off');
    %     M1 = Mc - (1/b) * log10(1 - q^(1/N)); % upper
    %     M2 = Mc - (1/b) * log10(1 - (1-q)^(1/N)); % lower
    %     dM1 = M1 - Mmax;
    %     dM2 = M2 - Mmax;
    dM1=-1/b*log10(-log(q));
    dM2=-1/b*log10(-log(1-q));
    if i==1
        plot([dM1, dM1], [0, max(f_Mmax)], '-.', ...
            'Color', 'k', 'LineWidth', 2.4,'DisplayName','90% Range');
        plot([dM2, dM2], [0, max(f_Mmax)], '-.', ...
            'Color', 'k', 'LineWidth', 2.4,'HandleVisibility','off');
        legend;
    end
end
xlim([-2, 3]);
xlabel('$$\Delta M$$','FontSize',22,'Interpreter','latex');
ylabel('$$PDF$$','FontSize',22,'Interpreter','latex');

%% Figure 2           Two different way to calculate Max-mag
b=1;
dV=logspace(0,8,100);
SI=-1.8;
Mmax_Nicholas=1/b*(SI+log10(dV));
plot(dV,Mmax_Nicholas,'LineWidth',2.5,'Color','r','DisplayName','$$M_{max}(Nicholas)$$');
hold on;
Fun_defaultAxes;
ax=gca;
ax.XScale='log';
G=3e10;
M0=G*dV;
Mmax_McGarr=2/3*log10(M0)-6.033;
plot(dV,Mmax_McGarr,'LineWidth',2.5,'Color','b','DisplayName','$$M_{max}(McGarr)$$');

% ==============
data=readtable('Data_McGarr.txt');
M0max=data.Var2;
Volume=data.Var3;
Mwmax=data.Var5;
scatter(Volume,Mwmax,140,'Marker','diamond','MarkerFaceColor','k','MarkerEdgeColor','k', ...
    'LineWidth',1,'DisplayName','18 Observe');
Mwmax_expect=2/3*log10(M0max)-6.033;
grid;
legend('Location','northwest','FontSize',22,'Interpreter','latex');
xlabel('$$\Delta V$$','Interpreter','latex');
ylabel('$$M_{max}$$','Interpreter','latex');
%% Figure 3
data=readtable('Table1.xlsx');
Mobs=data.MaxmagObs; % Obs
Mexp1=data.MaxmagExp;% Table data
Mc=data.Mc;
N=data.N;
Ntot=data.Ntot;
b=data.b;
V=(data.V);
Vtot=(data.Vtot);
V=cellfun(@str2double, V);
Vtot=cellfun(@str2double, Vtot);
DeltaMexp=zeros(length(Ntot),1);
for i=1:length(Ntot)
    Ntot_i=Ntot(i);
    b_i=b(i);
%     b_i=1.2;
    DeltaMexp(i)=1/b_i*( log10(Ntot_i) - 1/Ntot_i*sum(log10(1:Ntot_i)) );
end
% Calculate the expectation Max-mag
Mexp=Mc + 1./b.*log10(N) + DeltaMexp; % Exp
% Mexp=Mc + 1./b.*log10(N) + 0.4; % Exp (For larger Ntot)

% Using Injection volume
G=3e10;
MGV=2/3*log10(G*V)-6.033;
figure;
Fun_defaultAxes;
axis([0 7 0 7]);
hold on;
scatter(Mexp,Mobs,140,'Marker','diamond','MarkerFaceColor',[0 0 0], ...
    'MarkerEdgeColor','k', ...
    'LineWidth',1,'DisplayName','$$M_{exp}^{(1)}=M_{max}+\langle\Delta M_{max}\rangle$$');
scatter(MGV,Mobs,140,'Marker','square','MarkerFaceColor','c','MarkerEdgeColor','k', ...
    'LineWidth',1,'DisplayName','$$M_{exp}^{(2)}=\frac{2}{3}log_{10}(G\cdot V)-6.033$$');
% scatter(Mexp1,Mobs,140,'Marker','diamond','MarkerFaceColor','r','MarkerEdgeColor','k', ...
%     'LineWidth',1,'DisplayName','Data-Exp');
plot([0 7],[0,7],'LineWidth',2,'Color',[.5 .5 .5],'LineStyle','--','HandleVisibility','off');  
legend('Location','northwest','FontSize',20,'Interpreter','latex','Box','on');
set(gcf,'position',[300,10,800,800]);
grid;
xlabel('$$M_{exp}$$','Interpreter','latex');
ylabel('$$M_{Obs}$$','Interpreter','latex');

%% Figure 4
rat=N./Ntot;
over=(rat>=0.5);
less=~over;
figure;
tiledlayout(1,2,"TileSpacing","compact","Padding","compact");
nexttile;
hold on;
histogram(rat,10,'LineWidth',1,'FaceColor',[.5 .5 .5],'EdgeColor','w', ...
    'EdgeAlpha',0.5,'FaceAlpha',0.6);
Fun_defaultAxes;
xlabel('Ratio');
ylabel('Count');
nexttile;
[f,x,f1,f2]=ecdf(rat,"Alpha",0.05,'Function','cdf');
hold on;
J=plot(x,f*1e2,'LineWidth',3,'Color',[0 0 1],'LineStyle','-.','Marker','x', ...
    'MarkerSize',18); % Empirical
J0=plot([0 1],[0 100],'LineWidth',3,'Color','k','LineStyle','--'); % Predict
Fun_defaultAxes;
xlabel('Ratio');
ylabel('ECDF');
ax=gca;
ax.YAxisLocation="right";
%% Figure 5
figure;
hold on;
scatter(V,N,140,'Marker','diamond','MarkerFaceColor','k','MarkerEdgeColor','k', ...
    'LineWidth',1);
scatter(Vtot,Ntot,140,'Marker','square','MarkerFaceColor','c','MarkerEdgeColor','k', ...
    'LineWidth',1);
ax=gca;
ax.XScale="log";
ax.YScale="log";
Fun_defaultAxes;
xlabel('Volume');
ylabel('Number');