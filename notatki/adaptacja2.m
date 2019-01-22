clear variables;
global a b am bm;
a = 1;
b = 1;
    
am = 2;
bm = 3;

tspan = [0 20];
y0 = [0, 0, 3, 1];
[t, y] = ode45(@fun, tspan, y0);

clf;
hold on;
plot(t, y);
plot(t, (bm/b)*ones(size(t)), '--', t, (am-a)/b*ones(size(t)), '--');
legend('ym', 'y', 'theta1', 'theta2', 'oczekiwane t1', 'oczekiwane t2');
grid on;

function dx = fun (t, x)
    global a b am bm;
    
    uc = 1;
    gamma = 2;
    
    dx = zeros(4, 1);
    dx(1) = -am*x(1) + bm*uc;
    
    e = x(2)-x(1);
    u = x(3)*uc - x(4)*x(2);
    dx(3) = -gamma*e*u;
    dx(4) = gamma*e*x(2);
    
    dx(2) = -a*x(2) + b*u;
end

