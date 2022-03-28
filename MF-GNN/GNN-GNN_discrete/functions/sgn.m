function y = sgn(x, rho)
y = x;
y(x>0) = abs(x(x>0)).^rho;
y(x==0) = 0;
y(x<0) = -abs(x(x<0)).^rho;
end