clear all;
format long;
addpath('functions');
global mu gamma iota Td d subTime noise acf tdThetas index deltaT;
mu = 5; % Convergence rate
gamma = 5;
iota = 10;
Td = 20; % Duration of the task
d = 50; % Parameter of the continuum robot
noise = 0;
deltaT = 1; % Euler formula
% Record 't' and 'dq' every time 'deltaT'
tdThetas(:,1) = [0; 0; 0; 0; 0; 0; 0];
index = 1;
% activation functions 1:linear 2:sbp 3:caf-znn 4:na-znn1 5:na-znn2
% 6:power-sigmoid
acf = 6;
subTime = 0;
     
%Initial value
step = 0.01;
q0 =[200, 210, 190, 200, 210, 190]';
JHat0 = [0.03,3.34,-3.26,0.11,1.18,-0.95;
    -3.91,1.95,1.95,-1.32,0.66,0.66;
    0.33,-0.62,1.28,0.31,-0.12,0.74];
init = [q0; reshape(JHat0,[18,1])];
Rel = 3e-5;
Abs = 3e-3;
options = odeset('RelTol', Rel, 'Abstol', Abs*ones(24,1));
t0 = clock;
[t, y] = ode45(@func, (0:step:Td),init,options);
TotalTime = etime(clock, t0);
size(t)
size(y)

save (['data\INITdata',num2str(gamma),'_ACF',num2str(acf),'_n'], 't', 'y');
save (['data\parameter',num2str(gamma),'_ACF',num2str(acf),'_n'], 'mu', 'gamma', 'iota', 'Td', 'd', 'q0', 'JHat0', 'TotalTime', 'subTime','step', 'noise', 'Rel', 'Abs', 'acf', 'deltaT');