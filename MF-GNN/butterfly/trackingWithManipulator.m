clear all;
addpath('drawManipulator');
addpath('functions');
load data\INITdata5_ACF1_n.mat;
load data\parameter5_ACF1_n.mat;

global d;
d = 50;

inteval = 20;
number = fix(length(t)/inteval);
pos = zeros(number,3);
Error = zeros(number,3);
index = 0;

step = 0.01;
%目标轨迹
T = 0:step:20;

xdx = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*cos(T./Td.*2*pi)+iota+90.7;
xdy = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi);
xdz = iota*cos(pi/6)*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi)+385.9;

%实际轨迹
figure;
for i = 1:length(t)
    if (rem(i, inteval)==0)
        q = y(i,1:6)';
        index = index + 1;
        [px, py, pz] = position(q);
        %末端
        pos(index, 1:3) = [px, py, pz];
        drawManipulator(q);
    end
end
h1 = plot3(xdx, xdy, xdz,'r'); grid on;
hold on;
h2 = plot3(pos(1:number,1)', pos(1:number,2)', pos(1:number,3)','-.o','color',[0.50, 0.54, 0.53],'MarkerFaceColor',[0.50, 0.54, 0.53]);
legend([h1, h2],'Desired path','Actual trajactory','Location','best', 'FontName', 'times new Roman','fontsize',12);
hold off;
view(3);
% axis equal;
set(gca,'FontSize',12);
xlabel('X (mm)', 'FontName', 'times new Roman','fontsize',15);
ylabel('Y (mm)', 'FontName', 'times new Roman','fontsize',15);
zlabel('Z (mm)', 'FontName', 'times new Roman','fontsize',15);
% savefig('results\circleWithManipulator_20.fig');


