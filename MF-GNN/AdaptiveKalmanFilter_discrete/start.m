clear all;

global d Q zeta R step vk Vk P K iota
addpath('functions');
% *************** D-H parameters of the Jaco2 manipulator
% the end-effector is the finger
% D = [0.2755, 0.4100, 0.2073, 0.07433, 0.07433, 0.1687, 0.0098]; %D1~D6;E2
% the end-effector is a pen
D = [0.2755, 0.4100, 0.2073, 0.07433, 0.07433, 0.13, 0.0098]; %D1~D6;E2
pen_long=0.055;   % length of the pen
aaa = 11.0*pi/72;
ca = cos(aaa);
sa = sin(aaa);
c2a = cos(2*aaa);
s2a = sin(2*aaa);
d4b = D(3)+sa/s2a*D(4);
d5b = sa/s2a*D(4)+sa/s2a*D(5);
d6b = sa/s2a*D(5)+D(6);
alpha_i = [pi/2, pi, pi/2, 2*aaa, 2*aaa, pi];
a_i = [0, D(2), 0, 0, 0, 0];
d_i = [D(1), 0, -D(7), -d4b, -d5b, -d6b];
% *************** D-H parameters of the Jaco2 manipulator

scale = 0.06;
% task duration
Td = 20;
iota = 0.05;
% Sampling interval
step = 0.01;
% Distance from module center to actuators
d = 0.05;
% Initial covariance matrix of the process noise
Q = 5e-8;
zeta = sqrt(Q)*randn(Td/step+1,18);
% Covariance matrix of the measurement noise
R = 5e-8;
delta = sqrt(R)*randn(Td/step+1,3);
% Innovation sequence
vk = zeros([Td/step+1,3]);
Vk = zeros([3,3]);
% Updated error covariance
P = 2*randn(18,18);
% Kalman gain
K = zeros([18,3]);
% actuator length
% u = [0.2000, 0.2100, 0.1900, 0.2000, 0.2100, 0.1900]';
u = [0.2000, 0.2200, 0.1800, 0.2000, 0.1800, 0.2200]';
% Initial Jacobian matrix
JHat = zeros(3,6);
for j = 1:6
    q1 = u;
    q2 = u;
    q2(j) = q2(j) + 0.01;
    [x1, y1, z1] = ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,q1);
    [x2, y2, z2] = ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,q2);
    JHat(1,j) = (x2-x1) / 0.01;
    JHat(2,j) = (y2-y1) / 0.01;
    JHat(3,j) = (z2-z1) / 0.01;
end
initPos = [x1; y1; z1];
% Optimization factor
alpha = 0.003;
% Allocate memory for the actual position
U = zeros([Td/step+1,6]);
i = 1;
tic
for t = 0:step:Td
    U(i,:) = u';
    i = i + 1;
    % Desired path
% 	pdx = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*cos(t./Td.*2*pi)+iota+0.0907;
% 	pdy = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi);
% 	pdz = iota*cos(pi/6)*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi)+0.3859;
%   pdk = [pdx, pdy, pdz]';

    rdx=scale*sin(2*pi*t/Td)+initPos(1);
    rdy=scale*sin(4*pi*t/Td+pi/6)-0.5*scale+initPos(2);
    rdz = ones(1,1)*(0+initPos(3));
    
    pdk = [rdx; rdy; rdz];

    
    % Actual path
%   [x,y,z] = position(u);
    [x, y, z] = ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,u);
    pak = [x,y,z]';
    
    % Optimal controller
    df_obj = [2*(u(1)-u(2))+2*(u(1)-u(3));
             -2*(u(1)-u(2))+2*(u(2)-u(3));
             -2*(u(2)-u(3))-2*(u(1)-u(3));
             2*(u(4)-u(5))+2*(u(4)-u(6));
             -2*(u(4)-u(5))+2*(u(5)-u(6));
             -2*(u(5)-u(6))-2*(u(4)-u(6))];
    w = -alpha*df_obj; 
    duk = pinv(JHat)*(pdk-pak)+(eye(6,6)-pinv(JHat)*JHat)*w;
    % Update u
    u = u + duk;
    if t==Td-step
        U(i,:) = u';
        break;
    end
    % Estimate Jacobian
    xk = [JHat(1,:),JHat(2,:),JHat(3,:)]';
%     [x2, y2, z2] = position(u);
    [x2, y2, z2] =ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,u);
    dpk = [x2; y2; z2]-pak+delta(round(t/step)+1,:)';
    JHat = KalmanFilter(xk, duk, dpk, t);
    t
end
time = toc;
save data\circleTrackingData U step;
save data\circleParameter d Q R alpha iota Td scale initPos;
