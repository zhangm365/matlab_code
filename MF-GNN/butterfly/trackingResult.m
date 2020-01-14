clear all;
format long;
load data\INITdata5_ACF1_l.mat;
load data\parameter5_ACF1_l.mat
addpath('functions');
global d;
d = 50;

number = length(t);
actualPosition = zeros(number,3);
Error = zeros(number,3);

step = 0.01;

%目标轨迹
T = 0:step:20;
xdx = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*cos(T./Td.*2*pi)+iota+90.7;
xdy = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi);
xdz = iota*cos(pi/6)*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi)+385.9;


%实际轨迹
for i = 1:length(t)
    q = y(i,1:6)';
    [px, py, pz] = position(q);
    %末端
    actualPosition(i, 1:3) = [px, py, pz];
    %误差
    Error(i,:) = [px-xdx(i), py-xdy(i), pz-xdz(i)];
end
figure;
p1 = plot3(actualPosition(1:10:number,1)', actualPosition(1:10:number,2)', actualPosition(1:10:number,3)','r-*');grid on;
hold on;
p2 =plot3(xdx, xdy, xdz,'b'); 

tail = [75, 0, 380];
head = [90, -5, 385];
quiver3(tail(1), tail(2), tail(3), head(1)-tail(1), head(2)-tail(2), head(3)-tail(3), 'k','linewidth', 1);
text(60, 10, 380, 'Large noise', 'FontName', 'times new Roman','fontsize',12)

legend([p1, p2], 'Actual trajactory','Desired path','Location','best', 'FontName', 'times new Roman','fontsize',12);
hold off;
xlabel('X (m)', 'FontName', 'times new Roman','fontsize',15);
ylabel('Y (m)', 'FontName', 'times new Roman','fontsize',15);
zlabel('Z (m)', 'FontName', 'times new Roman','fontsize',15);
% savefig('results\Circle_50.fig');

%误差分析
figure;
Te = 0:step:t(number);
p1 = plot(Te,Error(:,1)','-.', 'linewidth', 2);
hold on;
p2 = plot(Te,Error(:,2)','--', 'linewidth', 2);%grid on;
p3 = plot(Te,Error(:,3)',':', 'linewidth', 2);
% error bound
bound = noise/gamma*ones(size(Te));
% p4 = plot(Te, bound, 'g-','linewidth', 2);
% p5 = plot(Te, -bound, 'g-','linewidth', 2);
RMSE = round(sqrt(sum(Error(:,1).^2 + Error(:,2).^2 + Error(:,3).^2)/number), 4);
annotation = strcat('RMSE=',mat2str(RMSE),' mm');
text(2, 0.8, annotation, 'fontsize', 15,'FontName', 'times new Roman');
legend([p1, p2, p3] ,'Ex','Ey','Ez','Location','best', 'FontName', 'times new Roman','fontsize',12);
% legend([p1, p2, p3, p4] ,'Ex','Ey','Ez','Boundary','Location','best', 'FontName', 'times new Roman');
hold off;
set(gca,'FontSize',12);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',15);
ylabel('Error (mm)', 'FontName', 'times new Roman','fontsize',15);
set(gca,'YLim',[-1,1]);%X轴的数据显示范围
% title('\gamma=20, \mu = 20');
% savefig('results\circleError.fig');


% 驱动器变化
q1 = y(:, 1)'; q2 = y(:, 2)'; q3 = y(:, 3)'; q4 = y(:, 4)'; q5 = y(:, 5)'; q6 = y(:, 6)';
figure;
plot(t, q1, 'r-', 'linewidth', 2);%grid on;
hold on;
plot(t, q2, 'b--', 'linewidth', 2);
plot(t, q3, 'g:', 'linewidth', 2);
plot(t, q4, 'c-', 'linewidth', 2);
plot(t, q5, 'm--', 'linewidth', 2);
plot(t, q6, 'y:', 'linewidth', 2);
hold off;
set(gca,'FontSize',12);
xlabel('Time (s)', 'FontName', 'times new Roman','fontsize',15);
ylabel('Bellow length (mm)', 'FontName', 'times new Roman','fontsize',15);
legend('a11', 'a12', 'a13','a21', 'a22', 'a23', 'FontName', 'times new Roman','fontsize',12);
% savefig('results\circleBellowsNoFeedback.fig');

% % 二范数
% L2Error = sqrt(Error(:,1).^2+Error(:,2).^2+Error(:,3).^2);
% figure;
% plot(Te, L2Error, 'g-', 'linewidth', 2);
% hold on;
% tau = 0.8;
% if acf==1
%     bound = 0.001/gamma*ones(size(Te))*sqrt(3);
% elseif acf==2
%     bound = sqrt(3)*(noise/(2*gamma))^(2*tau/(tau^2+1))*ones(size(Te));
% elseif acf==3
%     bound = sqrt(3)*(2*noise/(3*gamma))^(3*tau/(tau^2+tau+1))*ones(size(Te));
% elseif acf==4
%     bound = sqrt(3)*(noise/gamma)^(1/tau)*ones(size(Te));
% elseif acf==5
%     bound = sqrt(3)*(noise/(2*gamma))^(2/(tau+1))*ones(size(Te));
% end
% 
% plot(Te, bound*1000, 'r-','linewidth', 2);
% % set(gca,'YLim',[0,0.5]);%X轴的数据显示范围
% xlabel('Times (s)', 'FontName', 'times new Roman');
% ylabel('||e(t)||_F (mm)', 'FontName', 'times new Roman');


