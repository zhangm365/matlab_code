clear ;
format long;

global mu gamma Td;
mu = 200;
gamma = 200;

Td = 20; 



%Initial value

q0 = [-pi/12;pi/12;pi/6;-pi/4;pi/3];

%2X5 matrix
JHat0 = [-0.690,-0.948,-0.948,-0.4487,-0.707;...
                4.505,3.539,2.539,1.673,0.707];

init=[q0;reshape(JHat0,[10,1])];


tic
[t,y]=ode45(@func,(0:0.01:Td),init);
toc

time = toc

size(t)
size(y)

save data\INITdata50 t y;
save data\parameter50 mu gamma Td q0 ;