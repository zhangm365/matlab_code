function J= Jacobian(q)

syms q1 q2 q3 q4 q5 q6
qs = [q1, q2, q3, q4, q5, q6];

     
[x, y, z] = position(qs);

dxdq1 = diff(x, q1);dxdq2 = diff(x, q2);dxdq3 = diff(x, q3);dxdq4 = diff(x, q4);dxdq5 = diff(x, q5);dxdq6 = diff(x, q6);
dydq1 = diff(y, q1);dydq2 = diff(y, q2);dydq3 = diff(y, q3);dydq4 = diff(y, q4);dydq5 = diff(y, q5);dydq6 = diff(y, q6);
dzdq1 = diff(z, q1);dzdq2 = diff(z, q2);dzdq3 = diff(z, q3);dzdq4 = diff(z, q4);dzdq5 = diff(z, q5);dzdq6 = diff(z, q6);

    
q1 = q(1);q2=q(2);q3=q(3);q4=q(4);q5=q(5);q6=q(6);

dxdq = [eval(dxdq1), eval(dxdq2), eval(dxdq3), eval(dxdq4), eval(dxdq5), eval(dxdq6)];
dydq = [eval(dydq1), eval(dydq2), eval(dydq3), eval(dydq4), eval(dydq5), eval(dydq6)];
dzdq = [eval(dzdq1), eval(dzdq2), eval(dzdq3), eval(dzdq4), eval(dzdq5), eval(dzdq6)];

J = [dxdq; dydq; dzdq];
