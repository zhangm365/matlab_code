function dY = func(t, y)

global mu gamma  Td 
%%% 

q = y(1:5)';

JHat = reshape(y(6:15)',[2,5]);
% desired path xd   --square

% if t<=Td
%     desired_v=iota*(t-sin(2*pi*t/Td))/(4*pi*pi);
%     xdot=-desired_v;
%     ydot=0;
% elseif t<=2*Td
%     desired_v=iota*(t-sin(2*pi*(t-Td)/Td))/(4*pi*pi);
%     xdot=0;
%     ydot=-desired_v;
% elseif t<=3*Td
%     desired_v=iota*(t-sin(2*pi*(t-2*Td)/Td))/(4*pi*pi);
%     xdot=desired_v;
%     ydot=0;
% elseif t<=4*Td
%     desired_v=iota*(t-sin(2*pi*(t-3*Td)/Td))/(4*pi*pi);
%     xdot=0;
%     ydot=desired_v;
% end


% % quadrangle
if t <=5
    xdx = -0.20*4*t/Td+4.505;
    xdy = 0.10*4*t/Td+0.6895;
% xdz1 = 0.01*4*t/Td+0.3859;
elseif t <=10
    xdx = -0.20*4*(t-Td/4)/Td+4.305;
    xdy = -0.10*4*(t-Td/4)/Td+0.7895;
% xdz2 = -0.01*4*(t-Td/4)/Td+0.3959;
elseif t <=15
    xdx = 0.20*4*(t-2*Td/4)/Td+4.105;
    xdy = -0.10*4*(t-2*Td/4)/Td+0.6895;
% xdz3 = 0.01*4*(t-2*Td/4)/Td+0.3859;     
elseif t <= 20
    xdx = 0.20*4*(t-3*Td/4)/Td+4.305;
    xdy = 0.10*4*(t-3*Td/4)/Td+0.5895;
% xdz4 = -0.01*4*(T-3*Td/4)/Td+0.3959;
end

% rdx = [xdx1, xdx2, xdx3, xdx4];
% rdy = [xdy1, xdy2, xdy3, xdy4];
% rdz = [xdz1, xdz2, xdz3, xdz4];

xd = [xdx;xdy];

% % actual position xa
[xax, xay] = position5(q);
xa = [xax(6); xay(6)]; 

dq = JHat'*(mu*(xd-xa));

% % Jacobian matrix and its derivative
J = Jacob(q);

dJHat = gamma*(J*dq-JHat*dq)*dq';

DJHat = reshape(dJHat,[10,1]);

dY=[dq;DJHat];

t