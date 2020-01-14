clear all;
format long;
global len d3 d5 d7 W H I7 T mu r alpha k qP qM qDp qDm beta aBar q0 qd;
load SYSdata;

load SRDdata1;
load SRDdata2;
load SRDdata3;

%==plotting angles==
figure;
plot(t,qAll);hold on;
%axis([0 10 -2.5 2.5]);
title('Simulated theta');xlabel('t (Second)');
legend('q1','q2','q3','q4','q5','q6','q7');

figure;
plot(t,M);hold on;
title('M(q)');
xlabel('t (Second)');
legend('M(q)');


figure;
plot(t,nearness);hold on;
title('nearness');
xlabel('t (Second)');
legend('nearness');




figure;
plot(t,dqAll);hold on;
title('Simulated dotTheta');
xlabel('t (Second)');
legend('dq1','dq2','dq3','dq4','dq5','dq6','dq7');

figure;
plot(t,uAll);hold on;
xlabel('t (Second)');
title('dual variable u');
legend('u1','u2','u3','u4','u5','u6','u7','u8','u9','u10');

%==plotting 3d trajectories of joints==
figure;
grid on;
plot3(j1px,j1py,j1pz);hold on;
plot3(j2px,j2py,j2pz);hold on;
plot3(j3px,j3py,j3pz);hold on;
plot3(j4px,j4py,j4pz);hold on;
plot3(j5px,j5py,j5pz);hold on;
plot3(j6px,j6py,j6pz);hold on;
plot3(j7px,j7py,j7pz);hold on;
xlabel('t (Second)');
title('joints Position');
legend('X','Y','Z');

%==plotting end effector
figure;
plot(t,j7px,t,j7py,t,j7pz);hold on;
%axis([0 10 -0.5 1]);
xlabel('t (Second)');
title('End Effector Position');
legend('X','Y','Z');

figure;
plot(t,dposx,t,dposy,t,dposz);
%axis([0 10 -0.2 0.2]);
xlabel('t (Second)');
title('End Effector Velocity');
legend('dX','dY','dZ');

figure;
plot(t,erposx,t,erposy,t,erposz);
title('Position Error');
xlabel('t (Second)');
legend('ex','ey','ez');

figure;
plot(t,erdposx,t,erdposy,t,erdposz);
title('Velocity Error');
xlabel('t (Second)');
legend('edx','edy','edz');

figure;
plot3(j7px,j7py,j7pz);
grid on;
hold on;
plot3(rx,ry,rz);
hold on;
xlabel('x');
ylabel('y');
zlabel('z');


[Ppx,Ppy]=position(qAll(1,:));
pos_initial=[Ppx Ppy]
[Ppx,Ppy]=position(qAll(length(t),:));
pos_final=[Ppx Ppy]
qd
qend=qAll(end,:)'
qerr=qAll(end,:)'-qd
