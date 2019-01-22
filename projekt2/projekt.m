T = 5e2;

Rv = 1;
Re = 1;
U = ones(T, 1);

Phi = [0.23, 0.5; 1, 2];
Phi_xw = [0, 1; 0, 1];
Phi_w = [sqrt(0.5), sqrt(0.5); -sqrt(0.5), sqrt(0.5)];
Gamma = [1; 4];
Gamma_v = [1; 1];
C = [1, 0];
A = [Phi, Phi_xw; zeros(2, 2), Phi_w];
B = [Gamma; 0; 0];
% macierz sterowalności 
Wc = ctrb(A, B)
rank(Wc) 
Wo = obsv(A,[C, 0, 0])
rank(Wo)

% % bieguny kompensatora
% Pc = randn(1,n);

% bieguny obserwatora
Pox = randn(2, 1)
Pox = [-0.1; -0.1]
Pow = [0.9; 0.9]

L = acker(A',[C, zeros(1, 2)]', [Pox; Pow])';
L_x = L(1:2);
L_w = L(3:4);

% bieguny regulatora
Pc = [-0.1, 0.1, 0.9, 0.9]

K = acker(A, [Gamma; Gamma_v], Pc);
K_x = K(1:2);
K_w = K(3:4);


% % zaproponować takie Kw, który spróbuje kompensować wpływ w na x
% Kw = rand(1,nw)
% 
% Kc = 1;

noise = @(R)  sqrt(R)*randn();

S = zeros(4, T);
Y = zeros(1, T);
S_hat = zeros(4, T);
Y_hat = zeros(1, T);

for t=2:T-1
    U(t) = -[K_x, K_w]*S_hat(:, t);
    S(:,t+1) = A*S(:,t) + B*U(t) + [0; 0; Gamma_v]*noise(Rv);
    Y(t) = [C, 0, 0]*S(:, t) + noise(Re);
    S_hat(:, t+1) = A*S_hat(:,t) + B*U(t) +[L_x; L_w]*(Y(t)-[C, 0, 0]*S_hat(:, t));
    Y_hat(t) = [C, 0, 0] * S_hat(:, t);
end
Y(T) = [C, 0, 0]*S(:, T) + noise(Re);
Y_hat(T) = [C, 0, 0] * S_hat(:, T);
U(T) = U(T-1);

plot(1:T, Y, 1:T, Y_hat, 1:T, U);
legend('y', 'yhat', 'u', 'Location', 'southwest');

