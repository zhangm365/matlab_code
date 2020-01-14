function doty=PA10net(t,y)

global W H I7 T mu r alpha k qP qM qDp qDm beta aBar q0 qd gamma;

for i=1:7,
   q(i,1)=y(i);
end
for i=1:10,
   u(i,1)=y(i+7);
end

% phi_sin=2*pi*sin(0.5*pi*t/T);
% phi=phi_sin*sin(0.5*pi*t/T);
% phiDot=phi_sin*pi*cos(0.5*pi*t/T)/T;
% xdot=-r*sin(phi)*phiDot;
% ydot=r*cos(phi)*cos(alpha)*phiDot;
% zdot=r*cos(phi)*sin(alpha)*phiDot;
% dr=[xdot;ydot;zdot];
dr=[0;0;0];
J=Jacob(q);
b=k*(q-qd);

qCp=min(beta*(aBar*qP-q),qDp);
qCm=max(beta*(aBar*qM-q),qDm);

m=3;myInf=1e10;
Pinfty=myInf*ones(m,1);
Minfty=-Pinfty;
pdnn_uP=[qCp;Pinfty];
pdnn_uM=[qCm;Minfty];

n=7;
pdnn_Q=eye(n,n);
pdnn_p=b;
pdnn_C=J;
pdnn_d=dr;

m=3;
pdnn_W=[pdnn_Q,-pdnn_C';pdnn_C,zeros(m,m)];
pdnn_q=[pdnn_p;-pdnn_d];
newW=u-(pdnn_W*u+pdnn_q);
uDot=gfunction(pdnn_uM,newW,pdnn_uP)-u;
gamma=mu;
uDot=gamma*(eye(n+m,n+m)+pdnn_W')*uDot;%a possible problem

qDot=u(1:n,1);

doty=[qDot;uDot];
t