%for PA10
clear all;
clc
format long;
global len d3 d5 d7 W H I7 T mu r alpha k qP qM qDp qDm beta aBar q0 qd gamma;

qa=[0;-pi/4;0;pi/2;0;-pi/4;0];
qb=[0;0;0;0;0;0;0];
qc=[0;+pi/4;0;pi/2;0;-pi/4;0];
% qd=[0.8887964591;-0.7324647506;-0.1642809290;1.2948304599;0.8548757909;1.2812562327;1.0000000000];
% qd=[0;-0.824160192982792;0;1.469171837762340;0;0.304312521655447;0];

qe=[0;+pi/4;0;2*pi/3;0;-pi/4;0];
qf=[0;-pi/4;0;pi/2;0;-pi/4;0];
qg=[0;-pi/4;0;pi/2;0;-pi/4;0];
qh=[0;+pi/4;0;pi/2;0;-pi/4;0];
qm=[0;0;0;0;0;0;0];
q0=qg;%may need adjust

qd=qm;
% r=0.20;alpha=pi/6;%may need adjust
k=3;%need adjust
q100=1;
qd100=1;
beta=1;%may need adjust
aBar=0.99;%may need adjust

% joint limits
qP=q100*[pi;1.7637;pi;2.6831;3/2*pi;pi;2*pi];

% I7=eye(7,7);
% W=I7;
% H=W;

qM=-qP;
qDp=qd100*[1;1;2;2;2*pi;2*pi;2*pi];
qDm=-qDp;

len=[0.45 0.5 0.08];% manipulator length
d3=len(1);
d5=len(2);
d7=len(3);


u0=zeros(10,1);%abitrary initial

T=3;

init=[q0;u0];
mu=1e7; %8
gamma=mu;

options=odeset('RelTol',1e-6,'AbsTol',1e-8*ones(17,1));
[t,y]=ode15s('PA10net',[0,T],init,options);%ode15s much better than ode45
size(t)
size(y)
save SYSdata len d3 d5 d7 W H I7 T mu r alpha k qP qM qDp qDm beta aBar q0 qd gamma;
save INITdata t y;