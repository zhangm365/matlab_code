function dY = func_acf(t, y)

global mu gamma iota Td dJHat acf noise;

theta = y(1:5);
JHat = reshape(y(6:15),[2,5]);

% desired path
%quadrangle
if t < Td/4
    xdx = 451;
    xdy = iota*t*4/Td+68;
elseif t < 2*Td/4
    xdx = -iota*4*(t-Td/4)/Td+451;
    xdy = iota+68;
elseif t < 3*Td/4
    xdx = 451-iota;
    xdy = -iota*4*(t-2*Td/4)/Td+iota+68;
else
    xdx = iota*4*(t-3*Td/4)/Td+451-iota;
    xdy = 68;
end
rd = [xdx; xdy];

% derivative of the desired path
syms u;
if t < Td/4
    dotx = 0*u;
    doty = diff(iota*u*4/Td+68.9);
elseif t < 2*Td/4
    dotx = diff(-iota*4*(u-Td/4)/Td+450.5);
    doty = 0*u;
elseif t < 3*Td/4
    dotx = 0*u;
    doty = diff(-iota*4*(u-2*Td/4)/Td+iota+68.9);
else
    dotx = diff(iota*4*(u-3*Td/4)/Td+450.5-iota);
    doty = 0*u;
end
ddotx = diff(dotx);
ddoty = diff(doty);
u=t;
dRd = [eval(dotx); eval(doty)];
ddRd = [eval(ddotx); eval(ddoty)];

% actual path
[rax, ray] = position(theta);
ra = [rax; ray];

if t>10 && t<11
    noise = -50;
else
    noise = 0;
end
dTheta = pinv(JHat)*(dRd+gamma*ACF(rd-ra,acf)+noise*sin(t/Td*8*pi));%
ddTheta = pinv(JHat)*(ddRd-dJHat*dTheta+gamma*dACF(rd-ra,acf).*(dRd-JHat*dTheta));

[J, DJ] = Jacobian(theta, dTheta);
dJHat = (DJ*dTheta+J*ddTheta-JHat*ddTheta+mu*ACF(J*dTheta-JHat*dTheta,acf))*pinv(dTheta);

DJHat = reshape(dJHat,[10,1]);

dY=[dTheta;DJHat];

t


