clear all;
format long;
global len d3 d5 d7 W H I7 T mu r alpha k qP qM qDp qDm beta aBar q0 qd gamma;

load SYSdata;
load SNDdata;

%q0
[Ppx,Ppy,Ppz,PpTr]=position(q0);
ix=Ppx(7);iy=Ppy(7);iz=Ppz(7);
for jj=1:length(t),
   qjj=qAll(jj,:)';%simulated end effector position
   [Ppx,Ppy,Ppz,PpTr]=position(qjj);
   %-----------------
   j1px(jj,1)=Ppx(1);
   j2px(jj,1)=Ppx(2);
   j3px(jj,1)=Ppx(3);
   j4px(jj,1)=Ppx(4);
   j5px(jj,1)=Ppx(5);
   j6px(jj,1)=Ppx(6);
   j7px(jj,1)=Ppx(7);
   %-----------------
   j1py(jj,1)=Ppy(1);
   j2py(jj,1)=Ppy(2);
   j3py(jj,1)=Ppy(3);
   j4py(jj,1)=Ppy(4);
   j5py(jj,1)=Ppy(5);
   j6py(jj,1)=Ppy(6);
   j7py(jj,1)=Ppy(7);
   %-----------------
   j1pz(jj,1)=Ppz(1);
   j2pz(jj,1)=Ppz(2);
   j3pz(jj,1)=Ppz(3);
   j4pz(jj,1)=Ppz(4);
   j5pz(jj,1)=Ppz(5);
   j6pz(jj,1)=Ppz(6);
   j7pz(jj,1)=Ppz(7);
   %-----------------
   J=Jacob(qjj);
   M(jj)=det(J*J');
   nearness(jj)=(qjj-qd)'*(qjj-qd);
   b=k*(qjj-qd);   
   dqjj=uAll(jj,1:7)';%possible   
   dqAll(jj,:)=dqjj';
   %-----------------
   dpos=J*dqjj;
   dposx(jj,1)=dpos(1);
   dposy(jj,1)=dpos(2);
   dposz(jj,1)=dpos(3);
   %--Desired rt and ddrt--
%    phi_sin=2*pi*sin(0.5*pi*t(jj)/T);
%    phi=phi_sin*sin(0.5*pi*t(jj)/T);
%    phiDot=phi_sin*pi*cos(0.5*pi*t(jj)/T)/T;
%    rx(jj,1)=r*cos(phi)+ix-r;
%    ry(jj,1)=r*cos(alpha)*sin(phi)+iy;
%    rz(jj,1)=r*sin(alpha)*sin(phi)+iz;
%    rxdot(jj,1)=-r*sin(phi)*phiDot;
%    rydot(jj,1)=r*cos(phi)*cos(alpha)*phiDot;
%    rzdot(jj,1)=r*cos(phi)*sin(alpha)*phiDot;
   rx(jj,1)=ix;
   ry(jj,1)=iy;
   rz(jj,1)=iz;
   rxdot(jj,1)=0;
   rydot(jj,1)=0;
   rzdot(jj,1)=0;
end

%--Errors-
erposx=rx-j7px;
erposy=ry-j7py;
erposz=rz-j7pz;
erdposx=rxdot-dposx;
erdposy=rydot-dposy;
erdposz=rzdot-dposz;

save SRDdata1 t qAll dqAll uAll rx ry rz dposx dposy dposz M nearness;
save SRDdata2 erposx erposy erposz erdposx erdposy erdposz;
save SRDdata3 j1px j2px j3px j4px j5px j6px j7px j1py j2py j3py j4py j5py j6py j7py j1pz j2pz j3pz j4pz j5pz j6pz j7pz;