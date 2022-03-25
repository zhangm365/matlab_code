clear;
format long;
load data/INITdata10.mat;
addpath('functions');

%Jaco机械臂模型参数
%末端指尖
% D = [0.2755, 0.4100, 0.2073, 0.07433, 0.07433, 0.1687, 0.0098]; %D1~D6;E2
%末端为笔
D = [0.2755, 0.4100, 0.2073, 0.07433, 0.07433, 0.13, 0.0098]; %D1~D6;E2
pen_long=0.055;                                 %笔长
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


steps = Td/tau+1;
interval = round(steps/1000);
interval2 = round(steps/50);

pos = zeros(steps,3);
jointPos = zeros(6,3,steps);
Error = zeros(steps,3);
index = 0;

% Actual trajectory
for i = 1:steps
    [px, py, pz] = ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,theta(:,i));
    % Trajectory of the links
    jointPos(:,1,i) = px(1:6);
    jointPos(:,2,i) = py(1:6);
    jointPos(:,3,i) = pz(1:6);
    pos(i, 1:3) = [px(7), py(7), pz(7)];
   
end

figure;
% Desired path
pd = plot3(rd(1,1:interval2:steps),rd(2,1:interval2:steps),rd(3,1:interval2:steps), 'LineWidth',2);hold on;
for j=1:interval2:steps
    basejoint1=line('xdata',[jointPos(1,1,j);jointPos(2,1,j)],'ydata',[jointPos(1,2,j);jointPos(2,2,j)],'zdata',[jointPos(1,3,j);jointPos(2,3,j)],'color', 'k','linewidth',4);
    joints12=line('xdata',[jointPos(2,1,j);jointPos(3,1,j)],'ydata',[jointPos(2,2,j);jointPos(3,2,j)],'zdata',[jointPos(2,3,j);jointPos(3,3,j)],'color', 'red');
    joints23=line('xdata',[jointPos(3,1,j);jointPos(4,1,j)],'ydata',[jointPos(3,2,j);jointPos(4,2,j)],'zdata',[jointPos(3,3,j);jointPos(4,3,j)],'color', 'cyan');
    joints34=line('xdata',[jointPos(4,1,j);jointPos(5,1,j)],'ydata',[jointPos(4,2,j);jointPos(5,2,j)],'zdata',[jointPos(4,3,j);jointPos(5,3,j)],'color', 'magenta');
    joints45=line('xdata',[jointPos(5,1,j);jointPos(6,1,j)],'ydata',[jointPos(5,2,j);jointPos(6,2,j)],'zdata',[jointPos(5,3,j);jointPos(6,3,j)],'color', 'blue');
    joints56=line('xdata',[jointPos(6,1,j);pos(j,1)],'ydata',[jointPos(6,2,j);pos(j,2)],'zdata',[jointPos(6,3,j);pos(j,3)],'color', 'green');
    drawnow
end

grid on;
hold off;
axis equal;
view(3);
legend(pd,'Desired trajectory', 'best', 'FontName', 'times new Roman', 'fontsize', 24);
set(gca,'FontSize', 24);
xlabel('X (m)', 'FontName', 'times new Roman','fontsize',26);
ylabel('Y (m)', 'FontName', 'times new Roman','fontsize',26);
zlabel('Z (m)', 'FontName', 'times new Roman','fontsize',26);