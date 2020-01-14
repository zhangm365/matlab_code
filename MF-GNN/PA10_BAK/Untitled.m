for repeat=1:1000,
        for p=1:np,
            [x,y,z,t]=position(tg(p,:));
            %compute the wrist axes
            xv=t*[mag;0;0;1];
            yv=t*[0;mag;0;1];
            zv=t*[0;0;mag;1];
            %update the line segments, wrist axis and links
            set(hx,'xdata',[t(1,4) xv(1)], 'ydata', [t(2,4) xv(2)], ...
                'zdata', [t(3,4) xv(3)]);
            set(hy,'xdata',[t(1,4) yv(1)], 'ydata', [t(2,4) yv(2)], ...
                'zdata', [t(3,4) yv(3)]);
            set(hz,'xdata',[t(1,4) zv(1)], 'ydata', [t(2,4) zv(2)], ...
                'zdata', [t(3,4) zv(3)]);
            set(hr,'xdata',x,'ydata',y,'zdata', z);
            drawnow        
            for ii=1:10000,iii=ii^2;end;
        end
    end