clear all;
format long;
% global n m n1 n3m1 sBound A bP b dP dM In3m1 T mu radiusXY0 angleXY0 qP qM qDp qDm beta q0;
load SYSdata;
load SRDdata1;
load SRDdata2;
load SRDdata3;

figure;
plot(j6px,j6py);hold on;
for j=1:length(t),
    linksX=[j1px(j);j2px(j);j3px(j);j4px(j);j5px(j);j6px(j)];
    linksY=[j1py(j);j2py(j);j3py(j);j4py(j);j5py(j);j6py(j)];
    plot(linksX,linksY);
    hold on;
end;
title('Black-white IAN');
xlabel('X');ylabel('Y');
grid on;

figure;
plot(j4px,j4py);hold on;
for j=1:length(t),
    joints12=line('xdata',[j1px(j);j2px(j)],'ydata',[j1py(j);j2py(j)],...
        'color', 'red');
    joints23=line('xdata',[j2px(j);j3px(j)],'ydata',[j2py(j);j3py(j)],...
        'color', 'cyan');
    joints34=line('xdata',[j3px(j);j4px(j)],'ydata',[j3py(j);j4py(j)],...
        'color', 'magenta');
    joints45=line('xdata',[j4px(j);j5px(j)],'ydata',[j4py(j);j5py(j)],...
        'color', 'black');
    joints56=line('xdata',[j5px(j);j6px(j)],'ydata',[j5py(j);j6py(j)],...
        'color', 'black');
    drawnow
end;
title('colourful IAN');
xlabel('X');ylabel('Y');
grid on;

figure;
plot(j1px,j1py,'o',j2px,j2py,'--',j3px,j3py,'-.',j4px,j4py,':','linewidth',2);
hold on;
plot(j5px,j5py,'m--','linewidth',2.5);
hold on;
plot(j6px,j6py,'--.','linewidth',2);
hold on;
legend('Joint1','Joint2','Joint3','Joint4','Joint5','Joint6');
text(2.3,-2.3,'X (m)');
text(0.09,0.8,'Y (m)');
% plot(j1px,j1py);hold on;
% plot(j2px,j2py);hold on;
% plot(j3px,j3py);hold on;
% plot(j4px,j4py);hold on;
% plot(j5px,j5py);hold on;
% plot(j6px,j6py);hold on;

    j=1;
    joints12=line('xdata',[j1px(j);j2px(j)],'ydata',[j1py(j);j2py(j)],...
        'color', 'green','linewidth',2.5);
    joints23=line('xdata',[j2px(j);j3px(j)],'ydata',[j2py(j);j3py(j)],...
        'color', 'green','linewidth',2.5);
    joints34=line('xdata',[j3px(j);j4px(j)],'ydata',[j3py(j);j4py(j)],...
        'color', 'green','linewidth',2.5);
     joints45=line('xdata',[j4px(j);j5px(j)],'ydata',[j4py(j);j5py(j)],...
         'color', 'green','linewidth',2.5);
     joints56=line('xdata',[j5px(j);j6px(j)],'ydata',[j5py(j);j6py(j)],...
         'color', 'green','linewidth',2.5);
    drawnow
    animate(qAll);
    drawnow
hold on;