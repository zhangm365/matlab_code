function dY = func(t, y)

global mu gamma iota Td subTime noise acf tdThetas index deltaT
q = y(1:6);
JHat = reshape(y(7:24),[3,6]);

% desired path xd

xdx = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*cos(t./Td.*2*pi)+iota+90.7;
xdy = iota*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi);
xdz = iota*cos(pi/6)*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi)+385.9;
xd = [xdx; xdy; xdz];

% derivative and second derivative of xd
dotx = iota*cos((2*pi*t)/Td)*((16*pi*sin((8*pi*t)/Td))/Td + (2*pi*cos((2*pi*t)/Td)*exp(sin((2*pi*t)/Td)))/Td + (5*pi*cos(pi/24 - (pi*t)/(6*Td))*sin(pi/24 - (pi*t)/(6*Td))^4)/(6*Td)) + (2*iota*pi*sin((2*pi*t)/Td)*(2*cos((8*pi*t)/Td) - exp(sin((2*pi*t)/Td)) + sin(pi/24 - (pi*t)/(6*Td))^5))/Td;
doty = iota*sin((2*pi*t)/Td)*((16*pi*sin((8*pi*t)/Td))/Td + (2*pi*cos((2*pi*t)/Td)*exp(sin((2*pi*t)/Td)))/Td + (5*pi*cos(pi/24 - (pi*t)/(6*Td))*sin(pi/24 - (pi*t)/(6*Td))^4)/(6*Td)) - (2*iota*pi*cos((2*pi*t)/Td)*(2*cos((8*pi*t)/Td) - exp(sin((2*pi*t)/Td)) + sin(pi/24 - (pi*t)/(6*Td))^5))/Td;
dotz = (3^(1/2)*iota*sin((2*pi*t)/Td)*((16*pi*sin((8*pi*t)/Td))/Td + (2*pi*cos((2*pi*t)/Td)*exp(sin((2*pi*t)/Td)))/Td + (5*pi*cos(pi/24 - (pi*t)/(6*Td))*sin(pi/24 - (pi*t)/(6*Td))^4)/(6*Td)))/2 - (3^(1/2)*iota*pi*cos((2*pi*t)/Td)*(2*cos((8*pi*t)/Td) - exp(sin((2*pi*t)/Td)) + sin(pi/24 - (pi*t)/(6*Td))^5))/Td;
dxd = [dotx; doty; dotz];

% actual position xa
[xax, xay, xaz] = position(q);
xa = [xax; xay; xaz]; 

% if t>10 && t<11
%     noise = -50;
% else
%     noise = 0;
% end
% Equation 1
dq = pinv(JHat)*(dxd+gamma*ACF(xd-xa, acf)+noise*sin(t/Td*8*pi));

% Approximate ddq based on Euler formula
while t ~= 0 && t <= tdThetas(1, index)
    index = index-1;
end
if t == 0
    ddq = [0; 0; 0; 0; 0; 0];
else
    ddq = (dq - tdThetas(2:7, index))/(t - tdThetas(1, index));
end
% Update 'tdThetas'
if t - tdThetas(1, index) > deltaT
    index = index + 1;
    tdThetas(1, index) = t;
    tdThetas(2:7, index) = dq;
end

% Jacobian matrix and its derivative
tj = clock;
[J, DJ] = Jacobian2(q, dq);
subTime = subTime + etime(clock, tj);
% Equation 2
dJHat = (DJ*dq+J*ddq-JHat*ddq+mu*ACF(J*dq-JHat*dq, acf))*pinv(dq);
DJHat = reshape(dJHat,[18,1]);

dY=[dq;DJHat];
t
end
