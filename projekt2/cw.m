%% Badanie dynamiki układu sterowania

T=1e3;  
n = 2;  
m = 1;
nw = 2;

A = rand(n,n);
B = rand(n,m);
C = rand(1,n);

Aw = eye(nw,nw);
Axw = rand(n, nw);
Bw = ones(nw,1);


Phi = [A, Axw; zeros(nw,n), Aw];
Gamma = [B; zeros(nw,m)];
Gammav = [zeros(n,1); Bw];

uc = zeros(m,T);
Ac = 1e1;
omega = 2*pi*5/T;

% generowanie sygnału prostokątnego
for t=1:T
    uc(t) = Ac*square(omega*t);
end
plot(uc)

% macierz sterowalności 
Wc = ctrb(Phi, Gamma)
rank(Wc) % 2 ponieważ u ma wpływ tylko na x, nie na w

% macierz obserwowalności
Wo = obsv(A,C)
rank(Wo)

% bieguny kompensatora
Pc = randn(1,n);

% bieguny obserwatora
Po = randn(n+nw,1);

Kx = -place(A,B,Pc)

% zaproponować takie Kw, który spróbuje kompensować wpływ w na x
Kw = rand(1,nw)

Kc = 1;

L = acker(Phi',[C, zeros(1, nw)]', Po)' 

Rv = 1e-3;
Re = 1e-2;
v = sqrt(Rv)*randn(T,1);
e = sqrt(Re)*randn(T,1);
z = zeros(n+nw,T);
ze = z;
u = zeros(m,T);
y = zeros(1,T);

for t=1:T-1
    z(:, t+1) = Phi*z(:,t)+Gamma*u(:,t)+Gammav*v(t);
    y(:,t) = [C, zeros(1, nw)]*z(:,t)+e(t);
    ze(:, t+1) = Phi*ze(:,t)+Gamma*u(t)+L*(y(:,t)-[C,zeros(1,nw)]*ze(:,t)); %y-ye
    ye(:,t) = [C,zeros(1, nw)]*ze(:,t);
    u(:,t+1) = -[Kx, Kw]*ze(:,t) + Kc*uc(:,t);
end
