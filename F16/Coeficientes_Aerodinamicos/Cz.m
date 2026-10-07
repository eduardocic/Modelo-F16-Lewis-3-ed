function CoeficienteForcaZ = Cz (alpha, beta, elevator)

A = [ 0.770 0.241 -0.100 -0.416 -0.731 -1.053 -1.366 -1.646 -1.917 -2.120 -2.248 -2.229];

S = 0.2 * alpha;
K = fix(S);

if(K <= -2) 
    K = -1;
end
if(K >= 9)
    K = 8;
end

DA = S - double(K);

% Compensacao por software
K = K + 3;

L = K + fix(1.1*sign(DA));

% Compensacao por software

S = A(K) + abs(DA)*(A(L) - A(K));

CoeficienteForcaZ = S * (1.0 - (beta/57.3)^2) - 0.19 * (elevator/25.0);

end