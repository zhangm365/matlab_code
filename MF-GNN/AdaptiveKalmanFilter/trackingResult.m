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

% step = 0.01;

%目标轨迹
T = 0:step:20;
% % %circle
rdx = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*cos(T./Td.*2*pi)+iota+0.0907;
rdy = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi);
rdz = iota*cos(pi/6)*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi)+0.3859;



%实际轨迹
for i = 1:number
    q = U(i,1:6)';
    [px, py, pz] = position(q);
    %
    actualPosition(i, 1:3) = [px, py, pz];
    %
    Error(i,:) = [px-rdx(i), py-rdy(i), pz-rdz(i)];
end
figure;
plot3(actualPosition(1:10:number,1)', actualPosition(1:10:number,2)', actualPosition(1:10:number,3)','r:*');grid on;
hold on;
plot3(rdx, rdy, rdz,'b'); 
legend('Actual trajactory','Desired path','Location','best');
hold off;
xlabel('X (m)','fontsize', 15);
ylabel('Y (m)','fontsize', 15);
zlabel('Z (m)','fontsize', 15);
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
text(7, -3, annotation, 'fontsize', 14, 'FontName', 'times new Roman');
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
ylabel('Bellow length (mm)', 'FontName', 'times new Roman','fontsize', 15);
legend('w21', 'w22', 'w23','w11', 'w12', 'w13', 'FontName', 'times new Roman');
% savefig('results\circleBellowsKalman.fig');

