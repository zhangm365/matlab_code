clear ;
format long;

global mu gamma Td iota len d3 d5 d7;
mu = 500;
gamma = 500;
iota = 0.15;
Td = 20; 

step = 0.01;

len=[0.45 0.5 0.08];% manipulator length

d3=len(1);
d5=len(2);
d7=len(3);
%Initial value
% 7x1
q0 = [0;-pi/4;0;pi/2;0;-pi/4;0];

%3x7
JHat0 = [0,0.7518,0,0.4336,0,0.080,0
        0.0354,0,0.5566,0,-0.0566,0,0
        0,-0.0354,0,-0.3536,0,-1.7764e-17,0];


init = [q0; reshape(JHat0,[21,1])];
tic
[t, y] = ode45(@func, (0:step:Td),init);
toc
time = toc
size(t)
size(y)

save data\INITdata500 t y;
save data\parameter500 mu gamma Td iota q0 JHat0 len d3 d5 d7;