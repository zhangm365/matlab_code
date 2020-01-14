function dY = func(t, y)

global mu gamma iota Td  
q = y(1:5);
JHat = reshape(y(6:15),[2,5]);

% desired path xd
% circle
xdx = iota*cos(2*pi*(sin(0.5*pi*t/Td)).^2)-iota+4.505;
xdy = iota*cos(pi/6)*sin(2*pi*(sin(0.5*pi*t/Td)).^2)+0.6894;
% xdz = iota*sin(pi/6)*sin(2*pi*(sin(0.5*pi*t/Td)).^2)+0.3859;

xd = [xdx; xdy];


% % actual position xa
[xax, xay] = position5(q);
xa = [xax(6); xay(6)]; 

%dq = pinv(JHat)*(dxd+mu*(xd-xa));
dq = JHat'*(mu*(xd-xa));

% % Jacobian matrix and its derivative
J = Jacob(q);

dJHat = gamma*(J*dq-JHat*dq)*dq';
DJHat = reshape(dJHat,[10,1]);

dY=[dq;DJHat];

t