%% Problem dynamiki w przestrzeni fazowej
clear variables;
%% konstruowanie macierzy o zadanym widmie
lambda = [1 0.1];

A = [lambda(1) 0; 0 lambda(2)] *[cos(theta), -sin(theta); sin(theta), cos(theta)]*6.8;

eig(A)/max(eig(A))
f = @(x) A*x;

%% konstruowanie zbioru punktow X0 rozlozonych na okregu 
R = 0.1;
X0 = R*exp(1i * (0:pi/4:2*pi)); X0 = [real(X0); imag(X0)];
T0 = length(X0);

%% obliczanie trajektorii ukladu dla wybranych punktow poczatkowych
T = 3;
for i=1:T0
    x(:, 1+(i-1)*T) = X0(:, i);
    for t = 1:T, x(:, t+1 + (i-1)*T) = f(x(:, t + (i-1)*T)); end
end

%% ilustracja trajektorii w przestrzeni stanow
clf; hold on;
for i=1:T0
    plot(x(1, 1+(i-1)*T:i*T), x(2, 1+(i-1)*T:i*T), '-o');
    plot(x(1, 1+(i-1)*T), x(2, 1+(i-1)*T), 'ko');
end;

%% ilustracja pola wektorowego okreslajacego trajektorie ukladu
Ad = A - eye(2);
[x1, x2] = meshgrid(-4:0.5:4);
u = Ad(1,1).*x1 + Ad(1,2).*x2;
v = Ad(2,1).*x1 + Ad(2,2).*x2;
quiver(x1, x2, u, v, 'Color', 0.75*[1 1 1], 'Autoscale', 'On');
grid on;
axis equal;