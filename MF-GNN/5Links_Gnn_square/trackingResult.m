clear;
format long;
load data\INITdata50.mat;


iota = 0.0289;
Td = 20;
% inteval = 1;
inteval = 20;
number = fix(length(t)/inteval);
pos = zeros(number,2);
Error = zeros(number,2);
index = 0;

step = 0.01;
%Ä¿±ê¹ì¼£
% quadrangle
% T = 0:step:(Td-step);
%     desired_v=iota*(T-sin(2*pi*T/Td))/(4*pi*pi);
%     xdot1=-desired_v';
%     ydot1=zeros([Td/step-1, 1]);
%     
% T = Td:step:(2*Td-step);
%     desired_v=iota*(T-sin(2*pi*(T-Td)/Td))/(4*pi*pi);
%     xdot2=zeros([Td/step-1, 1]);
%     ydot2=-desired_v';
%     
% T = (2*Td):step:(3*Td-step);
%     desired_v=iota*(T-sin(2*pi*(T-2*Td)/Td))/(4*pi*pi);
%     xdot3=desired_v';
%     ydot3=zeros([Td/step-1, 1]);  
%     
% T =(3*Td):step:(4*Td-step);
%     desired_v=iota*(T-sin(2*pi*(T-3*Td)/Td))/(4*pi*pi);
%     xdot4=zeros([Td/step-1, 1]);
%     ydot4=desired_v';
%     
% rdx = [xdot1; xdot2; xdot3; xdot4];
% rdy = [ydot1; ydot2; ydot3; ydot4];
% % quadrangle

T = 0:step:4.99;
%     xdx1 = -0.03*4*T/Td+0.0907;
%     xdy1 = 0.06*4*T/Td+0.00001;
    xdx1 = -0.20*4*T/Td+4.505;
    xdy1 = 0.10*4*T/Td+0.6895;
T = 5:step:9.99;
%     xdx2 = -0.03*4*(T-Td/4)/Td+0.0607;
%     xdy2 = -0.06001*4*(T-Td/4)/Td+0.06001;
    xdx2 = -0.20*4*(T-Td/4)/Td+4.305;
    xdy2 = -0.10*4*(T-Td/4)/Td+0.7895;
T = 10:step:14.99;
%     xdx3 = 0.03*4*(T-2*Td/4)/Td+0.0307;
%     xdy3 = -0.06*4*(T-2*Td/4)/Td;
    xdx3 = 0.20*4*(T-2*Td/4)/Td+4.105;
    xdy3 = -0.10*4*(T-2*Td/4)/Td+0.6895;
T = 15:step:20;
%     xdx4 = 0.03*4*(T-3*Td/4)/Td+0.0607;
%     xdy4 = 0.06001*4*(T-3*Td/4)/Td-0.06;
    xdx4 = 0.20*4*(T-3*Td/4)/Td+4.305;
    xdy4 = 0.10*4*(T-3*Td/4)/Td+0.5895;  
    
rdx = [xdx1, xdx2, xdx3, xdx4];      
rdy = [xdy1, xdy2, xdy3, xdy4];


%Êµ¼Ê¹ì¼£
for i = 1:length(t)
    if (rem(i, inteval)==0)
        q = y(i,1:5)';
        index = index + 1;
        [px, py] = position5(q);
        %Ä©¶Ë
        pos(index, 1:2) = [px(6), py(6)];
        %Îó²î
         Error(index,:) = [px(6)-rdx(i), py(6)-rdy(i)];
    end
end

figure;
plot((1e+3)*rdx, (1e+3)*rdy,'b');       % ÆÚÍû¹ì¼£
grid on;
hold on;
plot((1e+3)*(pos(1:number,1)'), (1e+3)*(pos(1:number,2)'),'r:*');

legend('Actual trajactory','Desired path','Location','best');

hold off;

xlabel('X (mm)');
ylabel('Y (mm)');
% zlabel('Z (m)');
savefig('result\circleTrack_50.fig');

%Îó²î·ÖÎö
figure;
Te = 0:step*inteval:Td;
plot((1e+3)*Te,(1e+3)*([0;Error(:,1)]'),'-');
% plot(Te,Error(:,1)','-');
hold on;
plot((1e+3)*Te,(1e+3)*([0;Error(:,2)]'),'-');
% plot(Te,Error(:,2)','--');grid on;
% plot(Te,[0;Error(:,3)]','-');
% plot(Te,Error(:,3)','-.');
legend('Ex','Ey','Location','best');
hold off;
xlabel('t (s)');
ylabel('error (mm)');

title('\gamma=200,\mu=200');
% savefig('result\errorCircle_50.fig');

