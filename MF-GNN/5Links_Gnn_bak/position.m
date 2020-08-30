function [x,y]=position(q)
%ian planar manipulator 2x5
% J is the 2x5 jocobian matrix of a 5dof planar, unit-link-length robot.
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

x=[0;c1;c1+c2;c1+c2+c3;c1+c2+c3+c4;c1+c2+c3+c4+c5];
y=[0;s1;s1+s2;s1+s2+s3;s1+s2+s3+s4;s1+s2+s3+s4+s5];
