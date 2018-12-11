% g(t) = -ay(t) + bu(t)
% u(t) = theta_1(t)u_c(t) - theta_2(t)y(t)
gamma = 10.0;
am = 10;
bm = 1;
dt = 1e-2;

ym = @(y, uc, am, bm) (-am*y + bm*uc)*dt;
u = @(y, uc, theta_1, theta_2) theta_1*uc - theta_2*y;

theta_1 = @(uc, e) -gamma*uc*e*dt;
theta_2 = @(y, e) gamma*y*e*dt;

% e = @(y, ym) y - ym;
time = 0:dt:10;

Y = zeros(size(time));
YM = zeros(size(time));
U = zeros(size(time));
THETA_1 = zeros(size(time));
THETA_2 = zeros(size(time));
UC = 20*ones(size(time));

for i = 2:length(time)
    THETA_1(i) = theta_1(UC(i), Y(i-1)-YM(i-1));
    THETA_2(i) = theta_2(Y(i), Y(i-1)-YM(i-1));
    U(i) = u(Y(i-1), UC(i-1), THETA_1(i-1), THETA_2(i-1));
    YM(i) = ym(YM(i-1), UC(i-1), am, bm);
    Y(i) = ym(Y(i-1), U(i), THETA_1(i), THETA_2(i));
end;

%plot(time, THETA_1, time, THETA_2, time, Y, time, YM);
%plot(time, U);
plot(time, YM, time, Y);