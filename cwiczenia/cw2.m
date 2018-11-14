%% klatka jordana
A = [ 1 1 0; 0 1 0; -1 0 2 ];

[P, J] = jordan (A)
[V, D] = eig(A)

V*D*V^-1

P*J*P^-1

det(V)

%% dowod TCH
%[lambda_i p_i; ... ]
Z = [2 4; 3 3; -1 2]
Ji=@(V) diag(V(1)*ones(V(2), 1)) + diag(ones(V(2)-1, 1), 1) % lambda_i*i + Ni
J = blkdiag(Ji(Z(1,:)), Ji(Z(2,:)), Ji(Z(3,:))) 

PJ=@(J, z) (J-z(1)*eye(size(J, 1)))^z(2); %(j-lambda_i*I)^p_i

TCH = PJ(J, Z(1,:)) * PJ(J, Z(2,:)) * PJ(J, Z(3,:))

%%przyklad
syms h
A = [0 11; -2 -3]
h=3
expm(A*h)