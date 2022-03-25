function JHat = KalmanFilter(xk, duk, dpk,t)
global Q zeta R step vk Vk P K
k = round(t/step+1);

x_Predicted = xk + zeta(k, :)';
Hk = kron(eye(3,3),duk');
vk(k,:) = (dpk-Hk*x_Predicted)';
Vk = (0.95*Vk+vk(k,:)'*vk(k,:))/1.95;
N = 10;
Ck = [0, 0, 0; 0, 0, 0; 0, 0, 0];
for n = k-N+1:k
    if n>0
        Ck = Ck+vk(n,:)'*vk(n,:);
    end
end
Ck = Ck/N;
Q = K*Ck*K';
Nk = Vk-R-Hk*Q*Hk';
Mk = Hk*P*Hk';
ck = trace(Nk)/trace(Mk);
if ck >= 1
    lambdak = ck;
else
    lambdak = 1;
end
% Time prediction
P_Predicted = lambdak*P+Q;
% Measurement update
K = P_Predicted*Hk'/(Hk*P_Predicted*Hk'+R);
P = (eye(18,18)-K*Hk)*P_Predicted;
xk = x_Predicted+K*(dpk-Hk*x_Predicted);
JHat = [xk(1:6)'; xk(7:12)'; xk(13:18)'];
end
