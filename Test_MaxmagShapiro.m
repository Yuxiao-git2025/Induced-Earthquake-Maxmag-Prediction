Qc=5000;
Sigma=-1.5;
b=[0.6 0.8 1];
M=2:0.1:6;
col=Fun_Mycolor2024;
for i=1:3
    P=1-exp(-Qc*10.^(Sigma-b(i)*M));
    h(i)=plot(M,P,'LineWidth',2.5,'Color',col(i,:),'Marker','diamond','MarkerSize',8);
    h(i).DisplayName=sprintf('b=%.1f',b(i));
    Fun_Decorat;
    legend('FontSize',26);
    grid;
    hold on;
end
xlabel('Mag'); ylabel('Pro');
title('$$\Sigma=-1.5~~\Delta V=5000m^3$$','Interpreter','latex');