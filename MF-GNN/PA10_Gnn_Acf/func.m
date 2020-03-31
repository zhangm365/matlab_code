function dY = func(t, y)

global mu_t gamma_t iota Td acf 
q = y(1:7);
JHat = reshape(y(8:28),[3,7]);

% desired path xd 
% circle
xdx = iota*cos(2*pi*(sin(0.5*pi*t/Td)).^2)-iota+0.03535;
xdy = iota*cos(pi/6)*sin(2*pi*(sin(0.5*pi*t/Td)).^2)+0.00000;
xdz = iota*sin(pi/6)*sin(2*pi*(sin(0.5*pi*t/Td)).^2)+0.75175;

xd = [xdx xdy xdz]';


% % actual position xa

[xax, xay, xaz] = position(q);

xa = [xax(7)  xay(7) xaz(7)]'; 

%dq = pinv(JHat)*(dxd+mu*(xd-xa));
%dq = JHat'*(mu*(xd-xa));
% add the activate function

dq = JHat'*(mu_t*ACF(xd-xa,acf));

% % Jacobian matrix and its derivative
J = Jacob(q);

%dJHat = gamma*(J*dq-JHat*dq)*dq';
% add the activate function

dJHat = gamma_t*ACF((J*dq-JHat*dq),acf)*dq';

DJHat = reshape(dJHat,[21,1]);

dY=[dq;DJHat];

t