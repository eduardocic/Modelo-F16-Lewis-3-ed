function CoeficienteForcaX = Cx (alpha, elevator)
% Tabela X-axis aerodynamis forces coeef - OK.


A = [ -0.099  -0.081  -0.081  -0.063  -0.025  0.044  0.097  0.113  0.145  0.167  0.174  0.166;
      -0.048  -0.038  -0.040  -0.021   0.016  0.083  0.127  0.137  0.162  0.177  0.179  0.167;
      -0.022  -0.020  -0.021  -0.004   0.032  0.094  0.128  0.130  0.154  0.161  0.155  0.138;
      -0.040  -0.038  -0.039  -0.025   0.006  0.062  0.087  0.085  0.100  0.110  0.104  0.091;
      -0.083  -0.073  -0.076  -0.072  -0.046  0.012  0.024  0.025  0.043  0.053  0.047  0.040];

% Conversão do alfa para o índice da tabela. 
S = 0.2*alpha;                   

% Equivalente ao INT(S) do Fortran.
K = fix(S);

if(K <= -2)
    K = -1;
end

if(K >= 9)
    K = 8;
end

% Fração entre os pontos da tabela.
DA = S - K;

% Compensaçao de colunas e linhas.
K = K + 3;

L = K + fix(sign(DA)*1.1);              % L = K + int(sign(1,1DA)).

S = (elevator/12.0);
M = fix(S);

if(M <= -2)
    M = -1;
end
if(M >= 2)
    M = 1;
end

DE = S - M;

% Compensaçao de colunas e linhas.
M = M + 3;

N = M + fix(sign(DE)*1.1);              % L = K + int(sign(1.1, DA)).

T = A(M, K);
U = A(N, K);
V = T + abs(DA)*(A(M, L) - T);
W = U + abs(DA)*(A(N, L) - U);

CoeficienteForcaX = V + (W - V)*abs(DE);  
end