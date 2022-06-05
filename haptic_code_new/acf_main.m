
% Large disturbance
clear all;
format long;
load data\ObjectPosition_g1_d01_acf1;
pd1= pd;
pa1=pa;
load data\ObjectPosition_g1_d01_acf2;
pd2= pd;
pa2=pa;
load data\ObjectPosition_g1_d01_acf2;
pd3= pd;
pa3=pa;


Error1 = pd1-pa1;
Error2 = pd2-pa2;
Error3 = pd3-pa3;

L2Error1 = sqrt(Error1(:,1).^2+Error1(:,2).^2+Error1(:,3).^2);
L2Error2 = sqrt(Error2(:,1).^2+Error2(:,2).^2+Error2(:,3).^2);
L2Error3 = sqrt(Error3(:,1).^2+Error3(:,2).^2+Error3(:,3).^2);

figure;
plot(Te, L2Error1, 'g-.', 'linewidth', 2);
hold on;
plot(Te, L2Error2, 'b:', 'linewidth', 2);
plot(Te, L2Error3, 'm--', 'linewidth', 2);


% set(gca,'YLim',[0,0.5],'fontsize',12);
set(gca,'FontSize', 18);
legend('CPSF','FAF', 'CAF', 'fontsize', 18);
xlabel('时间 (s)',  'fontsize', 18);
ylabel('误差(m)',  'fontsize', 18);