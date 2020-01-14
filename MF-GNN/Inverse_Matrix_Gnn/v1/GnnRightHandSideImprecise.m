function output=GnnRightHandSideImprecise(t,x,gamma)
if nargin==2, gamma=1; end
e2=0.5; 
deltaB=e2*[cos(3*t) -sin(3*t) 0; 0 sin(3*t) cos(3*t);0 0 sin(2*t)];
vecB=reshape(deltaB,9,1);
vecI=reshape(eye(3),9,1);
IA=kron(eye(3),MatrixA);
output=-gamma*IA'*Powersigmoid(IA*x-vecI)+vecB;