clear;
format long;
load data/INITdata10.mat;
addpath('functions');

steps = Td/tau+1;
interval = round(steps/100);


% Desired path and acutal trajectory
figure;
plot3(rd(1,1:interval:steps), rd(2,1:interval:steps), rd(3,1:interval:steps), 'b','linewidth', 2);grid on;
hold on;
plot3(ra(1,1:interval:steps), ra(2,1:interval:steps), ra(3,1:interval:steps), 'r:*','linewidth', 1);
hold off;
axis equal
legend('Desired path', 'Actual trajectory', 'best', 'FontName', 'times new Roman', 'fontsize', 18);
set(gca,'FontSize', 18);
xlabel('X (m)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Y (m)', 'FontName', 'times new Roman','fontsize',20);
zlabel('Z (m)', 'FontName', 'times new Roman','fontsize',20);

% The changes of errors
Error = rd - ra;
figure;
Te = 0:tau:Td;
plot(Te(1:interval:steps),Error(1,1:interval:steps)','-.','linewidth', 2);
hold on;
plot(Te(1:interval:steps),Error(2,1:interval:steps)','--','linewidth', 2);
plot(Te(1:interval:steps),Error(3,1:interval:steps)',':','linewidth', 2);
legend('E_x','E_y','E_z','Location','best', 'FontName', 'times new Roman','fontsize',18);
RMSE = round(sqrt(sum(Error(1,:).^2 + Error(2,:).^2 + Error(3,:).^2)/steps), 8);
annotation = strcat('RMSE=',mat2str(RMSE),' m');
text(2, 0.23, annotation, 'fontsize', 18,'FontName', 'times new Roman');
hold off;
set(gca,'FontSize',18);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Error (m)', 'FontName', 'times new Roman','fontsize',20);

% The changes of joint angles
figure;
plot(Te(1:interval:steps), theta(1,1:interval:steps), 'r-', 'linewidth', 2);%grid on;
hold on;
plot(Te(1:interval:steps), theta(2,1:interval:steps), 'b--', 'linewidth', 2);
plot(Te(1:interval:steps), theta(3,1:interval:steps), 'g:', 'linewidth', 2);
plot(Te(1:interval:steps), theta(4,1:interval:steps), 'c-', 'linewidth', 2);
plot(Te(1:interval:steps), theta(5,1:interval:steps), 'm--', 'linewidth', 2);
plot(Te(1:interval:steps), theta(6,1:interval:steps), 'y:', 'linewidth', 2);
hold off;
set(gca,'FontSize',18);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint angle (rad)', 'FontName', 'times new Roman','fontsize',20);
legend('$\theta_1$', '$\theta_2$', '$\theta_3$','$\theta_4$', '$\theta_5$', '$\theta_6$','interpreter','latex', 'FontName', 'times new Roman','fontsize',18);

% The velocity of joint angles
figure;
plot(Te(1:interval:steps-1), dTheta(1,1:interval:steps-1), 'r-', 'linewidth', 2);%grid on;
hold on;
plot(Te(1:interval:steps-1), dTheta(2,1:interval:steps-1), 'b--', 'linewidth', 2);
plot(Te(1:interval:steps-1), dTheta(3,1:interval:steps-1), 'g:', 'linewidth', 2);
plot(Te(1:interval:steps-1), dTheta(4,1:interval:steps-1), 'c-', 'linewidth', 2);
plot(Te(1:interval:steps-1), dTheta(5,1:interval:steps-1), 'm--', 'linewidth', 2);
plot(Te(1:interval:steps-1), dTheta(6,1:interval:steps-1), 'y:', 'linewidth', 2);
hold off;
set(gca,'FontSize',18);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint velocity (rad/s)', 'FontName', 'times new Roman','fontsize',20);
legend('$\dot{\theta}_1$', '$\dot{\theta}_2$', '$\dot{\theta}_3$','$\dot{\theta}_4$', '$\dot{\theta}_5$', '$\dot{\theta}_6$','interpreter','latex', 'FontName', 'times new Roman','fontsize',18);

% 二范数
L2Error = sqrt(Error(1,:).^2+Error(2,:).^2+Error(3,:).^2);
figure;
plot(Te, L2Error, 'g-', 'linewidth', 2);

% set(gca,'YLim',[0,0.5]);%X轴的数据显示范围
xlabel('Times (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('||e(t)||_2 (m)', 'FontName', 'times new Roman','fontsize',20);

% Transformation from DH algorithm to robot physical angles
thetas = [-theta(1,:); theta(2,:)+pi/2; theta(3,:)-pi/2; theta(4,:); theta(5,:)+pi; theta(6,:)-pi/2];

save data/runData thetas;
