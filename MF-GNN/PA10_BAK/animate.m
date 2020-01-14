function animate(tg)
    %VERSION of April 15th, 2001
	np=numrows(tg);
	n=7;
% erasemode='xor';
	reach=0.315;
    figure(gcf);%bring to the top
    grid on
	title('PA10');
	xlabel('X');ylabel('Y');zlabel('Z')
	set(gca,'SortMethod','depth');%get handle of current axes, but ?
 	line('XData', [0;0], 'YData', [0;0], 'ZData', [-reach;0], 'color', 'magenta');
	
    %create a line which we will subsequently modify. Set erase mode to xor for fast update
	hr=line('color', 'black');
% 	hx=line('XData', [0;0], 'YData', [0;0], 'ZData', [0;0], ...
% 		'color', 'red', 'erasemode', 'xor');
% 	hy=line('XData', [0;0], 'YData', [0;0], 'ZData', [0;0], ...
% 		'color', 'green', 'erasemode', 'xor');
% 	hz=line('XData', [0;0], 'YData', [0;0], 'ZData', [0;0], ...
% 		'color', 'blue', 'erasemode', 'xor');
    mag=0.2*reach;
    
	for repeat=1:15 %10000000,
        for p=1:np,
            [x,y,z,t]=position(tg(p,:));
            %compute the wrist axes
            xv=t*[mag;0;0;1];
            yv=t*[0;mag;0;1];
            zv=t*[0;0;mag;1];
            %update the line segments, wrist axis and links
%             set(hx,'XData',[t(1,4) xv(1)], 'YData', [t(2,4) xv(2)], ...
%                 'ZData', [t(3,4) xv(3)]);
%             set(hy,'XData',[t(1,4) yv(1)], 'YData', [t(2,4) yv(2)], ...
%                 'ZData', [t(3,4) yv(3)]);
%             set(hz,'XData',[t(1,4) zv(1)], 'YData', [t(2,4) zv(2)], ...
%                 'ZData', [t(3,4) zv(3)]);
            set(hr,'XData',x,'YData',y,'ZData', z);
            drawnow        
            pause(0.00001)
        end
    end