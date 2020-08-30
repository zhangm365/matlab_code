function ZYNplot(tg)
	np=numrows(tg);
    erasemode='xor';
	wrist=1;
	base=0.0;
	reach=0.1;
    figure(gcf);%bring to the top
    grid on
	title('Links5');
	xlabel('X')
	ylabel('Y')
	zlabel('Z')
	set(gca,'drawmode','fast');%get handle of current axes, but ?
	line('xdata', [0;0], 'ydata', [0;0], 'zdata', [-reach;base], 'color', 'magenta');
	%create a line which we will subsequently modify. Set erase mode to xor for fast update
	hr=line('color', 'black', 'erasemode', erasemode);
	hx=line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;base], ...
		'color', 'red', 'erasemode', 'xor');
	hy=line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;base], ...
		'color', 'green', 'erasemode', 'xor');
	hz=line('xdata', [0;0], 'ydata', [0;0], 'zdata', [0;base], ...
		'color', 'blue', 'erasemode', 'xor');
	mag=0.3*reach;
    %save the handles in the passed robot object
	handle=[hr hx hy hz mag];%handle
	%assignin('base',inputname(1),p560);
    %i still don't know what the above sentence means?
    for repeat=1:10,
        for p=1:np,
            animate(handle,tg(p,:));
            for ii=1:5000,iii=ii^2;end;
        end
    end