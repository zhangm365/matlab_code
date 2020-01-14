clear all;
format long;
% global n m n1 n3m1 sBound A bP b dP dM In3m1 T mu radiusXY0 angleXY0 qP qM qDp qDm beta q0;
load SYSdata;

load SRDdata1;
load SRDdata2;
load SRDdata3;


%==plotting angles==

figure;
plot(t,qAll(:,1),'-',t,qAll(:,2),'--',t,qAll(:,3),'-.',t,qAll(:,4),':','linewidth',2);
hold on;
plot(t,qAll(:,5),'m--','linewidth',2.5)
text(38,-1.3,'time (s)')
text(0.8,1.4,'rad')
plot(t,-pi/12*ones(length(t),1),'k:');
plot(t,pi/12*ones(length(t),1),'k:');
plot(t,pi/6*ones(length(t),1),'k:');
plot(t,-pi/4*ones(length(t),1),'k:');
plot(t,pi/3*ones(length(t),1),'k:');
plot(t,pi/3*ones(length(t),1),'k:');
plot(t,-pi/3*ones(length(t),1),'k:');
legend('q1','q2','q3','q4','q5');

figure;
plot(t,dqAll);hold on;
xlabel('time (s)');
legend('dq1','dq2','dq3','dq4','dq5');

figure;
plot(t,xAll(:,1:5));hold on;
xlabel('time (s)');
title('x');
legend('x1','x2','x3','x4','x5');

figure;
plot(t,xAll(:,6:10));hold on;
xlabel('time (s)');
title('x');
legend('x6','x7','x8','x9','x10');

%==plotting 3d trajectories of joints==
figure;
grid on;
plot(j1px,j1py);hold on;
plot(j2px,j2py);hold on;
plot(j3px,j3py);hold on;
plot(j4px,j4py);hold on;
plot(j5px,j5py);hold on;
plot(j6px,j6py);hold on;

xlabel('time (s)');
title('joints Position');
legend('X','Y');

%==plotting end effector
figure;
plot(t,j6px,t,j6py);hold on;
xlabel('time (s)');
title('End Effector Position');
legend('X','Y');

figure;
plot(t,dposx,t,dposy);
xlabel('time (s)');
title('End Effector Velocity');
legend('dX','dY');

figure;
plot(t,erposx,t,erposy);
title('Position Error');
xlabel('time (s)');
legend('ex','ey');

figure;
plot(t,erdposx,t,erdposy);
title('Velocity Error');
xlabel('time (s)');
legend('edx','edy');

figure;
plot(j6px,j6py);
grid on;
hold on;
plot(rx,ry);
hold on;
xlabel('x');
ylabel('y');

[Ppx,Ppy]=position(qAll(1,:));
pos_initial=[Ppx Ppy]
[Ppx,Ppy]=position(qAll(length(t),:));
pos_final=[Ppx Ppy]
error=pos_initial-pos_final
