clear;
load data_1.5\JointAngle_circle.mat;
load data_1.5\ObjectPosition_circle.mat;
load data_1.5\JointVelocity_circle.mat;

format long;

%% % display the joint angle
[rows, cols] = size(joint_angle);

Te = 0:rows;

figure;
plot(Te, [0;joint_angle(:,1)]', 'r','linewidth', 1);

hold on;

plot(Te, [0;joint_angle(:,2)]', 'g','linewidth', 1);
plot(Te, [0;joint_angle(:,3)]', 'b','linewidth', 1);
plot(Te, [0;joint_angle(:,4)]', 'm','linewidth', 1); %101
plot(Te, [0;joint_angle(:,5)]', 'c','linewidth', 1); %011
plot(Te, [0;joint_angle(:,6)]', 'color',[0.5, 0, 1],'linewidth', 1);
plot(Te, [0;joint_angle(:,7)]', 'color',[1, 0.5, 0],'linewidth', 1);

legend('joint1','joint2','joint3','joint4','joint5','joint6','joint7','Location','best', 'FontName', 'times new Roman','fontsize',10);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('JointAngle (deg)', 'FontName', 'times new Roman','fontsize',20);

ax = gca;
ax.YAxis.Exponent = 2;

%% show each joint angle
%{
figure;
plot(Te, [0;joint_angle(:,1)]', 'r','linewidth', 1);

xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint1Angle (deg)', 'FontName', 'times new Roman','fontsize',20);


figure;
plot(Te, [0;joint_angle(:,2)]', 'g','linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint2Angle (deg)', 'FontName', 'times new Roman','fontsize',20);

figure;
plot(Te, [0;joint_angle(:,3)]', 'b','linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint3Angle (deg)', 'FontName', 'times new Roman','fontsize',20);


figure;
plot(Te, [0;joint_angle(:,4)]', 'm','linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint4Angle (deg)', 'FontName', 'times new Roman','fontsize',20);


figure;
plot(Te, [0;joint_angle(:,5)]', 'c','linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint5Angle (deg)', 'FontName', 'times new Roman','fontsize',20);


figure;
plot(Te, [0;joint_angle(:,6)]', 'color',[0.5, 0, 1],'linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint6Angle (deg)', 'FontName', 'times new Roman','fontsize',20);


figure;
plot(Te, [0;joint_angle(:,7)]', 'color',[1, 0.5, 0],'linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint7Angle (deg)', 'FontName', 'times new Roman','fontsize',20);


hold off;
%}

%% % actual & desired path
[numbers, res] = size(pa);

Error = zeros(numbers,3);

for i = 1:numbers
    Error(i,:) = pd(i,:)-pa(i,:);
end


figure;
plot3(pd(:,1)',pd(:,2)',pd(:,3)', 'r.-','linewidth', 1);
hold on;
plot3(pa(:,1)',pa(:,2)',pa(:,3)', 'b--*','linewidth', 1);

xlabel('X (m)','fontsize',18);
ylabel('Y (m)','fontsize',18);
zlabel('Z (m)','fontsize',18);
legend('Desired Path', 'Actual Path','Location','best');
% legend('期望轨迹','实际轨迹', 'Location','best');

%误差分析
figure;
Te = 0:numbers;
plot(Te,[0;Error(:,1)]','r-');
% plot(Te,Error(:,1)','-');
hold on;
plot(Te,[0;Error(:,2)]','g-');
% plot(Te,Error(:,2)','--');grid on;
plot(Te,[0;Error(:,3)]','b-');
% plot(Te,Error(:,3)','-.');
RMSE = round(sqrt(sum(Error(:,1).^2 + Error(:,2).^2 + Error(:,3).^2)/numbers), 4);
annotation = strcat('RMSE=',mat2str(RMSE),'m');
text(22, -0.05, annotation, 'fontsize', 15, 'FontName', 'times new Roman');
legend('Ex','Ey','Ez','Location','best', 'FontName', 'times new Roman');
hold off;
% xlabel('t (s)');
% ylabel('error (m)');
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize', 15);
ylabel('Error (m)', 'FontName', 'times new Roman','fontsize', 15);
legend('Ex','Ey','Ez','Location','best');


%%
[rows, cols] = size(joint_velocity);

Te = 0:rows;

figure;
plot(Te, [0;joint_velocity(:,1)]', 'r','linewidth', 1);

hold on;

plot(Te, [0;joint_velocity(:,2)]', 'g','linewidth', 1);
plot(Te, [0;joint_velocity(:,3)]', 'b','linewidth', 1);
plot(Te, [0;joint_velocity(:,4)]', 'm','linewidth', 1); %101
plot(Te, [0;joint_velocity(:,5)]', 'c','linewidth', 1); %011
plot(Te, [0;joint_velocity(:,6)]', 'color',[0.5, 0, 1],'linewidth', 1);
plot(Te, [0;joint_velocity(:,7)]', 'color',[1, 0.5, 0],'linewidth', 1);

legend('joint1','joint2','joint3','joint4','joint5','joint6','joint7','Location','best', 'FontName', 'times new Roman','fontsize',10);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('JointVelocity (deg/s)', 'FontName', 'times new Roman','fontsize',20);
ax = gca;
ax.YAxis.Exponent = 2;

%% show each joint angle
%{
figure;
plot(Te, [0;joint_velocity(:,1)]', 'r','linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint1Velocity (deg/s)', 'FontName', 'times new Roman','fontsize',20);

figure;
plot(Te, [0;joint_velocity(:,2)]', 'g','linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint2Velocity (deg/s)', 'FontName', 'times new Roman','fontsize',20);

figure;
plot(Te, [0;joint_velocity(:,3)]', 'b','linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint3Velocity (deg/s)', 'FontName', 'times new Roman','fontsize',20);


figure;
plot(Te, [0;joint_velocity(:,4)]', 'm','linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint4Velocity (deg/s)', 'FontName', 'times new Roman','fontsize',20);

figure;
plot(Te, [0;joint_velocity(:,5)]', 'c','linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint5Velocity (deg/s)', 'FontName', 'times new Roman','fontsize',20);

figure;
plot(Te, [0;joint_velocity(:,6)]', 'color',[0.5, 0, 1],'linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint6Velocity (deg/s)', 'FontName', 'times new Roman','fontsize',20);

figure;
plot(Te, [0;joint_velocity(:,7)]', 'color',[1, 0.5, 0],'linewidth', 1);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',20);
ylabel('Joint7Velocity (deg/s)', 'FontName', 'times new Roman','fontsize',20);


hold off;
%}


%% workspace match
%{
[rows, cols] = size(pa);
xa = zeros(rows, cols);     % actual position

val = pi/4;

TransMatrix = [cos(val), -sin(val), 0; sin(val), cos(val), 0; 0, 0, 1];
sx = 0.0041; sy = 0.0040; sz = 0.0041;
coefMatrix = [sx, 0, 0; 0, sy, 0; 0, 0, sz];
Tb = [0.701, 0.210, 0.129]';


for i = 1:rows
%     for j = 1:cols
      xa(i,:) = TransMatrix*( coefMatrix*pd(i,:)' + Tb );
%     end
end

plot3(xa(:,1)',xa(:,2)',xa(:,3)', 'r*','linewidth', 1);
hold on;
% plot3(pd(:,1)',pd(:,2)',pd(:,3)', 'g--','linewidth', 1);

xlabel('X (m)','fontsize',18);
ylabel('Y (m)','fontsize',18);
zlabel('Z (m)','fontsize',18);
legend('Actual Path','Desired Path', 'Location','best');
%}