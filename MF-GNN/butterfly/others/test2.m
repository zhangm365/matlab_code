%% 计算H
syms kl phi k
% B = [cos(kl), 0, sin(kl), (1-cos(kl))/k;
%      0, 1, 0, 0;
%      -sin(kl), 0, cos(kl), sin(kl)/k;
%      0, 0, 0, 1];
B = [cos(kl), 0, sin(kl), 0;
     0, 1, 0, 0;
     -sin(kl), 0, cos(kl), 0;
     0, 0, 0, 1];

C = [cos(phi), -sin(phi), 0, 0;
     sin(phi), cos(phi), 0, 0;
     0, 0, 1, 0;
     0, 0, 0, 1];
H = C*B

%% 计算坐标映射表达式
global d = 0.05;
% q = [0.2100, 0.2000, 0.2000, 0.2100, 0.2000, 0.2000]';
% q1=q(1); q2=q(2); q3=q(3); q4=q(4); q5=q(5); q6=q(6);
syms sinphi1 cosphi1 k1 l1 sinphi2 cosphi2 k2 l2;

% u1 = sqrt(q1^2+q2^2+q3^2-q1*q2-q1*q3-q2*q3);
% u2 = sqrt(q4^2+q5^2+q6^2-q4*q5-q4*q6-q5*q6);
% kl1 = 2*u1/(3*d);
% kl2 = 2*u2/(3*d);
% sinphi1 = (q2+q3-2*q1)/(2*u1);
% cosphi1 = sqrt(3)*(q2-q3)/(2*u1);
% sinphi2 = (q5+q6-2*q4)/(2*u2);
% cosphi2 = sqrt(3)*(q5-q6)/(2*u2);
% k1 = 2*u1/(d*(q1+q2+q3));
% k2 = 2*u2/(d*(q4+q5+q6));
H1 = [cosphi1^2*(cos(k1*l1)-1)+1, sinphi1*cosphi1*(cos(k1*l1)-1), cosphi1*sin(k1*l1), cosphi1*(1-cos(k1*l1))/k1;
      sinphi1*cosphi1*(cos(k1*l1)-1), cosphi1^2*(1-cos(k1*l1))+cos(k1*l1), sinphi1*sin(k1*l1), sinphi1*(1-cos(k1*l1))/k1;
      -cosphi1*sin(k1*l1), -sinphi1*sin(k1*l1), cos(k1*l1), sin(k1*l1)/k1;
      0, 0, 0, 1];
P1 = H1*[0;0;0;1]
H2 = [cosphi2^2*(cos(k2*l2)-1)+1, sinphi2*cosphi2*(cos(k2*l2)-1), cosphi2*sin(k2*l2), cosphi2*(1-cos(k2*l2))/k2;
      sinphi2*cosphi2*(cos(k2*l2)-1), cosphi2^2*(1-cos(k2*l2))+cos(k2*l2), sinphi2*sin(k2*l2), sinphi2*(1-cos(k2*l2))/k2;
      -cosphi2*sin(k2*l2), -sinphi2*sin(k2*l2), cos(k2*l2), sin(k2*l2)/k2;
      0, 0, 0, 1];
pos2 = H1*H2*[0;0;0;1]