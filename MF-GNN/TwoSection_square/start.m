clear all;
format long;

global mu gamma iota Td d i tpre ;
mu = 50;
gamma = 50;
iota = 0.15;
Td = 10; 
d = 0.05;
i = 1;
tpre = 0;

%Initial value
q0 = [0.2000, 0.2200, 0.1800, 0.2000, 0.1800, 0.2200]';

JHat0 = [0.0756, 3.3976, -3.2464, 0.0756, 1.2099, -1.0587;
            -3.9294, 1.9647, 1.9647, -1.3098, 0.6549, 0.6549;
            0.3216, -0.5503, 1.1936, 0.3216, 0.1457, 0.4975];


init = [q0; reshape(JHat0,[18,1])];
tic
[t, y] = ode45(@func, (0:0.01:Td),init);
toc
time = toc
size(t)
size(y)

save data\INITdata100 t y;
save data\parameter100 mu gamma iota Td q0 JHat0 ;