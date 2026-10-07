function CoeficienteRollingMoment = Cl(alpha, beta)
% Rolling moments Coeefs - OK.


A = [  0.000,   0.000,   0.000,   0.000,   0.000,   0.000,   0.000,   0.000,   0.000,   0.000,   0.000,   0.000;
      -0.001,  -0.004,  -0.008,  -0.012,  -0.016,  -0.019,  -0.020,  -0.020,  -0.015,  -0.008,  -0.013,  -0.015;
      -0.003,  -0.009,  -0.017,  -0.024,  -0.030,  -0.034,  -0.040,  -0.037,  -0.016,  -0.002,  -0.010,  -0.019;
      -0.001,  -0.010,  -0.020,  -0.030,  -0.039,  -0.044,  -0.050,  -0.049,  -0.023,  -0.006,  -0.014,  -0.027;
       0.000,  -0.010,  -0.022,  -0.034,  -0.047,  -0.046,  -0.059,  -0.061,  -0.033,  -0.036,  -0.035,  -0.035;
       0.007,  -0.010,  -0.023,  -0.034,  -0.049,  -0.046,  -0.068,  -0.071,  -0.060,  -0.058,  -0.062,  -0.059;
       0.009,  -0.011,  -0.023,  -0.037,  -0.050,  -0.047,  -0.074,  -0.079,  -0.091,  -0.076,  -0.077,  -0.076];

S = 0.2*alpha;
K = fix(S);

if(K <= -2)
 K = -1;
end
if(K >= 9)
 K = 8;
end

DA = S - K;
L = K + fix(1.1*sign(DA));

S = 0.2*abs(beta);
M = fix(S);
if( M == 0)
 M = 1;
end
if( M >= 6)
 M = 5;
end
DB = S - M;
N = M + fix(1.1*sign(DB));

% Compensacao por software
K = K + 3;
L = L + 3;
M = M + 1;
N = N + 1;

T = A(M, K);
U = A(N, K);
V = T + abs(DA)*(A(M, L) - T);
W = U + abs(DA)*(A(N, L) - U);

DUM = V + (W - V)*abs(DB);

CoeficienteRollingMoment = DUM * sign(beta);
end
% 
% 
% 
% 
% function Cl = Cl(alpha, beta)
% % Coeficiente de momento de rolagem – tabela do modelo F-16 de Lewis
% % alpha, beta em graus
% 
% % Tabela 7×12  (linhas = |β|/5, colunas = α/5)
% A = [ ...
%      0.000  0.000  0.000  0.000  0.000  0.000  0.000  0.000  0.000  0.000  0.000  0.000;
%     -0.001 -0.004 -0.008 -0.012 -0.016 -0.019 -0.020 -0.020 -0.015 -0.008 -0.013 -0.015;
%     -0.003 -0.009 -0.017 -0.024 -0.030 -0.034 -0.040 -0.037 -0.016 -0.002 -0.010 -0.019;
%     -0.001 -0.010 -0.020 -0.030 -0.039 -0.044 -0.050 -0.049 -0.023 -0.006 -0.014 -0.027;
%      0.000 -0.010 -0.022 -0.034 -0.047 -0.046 -0.059 -0.061 -0.033 -0.036 -0.035 -0.035;
%      0.007 -0.010 -0.023 -0.034 -0.049 -0.046 -0.068 -0.071 -0.060 -0.058 -0.062 -0.059;
%      0.009 -0.011 -0.023 -0.037 -0.050 -0.047 -0.074 -0.079 -0.091 -0.076 -0.077 -0.076];
% 
% % ----- indexação de α (colunas 1…12) -----
% S  = 0.2 * alpha;                 % α / 5
% K  = fix(S);                      % truncamento em direção a zero
% if K <= -2,  K = -1;  end
% if K >=  9,  K =  8;  end
% DA = S - K;
% L  = K + fix(sign(1.1*DA));       % próximo índice (trata DA==0)
% 
% % ----- indexação de |β| (linhas 1…7) -----
% S  = 0.2 * abs(beta);             % |β| / 5
% M  = fix(S);
% if M == 0,  M = 1;  end           % Fortran força M≥1
% if M >= 6,  M = 5;  end
% DB = S - M;
% N  = M + fix(sign(1.1*DB));
% 
% % Conversão para índices base-1 do MATLAB
% % Fortran: K,L ∈ [-1…8]  →  colunas MATLAB 1…12
% K = K + 3;   L = L + 3;
% % Fortran: M,N ∈ [1…5]  →  linhas MATLAB 1…7
% M = M + 1;   N = N + 1;
% 
% % interpolação bilinear
% T   = A(M,K);
% U   = A(N,K);
% V   = T + abs(DA)*(A(M,L) - T);
% W   = U + abs(DA)*(A(N,L) - U);
% DUM = V + (W-V)*abs(DB);
% 
% Cl = DUM * sign(beta);            % restaura o sinal de β
% end