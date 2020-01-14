
function Xdot=xfunctionNEW(J,X)
global mu af; 

X=reshape(X,10,1);
At=J;
AA=J*J';
M=kron(AA.',eye(5));
B=reshape(At',10,1);
if(af==1),
    Xdot=-mu*M*(M*X-B);
elseif(af==2),
    Xdot=-mu*M*AFMpowersigmoid(M*X-B);
end
