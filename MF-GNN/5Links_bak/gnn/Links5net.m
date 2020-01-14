function doty=Links5net(t,y)

global T n m aa;

n=5;
m=2;

for i=1:n,
 q(i,1)=y(i);
end
    X(1,1)=y(6);
    X(2,1)=y(7);
    X(3,1)=y(8);
    X(4,1)=y(9);
    X(5,1)=y(10);
    X(1,2)=y(11);
    X(2,2)=y(12);
    X(3,2)=y(13);
    X(4,2)=y(14);
    X(5,2)=y(15);
%--------------------------------------------»­Õý·½ÐÎ
if t<=T,
    desired_v=aa*T*(1-cos(2*pi*t/T))/(2*pi);
    xdot=-desired_v;
    ydot=0;
elseif t<=2*T,
    desired_v=aa*T*(1-cos(2*pi*(t-T)/T))/(2*pi);
    xdot=0;
    ydot=-desired_v;
elseif t<=3*T,
    desired_v=aa*T*(1-cos(2*pi*(t-2*T)/T))/(2*pi);
    xdot=desired_v;
    ydot=0;
elseif t<=4*T,
    desired_v=aa*T*(1-cos(2*pi*(t-3*T)/T))/(2*pi);
    xdot=0;
    ydot=desired_v;
end
dr=[xdot;ydot];
%--------------------------------------------
dq=X*dr;
J=Jacob(q);
dX=xfunctionNEW(J,X);%select xfunction via af=? % X 5*2
doty=[dq;dX];