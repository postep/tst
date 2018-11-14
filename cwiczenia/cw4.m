%% Problem dynamiki w przestrzeni fazowej

%Definicja ukladu
dx1 = 1e-1; dx2=1e-1;
% f1=@(x) x(1)+(x(2)+x(1)*(1-x(1)^2-x(2)^2))*dx1;
% f2=@(x) x(2)-(x(1)-x(2)*(1-x(1)^2-x(2)^2))*dx2;
%lkjfdsa
% f1 = @(x) x(1) + (x(2)^1.2 - sin(x(1)))*dx1;
% f2 = @(x) x(2) + (x(1) - x(1)^3)*dx2;
% f =@(x) [f1(x); f2(x)];

theta = -0.2
A = 5*[cos(theta) -sin(theta); sin(theta) cos(theta)];
f = @(x) A*x;
Ad = A - eye(2);
R = 0.1;
X0 = R*exp(1i * (0:pi/4:2*pi)); X0 = [real(X0); imag(X0)];
T0 = length(X0);
T = 3;
for i=1:T0
    x(:, 1+(i-1)*T) = X0(:, i);
    for t = 1:T, x(:, t+1 + (i-1)*T) = f(x(:, t + (i-1)*T)); end
end

clf; hold on;
for i=1:T0
    plot(x(1, 1+(i-1)*T:i*T), x(2, 1+(i-1)*T:i*T), '-o');
    plot(x(1, 1+(i-1)*T), x(2, 1+(i-1)*T), 'ko');
end;
[x1, x2] = meshgrid(-4:0.5:4);
u = Ad(1,1).*x1 + Ad(1,2).*x2;
v = Ad(2,1).*x1 + Ad(2,2).*x2;
quiver(x1, x2, u, v, 'Color', 0.75*[1 1 1], 'Autoscale', 'On');
grid on;
axis equal;