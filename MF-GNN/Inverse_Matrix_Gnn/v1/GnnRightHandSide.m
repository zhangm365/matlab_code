function output=GnnRightHandSide(t,x,gamma)
if nargin==2, gamma=1; end
A=MatrixA; n=size(A,1); IA=kron(eye(n),A);

% The following generates the vectorization of identity matrix I
vecI=reshape(eye(n),n^2,1);

% The following calculates the right hand side of equations (2) and (5)
output=-gamma*IA'*Powersigmoid(IA*x-vecI);
