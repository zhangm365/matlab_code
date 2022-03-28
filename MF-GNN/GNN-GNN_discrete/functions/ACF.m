function y = ACF(x, acf)
k1 = 1;
k2 = 1;
tau = 0.8;
if acf == 1     % linear
    y = x;
elseif acf == 2     % Sign-Bi-Power Activation Function (SBPF)
    y = sgn(x, tau)+sgn(x, 1/tau);
elseif acf == 3     % Combined Activation Function (CAF)
    y = k1.*(sgn(x,tau)+sgn(x, 1/tau)) + k2.*x;
elseif acf == 4
	% na-znn1
    y = sgn(x,tau);
elseif acf == 5     % Finite-Time Activation Function (FTAF)
    % na-znn2
    y = k1.*sgn(x,tau)+k2.*x;
elseif acf ==6      % power-sigmoid activation function
    y = x;
    y(abs(x)>=1) = x(abs(x)>=1).^3;
    y(abs(x)<1) = ((1+exp(-3))/(1-exp(-3))).*(1-exp(-3*x(abs(x)<1)))./(1+exp(-3*x(abs(x)<1)));
elseif acf == 7
    y = x;
    y(abs(x)>1) = x(abs(x)>1).^3;
    y(abs(x)<=1) = k1.*(sgn(x(abs(x)<=1),tau)+sgn(x(abs(x)<=1), 1/tau)) + k2.*x(abs(x)<=1);
end
end