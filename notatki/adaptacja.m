clear variables;
dt = 1e-2;
a = 1;
b = 1;
gamma = 0.9;

am = -90;
bm = 10;

uc = 100;

time = 0:dt:10;

u =zeros(size(time));
uc = uc*ones(size(time));
theta_1 = zeros(size(time));
theta_2 = zeros(size(time));
y = zeros(size(time));
ym = zeros(size(time));

for t = 2:length(time)
    e = y(t-1)-ym(t-1);
    theta_1(t) = -gamma*uc(t)*e * dt;
    theta_2(t) = gamma*e * dt;
%     theta_1(t) = bm/b;
%     theta_2(t) = (am-a)/b;
    u(t) = theta_1(t)*uc(t) - theta_2(t)*y(t-1);
    y(t) = (-a*y(t-1) + b*u(t)) * dt;
    ym(t) = (-am*ym(t-1) + bm*uc(t)) * dt;
end

% plot(time, ym, time, y);
% legend('Ym', 'Y');

plot(time, theta_1, time, theta_2, time, (bm/b)*ones(size(time)), time, ((am-a)/b)*ones(size(time)));
legend('theta_1', 'theta_2', 'exp_t1', 'exp_t2');