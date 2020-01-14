% Large disturbance
clear;
format long;
load data\INITdata5_ACF1_l.mat;
y1 = y;
load data\parameter5_ACF1_l.mat
load data\INITdata5_ACF2_l.mat;
y2 = y;
load data\INITdata5_ACF3_l.mat;
y3 = y;
load data\INITdata5_ACF5_l.mat;
y5 = y;
load data\INITdata5_ACF6_l.mat;
y6 = y;
addpath('functions');

inteval = 1;
number = fix(length(t)/inteval);
pos = zeros(number,3);
Error1 = zeros(number,3);
Error2 = zeros(number,3);
Error3 = zeros(number,3);
Error5 = zeros(number,3);
Error6 = zeros(number,3);
index = 0;

Te = 0:step:Td;
%目标轨迹
T = 0:step:Td;
xdx = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*cos(T./Td.*2*pi)+iota+90.7;
xdy = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi);
xdz = iota*cos(pi/6)*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi)+385.9;

%实际轨迹
for i = 1:length(t)
    if (rem(i, inteval)==0)
        theta1 = y1(i,1:6)';
        theta2 = y2(i,1:6)';
        theta3 = y3(i,1:6)';
        theta5 = y5(i,1:6)';
        theta6 = y6(i,1:6)';
        index = index + 1;
        [px1, py1, pz1] = position(theta1);
        [px2, py2, pz2] = position(theta2);
        [px3, py3, pz3] = position(theta3);
        [px5, py5, pz5] = position(theta5);
        [px6, py6, pz6] = position(theta6);
        %误差
        Error1(index,:) = [px1-xdx(i), py1-xdy(i), pz1-xdz(i)];
        Error2(index,:) = [px2-xdx(i), py2-xdy(i), pz2-xdz(i)];
        Error3(index,:) = [px3-xdx(i), py3-xdy(i), pz3-xdz(i)];
        Error5(index,:) = [px5-xdx(i), py5-xdy(i), pz5-xdz(i)];
        Error6(index,:) = [px6-xdx(i), py6-xdy(i), pz6-xdz(i)];
    end
end

% % 二范数
L2Error1 = sqrt(Error1(:,1).^2+Error1(:,2).^2+Error1(:,3).^2);
L2Error2 = sqrt(Error2(:,1).^2+Error2(:,2).^2+Error2(:,3).^2);
L2Error3 = sqrt(Error3(:,1).^2+Error3(:,2).^2+Error3(:,3).^2);
L2Error5 = sqrt(Error5(:,1).^2+Error5(:,2).^2+Error5(:,3).^2);
L2Error6 = sqrt(Error6(:,1).^2+Error6(:,2).^2+Error6(:,3).^2);
figure;
plot(Te, L2Error1, 'g-.', 'linewidth', 2);
hold on;
plot(Te, L2Error3, 'b:', 'linewidth', 2);
plot(Te, L2Error5, 'm--', 'linewidth', 2);
plot(Te, L2Error6, 'c-', 'linewidth', 2);


% set(gca,'YLim',[0,0.5],'fontsize',12);%X轴的数据显示范围
set(gca,'FontSize',12);
legend('LAF','NFTAF', 'CAF','PSAF', 'FontName', 'times new Roman','fontsize',12);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',15);
ylabel('||e(t)||_F (mm)', 'FontName', 'times new Roman','fontsize',15);