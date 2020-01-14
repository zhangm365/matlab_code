clc;
close all;
load data\INITdata20_triangle.mat;
load data\parameter20_triangle.mat
addpath('functions');
addpath('drawManipulator')
global d;
d = 0.05;
number = length(t);
actualPosition = zeros(number,3);
Error = zeros(number,3);
step = 0.01;
%目标轨迹
T = 0:step:Td;
% %circle
% rdx = iota*cos(2*pi*sin(0.5*pi*T/Td).^2)-iota+0.0907;
% rdy = iota*cos(pi/6)*sin(2*pi*sin(0.5*pi*T/Td).^2)+0.00001;
% rdz = iota*sin(pi/6)*sin(2*pi*sin(0.5*pi*T/Td).^2)+0.3859;
% % quadrangle
% T = 0:step:4.99;
% xdx1 = -0.03*4*T/Td+0.0907;
% xdy1 = 0.06*4*T/Td+0.00001;
% xdz1 = 0.01*4*T/Td+0.3859;
% T = 5:step:9.99;
% xdx2 = -0.03*4*(T-Td/4)/Td+0.0607;
% xdy2 = -0.06001*4*(T-Td/4)/Td+0.06001;
% xdz2 = -0.01*4*(T-Td/4)/Td+0.3959;
% T = 10:step:14.99;
% xdx3 = 0.03*4*(T-2*Td/4)/Td+0.0307;
% xdy3 = -0.06*4*(T-2*Td/4)/Td;
% xdz3 = 0.01*4*(T-2*Td/4)/Td+0.3859;     
% T = 15:step:20;
% xdx4 = 0.03*4*(T-3*Td/4)/Td+0.0607;
% xdy4 = 0.06001*4*(T-3*Td/4)/Td-0.06;
% xdz4 = -0.01*4*(T-3*Td/4)/Td+0.3959;
% rdx = [xdx1, xdx2, xdx3, xdx4];
% rdy = [xdy1, xdy2, xdy3, xdy4];
% rdz = [xdz1, xdz2, xdz3, xdz4];
% triangle
T = 0:step:4.99;
xdx1 = -0.1614*3*T/Td+0.0907;
xdy1 = 0.13*3*T/Td+0.00001;
xdz1 = 0.01*3*T/Td+0.3859;
T = 5:step:9.99;
xdx2 = -0.01*3*(T-Td/3)/Td-0.0707;
xdy2 = -0.26001*3*(T-Td/3)/Td+0.13001;
xdz2 = -0.02*3*(T-Td/3)/Td+0.3959;
T = 10:step:15;
xdx3 = 0.1714*3*(T-2*Td/3)/Td-0.0807;
xdy3 = 0.13001*3*(T-2*Td/3)/Td-0.13;
xdz3 = 0.01*3*(T-2*Td/3)/Td+0.3759;
rdx = [xdx1, xdx2, xdx3];
rdy = [xdy1, xdy2, xdy3];
rdz = [xdz1, xdz2, xdz3];
%实际轨迹
for i = 1:length(t)
    q = y(i,1:6)';
    [px, py, pz] = position(q);
    %末端
    pos(i, 1:3) = [px, py, pz];
    %误差
    Error(i,:) = [px-rdx(i), py-rdy(i), pz-rdz(i)];
end

