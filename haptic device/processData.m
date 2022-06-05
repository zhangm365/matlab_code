clear all;
close all;
load data/ObjectPosition_c2.mat
load data/JointAngle_c2.mat
load data/JointVelocity_c2.mat
joint_angle = joint_angle';
% joint_velocity = joint_velocity';

[row, col] = size(pa);

start = 600;
tail =6500;
t = 0:0.01:(tail-start)*0.01;
steps=  (tail-start)+1;

actualPath = pa(start:tail,:);
desiredPath = pd(start:tail,:);
theta = joint_angle(:,start:tail);
% dtheta = joint_velocity(:,start:tail);

interval = 50;
figure
plot3(desiredPath(1:interval:end,1), desiredPath(1:interval:end,2), desiredPath(1:interval:end,3), 'b','linewidth', 2); 
hold on;
plot3(actualPath(1:interval:end,1), actualPath(1:interval:end,2), actualPath(1:interval:end,3), 'r:*','linewidth', 1);
hold off;
axis equal;
legend('期望轨迹', '实际轨迹', 'best', 'FontName', 'times new Roman', 'fontsize', 18);
set(gca,'FontSize', 18);
xlabel('X (m)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Y (m)', 'FontName', 'times new Roman','fontsize',20);
zlabel('Z (m)', 'FontName', 'times new Roman','fontsize',20);
Error = desiredPath - actualPath;

figure
plot(t,Error(:,1),'-.','linewidth', 2); hold on;
plot(t,Error(:,2),'--','linewidth', 2);
plot(t,Error(:,3),':','linewidth', 2); hold off;
grid on;
legend('E_x','E_y','E_z','Location','best', 'FontName', 'times new Roman','fontsize',18);
RMSE = double(round(sqrt(sum(Error(:,1).^2 + Error(:,2).^2 + Error(:,3).^2)/steps), 5));
annotation = strcat('RMSE=',mat2str(round(RMSE,6)),' m');
text(2, 0.001, annotation, 'fontsize', 20,'FontName', 'times new Roman');
hold off;
set(gca,'FontSize',18);
xlim([0 (tail-start)*0.01]);
xlabel('时间 (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('误差 (m)', 'FontName', 'times new Roman','fontsize',20);

% 驱动器变化
figure;
plot(t, theta(1,:), 'r-', 'linewidth', 2);%grid on;
hold on;
plot(t, theta(2,:), 'b--', 'linewidth', 2);
plot(t, theta(3,:), 'g:', 'linewidth', 2);
plot(t, theta(4,:), 'c-', 'linewidth', 2);
plot(t, theta(5,:), 'm--', 'linewidth', 2);
plot(t, theta(6,:), 'y:', 'linewidth', 2);
hold off;
grid on;
set(gca,'FontSize',18);
xlim([0 (tail-start)*0.01]);
xlabel('时间 (s)', 'FontName', 'times new Roman','fontsize',20,'interpreter','latex');
ylabel('关节角度 (rad)', 'FontName', 'times new Roman','fontsize',20);
legend('关节 1', '关节 2', '关节 3','关节 4', '关节 5', '关节 6', 'FontName', 'times new Roman','fontsize',24);
% savefig('results\circleBellowsNoFeedback.fig');


% % 驱动器速度
% figure;
% plot(t, dtheta(1,:), 'r-', 'linewidth', 2);%grid on;
% hold on;
% plot(t, dtheta(2,:), 'b--', 'linewidth', 2);
% plot(t, dtheta(3,:), 'g:', 'linewidth', 2);
% plot(t, dtheta(4,:), 'c-', 'linewidth', 2);
% plot(t, dtheta(5,:), 'm--', 'linewidth', 2);
% plot(t, dtheta(6,:), 'y:', 'linewidth', 2);
% hold off;
% grid on;
% set(gca,'FontSize',18);
% xlabel('时间 (s)', 'FontName', 'times new Roman','fontsize',20,'interpreter','latex');
% ylabel('关节速度 (rad/s)', 'FontName', 'times new Roman','fontsize',20);
% legend('关节 1', '关节 2', '关节 3','关节 4', '关节 5', '关节 6', 'FontName', 'times new Roman','fontsize',24);
% % savefig('results\circleBellowsNoFeedback.fig');
