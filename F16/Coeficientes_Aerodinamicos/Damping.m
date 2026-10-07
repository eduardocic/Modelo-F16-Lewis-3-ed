function D = Damping(alpha)
% Tabela de coeficientes de amortecimento - OK


A = [ -0.267   -0.110   0.308    1.34    2.08    2.91    2.76    2.05    1.50    1.49    1.83    1.21;
       0.882    0.852   0.876   0.958   0.962   0.974   0.819   0.483   0.590    1.21  -0.493   -1.04;
      -0.108   -0.108  -0.188  +0.110   0.258   0.226   0.344   0.362   0.611   0.529   0.298   -2.27;
       -8.80    -25.8   -28.9   -31.4   -31.2   -30.7   -27.7   -28.2   -29.0   -29.8   -38.3   -35.3;
      -0.126   -0.026   0.063   0.113   0.208   0.230   0.319   0.437   0.680   0.100   0.447  -0.330;
      -0.360   -0.359  -0.443  -0.420  -0.383  -0.375  -0.329  -0.294  -0.230  -0.210  -0.120  -0.100;
      -7.210   -0.540  -5.230  -5.26   -6.11   -6.64   -5.69   -6.00   -6.20   -6.40   -6.600  -6.000;
      -0.380   -0.363  -0.378  -0.386  -0.370  -0.453  -0.550  -0.582  -0.595  -0.637   -1.02  -0.840;
       0.061    0.052   0.052  -0.012  -0.013  -0.024   0.050   0.150   0.130   0.158   0.240   0.150];

% Conversão do alfa para o índice da tabela.
S = 0.2*alpha;                              

% Equivalente ao INT(S) do Fortran
K = fix(S);                      

if( K <= -2)                         
    K = -1;
end

if( K >= 9)
    K = 8;
end

% Fração entre os pontos da tabela.
DA = S - double(K);

if (DA >= 0)
    L = K + 1;
else
    L = K - 1;
end

% Conversão dos índices Fortran para índices MATLAB
K_index = K + 3;
L_index = L + 3;

% Interpolação
D = zeros(9,1);
for I = 1:9
    D(I) = A(I, K_index) + abs(DA) * (A(I, L_index) - A(I, K_index));
end

end