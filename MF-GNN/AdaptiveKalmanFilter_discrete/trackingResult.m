clear all;
format long;
% addpath('functions');
load data\circleTrackingData.mat;
load data\circleParameter.mat
global d;
d = 0.05;


number = Td/step+1;
actualPosition = zeros(number,3);
Error = zeros(number,3);
% *************** D-H parameters of the Jaco2 manipulator
% the end-effector is the finger
% D = [0.2755, 0.4100, 0.2073, 0.07433, 0.07433, 0.1687, 0.0098]; %D1~D6;E2
% the end-effector is a pen
D = [0.2755, 0.4100, 0.2073, 0.07433, 0.07433, 0.13, 0.0098]; %D1~D6;E2
pen_long=0.055;   % length of the pen
aaa = 11.0*pi/72;
ca = cos(aaa);
sa = sin(aaa);
c2a = cos(2*aaa);
s2a = sin(2*aaa);
d4b = D(3)+sa/s2a*D(4);
d5b = sa/s2a*D(4)+sa/s2a*D(5);
d6b = sa/s2a*D(5)+D(6);
alpha_i = [pi/2, pi, pi/2, 2*aaa, 2*aaa, pi];
a_i = [0, D(2), 0, 0, 0, 0];
d_i = [D(1), 0, -D(7), -d4b, -d5b, -d6b];
% *************** D-H parameters of the Jaco2 manipulator
% step = 0.01;

% %目标轨迹
% T = 0:step:20;
% % % %circle
% rdx = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*cos(T./Td.*2*pi)+iota+0.0907;
% rdy = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi);
% rdz = iota*cos(pi/6)*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi)+0.3859;

% Desired path
t = 0:step:Td;

rdx=scale*sin(2*pi*t/Td)+initPos(1);
rdy=scale*sin(4*pi*t/Td+pi/6)-0.5*scale+initPos(2);
rdz = ones(1,Td/step+1)*(0+initPos(3));


%实际轨迹
for i = 1:number
    q = U(i,1:6)';
    [px, py, pz] = ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,q);
    %
    actualPosition(i, 1:3) = [px, py, pz];
    %
    Error(i,:) = [px-rdx(i), py-rdy(i), pz-rdz(i)];
end
figure;
plot3(rdx, rdy, rdz,'r','linewidth', 2);grid on;
hold on;
plot3(actualPosition(1:10:number,1)', actualPosition(1:10:number,2)', actualPosition(1:10:number,3)','b:*','linewidth', 1);
hold off;
axis equal;

% legend('Desired path','Actual trajactory','Location','best');


legend('期望轨迹','实际轨迹','Location','best', 'fontsize', 12);
xlabel('X (m)','fontsize', 20);
ylabel('Y (m)','fontsize', 20);
zlabel('Z (m)','fontsize', 20);
% savefig('results\Circle.fig');

%
figure;
Te = 0:step:20;
plot(Te,Error(:,1)*1000','-', 'linewidth', 2);
hold on;
plot(Te,Error(:,2)'*1000,'--', 'linewidth', 2);%grid on;
plot(Te,Error(:,3)'*1000,':', 'linewidth', 2);
RMSE = round(sqrt(sum(Error(:,1).^2 + Error(:,2).^2 + Error(:,3).^2)/number)*1000, 4);
annotation = strcat('RMSE=',mat2str(RMSE),'mm');
text(6, -10, annotation, 'fontsize', 14, 'FontName', 'times new Roman');
legend('Ex','Ey','Ez','Location','best', 'FontName', 'times new Roman');
hold off;
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize', 15);
ylabel('Error (mm)', 'FontName', 'times new Roman','fontsize', 15);
% savefig('results\circleErrorKalman.fig');

% bellows
q1 = U(:, 1)'; q2 = U(:, 2)'; q3 = U(:, 3)'; q4 = U(:, 4)'; q5 = U(:, 5)'; q6 = U(:, 6)';
t = 0:step:Td;
figure;
plot(t, q1*1000, 'r-', 'linewidth', 2);
hold on;
plot(t, q2*1000, 'b--', 'linewidth', 2);
plot(t, q3*1000, 'g:', 'linewidth', 2);
plot(t, q4*1000, 'c-', 'linewidth', 2);
plot(t, q5*1000, 'm--', 'linewidth', 2);
plot(t, q6*1000, 'y:', 'linewidth', 2);
hold off;
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize', 15);
ylabel('JointAngle (mm)', 'FontName', 'times new Roman','fontsize', 15);
legend('${\theta}_1$', '${\theta}_2$', '${\theta}_3$','${\theta}_4$', '${\theta}_5$', '${\theta}_6$','interpreter','latex', 'FontName', 'times new Roman');
% savefig('results\circleBellowsKalman.fig');

