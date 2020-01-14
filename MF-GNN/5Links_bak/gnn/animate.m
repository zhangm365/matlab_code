function animate(tg)
    %VERSION of April 15th, 2001
	np=numrows(tg);
%     erasemode='xor';
    figure(gcf);%bring to the top
    grid on
	set(gca,'SortMethod','depth');%get handle of current axes, but ?
	line('xdata', [0;0], 'ydata', [0;0], 'color', 'magenta');
	
    %create a line which we will subsequently modify. Set erase mode to xor for fast update
	hr=line('color', 'black' );
	hx=line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], ...
		'color', 'red');
	hy=line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;0], ...
		'color', 'green');
    
    for repeat=1:5,
        for p=1:np,
            [x,y]=position(tg(p,:));
            %update the line segments, wrist axis and links
            set(hr,'xdata',x,'ydata',y,'linewidth',2);
            drawnow        
            for ii=1:1000000,iii=ii^2;end;
        end
        axis equal
    end
    