function dY = func(t, y)

global mu gamma iota Td  
q = y(1:6);
JHat = reshape(y(7:24),[3,6]);

% desired path xd
% circle
xdx = iota*cos(2*pi*(sin(0.5*pi*t/Td)).^2)-iota+0.0907;
xdy = iota*cos(pi/6)*sin(2*pi*(sin(0.5*pi*t/Td)).^2)+0.00001;
xdz = iota*sin(pi/6)*sin(2*pi*(sin(0.5*pi*t/Td)).^2)+0.3859;

xd = [xdx; xdy; xdz];


% % actual position xa
[xax, xay, xaz] = position(q);
xa = [xax; xay; xaz]; 

%dq = pinv(JHat)*(dxd+mu*(xd-xa));
dq = JHat'*(mu*(xd-xa));

% % Jacobian matrix and its derivative
J = Jacobian(q);

dJHat = gamma*(J*dq-JHat*dq)*dq';
DJHat = reshape(dJHat,[18,1]);

dY=[dq;DJHat];

t