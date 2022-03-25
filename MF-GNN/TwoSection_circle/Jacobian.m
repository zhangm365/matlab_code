function J = Jacobian(q)

load data\JacobianData1.mat


syms q1 q2 q3 q4 q5 q6

q1 = q(1);q2=q(2);q3=q(3);q4=q(4);q5=q(5);q6=q(6);


dxdq = [eval(dxdq1Char), eval(dxdq2Char), eval(dxdq3Char), eval(dxdq4Char), eval(dxdq5Char), eval(dxdq6Char)];
dydq = [eval(dydq1Char), eval(dydq2Char), eval(dydq3Char), eval(dydq4Char), eval(dydq5Char), eval(dydq6Char)];
dzdq = [eval(dzdq1Char), eval(dzdq2Char), eval(dzdq3Char), eval(dzdq4Char), eval(dzdq5Char), eval(dzdq6Char)];

J = [dxdq; dydq; dzdq];