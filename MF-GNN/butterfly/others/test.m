
%%
clear all
global d
d = 50;
addpath('functions');
q = [0.20, 0.21, 0.19, 0.20, 0.21, 0.19]'*1000;
% q2 = [0.2003, 0.220, 0.180, 0.2000, 0.1800, 0.2200]';
[x, y, z]=position(q);

dq = [0, 0, 0, 0, 0, 0]';
[J, DJ]  = Jacobian2(q, dq);

%% 计算H
syms kl phi k
% B = [cos(kl), 0, sin(kl), (1-cos(kl))/k;
%      0, 1, 0, 0;
%      -sin(kl), 0, cos(kl), sin(kl)/k;
%      0, 0, 0, 1];
B = [cos(kl), 0, sin(kl), 0;
     0, 1, 0, 0;
     -sin(kl), 0, cos(kl), 0;
     0, 0, 0, 1];

C = [cos(phi), -sin(phi), 0, 0;
     sin(phi), cos(phi), 0, 0;
     0, 0, 1, 0;
     0, 0, 0, 1];
H = C*B

%% 计算坐标映射表达式
% q = [0.2100, 0.2000, 0.2000, 0.2100, 0.2000, 0.2000]';
% q1=q(1); q2=q(2); q3=q(3); q4=q(4); q5=q(5); q6=q(6);
syms sinphi1 cosphi1 k1 kl1 sinphi2 cosphi2 k2 kl2;

% u1 = sqrt(q1^2+q2^2+q3^2-q1*q2-q1*q3-q2*q3);
% u2 = sqrt(q4^2+q5^2+q6^2-q4*q5-q4*q6-q5*q6);
% kl1 = 2*u1/(3*d);
% kl2 = 2*u2/(3*d);
% sinphi1 = (q2+q3-2*q1)/(2*u1);
% cosphi1 = sqrt(3)*(q2-q3)/(2*u1);
% sinphi2 = (q5+q6-2*q4)/(2*u2);
% cosphi2 = sqrt(3)*(q5-q6)/(2*u2);
% k1 = 2*u1/(d*(q1+q2+q3));
% k2 = 2*u2/(d*(q4+q5+q6));
H1 = [cosphi1^2*(cos(kl1)-1)+1, sinphi1*cosphi1*(cos(kl1)-1), cosphi1*sin(kl1), cosphi1*(1-cos(kl1))/k1;
      sinphi1*cosphi1*(cos(kl1)-1), cosphi1^2*(1-cos(kl1))+cos(kl1), sinphi1*sin(kl1), sinphi1*(1-cos(kl1))/k1;
      -cosphi1*sin(kl1), -sinphi1*sin(kl1), cos(kl1), sin(kl1)/k1;
      0, 0, 0, 1];
P1 = H1*[0;0;0;1]
H2 = [cosphi2^2*(cos(kl2)-1)+1, sinphi2*cosphi2*(cos(kl2)-1), cosphi2*sin(kl2), cosphi2*(1-cos(kl2))/k2;
      sinphi2*cosphi2*(cos(kl2)-1), cosphi2^2*(1-cos(kl2))+cos(kl2), sinphi2*sin(kl2), sinphi2*(1-cos(kl2))/k2;
      -cosphi2*sin(kl2), -sinphi2*sin(kl2), cos(kl2), sin(kl2)/k2;
      0, 0, 0, 1];
pos2 = H1*H2*[0;0;0;1]


%% 
% load data\parameter20_circle_robust1.mat
% % 
global d
d= 0.05;
addpath('functions');
q1 =[0.20, 0.18, 0.22, 0.20, 0.22, 0.18]';
q2 = [0.201, 0.182, 0.219, 0.201, 0.222, 0.179];
[x1, y1, z1] = position(q1);
[x2, y2, z2] = position(q2);
dx =  [x2-x1, y2-y1, z2-z1]';
dq = [0.001, 0.002, -0.001, 0.001, 0.002, -0.001]';
J = [dx(1)/dq(1), dx(1)/dq(2), dx(1)/dq(3), dx(1)/dq(4), dx(1)/dq(5), dx(1)/dq(6);
    dx(2)/dq(1), dx(2)/dq(2), dx(2)/dq(3), dx(2)/dq(4), dx(2)/dq(5), dx(2)/dq(6);
    dx(3)/dq(1), dx(3)/dq(2), dx(3)/dq(3), dx(3)/dq(4), dx(3)/dq(5), dx(3)/dq(6)];


%%
clear all
global d
d = 0.05;
addpath('functions');
load data\INITdata_circle_test_model.mat
q0 =[0.20, 0.22, 0.18, 0.20, 0.18, 0.22]';
% [x, y, z] = position(q0);
q = y(1400, 1:6)';
% q = q0 - (q-q0);
dq = [0, 0, 0, 0, 0, 0]';
[J, DJ]  = Jacobian2(q, dq);

%%
J = [0.0756211967318909,3.39762417485369,-3.24638178138990,0.0756211967318909,1.20993914771025,-1.05869675424647;-3.92939264606390,1.96469632303195,1.96469632303195,-1.30979754868797,0.654898774343983,0.654898774343983;0.321607261001417,-0.550339692970218,1.19355421497305,0.321607261001417,0.145716176022679,0.497498345980157];
xd = [91.7, 1, 386.9]';
xa = [90.7454, 0, 385.9287]';
e = [1;1;1];
JHat0 = pinv(eye(3,3)-e*pinv(xd-xa))*J;
%%
Td = 20;
t = 0:0.01:Td;
iota = 10
a = 10;
% y = a*(2*cos(t/Td*2*pi)-cos(2*t/Td*2*pi));
% x = a*(2*sin(t/Td*2*pi)-sin(2*t/Td*2*pi));
% x = a*cos(t./Td.*2*pi).^3;
% y = a*sin(t./Td.*2*pi).^3;
% z = a*cos(pi/6)*sin(t./Td.*2*pi).^3;
x = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*cos(t./Td.*2*pi);
y = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi);
z = iota*cos(pi/6)*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi);

figure;
plot3(x,y,z);hold on;
plot3(x(1),y(1),z(1),'*');
xlabel('x');
ylabel('y');
zlabel('z');
%%
syms iota Td t
xdx = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*cos(t./Td.*2*pi);
xdy = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi);
xdz = iota*cos(pi/6)*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi);

diff(xdx, t)
diff(xdy, t)
diff(xdz, t)