clear all;
format long;
global aa T k q0;
load SYSdata;
load SNDdata;

jj=length(t);qjj=qAll(jj,:)';

[Ppx,Ppy]=position(q0);
ix=Ppx(6);iy=Ppy(6);

desired_p=aa*T*(T-T*sin(2*pi*T/T)/(2*pi))/(2*pi);
ix1=-desired_p+ix;%not sure
iy1=iy;

desired_p=aa*T*(T-T*sin(2*pi*T/T)/(2*pi))/(2*pi);
ix2=ix1;%not sure
iy2=-desired_p+iy1;

desired_p=aa*T*(T-T*sin(2*pi*T/T)/(2*pi))/(2*pi);
ix3=desired_p+ix2;%not sure
iy3=iy2;

%%%======Init value=========%%%%%
j1px = zeros(476,1);
j2px = zeros(476,1);
j3px = zeros(476,1);
j4px = zeros(476,1);
j5px = zeros(476,1);
j6px = zeros(476,1);


j1py = zeros(476,1);
j2py = zeros(476,1);
j3py = zeros(476,1);
j4py = zeros(476,1);
j5py = zeros(476,1);
j6py = zeros(476,1);

for jj=1:length(t),
        qjj=qAll(jj,:)';%simulated end effector position
        [Ppx,Ppy]=position(qjj);
       %-----------------
       j1px(jj,1)=Ppx(1);
       j2px(jj,1)=Ppx(2);
       j3px(jj,1)=Ppx(3);
       j4px(jj,1)=Ppx(4);
       j5px(jj,1)=Ppx(5);
       j6px(jj,1)=Ppx(6);

       %-----------------
       j1py(jj,1)=Ppy(1);
       j2py(jj,1)=Ppy(2);
       j3py(jj,1)=Ppy(3);
       j4py(jj,1)=Ppy(4);
       j5py(jj,1)=Ppy(5);
       j6py(jj,1)=Ppy(6);

       %--Desired rt and ddrt----------------------期望正方形的位置

        if t(jj)<=T,
            desired_v=aa*T*(1-cos(2*pi*t(jj)/T))/(2*pi);
            rxdot(jj,1)=-desired_v;
            rydot(jj,1)=0;
            desired_p=aa*T*(t(jj)-T*sin(2*pi*t(jj)/T)/(2*pi))/(2*pi);
            rx(jj,1)=-desired_p+ix;%not sure
            ry(jj,1)=iy;
        elseif t(jj)<=2*T,
            desired_v=aa*T*(1-cos(2*pi*(t(jj)-T)/T))/(2*pi);
            rxdot(jj,1)=0;
            rydot(jj,1)=-desired_v;
            desired_p=aa*T*((t(jj)-T)-T*sin(2*pi*(t(jj)-T)/T)/(2*pi))/(2*pi);
            rx(jj,1)=ix1;%not sure
            ry(jj,1)=-desired_p+iy1;
        elseif t(jj)<=3*T,
            desired_v=aa*T*(1-cos(2*pi*(t(jj)-2*T)/T))/(2*pi);
            rxdot(jj,1)=desired_v;
            rydot(jj,1)=0;
            desired_p=aa*T*((t(jj)-2*T)-T*sin(2*pi*(t(jj)-2*T)/T)/(2*pi))/(2*pi);
            rx(jj,1)=desired_p+ix2;%not sure
            ry(jj,1)=iy2;
        elseif t(jj)<=4*T,
            desired_v=aa*T*(1-cos(2*pi*(t(jj)-3*T)/T))/(2*pi);
            rxdot(jj,1)=0;
            rydot(jj,1)=desired_v;
            desired_p=aa*T*((t(jj)-3*T)-T*sin(2*pi*(t(jj)-3*T)/T)/(2*pi))/(2*pi);
            rx(jj,1)=ix3;%not sure
            ry(jj,1)=desired_p+iy3;
        end
     drjj=[rxdot(jj,1);rydot(jj,1)];   
   %-----------------
   
   myJinv=xAll(jj,:);%actual
   myJinv=[myJinv(1),myJinv(6);myJinv(2),myJinv(7);myJinv(3),myJinv(8);myJinv(4),myJinv(9);myJinv(5),myJinv(10)];
   dqjj=myJinv*drjj; %change
   J=Jacob(qjj);
   dqAll(jj,:)=dqjj';
   %-----------------   
   dpos=J*dqjj;
   dposx(jj,1)=dpos(1);
   dposy(jj,1)=dpos(2);       

end 

%--Errors-
erposx=rx-j6px;
erposy=ry-j6py;
erdposx=rxdot-dposx;
erdposy=rydot-dposy;

save SRDdata1 t qAll dqAll xAll rx ry rxdot rydot k q0;
save SRDdata2 erdposx erdposy dposx dposy erposx erposy;
save SRDdata3 j1px j2px j3px j4px j5px j6px j1py j2py j3py j4py j5py j6py;