x1=0;s=10;%确定起始点和增量
nframes=Td/step/10;%确定总动画帧数
% % 无损
% aviobj = VideoWriter('demo.avi','Uncompressed AVI');
% 有损
aviobj = VideoWriter('results\triangle.avi');
open(aviobj);
for k=1:nframes
    x1=x1+s;%确定画图时的横坐标终止值x1
    x=0:0.1:x1;
    set(gcf, 'position', [300,300,1500,300]);
    
    % tracking
    subplot(1,3,1);
    plot3(rdx*1000, rdy*1000, rdz*1000,'-','color',[0.75,0.75,0.75]);hold on;
    plot3(pos(1:10:x1,1)'*1000, pos(1:10:x1,2)'*1000, pos(1:10:x1,3)'*1000,'k-','linewidth',2);
    % 画坐标轴
    plot3(100*ones(1,281),-140:1:140,zeros(1,281),'k-');
    plot3(100*ones(1,281),-140:1:140,500*ones(1,281),'k-');
    plot3(-100:1:100,140*ones(1,201),zeros(1,201),'k-');
    plot3(-100:1:100,140*ones(1,201),500*ones(1,201),'k-');
    plot3(100*ones(1,501),140*ones(1,501),0:1:500,'k-');
    plot3(100*ones(1,501),-140*ones(1,501),0:1:500,'k-');
    q = y(x1,1:6)';
    drawManipulator(q);
    axis([-110 110 -110 110 -50 500]);
    set(gca, 'xtick', -100:100:100);
    set(gca, 'ytick', -100:100:100);
    set(gca, 'ztick', 0:100:500);
    xlabel('X(mm)', 'FontName', 'times new Roman'); ylabel('Y(mm)', 'FontName', 'times new Roman'); zlabel('Z(mm)', 'FontName', 'times new Roman');
%     grid on
    hold off;
    axis equal
    
    % error
    subplot(1,3,2);
    T = 0:step:Td;
    p1 = plot(T(1:10:x1),Error(1:10:x1,1)*1000','-', 'linewidth', 2);
    hold on;
    p2 = plot(T(1:10:x1),Error(1:10:x1,2)'*1000,'-', 'linewidth', 2);
    p3 = plot(T(1:10:x1),Error(1:10:x1,3)'*1000,'-', 'linewidth', 2);
    axis([0 Td -1 1]);
    set(gca, 'xtick', 0:5:Td);
    set(gca, 'ytick', -1:0.5:1);
    hold off
    legend([p1, p2, p3] ,'Ex','Ey','Ez','Location','best', 'FontName', 'times new Roman');
    xlabel('Time (s)', 'FontName', 'times new Roman');
    ylabel('Error (mm)', 'FontName', 'times new Roman');
    
    % bellow
    subplot(1,3,3);
    q1 = y(:, 1)'; q2 = y(:, 2)'; q3 = y(:, 3)'; q4 = y(:, 4)'; q5 = y(:, 5)'; q6 = y(:, 6)';
    plot(T(1:10:x1), q1(1:10:x1)*1000, 'r-', 'linewidth', 2);grid on;
    hold on;
    plot(T(1:10:x1), q2(1:10:x1)*1000, 'b-', 'linewidth', 2);
    plot(T(1:10:x1), q3(1:10:x1)*1000, 'g-', 'linewidth', 2);
    plot(T(1:10:x1), q4(1:10:x1)*1000, 'c-', 'linewidth', 2);
    plot(T(1:10:x1), q5(1:10:x1)*1000, 'm-', 'linewidth', 2);
    plot(T(1:10:x1), q6(1:10:x1)*1000, 'y-', 'linewidth', 2);
    axis([0 Td 140 260]);
    set(gca, 'xtick', 0:5:Td);
    set(gca, 'ytick', 140:20:260);
    hold off;
    title('Actuators', 'FontName', 'times new Roman');
    xlabel('Time (s)', 'FontName', 'times new Roman');
    ylabel('Bellow length (mm)', 'FontName', 'times new Roman');
    legend('u11', 'u12', 'u13', 'u21', 'u22', 'u23', 'FontName', 'times new Roman');

    rect=[0 0 1500 300];
    m(k)=getframe(gcf,rect);
    % 保存gif文件
    im = frame2im(m(k));
    [imind, cm] = rgb2ind(im, 256);
    if k == 1
        imwrite(imind, cm, 'results/triangle.gif', 'Loopcount', inf, 'DelayTime', 0.001);
    else
        imwrite(imind,cm, 'results/triangle.gif','WriteMode','append','DelayTime',0.001);
    end
    % 保存avi文件
    writeVideo(aviobj, m(k));
end
close(aviobj);
% movie(m,1,10);