function NormError(x0,gamma)
tspan=[0 10]; options=odeset();
[t,x]=ode45(@GnnRightHandSide,tspan,x0,options,gamma);
Ainv=inv(MatrixA); 
B=reshape(Ainv,size(Ainv,1)^2,1);
total=length(t); x=x';
for i=1:total, nerr(i)=norm(x(:,i)-B); end
plot(t,nerr); hold on
