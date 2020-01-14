function dY = func(t, y)

global mu gamma iota Td  
q = y(1:6);
JHat = reshape(y(7:24),[3,6]);

% desired path xd
% butterfly
xdx = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*cos(t./Td.*2*pi)+iota+0.0907;
xdy = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi);
xdz = iota*cos(pi/6)*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi)+0.3859;

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