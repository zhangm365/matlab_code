clear;
format long;
load data\INITdata5_ACF1_v.mat;
yv = y;
load data\parameter5_ACF1_v.mat
load data\INITdata5_ACF1_n.mat;
yc = y;
load data\INITdata5_ACF1_n.mat;
yn = y;
addpath('functions');

inteval = 1;
number = fix(length(t)/inteval);
pos = zeros(number,3);
Errorc = zeros(number,3);
Errorv = zeros(number,3);
Errorn = zeros(number,3);
index = 0;

%目标轨迹
T = 0:0.01:20;
Te = 0:0.01:20;

rdx = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*cos(T./Td.*2*pi)+iota+90.7;
rdy = iota*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi);
rdz = iota*cos(pi/6)*(exp(sin(T./Td.*2*pi))-2*cos(4*(T./Td.*2*pi))+sin(1/24*(2*(T./Td.*2*pi)-pi)).^5).*sin(T./Td.*2*pi)+385.9;

%实际轨迹
for i = 1:length(t)
    if (rem(i, inteval)==0)
        thetac = yc(i,1:6)';
        thetav = yv(i,1:6)';
        thetan = yn(i,1:6)';
        index = index + 1;
        [pxc, pyc, pzc] = position(thetac);
        [pxv, pyv, pzv] = position(thetav);
        [pxn, pyn, pzn] = position(thetan);
        %误差
        Errorc(index,:) = [pxc-rdx(i), pyc-rdy(i), pzc-rdz(i)];
        Errorv(index,:) = [pxv-rdx(i), pyv-rdy(i), pzv-rdz(i)];
        Errorn(index,:) = [pxn-rdx(i), pyn-rdy(i), pzn-rdz(i)];
    end
end

% % 二范数
L2Errorc = sqrt(Errorc(:,1).^2+Errorc(:,2).^2+Errorc(:,3).^2);
L2Errorv = sqrt(Errorv(:,1).^2+Errorv(:,2).^2+Errorv(:,3).^2);
L2Errorn = sqrt(Errorn(:,1).^2+Errorn(:,2).^2+Errorn(:,3).^2);
figure;
% plot(Te, L2Errorc, 'g-.', 'linewidth', 2);
plot(Te, L2Errorv, 'b:', 'linewidth', 2);
hold on;
plot(Te, L2Errorn, 'c-', 'linewidth', 2);

tau = 0.8;
if acf==1
    bound = noise/gamma*ones(size(Te))*sqrt(3);
elseif acf==2
    bound = sqrt(3)*(noise/(2*gamma))^(2*tau/(tau^2+1))*ones(size(Te));
elseif acf==3
    bound = sqrt(3)*(noise/(3*gamma))^(3*tau/(tau^2+tau+1))*ones(size(Te));
elseif acf==4
    bound = sqrt(3)*(noise/gamma)^(1/tau)*ones(size(Te));
elseif acf==5
    bound = sqrt(3)*(noise/(2*gamma))^(2/(tau+1))*ones(size(Te));
elseif acf==6
    bound = sqrt(3)*(noise/gamma)^(1/3)*ones(size(Te));
end

% plot(Te, bound, 'r-','linewidth', 2);
set(gca,'YLim',[0,1.1],'fontsize',12);%X轴的数据显示范围
set(gca,'FontSize',12);
legend('Time-varying noise', 'Noise-free','Upper bound', 'FontName', 'times new Roman','fontsize',12);
xlabel('Times (s)', 'FontName', 'times new Roman','fontsize',15);
ylabel('||e(t)||_F (mm)', 'FontName', 'times new Roman','fontsize',15);