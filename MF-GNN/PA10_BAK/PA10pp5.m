clear all;
format long;
global len d3 d5 d7 W H I7 T mu r alpha k qP qM qDp qDm beta aBar q0;
load SYSdata;

load SRDdata1;
load SRDdata2;
load SRDdata3;

figure;
plot3(j1px,j1py,j1pz);hold on;
plot3(j2px,j2py,j2pz);hold on;
plot3(j3px,j3py,j3pz);hold on;
plot3(j4px,j4py,j4pz);hold on;
plot3(j5px,j5py,j5pz);hold on;
plot3(j6px,j6py,j6pz);hold on;
plot3(j7px,j7py,j7pz);hold on;
reach=0.315;
for j=1:15:length(t),
    linksX=[0;j1px(j);j2px(j);j3px(j);j4px(j);j5px(j);j6px(j);j7px(j)];
    linksY=[0;j1py(j);j2py(j);j3py(j);j4py(j);j5py(j);j6py(j);j7py(j)];
    linksZ=[-reach;j1pz(j);j2pz(j);j3pz(j);j4pz(j);j5pz(j);j6pz(j);j7pz(j)];
    plot3(linksX,linksY,linksZ);hold on;
end;
xlabel('X');ylabel('Y');zlabel('Z');
grid on;

figure;
plot3(j1px,j1py,j1pz);hold on;
plot3(j2px,j2py,j2pz);hold on;
plot3(j3px,j3py,j3pz);hold on;
plot3(j4px,j4py,j4pz);hold on;
plot3(j5px,j5py,j5pz);hold on;
plot3(j6px,j6py,j6pz);hold on;
plot3(j7px,j7py,j7pz);hold on;
animate(qAll);
hold on;