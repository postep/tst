%% atraktor lorenta

clear variables;
close all;

sigma = 10;
beta = 8/3;
rho = 28;
eta = sqrt(beta*(rho-1));

A = [-beta, 0, eta; 0, -sigma, sigma; -eta, rho, -1];
v01 = [rho-1, -eta, -eta]';
y01 = v01 + [0, 0, 0.1]';
v02 = [rho-1, -eta, -eta]';
y02 = v02 + [0, 0, 0.25]';
T = [0 1e2];

% d/dt(y(t)) = f(y(x))*y(t)
f = @(t,y) [-beta, 0, y(2); 0, -sigma, sigma; -y(2), rho, -1]*y;
[t1, y1] = ode45(f, T, y01);
[t2, y2] = ode45(f, T, y02);

figure(1); hold on; grid on;
plot(t1,[ y1(:, 1) + 15, y1(:, 2), y1(:, 3)-15]);
plot(t2,[ y2(:, 1) + 15, y2(:, 2), y2(:, 3)-15]);

figure(2); hold on; grid on;
plot3(y1(:, 1), y1(:, 2), y1(:, 3));
plot3(y2(:, 1), y2(:, 2), y2(:, 3));

%% Fraktale

p = [.85, 0.92, 0.99, 1];

A1 = [0.84, 0.04; -0.04, 0.85];
A2 = [0.2, -0.26; 0.23, 0.22];
A3 = [-0.15, 0.25; 0.026, 0.24];
A4 = [0, 0; 0, 0.16];

b1 = [0; 1.6];
b2 = [0; 1.6];
b3 = [0; 0.44];

cnt = 1;
x = rand(2, 1);
clf; hold on;
for t = 1:5e3
    r = rand;
    if r < p(1), x = A1*x + b1;
    elseif r < p(2), x = A2*x + b2;
    elseif r < p(3), x = A3*x + b3;
    else x = A4*x; end;
    plot(x(1), x(2), '.b', 'MarkerSize', 3);
end