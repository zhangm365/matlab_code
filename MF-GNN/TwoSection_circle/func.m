function dY = func(t, y)

global mu_t gamma_t iota Td acf
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
dq = JHat'*(mu_t*ACF(xd-xa,acf));
% dq = JHat'*(mu_t*(xd-xa));
% % Jacobian matrix and its derivative
J = Jacobian(q);

dJHat = gamma_t*ACF((J*dq-JHat*dq),acf)*dq';
% dJHat = gamma_t*(J*dq-JHat*dq)*dq';
DJHat = reshape(dJHat,[18,1]);

dY=[dq;DJHat];

t