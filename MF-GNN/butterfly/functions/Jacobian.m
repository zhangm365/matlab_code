function [J, DJ] = Jacobian(q, dq)

syms q1 q2 q3 q4 q5 q6
qs = [q1, q2, q3, q4, q5, q6];

[x, y, z] = position(qs);

dxdq1 = diff(x, q1);dxdq2 = diff(x, q2);dxdq3 = diff(x, q3);dxdq4 = diff(x, q4);dxdq5 = diff(x, q5);dxdq6 = diff(x, q6);
dydq1 = diff(y, q1);dydq2 = diff(y, q2);dydq3 = diff(y, q3);dydq4 = diff(y, q4);dydq5 = diff(y, q5);dydq6 = diff(y, q6);
dzdq1 = diff(z, q1);dzdq2 = diff(z, q2);dzdq3 = diff(z, q3);dzdq4 = diff(z, q4);dzdq5 = diff(z, q5);dzdq6 = diff(z, q6);
DJ11 = [diff(dxdq1, q1),diff(dxdq1, q2), diff(dxdq1, q3), diff(dxdq1, q4), diff(dxdq1, q5), diff(dxdq1, q6)]*dq;
DJ12 = [diff(dxdq2, q1),diff(dxdq2, q2), diff(dxdq2, q3), diff(dxdq2, q4), diff(dxdq2, q5), diff(dxdq2, q6)]*dq;
DJ13 = [diff(dxdq3, q1),diff(dxdq3, q2), diff(dxdq3, q3), diff(dxdq3, q4), diff(dxdq3, q5), diff(dxdq3, q6)]*dq;
DJ14 = [diff(dxdq4, q1),diff(dxdq4, q2), diff(dxdq4, q3), diff(dxdq4, q4), diff(dxdq4, q5), diff(dxdq4, q6)]*dq;
DJ15 = [diff(dxdq5, q1),diff(dxdq5, q2), diff(dxdq5, q3), diff(dxdq5, q4), diff(dxdq5, q5), diff(dxdq5, q6)]*dq;
DJ16 = [diff(dxdq6, q1),diff(dxdq6, q2), diff(dxdq6, q3), diff(dxdq6, q4), diff(dxdq6, q5), diff(dxdq6, q6)]*dq;
DJ21 = [diff(dydq1, q1),diff(dydq1, q2), diff(dydq1, q3), diff(dydq1, q4), diff(dydq1, q5), diff(dydq1, q6)]*dq;
DJ22 = [diff(dydq2, q1),diff(dydq2, q2), diff(dydq2, q3), diff(dydq2, q4), diff(dydq2, q5), diff(dydq2, q6)]*dq;
DJ23 = [diff(dydq3, q1),diff(dydq3, q2), diff(dydq3, q3), diff(dydq3, q4), diff(dydq3, q5), diff(dydq3, q6)]*dq;
DJ24 = [diff(dydq4, q1),diff(dydq4, q2), diff(dydq4, q3), diff(dydq4, q4), diff(dydq4, q5), diff(dydq4, q6)]*dq;
DJ25 = [diff(dydq5, q1),diff(dydq5, q2), diff(dydq5, q3), diff(dydq5, q4), diff(dydq5, q5), diff(dydq5, q6)]*dq;
DJ26 = [diff(dydq6, q1),diff(dydq6, q2), diff(dydq6, q3), diff(dydq6, q4), diff(dydq6, q5), diff(dydq6, q6)]*dq;
DJ31 = [diff(dzdq1, q1),diff(dzdq1, q2), diff(dzdq1, q3), diff(dzdq1, q4), diff(dzdq1, q5), diff(dzdq1, q6)]*dq;
DJ32 = [diff(dzdq2, q1),diff(dzdq2, q2), diff(dzdq2, q3), diff(dzdq2, q4), diff(dzdq2, q5), diff(dzdq2, q6)]*dq;
DJ33 = [diff(dzdq3, q1),diff(dzdq3, q2), diff(dzdq3, q3), diff(dzdq3, q4), diff(dzdq3, q5), diff(dzdq3, q6)]*dq;
DJ34 = [diff(dzdq4, q1),diff(dzdq4, q2), diff(dzdq4, q3), diff(dzdq4, q4), diff(dzdq4, q5), diff(dzdq4, q6)]*dq;
DJ35 = [diff(dzdq5, q1),diff(dzdq5, q2), diff(dzdq5, q3), diff(dzdq5, q4), diff(dzdq5, q5), diff(dzdq5, q6)]*dq;
DJ36 = [diff(dzdq6, q1),diff(dzdq6, q2), diff(dzdq6, q3), diff(dzdq6, q4), diff(dzdq6, q5), diff(dzdq6, q6)]*dq;
    
q1 = q(1);q2=q(2);q3=q(3);q4=q(4);q5=q(5);q6=q(6);

dxdq = [eval(dxdq1), eval(dxdq2), eval(dxdq3), eval(dxdq4), eval(dxdq5), eval(dxdq6)];
dydq = [eval(dydq1), eval(dydq2), eval(dydq3), eval(dydq4), eval(dydq5), eval(dydq6)];
dzdq = [eval(dzdq1), eval(dzdq2), eval(dzdq3), eval(dzdq4), eval(dzdq5), eval(dzdq6)];

J = [dxdq; dydq; dzdq];
DJ = [eval(DJ11), eval(DJ12), eval(DJ13), eval(DJ14), eval(DJ15), eval(DJ16);
      eval(DJ21), eval(DJ22), eval(DJ23), eval(DJ24), eval(DJ25), eval(DJ26);
      eval(DJ31), eval(DJ32), eval(DJ33), eval(DJ34), eval(DJ35), eval(DJ36)];