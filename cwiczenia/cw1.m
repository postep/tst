%% test wielomianu
syms z
n = 4
A = rand(n)
det(z * eye(n) - A)


%% test 2
[V, D] = eig(A) %AV=VD
roots(poly(A))

%% Rozwiniecie exp(z) w szereg taylora
clear vars
theta = pi/4
z = -5*exp(-1i*theta)
k = 0:100
w=sum(z.^k./factorial(k))
Pn=z.^k./factorial(k)

clf; hold on; grid on;
plot(cumsum(Pn));
plot(exp(z), 'ro');
plot(w, 'ks');

%% szybkie rysowanie okregu

