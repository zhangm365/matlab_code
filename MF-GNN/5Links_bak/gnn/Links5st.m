clc;
clear all;
format long;

global mu T m r alpha af n n1 aa k;
mu=1e4;
aa=0.0289;
af=1;%or 4
n1=n+1;
n=5;
m=2;

qa=[0;0;0;0;0];
qb=[0;-pi/4;0;pi/2;0];
qc=[0;+pi/4;0;pi/2;0];
qd=[0;-pi/4;0;2*pi/3;0];
qe=[0;+pi/4;0;2*pi/3;0];
qf=[0;-pi/4;0;pi/2;0];
qg=[0;-pi/4;0;pi/2;0];
qh=[pi/4;pi/4;pi/4;pi/4;pi/4];
qi=[-pi/12;pi/12;pi/6;-pi/4;pi/3];
q0=qi;%may need adjust 
%circle data ≥ı ºªØŒª÷√
T=10;

% dq0=zeros(5,1);
[x0,y0]=position(q0);
J = Jacob(q0);

X0=zeros(5,2);%(rand(7,3)-0.5*ones(7,3))*6;%or any initial 7x3 values
init=[q0;X0(:,1);X0(:,2)];
options=odeset('RelTol',1e-6,'AbsTol',1e-8*ones(5+5*2,1));

[t,y]=ode15s('Links5net',[0,4*T],init,options);%ode15s better than ode45

size(t)
size(y)
save SYSdata mu T m r alpha q0 af n k aa;
save INITdata t y;