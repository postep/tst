T = 5e3;

Rv = 0.001;
Re = 0.001;
noise = @(R)  sqrt(R)*randn();

K_c = 0.5;
u_c = zeros(T, 1);
A_c = 3e1;
omega = 2*pi*5/T;
for t=1:T
    u_c(t) = A_c*square(omega*t);
end

Phi = [0.23, 0.5; 1, 2];
Phi_xw = [0, 1; 0, 1];
Phi_w = [sqrt(0.5), sqrt(0.5); -sqrt(0.5), sqrt(0.5)];
Gamma = [1; 4];
Gamma_v = [1; 1];
C = [1, 0];
A = [Phi, Phi_xw; zeros(2, 2), Phi_w];
B = [Gamma; 0; 0];

% macierz sterowalności i obserwowalnosci 
Wc = ctrb(A, B)
rank(Wc) 
Wo = obsv(A,[C, 0, 0])
rank(Wo)


% bieguny obserwatora
Pox = [-0.1; -0.1]
Pow = [0.9; 0.9]
L = acker(A',[C, zeros(1, 2)]', [Pox; Pow])';


% bieguny regulatora
syms z k1 k2;
K_x = [k1, k2];
det(z*eye(2) - Phi + Gamma*K_x)

k2 = -1;
k1 = 9/4 - 4*k2;
K_x = [k1, k2]

K_w = pinv(Gamma)*Phi_xw

% wartosc kc
K_c = 0.5

% symulacja
S = zeros(4, T);
Y = zeros(1, T);
S_hat = zeros(4, T);
Y_hat = zeros(1, T);
U = zeros(T, 1);

for t=1:T
    U(t) = -[K_x, K_w]*S_hat(:, t) + K_c*u_c(t) + K_c*u_c(t);
    S(:,t+1) = A*S(:,t) + B*U(t) + [0; 0; Gamma_v]*noise(Rv);
    Y(t) = [C, 0, 0]*S(:, t) + noise(Re);
    S_hat(:, t+1) = A*S_hat(:,t) + B*U(t) +L*(Y(t)-[C, 0, 0]*S_hat(:, t));
    Y_hat(t) = [C, 0, 0] * S_hat(:, t);
end

subplot(3,1,1);
plot(1:T, Y, 1:T, Y_hat, 1:T, u_c);
legend('y', 'yhat', 'u_c', 'Location', 'southwest');

subplot(3,1,2); 
plot(1:T, U);
legend('u', 'Location', 'southwest');

subplot(3,1,3);
e = (u_c'-Y).^2;
plot(1:T, e);
legend('e', 'Location', 'southwest');