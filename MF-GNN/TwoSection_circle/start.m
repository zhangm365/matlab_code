clear;
format long;

global mu_t gamma_t iota Td d i tpre acf ;
mu_t = 100;
gamma_t = 100;
iota = 0.15;
Td = 20; 
d = 0.05;
i = 1;
tpre = 0;

% acf parameter
acf = 7;

%Initial value
q0 = [0.2000, 0.2200, 0.1800, 0.2000, 0.1800, 0.2200]';

JHat0 = [0.007,  1.064,  -1.482, 0.043, 0, 0;
         -1.591,  0.523,  0.512, -0.157, 0.217, 0.217;
         0.248, 0, 0.428, 0.217, 0.158, 0.158];  

init = [q0; reshape(JHat0,[18,1])];
tic
[t, y] = ode45(@func, (0:0.01:Td),init);
toc
time = toc
size(t)
size(y)

save data\INITdata100 t y;
save data\parameter100 mu_t gamma_t iota Td q0 JHat0 ;