q0 = [0;-pi/4;0;pi/2;0;-pi/4;0];
global len d3 d5 d7;
len=[0.45 0.5 0.08];% manipulator length

d3=len(1);
d5=len(2);
d7=len(3);

J0 = Jacob(q0);
[x0,y0,z0] = position(q0);
