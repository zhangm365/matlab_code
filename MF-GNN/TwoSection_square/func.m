function dY = func(t, y)

global mu gamma iota Td  
q = y(1:6);
JHat = reshape(y(7:24),[3,6]);

% desired path xd
% square
if t <=2.5
    xdx = -0.03*4*t/Td+0.0907;
    xdy = 0.06*4*t/Td+0.00001;
    xdz = 0.01*4*t/Td+0.3859;
elseif t <=5
    xdx = -0.03*4*(t-Td/4)/Td+0.0607;
    xdy = -0.06001*4*(t-Td/4)/Td+0.06001;
    xdz = -0.01*4*(t-Td/4)/Td+0.3959;
elseif t <=7.5
    xdx = 0.03*4*(t-2*Td/4)/Td+0.0307;
    xdy = -0.06*4*(t-2*Td/4)/Td;
    xdz = 0.01*4*(t-2*Td/4)/Td+0.3859;      
elseif t <= 10
    xdx = 0.03*4*(t-3*Td/4)/Td+0.0607;
    xdy = 0.06001*4*(t-3*Td/4)/Td-0.06;
    xdz = -0.01*4*(t-3*Td/4)/Td+0.3959;
end

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