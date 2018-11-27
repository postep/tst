%% Problem dynamiki w przestrzeni fazowej
clear all;
%% konstruowanie macierzy o zadanym widmie
l1 = -1.5i;
l2 = 0.5;
v1 = [1, 0]';
v2 = [0, 1]';

v1scaled = v1./sqrt(sum(v1'*v1));
v2scaled = v2./sqrt(sum(v2'*v2));

V = [v1, v2];
D = [l1, 0; 0, l2];

A = V*[l1 0; 0 l2]*(V^-1);

f = @(x) A*x;

%% konstruowanie zbioru punktow X0 rozlozonych na okregu 
R = 1;
X0 = R*exp(1i * (0:pi/4:2*pi)); X0 = [real(X0); imag(X0)];
T0 = length(X0);

%% obliczanie trajektorii ukladu dla wybranych punktow poczatkowych
T = 5;
for i=1:T0
    x(:, 1+(i-1)*T) = X0(:, i);
    for t = 1:T, x(:, t+1 + (i-1)*T) = f(x(:, t + (i-1)*T)); end
end

%% obliczanie wartosci i wektorow wlasnych macierzy A
[V, D] = eig(A)
veig1 = V(:,1);
veig2 = V(:,2);

veig1scaled = veig1./sum(veig1'*veig1);
vieg2scaled = veig2./sum(veig2'*veig2);

%% ilustracja trajektorii w przestrzeni stanow
clf; 
fig = figure(1);
hold on;
for i=1:T0
    plot(x(1, 1+(i-1)*T:i*T), x(2, 1+(i-1)*T:i*T), '-o');
    plot(x(1, 1+(i-1)*T), x(2, 1+(i-1)*T), 'ko');
end;

%% ilustracja obrazu Y = AX0

Ximage = R*exp(1i * (0:pi/100:2*pi)); Ximage = [real(Ximage); imag(Ximage)];
Yimage = A*Ximage;

plot(Ximage(1,:), Ximage(2,:), 'Color', 0.75*[0, 1, 0]);
plot(Yimage(1,:), Yimage(2,:), 'Color', 0.75*[0, 0, 1]);

%% ilustracja wektorow lambda_i, v_i

% wektory uzyte do konstrukcji macierzy A
lv1 = l1 * v1;
lv2 = l2 * v2;

plot([0, lv1(1)], [0, lv1(2)], 'r-');
plot([0, lv2(1)], [0, lv2(2)], 'r-');

% wektory uzyskane przez matlaba
%kierunki wektorow pokrywaja sie w obu przypadkach
leigv1 = D(1, 1) * veig1;
leigv2 = D(2, 2) * veig2;

% plot([0, leigv1(1)], [0, leigv1(2)], 'Color', 0.75*[1, 1, 0]);
% plot([0, leigv2(1)], [0, leigv2(2)], 'Color', 0.75*[1, 1, 0]);


%% ilustracja pola wektorowego okreslajacego trajektorie ukladu
Ad = A - eye(2);
[x1, x2] = meshgrid(-4:0.5:4);
u = Ad(1,1).*x1 + Ad(1,2).*x2;
v = Ad(2,1).*x1 + Ad(2,2).*x2;
quiver(x1, x2, u, v, 'Color', 0.75*[1 1 1], 'Autoscale', 'On');
grid on;
axis equal;

%% drukowanie
set(fig, 'PaperUnits', 'centimeters');
set(fig, 'PaperSize', [20 20]);
figureName = ['imag_', num2str(l1), '_', num2str(l2)];
%figureName = 'demo';
print(['images/', figureName, '.pdf'], '-dpdf', '-bestfit');
