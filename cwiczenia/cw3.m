%% przyklad chaos oraz zjawisko bifurkacji
% x(t+1) = mi x(t)(1-x(t), mi > 0, x e [0, 1]

clear variables;
clf; hold on; grid on;

f = @(x, a) a.*x.*(1-x);

a = 3.9;
T = 2e3;
T_phi = T-2e1;
x(1) = 0.4;

for t = 1:T-1
    x(t+1) = f(x(t), a); %wedrowka do punktu rownowagi
end

X = 0:1e-3:1; Y = X;
plot(X, Y);
plot(X, f(X, a));

for t = 1+T_phi : T-1
    plot([x(t), f(x(t), a)], [f(x(t),a), f(x(t), a)], 'Color', 0.75*[1, 1, 1])
    plot([f(x(t), a), f(x(t), a)], [f(x(t), a), f(x(t+1), a)], 'Color', 0.75*[1,1,1]);
end

plot(x(1+T_phi:T-1), x(2+T_phi:T), 'o');
%plot(X, f(f(X, a), a));
%plot(X, f(f(f(f(X, a), a), a), a));