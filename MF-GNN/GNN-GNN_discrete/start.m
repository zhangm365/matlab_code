clear all;
format long;
addpath('functions');

% *************** D-H parameters of the Jaco2 manipulator
% the end-effector is the finger
% D = [0.2755, 0.4100, 0.2073, 0.07433, 0.07433, 0.1687, 0.0098]; %D1~D6;E2
% the end-effector is a pen
D = [0.2755, 0.4100, 0.2073, 0.07433, 0.07433, 0.13, 0.0098]; %D1~D6;E2
pen_long=0.055;   % length of the pen
aaa = 11.0*pi/72;
ca = cos(aaa);
sa = sin(aaa);
c2a = cos(2*aaa);
s2a = sin(2*aaa);
d4b = D(3)+sa/s2a*D(4);
d5b = sa/s2a*D(4)+sa/s2a*D(5);
d6b = sa/s2a*D(5)+D(6);
alpha_i = [pi/2, pi, pi/2, 2*aaa, 2*aaa, pi];
a_i = [0, D(2), 0, 0, 0, 0];
d_i = [D(1), 0, -D(7), -d4b, -d5b, -d6b];
% *************** D-H parameters of the Jaco2 manipulator

% some parameters
scale = 0.06; % scale the desired path
Td = 20; % task duration
subTime = 0;

tau = 0.1; % step size
h =6;
% allocate the memory
theta = zeros(6, Td/tau);
JHat = zeros(3, 6, Td/tau);
dTheta = zeros(6, Td/tau);
dJHat = zeros(3, 6, Td/tau);
ra = zeros(3, Td/tau);
dra = zeros(3, Td/tau);

%Initial value
% q0 = [1.675;2.843;-3.216;4.187;-1.71;-2.65];
 q0 = [1.596;3.041;3.045;-2.498;-1.131;0.77];
JHat0 = zeros(3, 6);
for j = 1:6
    q1 = q0;
    q2 = q0;
    q2(j) = q2(j) + 0.01;
    [x1, y1, z1] = ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,q1);
    [x2, y2, z2] = ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,q2);
    JHat0(1,j) = (x2(7)-x1(7)) / 0.01;
    JHat0(2,j) = (y2(7)-y1(7)) / 0.01;
    JHat0(3,j) = (z2(7)-z1(7)) / 0.01;
end
initPos = [x1(7); y1(7); z1(7)];
theta(:,1) = q0;
JHat(:, :, 1) = JHat0;

% Desired path
t = 0:tau:Td;
% rdx = scale*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*cos(t./Td.*2*pi)+scale+initPos(1);
% rdy = scale*(exp(sin(t./Td.*2*pi))-2*cos(4*(t./Td.*2*pi))+sin(1/24*(2*(t./Td.*2*pi)-pi)).^5).*sin(t./Td.*2*pi)+initPos(2);
rdx=scale*sin(2*pi*t/Td)+initPos(1);
rdy=scale*sin(4*pi*t/Td+pi/6)-0.5*scale+initPos(2);
rdz = ones(1,Td/tau+1)*(0+initPos(3));
rd = [rdx; rdy; rdz];

tic
for idx = 1:Td/tau
    % actual trajectory
   [rax, ray, raz] = ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,theta(:,idx));
   ra(:, idx) = [rax(7); ray(7); raz(7)];
   
   % dTheta_k = h/tau*JHat_k'*(rd_k-ra_k);
   dTheta(:, idx) = h/tau*JHat(:,:,idx)'*(rd(:, idx)- ra(:, idx));
   
   % actual veloctiy
   tj = clock;
   [J,DJ]=ZYNjdj(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,theta(:,idx), dTheta(:,idx)); 
   subTime = subTime + etime(clock, tj);
%    dra(:, idx) = J*dTheta(:,idx);
   if idx==1
       dra(:,idx) = zeros(3,1);
   else
       dra(:,idx) = (ra(:,idx)-ra(:,idx-1))/tau;
   end
   % dJHat_k = h/tau*(dra_k - JHat_k*dTheta_k)*dTheta_k'
   dJHat(:,:,idx) = h/tau*(dra(:,idx) - JHat(:,:,idx)*dTheta(:,idx))*dTheta(:,idx)';
   
   % theta_k+1 = theta_k + tau *dTheta_k
   theta(:,idx+1) = theta(:,idx)+tau*dTheta(:,idx);
   % JHat_k+1 = JHat_k + tau* dJHat_k
   JHat(:,:,idx+1) = JHat(:,:,idx)+tau*(dJHat(:,:,idx));
   
end

% the last point
[rax, ray, raz] = ZYNposition(alpha_i,a_i,d_i,D,sa,ca,s2a,c2a,pen_long,theta(:,Td/tau+1));
ra(:, Td/tau+1) = [rax(7); ray(7); raz(7)];

toc
time = toc;
cost = time - subTime;

save (['data/INITdata',num2str(1/tau)], 'theta','rd','ra','tau','h','dTheta','Td','initPos','time','cost','subTime');
