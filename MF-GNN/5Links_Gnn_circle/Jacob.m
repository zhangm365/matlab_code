function J=Jacob(q) 
%ian planar manipulator 2x5
% J is the 2x5 jocobian matrix of a 4dof planar, unit-link-length robot.
%q/theta is a 5x1 column vector of angles in radians meansuring ccw from
%the previous link (from horizontal for the first link).

% s6=sin(q(1)+q(2)+q(3)+q(4)+q(5)+q(6));
s5=sin(q(1)+q(2)+q(3)+q(4)+q(5));
s4=sin(q(1)+q(2)+q(3)+q(4));
s3=sin(q(1)+q(2)+q(3));
s2=sin(q(1)+q(2));
s1=sin(q(1));

% c6=cos(q(1)+q(2)+q(3)+q(4)+q(5)+q(6));
c5=cos(q(1)+q(2)+q(3)+q(4)+q(5));
c4=cos(q(1)+q(2)+q(3)+q(4));
c3=cos(q(1)+q(2)+q(3));
c2=cos(q(1)+q(2));
c1=cos(q(1));

J=[-s1-s2-s3-s4-s5,-s2-s3-s4-s5,-s3-s4-s5,-s4-s5,-s5;...
    c1+c2+c3+c4+c5,c2+c3+c4+c5,c3+c4+c5,c4+c5,c5];

%time-derivative Jacob dJ-------------------------------------------------

% ds1=dq(1)*cos(q(1));
% ds2=(dq(1)+dq(2))*cos(q(1)+q(2));
% ds3=(dq(1)+dq(2)+dq(3))*cos(q(1)+q(2)+q(3));
% ds4=(dq(1)+dq(2)+dq(3)+dq(4))*cos(q(1)+q(2)+q(3)+q(4));
% ds5=(dq(1)+dq(2)+dq(3)+dq(4)+dq(5))*cos(q(1)+q(2)+q(3)+q(4)+q(5));
% 
% dc1=-dq(1)*sin(q(1));
% dc2=-(dq(1)+dq(2))*sin(q(1)+q(2));
% dc3=-(dq(1)+dq(2)+dq(3))*sin(q(1)+q(2)+q(3));
% dc4=-(dq(1)+dq(2)+dq(3)+dq(4))*sin(q(1)+q(2)+q(3)+q(4));
% dc5=-(dq(1)+dq(2)+dq(3)+dq(4)+dq(5))*sin(q(1)+q(2)+q(3)+q(4)+q(5));
% 
% dJ=zeros(2,5);
% 
% dJ(1,1)=-ds1-ds2-ds3-ds4-ds5;
% dJ(1,2)=-ds2-ds3-ds4-ds5;
% dJ(1,3)=-ds3-ds4-ds5;
% dJ(1,4)=-ds4-ds5;
% dJ(1,5)=-ds5;
% 
% dJ(2,1)=dc1+dc2+dc3+dc4+dc5;
% dJ(2,2)=dc2+dc3+dc4+dc5;
% dJ(2,3)=dc3+dc4+dc5;
% dJ(2,4)=dc4+dc5;
% dJ(2,5)=dc5;