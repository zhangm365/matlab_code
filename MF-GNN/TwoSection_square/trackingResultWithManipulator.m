clear;
format long;
load data\INITdata100.mat;
global d;
d = 0.05;
iota = 0.15;
Td = 10;
inteval = 50;
number = fix(length(t)/inteval);
pos = zeros(number,3);
Error = zeros(number,3);
index = 0;

step = 0.01;
%Ä¿±ê¹ì¼£

% rectangle
T = 0:step:2.49;
xdx1 = -0.03*4*T/Td+0.0907;
xdy1 = 0.06*4*T/Td+0.00001;
xdz1 = 0.01*4*T/Td+0.3859;

T = 2.5:step:4.99;
xdx2 = -0.03*4*(T-Td/4)/Td+0.0607;
xdy2 = -0.06001*4*(T-Td/4)/Td+0.06001;
xdz2 = -0.01*4*(T-Td/4)/Td+0.3959;

T = 5:step:7.49;
xdx3 = 0.03*4*(T-2*Td/4)/Td+0.0307;
xdy3 = -0.06*4*(T-2*Td/4)/Td;
xdz3 = 0.01*4*(T-2*Td/4)/Td+0.3859;  

T = 7.5:step:10;
xdx4 = 0.03*4*(T-3*Td/4)/Td+0.0607;
xdy4 = 0.06001*4*(T-3*Td/4)/Td-0.06;
xdz4 = -0.01*4*(T-3*Td/4)/Td+0.3959;


rdx = [xdx1, xdx2, xdx3, xdx4];
rdy = [xdy1, xdy2, xdy3, xdy4];
rdz = [xdz1, xdz2, xdz3, xdz4];

%Êµ¼Ê¹ì¼£

figure;
for i = 1:length(t)
    if (rem(i, inteval)==0)
        q = y(i,1:6)';
        index = index + 1;
        [px, py, pz] = position(q);
        %Ä©¶Ë
        pos(index, 1:3) = [px, py, pz];
        %Draw the track of manipulator
        drawManipulator(q);
        
        %Îó²î
        Error(index,:) = [px-rdx(i), py-rdy(i), pz-rdz(i)];
    end
end
h1 = plot3(rdx, rdy, rdz,'r'); grid on;
hold on;
h2 = plot3(pos(1:number,1)', pos(1:number,2)', pos(1:number,3)','-.o','color',[0.48, 0.50, 0.20],'MarkerFaceColor',[0.48, 0.50, 0.20]);
legend([h1, h2],'Desired path','Actual trajactory','Location','best');


hold off;

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
% savefig('result\RectangleTrackWithManipulator_10.fig');
%Îó²î·ÖÎö
figure;
Te = 0:step*inteval:10;
plot(Te,[0;Error(:,1)]','r');
% plot(Te,Error(:,1)','-');
hold on;
plot(Te,[0;Error(:,2)]','b');
% plot(Te,Error(:,2)','--');grid on;
plot(Te,[0;Error(:,3)]','g');
% plot(Te,Error(:,3)','-.');
legend('Ex','Ey','Ez','Location','best');
hold off;
xlabel('t (s)');
ylabel('error (m)');
title('\gamma = 100, \mu = 100');

