function point = calculateP5(q)
global d;
q1=q(1); q2=q(2); q3=q(3); q4=q(4); q5=q(5); q6=q(6);
u1 = sqrt(q1^2+q2^2+q3^2-q1*q2-q1*q3-q2*q3);
u2 = sqrt(q4^2+q5^2+q6^2-q4*q5-q4*q6-q5*q6);
kl1 = 2*u1/(3*d);
kl2 = 2*u2/(3*d);
sinphi1 = (q2+q3-2*q1)/(2*u1);
cosphi1 = sqrt(3)*(q2-q3)/(2*u1);
sinphi2 = (q5+q6-2*q4)/(2*u2);
cosphi2 = sqrt(3)*(q5-q6)/(2*u2);
k1 = 2*u1/(d*(q1+q2+q3));
k2 = 2*u2/(d*(q4+q5+q6));

x = (cosphi1*sin(kl1)*sin(kl2))/k2 - (cosphi1*(cos(kl1) - 1))/k1 - (cosphi2*(cos(kl2) - 1)*((cos(kl1) - 1)*cosphi1^2 + 1))/k2 - (cosphi1*sinphi1*sinphi2*(cos(kl1) - 1)*(cos(kl2) - 1))/k2;
y = (sinphi1*sin(kl1)*sin(kl2))/k2 - (sinphi2*(cos(kl2) - 1)*((1 - cos(kl1))*cosphi1^2 + cos(kl1)))/k2 - (sinphi1*(cos(kl1) - 1))/k1 - (cosphi1*cosphi2*sinphi1*(cos(kl1) - 1)*(cos(kl2) - 1))/k2;
z = sin(kl1)/k1 + (cos(kl1)*sin(kl2))/k2 + (sinphi1*sinphi2*sin(kl1)*(cos(kl2) - 1))/k2 + (cosphi1*cosphi2*sin(kl1)*(cos(kl2) - 1))/k2;
point = [x;y;z];
end