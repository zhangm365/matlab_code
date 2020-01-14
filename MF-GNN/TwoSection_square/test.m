clear all;

global d;
d = 5;

% 求J和DJ
% q1 = [0.2000, 0.2200, 0.1800, 0.2000, 0.1800, 0.2200]'*100;
% dq = [0,0,0,0,0,0]';
% % q2 = [0.1811, 0.1919, 0.1811, 0.2098, 0.1912, 0.1888]';
% [J, DJ] = Jacobian(q1, dq);
% J
% % % % DJ
% % % % 
% % % % % 测试位置
% q = [0.2000, 0.2200, 0.1800, 0.2000, 0.1800, 0.2200]';
% q2 = [0.2003, 0.220, 0.180, 0.2000, 0.1800, 0.2200]';
% [x, y, z]=position(q)
% [x2, y2, z2]=position(q2)

% % 测试结果
% load data\Position5.mat
load data\INITdata5.mat
iota = 0.10;
Td = 20;
T = 0:0.05:Td; 
% circle
xdx = iota*cos(2*pi*(sin(0.5*pi*T/Td)).^2)-iota+0.0908;
xdy = iota*cos(pi/6)*sin(2*pi*(sin(0.5*pi*T/Td)).^2)+0.00001;
xdz = iota*sin(pi/6)*sin(2*pi*(sin(0.5*pi*T/Td)).^2)+0.3860;

figure;
plot3(xdx, xdy, xdz,'b'); grid on;
hold on;
plot3(Position(:,3),Position(:,4),Position(:,5),'r*--');

tt=10;
xt = iota*cos(2*pi*(sin(0.5*pi*tt/Td)).^2)-iota+0.0908;
yt = iota*cos(pi/6)*sin(2*pi*(sin(0.5*pi*tt/Td)).^2)+0.00001;
zt = iota*sin(pi/6)*sin(2*pi*(sin(0.5*pi*tt/Td)).^2)+0.3860;
plot3(xt,yt,zt,'b*');

hold off;


%计算H
% syms kl phi k
% B = [cos(kl), 0, sin(kl), (1-cos(kl))/k;
%      0, 1, 0, 0;
%      -sin(kl), 0, cos(kl), sin(kl)/k;
%      0, 0, 0, 1];
% C = [cos(phi), -sin(phi), 0, 0;
%      sin(phi), cos(phi), 0, 0;
%      0, 0, 1, 0;
%      0, 0, 0, 1];
% H = C*B
% 
% %计算坐标映射表达式
% syms sinphi1 cosphi1 k1 kl1 sinphi2 cosphi2 k2 kl2;
% H1 = [cosphi1*cos(kl1), -sinphi1, cosphi1*sin(kl1), cosphi1*(1-cos(kl1))/k1;
%       sinphi1*cos(kl1), cosphi1, sinphi1*sin(kl1), sinphi1*(1-cos(kl1))/k1;
%       -sin(kl1), 0, cos(kl1), sin(kl1)/k1;
%       0, 0, 0, 1];
% H2 = [cosphi2*cos(kl2), -sinphi2, cosphi2*sin(kl2), cosphi2*(1-cos(kl2))/k2;
%       sinphi2*cos(kl2), cosphi2, sinphi2*sin(kl2), sinphi2*(1-cos(kl2))/k2;
%       -sin(kl2), 0, cos(kl2), sin(kl2)/k2;
%       0, 0, 0, 1];
% pos1 = H2*[0;0;0;1]
% pos = H1*pos1

% debug
% load data\Position5.mat

% q1 = Position(217,7:12);
% dq1 = Position(217,13:18);
% JHat1 = reshape(Position(100,17:34),[3,6])
% [x1, y1, z1] = position(q1');
% [J1, DJ1] = Jacobian(q1', dq1')
% q2 = Position(218,7:12);
% dq2 = Position(218,13:18);
% JHat2 = reshape(Position(102,17:34),[3,6])
% [x2, y2, z2] = position(q2');
% [J2, DJ2] = Jacobian(q2', dq2')


