function point = calculateP2(q)

global d;
q1=q(1)/2; q2=q(2)/2; q3=q(3)/2; q4=q(4); q5=q(5); q6=q(6);
u1 = sqrt(q1^2+q2^2+q3^2-q1*q2-q1*q3-q2*q3);
kl1 = 2*u1/(3*d);
sinphi1 = (q2+q3-2*q1)/(2*u1);
cosphi1 = sqrt(3)*(q2-q3)/(2*u1);
k1 = 2*u1/(d*(q1+q2+q3));

x = -(cosphi1*(cos(kl1) - 1))/k1;
y = -(sinphi1*(cos(kl1) - 1))/k1;
z = sin(kl1)/k1;
point = [x; y; z];

end