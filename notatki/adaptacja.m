clear variables;
dt = 1e-3;
a = 2;
b = 2;
am = 1;
bm = 11;
uc = 1;
gamma = 5000;


time = 0:dt:10;

sysd = c2d(ss([-a], [b], [1], [0]), dt);
Ad = sysd.A;
Bd = sysd.B;

sysmd = c2d(ss([-am], [bm], [1], [0]), dt);
Amd = sysmd.A;
Bmd = sysmd.B;
    

u = zeros(size(time));
uc = uc*ones(1, 2/dt);
ud = 3*ones(1, 2/dt);
 ue = -3*ones(1, 2/dt);
uf = 3*ones(1, 2/dt);
ug = zeros(1, 2/dt);
uc = [uc, ud, ue, uf, ug, 0];
theta_1 = zeros(size(time));
theta_2 = zeros(size(time));
y = zeros(size(time));
ym = zeros(size(time));

for t = 2:length(time)
    e = y(t-1)-ym(t-1);
    theta_1(t) = -gamma*uc(t)*e*dt;
    theta_2(t) = gamma*e*dt;
    u(t) = theta_1(t)*uc(t) - theta_2(t)*y(t-1);
    y(t) = Ad*y(t-1) + Bd*u(t);
    ym(t) = Amd*ym(t-1) + Bmd*uc(t);
end

subplot(2,1,1);
plot(time, y, time, ym);
legend('Y', 'Ym');
title('Wyjscie modeli')

subplot(2,1,2);
plot(time, theta_1, time, theta_2, time, (bm/b)*ones(size(time)), time, ((am-a)/b)*ones(size(time)));
legend('t_1', 't_2', 'oczekiwane t_1', 'oczekiwane t_2');
title('Parametry theta')


