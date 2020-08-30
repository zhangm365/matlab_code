clear;
format long;
load data\INITdata210.mat;
load data\parameter210.mat;

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
rdx = iota*cos(2*pi*sin(0.5*pi*T/Td).^2)-iota+0.03535;
rdy = iota*cos(pi/6)*sin(2*pi*sin(0.5*pi*T/Td).^2)+0.00000;
rdz = iota*sin(pi/6)*sin(2*pi*sin(0.5*pi*T/Td).^2)+0.75175;
%rhodonea
% rdx = iota*cos(4*pi*sin(0.5*pi*T/Td).^2).*cos(2*pi*sin(0.5*pi*T/Td).^2)-iota+0.0907;
% rdy = iota*cos(pi/6)*cos(4*pi*sin(0.5*pi*T/Td).^2).*sin(2*pi*sin(0.5*pi*T/Td).^2)+0.00001;
% rdz = iota*sin(pi/6)*cos(4*pi*sin(0.5*pi*T/Td).^2).*sin(2*pi*sin(0.5*pi*T/Td).^2)+0.3859;

%Êµ¼Ê¹ì¼£
for i = 1:length(t)
    if (rem(i, inteval)==0)
        q = y(i,1:7)';
        index = index + 1;
        [px, py, pz] = position(q);
        %Ä©¶Ë
        pos(index, 1:3) = [px(7), py(7), pz(7)];
        %Îó²î
        Error(index,:) = [px(7)-rdx(i), py(7)-rdy(i), pz(7)-rdz(i)];
    end
end
figure;
plot3((1e+3)*(pos(1:number,1)'), (1e+3)*(pos(1:number,2)'), (1e+3)*(pos(1:number,3)'),'r:*');grid on;
hold on;
plot3((1e+3)*rdx, (1e+3)*rdy, (1e+3)*rdz,'b'); 
legend('Actual trajactory','Desired trajactory','Location','best');

hold off;

xlabel('X (mm)');
ylabel('Y (mm)');
zlabel('Z (mm)');
% savefig('result\circleTrack_500.fig');

%Îó²î·ÖÎö
figure;
Te = 0:step*inteval:20;
plot(Te,(1e+3)*([0;Error(:,1)]'),'-');grid on;
% plot(Te,Error(:,1)','-');
hold on;
plot(Te,(1e+3)*[0;Error(:,2)]','-');
% plot(Te,Error(:,2)','--');grid on;
hold on;
plot(Te,(1e+3)*[0;Error(:,3)]','-');
% plot(Te,Error(:,3)','-.');
legend('Ex','Ey','Ez','Location','best');
hold off;
xlabel('t (s)');
ylabel('error (mm)');

title(['\gamma=', num2str(gamma_t), ',  \mu=', num2str(mu_t)]);
% savefig('result\errorCircle_50.fig');

