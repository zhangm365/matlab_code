clear all;

load data\INITdata500.mat

q1 = y(:, 1)';
q2 = y(:, 2)';
q3 = y(:, 3)';
q4 = y(:, 4)';
q5 = y(:, 5)';
q6 = y(:, 6)';

figure;
plot(t, q1, 'r');grid on;
hold on;
plot(t, q2, 'b');
plot(t, q3, 'g');
hold off;
title('section 1');
xlabel('t (s)');
ylabel('bellow length (m)');
legend('bellows11', 'bellows12', 'bellows13');
% savefig('result\Section1_bellows_50.fig');

figure;
plot(t, q4, 'r');grid on;
hold on;
plot(t, q5, 'b');
plot(t, q6, 'g');
hold off;
title('section 2');
xlabel('t (s)');
ylabel('bellow length (m)');
legend('bellows21', 'bellows22', 'bellows23');
% savefig('result\Section2_bellows_50.fig');