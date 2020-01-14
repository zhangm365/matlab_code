function J=Jacob(q) %Jacob.m of PA10: 3x7

global len d3 d5 d7;%need run PA10st

c(1)=cos(q(1));
s(1)=sin(q(1));
c(2)=cos(q(2));
s(2)=sin(q(2));
c(3)=cos(q(3));
s(3)=sin(q(3));
c(4)=cos(q(4));
s(4)=sin(q(4));
c(5)=cos(q(5));
s(5)=sin(q(5));
c(6)=cos(q(6));
s(6)=sin(q(6));
c(7)=cos(q(7));
s(7)=sin(q(7));

t414= d7*c(5)*s(6);
t424=-d7*c(6)-d5;
t434= d7*s(5)*s(6);
t314=c(4)*t414-s(4)*t424;
t324=t434;
t334=-s(4)*t414-c(4)*t424;
t214=c(3)*t314-s(3)*t434;
t224=-t334-d3;
t234=s(3)*t314+c(3)*t434;
t114= c(2)*t214-s(2)*t224;
t134=-s(2)*t214-c(2)*t224;

r411=(c(1)*c(2)*c(3)-s(1)*s(3))*c(4)-c(1)*s(2)*s(4);
r412=-(c(1)*c(2)*c(3)-s(1)*s(3))*s(4)-c(1)*s(2)*c(4);
r413=-c(1)*c(2)*s(3)-s(1)*c(3);
r421=(s(1)*c(2)*c(3)+c(1)*s(3))*c(4)-s(1)*s(2)*s(4);
r422=-(s(1)*c(2)*c(3)+c(1)*s(3))*s(4)-s(1)*s(2)*c(4);
r423=-s(1)*c(2)*s(3)+c(1)*c(3); 
r431=-s(2)*c(3)*c(4)-c(2)*s(4);
r432= s(2)*c(3)*s(4)-c(2)*c(4);
r433=s(2)*s(3);
r511= r411*c(5)+r413*s(5);
r512=-r411*s(5)+r413*c(5);
r513=-r412;
r521= r421*c(5)+r423*s(5);
r522=-r421*s(5)+r423*c(5);
r523=-r422;
r531= r431*c(5)+r433*s(5);
r532=-r431*s(5)+r433*c(5);
r533=-r432;
r612=-r511*s(6)+r412*c(6);
r622=-r521*s(6)+r422*c(6);
r632=-r531*s(6)+r432*c(6);

p21=c(1)*c(2)*t214-c(1)*s(2)*t224-s(1)*t234;
p22=s(1)*c(2)*t214-s(1)*s(2)*t224+c(1)*t234;
p23=-s(2)*t214-c(2)*t224;
p31=(c(1)*c(2)*c(3)-s(1)*s(3))*t314-( c(1)*c(2)*s(3)+s(1)*c(3))*t434+c(1)*s(2)*t334;
p32=(s(1)*c(2)*c(3)+c(1)*s(3))*t314+(-s(1)*c(2)*s(3)+c(1)*c(3))*t434+s(1)*s(2)*t334;
p33=-s(2)*c(3)*t314+s(2)*s(3)*t434+c(2)*t334;
p41=r411*t414+r412*t424+r413*t434;
p42=r421*t414+r422*t424+r423*t434;
p43=r431*t414+r432*t424+r433*t434;
p51=r511*d7*s(6)+r513*d7*c(6);
p52=r521*d7*s(6)+r523*d7*c(6);
p53=r531*d7*s(6)+r533*d7*c(6);

J=zeros(3,7);

J(1,1)=-s(1)*t114-c(1)*t234;
J(2,1)= c(1)*t114-s(1)*t234;
J(1,2)=c(1)*p23;
J(2,2)=s(1)*p23;
J(3,2)=-s(1)*p22-c(1)*p21;
J(1,3)=s(1)*s(2)*p33-c(2)*p32;
J(2,3)=c(2)*p31-c(1)*s(2)*p33;
J(3,3)=c(1)*s(2)*p32-s(1)*s(2)*p31;
J(1,4)=r423*p43-r433*p42;
J(2,4)=r433*p41-r413*p43;
J(3,4)=r413*p42-r423*p41;
J(1,5)=-r422*p53+r432*p52;
J(2,5)=-r432*p51+r412*p53;
J(3,5)=-r412*p52+r422*p51;
J(1,6)=d7*(-r522*r632+r532*r622);
J(2,6)=d7*(-r532*r612+r512*r632);
J(3,6)=d7*(-r512*r622+r522*r612);