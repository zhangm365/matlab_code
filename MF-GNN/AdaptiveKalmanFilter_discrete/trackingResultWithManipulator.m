clear;
addpath('functions');
addpath('drawManipulator');
load data\circleTrackingData.mat;
load data\circleParameter.mat

global d;
d = 0.05;

inteval = 20;
number = fix((Td/step+1)/inteval);
pos = zeros(number,3);
Error = zeros(number,3);
index = 0;

%目标轨迹
T = 0:step:20;
% %butterfly
rdx = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*cos(T./Td.*2*pi)+iota+0.0907;
rdy = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi);
rdz = iota*cos(pi/6)*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi)+0.3859;


%实际轨迹
figure;
for i = 1:Td/step
    if (rem(i, inteval)==0)
        q = U(i,1:6)';
        index = index + 1;
        [px, py, pz] = position(q);
        %末端
        pos(index, 1:3) = [px, py, pz];
        drawManipulator(q);
    end
end
h1 = plot3(rdx*1000, rdy*1000, rdz*1000,'r'); grid on;
hold on;
h2 = plot3(pos(1:number,1)'*1000, pos(1:number,2)'*1000, pos(1:number,3)'*1000,'-.o','color',[0.48, 0.50, 0.20],'MarkerFaceColor',[0.48, 0.50, 0.20]);
legend([h1, h2],'Desired path','Actual trajactory','Location','best', 'FontName', 'times new Roman');
hold off;
view(3);
xlabel('X (mm)', 'FontName', 'times new Roman','fontsize',15);
ylabel('Y (mm)', 'FontName', 'times new Roman','fontsize',15);
zlabel('Z (mm)', 'FontName', 'times new Roman','fontsize',15);
% savefig('results\circleKalman.fig');


