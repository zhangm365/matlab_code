clear all;

global d Q zeta R step vk Vk P K iota
addpath('functions');
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
% JHat = [0.03,3.34,-3.26,0.11,1.18,-0.95;-3.91,1.95,1.95,-1.32,0.66,0.66;0.33,-0.62,1.28,0.31,-0.12,0.74];
JHat = [0.007,  1.064,  -1.482, 0.043, 0, 0;
         -1.591,  0.523,  0.512, -0.157, 0.217, 0.217;
         0.248, 0, 0.428, 0.217, 0.158, 0.158];  
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
	pdx = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*cos(t./Td.*2*pi)+iota+0.0907;
	pdy = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi);
	pdz = iota*cos(pi/6)*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi)+0.3859;
%     % Quadrangle
%     if t < Td/4
%         pdx = -0.03*4*t/Td+0.0907;
%         pdy = 0.06*4*t/Td+0.00001;
%         pdz = 0.01*4*t/Td+0.3859;
%     elseif t < 2*Td/4
%         pdx = -0.03*4*(t-Td/4)/Td+0.0607;
%         pdy = -0.06001*4*(t-Td/4)/Td+0.06001;
%         pdz = -0.01*4*(t-Td/4)/Td+0.3959;
%     elseif t < 3*Td/4
%         pdx = 0.03*4*(t-2*Td/4)/Td+0.0307;
%         pdy = -0.06*4*(t-2*Td/4)/Td;
%         pdz = 0.01*4*(t-2*Td/4)/Td+0.3859;    
%     else
%         pdx = 0.03*4*(t-3*Td/4)/Td+0.0607;
%         pdy = 0.06001*4*(t-3*Td/4)/Td-0.06;
%         pdz = -0.01*4*(t-3*Td/4)/Td+0.3959;
%     end
    pdk2 = [pdx, pdy, pdz]';
    % Actual path
    [x,y,z] = position(u);
    pak = [x,y,z]';
    % Optimal controller
    df_obj = [2*(u(1)-u(2))+2*(u(1)-u(3));
             -2*(u(1)-u(2))+2*(u(2)-u(3));
             -2*(u(2)-u(3))-2*(u(1)-u(3));
             2*(u(4)-u(5))+2*(u(4)-u(6));
             -2*(u(4)-u(5))+2*(u(5)-u(6));
             -2*(u(5)-u(6))-2*(u(4)-u(6))];
    w = -alpha*df_obj; 
    duk = pinv(JHat)*(pdk2-pak)+(eye(6,6)-pinv(JHat)*JHat)*w;
    % Update u
    u = u + duk;
    if t==Td-step
        U(i,:) = u';
        break;
    end
    % Estimate Jacobian
    xk = [JHat(1,:),JHat(2,:),JHat(3,:)]';
    [x2, y2, z2] = position(u);
    dpk = [x2; y2; z2]-pak+delta(round(t/step)+1,:)';
    JHat = KalmanFilter(xk, duk, dpk, t);
    t
end
time = toc;
save data\circleTrackingData U step;
save data\circleParameter d Q R alpha iota Td;
