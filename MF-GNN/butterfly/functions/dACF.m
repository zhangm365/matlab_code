function dy = dACF(x, acf)
k1 = 1;
k2 = 1;
tau = 0.8;
if acf == 1
    dy = 1;
elseif acf == 2
    % sbp
    dy = x; % if x == 0 , then dy =0
    dy(x~=0) = tau.*(abs(x(x~=0))).^(tau-1)+1/tau.*(abs(x(x~=0)));
elseif acf == 3
    % caf-znn
    dy = x;
    dy(x~=0) = k1.*(tau.*(abs(x(x~=0))).^(tau-1)+1/tau.*(abs(x(x~=0))).^(1/tau-1))+k2;
elseif acf == 4
    % % na-znn1
    dy = x;
    dy(x~=0) = tau*(abs(x(x~=0))).^(tau-1);
elseif acf == 5
    % % na-znn2
    dy = x;
    dy(x~=0) = k1.*tau*(abs(x(x~=0))).^(tau-1)+k2;
elseif acf == 6
    dy = x;
    dy(x>=1) = 5.*x(x>=1).^4;
    dy(x<1) = 6*(exp(3*x(x<1))+1).^(-2).*exp(3*x(x<1));
end
end