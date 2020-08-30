clear;
format long;
load data\INITdata100.mat;
load data\parameter100.mat;
global d;
d = 0.05;
iota = 0.15;
Td = 20;
% inteval = 1;
inteval = 20;
number = fix(length(t)/inteval);
pos = zeros(number,3);
Error = zeros(number,3);
index = 0;

step = 0.01;
%Ä¿±ê¹ì¼£
T = 0:step:20;
% %circle
rdx = iota*cos(2*pi*sin(0.5*pi*T/Td).^2)-iota+0.0907;
rdy = iota*cos(pi/6)*sin(2*pi*sin(0.5*pi*T/Td).^2);
rdz = iota*sin(pi/6)*sin(2*pi*sin(0.5*pi*T/Td).^2)+0.3859;
%rhodonea
% rdx = iota*cos(4*pi*sin(0.5*pi*T/Td).^2).*cos(2*pi*sin(0.5*pi*T/Td).^2)-iota+0.0907;
% rdy = iota*cos(pi/6)*cos(4*pi*sin(0.5*pi*T/Td).^2).*sin(2*pi*sin(0.5*pi*T/Td).^2)+0.00001;
% rdz = iota*sin(pi/6)*cos(4*pi*sin(0.5*pi*T/Td).^2).*sin(2*pi*sin(0.5*pi*T/Td).^2)+0.3859;

%Êµ¼Ê¹ì¼£
for i = 1:length(t)
    if (rem(i, inteval)==0)
        q = y(i,1:6)';
        index = index + 1;
        [px, py, pz] = position(q);
        %Ä©¶Ë
        pos(index, 1:3) = [px, py, pz];
        %Îó²î
        Error(index,:) = [px-rdx(i), py-rdy(i), pz-rdz(i)];
    end
end
figure;
plot3(pos(1:number,1)', pos(1:number,2)', pos(1:number,3)','r:*');grid on;
hold on;
plot3(rdx, rdy, rdz,'b'); 
legend('Actual trajactory','Desired path','Location','best');

hold off;

xlabel('X (m)');
ylabel('Y (m)');
zlabel('Z (m)');
% savefig('result\circleTrack_50.fig');

%Îó²î·ÖÎö
figure;
Te = 0:step*inteval:20;
plot(Te,[0;Error(:,1)]'*1000,'b','linewidth',2);
% plot(Te,Error(:,1)','-');
hold on;
plot(Te,[0;Error(:,2)]'*1000,'g','linewidth',2);
% plot(Te,Error(:,2)','--');grid on;
plot(Te,[0;Error(:,3)]'*1000,'r','linewidth',2);
% plot(Te,Error(:,3)','-.');
RMSE = round(sqrt(sum(Error(:,1).^2 + Error(:,2).^2 + Error(:,3).^2)/number)*1000, 4);
annotation = strcat('RMSE=',mat2str(RMSE),'mm');
text(7.5, -0.2, annotation, 'fontsize', 15, 'FontName', 'times new Roman');
% legend('Ex','Ey','Ez','Location','best');
legend('Ex','Ey','Ez','Location','best', 'FontName', 'times new Roman');
hold off;
% xlabel('t (s)');
% ylabel('error (m)');
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize', 15);
ylabel('Error (mm)', 'FontName', 'times new Roman','fontsize', 15);
title(['\gamma=', num2str(gamma_t), ',  \mu=', num2str(mu_t)],'fontsize', 15);
% savefig('result\errorCircle_50.fig');

