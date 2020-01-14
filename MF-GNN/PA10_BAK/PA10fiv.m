clear all;
format long;
% global len d3 d5 d7 W H I7 T mu r alpha k qP qM qDp qDm beta aBar q0 qd;
load SYSdata;

load SRDdata1;
load SRDdata2;
load SRDdata3;

figure;
plot3(j7px,j7py,j7pz);hold on;
for j=1:length(t),
    linksX=[j1px(j);j2px(j);j3px(j);j4px(j);j5px(j);j6px(j);j7px(j)];
    linksY=[j1py(j);j2py(j);j3py(j);j4py(j);j5py(j);j6py(j);j7py(j)];
    linksZ=[j1pz(j);j2pz(j);j3pz(j);j4pz(j);j5pz(j);j6pz(j);j7pz(j)];
    plot3(linksX,linksY,linksZ);hold on;
end;
title('Black-white PA10');
xlabel('X');ylabel('Y');zlabel('Z');
grid on;

figure;
plot3(j7px,j7py,j7pz);hold on;
for j=1:length(t),
    reach=0.315;
 	joints01=line('XData', [0;0], 'YData', [0;0], 'ZData', [-reach;0], 'color', 'magenta');
    joints12=line('xdata',[j1px(j);j2px(j)],'ydata',[j1py(j);j2py(j)],'zdata',[j1pz(j);j2pz(j)],...
        'color', 'red');
    joints23=line('xdata',[j2px(j);j3px(j)],'ydata',[j2py(j);j3py(j)],'zdata',[j2pz(j);j3pz(j)],...
        'color', 'cyan');
    joints34=line('xdata',[j3px(j);j4px(j)],'ydata',[j3py(j);j4py(j)],'zdata',[j3pz(j);j4pz(j)],...
        'color', 'magenta');
    joints45=line('xdata',[j4px(j);j5px(j)],'ydata',[j4py(j);j5py(j)],'zdata',[j4pz(j);j5pz(j)],...
        'color', 'blue');
    joints56=line('xdata',[j5px(j);j6px(j)],'ydata',[j5py(j);j6py(j)],'zdata',[j5pz(j);j6pz(j)],...
        'color', 'green');
    joints67=line('xdata',[j6px(j);j7px(j)],'ydata',[j5py(j);j7py(j)],'zdata',[j5pz(j);j7pz(j)],...
        'color', 'red');
    drawnow
end;
title('colourful PA10');
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

n=7;
reach=0.315;
p=1;
 line('XData', [0;0], 'YData', [0;0], 'ZData', [0;0], 'color', 'magenta');
 hr=line('color', 'green');
mag=0.2*reach;
[x,y,z,t]=position(qAll(p,:));
 %compute the wrist axes
 xv=t*[mag;0;0;1];
 yv=t*[0;mag;0;1];
 zv=t*[0;0;mag;1];
 %update the line segments, wrist axis and links
%   hx=line('XData',[t(1,4) xv(1)], 'YData', [t(2,4) xv(2)], ...
%          'ZData', [t(3,4) xv(3)]);
%   hy=line('XData',[t(1,4) yv(1)], 'YData', [t(2,4) yv(2)], ...
%          'ZData', [t(3,4) yv(3)]);
%   hz=line('XData',[t(1,4) zv(1)], 'YData', [t(2,4) zv(2)], ...
%          'ZData', [t(3,4) zv(3)]);
set(hr,'XData',x,'YData',y,'ZData', z);
 
animate(qAll);
hold on;