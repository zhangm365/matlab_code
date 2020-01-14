function GnnRobust(gamma)
if nargin<1, gamma=1; end
tspan=[0 10]; options=odeset(); n=size(MatrixA,1);
for i=1:8
    x0=4*(rand(n^2,1)-0.5*ones(n^2,1));
    [t,x]=ode45(@GnnRightHandSideImprecise,tspan,x0,options,gamma);
    for j=1:n^2
      k=mod(n*(j-1)+1,n^2)+floor((j-1)/n);  
      subplot(n,n,k); plot(t,x(:,j)); hold on
    end    
end