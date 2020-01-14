clear;
format long;
load data\INITdata2_circle_ACF1_n.mat;
y2 = y;
load data\parameter2_circle_ACF1_n.mat
load data\INITdata4_circle_ACF1_n.mat;
y4 = y;
load data\INITdata6_circle_ACF1_n.mat;
y6 = y;
addpath('functions');

inteval = 1;
number = fix(length(t)/inteval);
pos = zeros(number,3);
Error4 = zeros(number,3);
Error2 = zeros(number,3);
Error6 = zeros(number,3);
index = 0;

%目标轨迹
T = 0:0.01:20;
Te = 0:0.01:20;
%circle
rdx = iota*cos(2*pi*(sin(0.5*pi*T/Td)).^2)-iota+0.0917;
rdy = iota*cos(pi/6)*sin(2*pi*(sin(0.5*pi*T/Td)).^2)+0.0005;
rdz = iota*sin(pi/6)*sin(2*pi*(sin(0.5*pi*T/Td)).^2)+0.3849;

%实际轨迹
for i = 1:length(t)
    if (rem(i, inteval)==0)
        theta4 = y4(i,1:6)';
        theta2 = y2(i,1:6)';
        theta6 = y6(i,1:6)';
        index = index + 1;
        [px4, py4, pz4] = position(theta4);
        [px2, py2, pz2] = position(theta2);
        [px6, py6, pz6] = position(theta6);
        %误差
        Error4(index,:) = [px4-rdx(i), py4-rdy(i), pz4-rdz(i)]*1000;
        Error2(index,:) = [px2-rdx(i), py2-rdy(i), pz2-rdz(i)]*1000;
        Error6(index,:) = [px6-rdx(i), py6-rdy(i), pz6-rdz(i)]*1000;
    end
end

% % 二范数
L2Error4 = sqrt(Error4(:,1).^2+Error4(:,2).^2+Error4(:,3).^2);
L2Error2 = sqrt(Error2(:,1).^2+Error2(:,2).^2+Error2(:,3).^2);
L2Error6 = sqrt(Error6(:,1).^2+Error6(:,2).^2+Error6(:,3).^2);
figure;
plot(Te, L2Error2, 'b:', 'linewidth', 2);
hold on;
plot(Te, L2Error4, 'g-.', 'linewidth', 2);
plot(Te, L2Error6, 'm-', 'linewidth', 2);


% set(gca,'YLim',[0,0.5],'fontsize',12);%X轴的数据显示范围
set(gca,'FontSize',12);
legend('\gamma = 2','\gamma = 4', '\gamma = 6','Upper bound', 'FontName', 'times new Roman','fontsize',12);
xlabel('Times (s)', 'FontName', 'times new Roman','fontsize',15);
ylabel('||e(t)||_F (mm)', 'FontName', 'times new Roman','fontsize',15);