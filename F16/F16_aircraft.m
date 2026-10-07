function [xd, y] = F16_aircraft(x, u, t)

% =========================================================================
%
%                     CONSTANTES DE CARÁTER GERAL
%
% =========================================================================
RtoD  = 180/pi;           % conversão 'radiano' para 'graus'.


% =========================================================================
%
%            PROPRIEDADES DE MASSA E DERIVAÇÕES PARA O F16
%
% =========================================================================
g             = gravidade();        % Escalar e positiva.
g_vector      = [0; 
                 0; 
                 g];
[massa, peso] = massa_e_peso(g);
J             = momento_de_inercia();


% =========================================================================
%
%                        PROPRIEDADES DO F16
%
% =========================================================================
S     = 300;        % Area das asas (total)
b     = 30;         % Wingtip to wingtip.
c_bar = 11.32;      % Corda media.
Xcgr  = 0.35;       % Xcg de referência
Hx    = 160.0;      % Momento angular induzido pelo sistema de propulsão
Hy    = 0.0;         % Não explicitamente apresentado no livro.
Hz    = 0.0;         % Não explicitamente apresentado no livro.


% =========================================================================
%
%             PARÂMETROS DE CONTROLE DO SISTEMA (ENTRADA)
%
% =========================================================================
throatle = u(1);
elevator = u(2);
aileron  = u(3);
rudder   = u(4);
Xcg      = u(5);


% =========================================================================
%
%                       PARÂMETROS DE ESTADO
%
% =========================================================================
VT        = x(1);           % velocidade total [ft/s]
alfa_deg  = x(2) * RtoD;    % ângulo de ataque [°]
beta_deg  = x(3) * RtoD;    % ângulo de derrapagem [°]
phi       = x(4);           % ângulo de rolamento [rad]
theta     = x(5);           % ângulo de arfagem [rad]
psi       = x(6);           % ângulo de guinada [rad]
P         = x(7);           % taxa de rolamento [rad/s]
Q         = x(8);           % taxa de arfagem [rad/s]
R         = x(9);           % taxa de guinada [rad/s]
altitude  = x(12);          % altitude [ft]
pow       = x(13);      


% =========================================================================
%
%                       PRÉ-CÁLCULO DE VARIÁVEIS
%
% =========================================================================
% Matriz C_frd/ned da Equação (1.3-10), página 12.
%
% (*) O 'frd' é a referência para 'forward, right and down', que alinha com
%     o eixo do avião. E o NED é o nosso North-East-Down.
%
% (*) O a matriz 'C_NED_to_frd' pega uma variável no eixo do NED e
%     transporta para o frd. Essa é importante, por exemplo, para a gente trazer o
%     vetor de gravidade local e refleti-lo no eixo do corpo nas equações
%     de Força.
%
% (*) Já a matrix 'C_frd_to_NED' pega uma variável em NED e transporta para 
%     o eixo NED. 
C_NED_to_frd = [                                 cos(theta)*cos(psi),                               cos(theta) * sin(psi),          -sin(theta);
                (-cos(phi)*sin(psi) + sin(phi)*sin(theta)*cos(psi)),  (cos(phi)*cos(psi) + sin(phi)*sin(theta)*sin(psi)), (sin(phi)*cos(theta));
                (sin(phi)*sin(psi) + cos(phi)*sin(theta)*cos(psi)), (-sin(phi)*cos(psi) + cos(phi)*sin(theta)*sin(psi)), (cos(phi)*cos(theta))];


C_frd_to_NED = C_NED_to_frd';

% Velocidade angular instantânea da aeronave.
omega_b = [P; 
           Q; 
           R];

% Equação 2.3-6a, página 78.
alfa = x(2);        % em rad.
beta = x(3);        % em rad.
U     = VT * cos(alfa) * cos(beta);
V     = VT * sin(beta);
W     = VT * sin(alfa) * cos(beta);

% Velocidade relativa.
v_rel = [U;
         V;
         W];


% =========================================================================
%
%                       PROCESSA MODELO ATMOSFÉRICO
%
% =========================================================================
% calcula número Mach e pressão dinâmica. 
[Mach, ~, rho, temperature] = ADC (VT, altitude);


% =========================================================================
%
%                       PROCESSA MODELO PROPULSIVO
%
% =========================================================================
Cpow   = TGear(throatle);
xd(13) = PowerRate(x(13), Cpow);
Empuxo = Thrust(pow, altitude, Mach);


% =========================================================================
%
%                       PROCESSA MODELO AERODINÂMICO
%
% =========================================================================
% Normaliza parâmetros do sistema de atuação.
Dail = aileron / 20.0;
Drdr =  rudder / 30.0;

% Modelo básico.
Cxt = Cx(alfa_deg, elevator);
Cyt = Cy(beta_deg, aileron, rudder);
Czt = Cz(alfa_deg, beta_deg, elevator);
Clt = Cl(alfa_deg, beta_deg) + Dlda(alfa_deg, beta_deg) * Dail + Dldr(alfa_deg, beta_deg) * Drdr;
Cmt = Cm(alfa_deg, elevator);
Cnt = Cn(alfa_deg, beta_deg) + Dnda(alfa_deg, beta_deg) * Dail + Dndr(alfa_deg, beta_deg) * Drdr;

% Considera amortecimento aeerodinâmico e arrasto.
TVT = 0.5 / VT;
B2V = b * TVT;
Cq  = c_bar * Q * TVT;
D   = Damping(alfa_deg);

% Resultante total do sistema.
CX = Cxt + Cq * D(1);
CY = Cyt + B2V * (D(2)*R + D(3)*P);
CZ = Czt + Cq * D(4);
CL = Clt + B2V * (D(5)*R + D(6)*P);
CM = Cmt + Cq * D(7) + CZ * (Xcgr - Xcg);
CN = Cnt + B2V * (D(8)*R + D(9)*P) - CY * (Xcgr - Xcg) * c_bar/ b;


% =========================================================================
%                       Equações de Força 
%                       ------------------
%
% A referência encontra-se disponível na equação 1.7-16c, página 41 do
% livro do Lewis, 3ª Edição. 
% =========================================================================
% a) Forças aerodinânicas
forca_aerodinamica_x = (1/2) * rho * (VT^2) * S * CX;
forca_aerodinamica_y = (1/2) * rho * (VT^2) * S * CY;
forca_aerodinamica_z = (1/2) * rho * (VT^2) * S * CZ;

Fx_resultante = forca_aerodinamica_x + Empuxo;
Fy_resultante = forca_aerodinamica_y;
Fz_resultante = forca_aerodinamica_z;

% b) Gravidade (refletida no eixo do corpo 'frd').
Grav = C_NED_to_frd * g_vector;

% c) omega_b x v_rel.
prod_vetorial = cross(omega_b, v_rel);

% Equação 2.5-0, da página 112.
Udot = (Fx_resultante)/massa + Grav(1) - prod_vetorial(1);
Vdot = (Fy_resultante)/massa + Grav(2) - prod_vetorial(2);
Wdot = (Fz_resultante)/massa + Grav(3) - prod_vetorial(3);

% Equação 2.3-10, página 81 do livro. 
xd(1) = (U * Udot + V * Vdot + W * Wdot)/VT;
xd(2) = (U * Wdot - W * Udot) / (U * U + W * W);
xd(3) = (Vdot * VT - V * xd(1)) / (VT * (sqrt(U * U + W * W)));


% =========================================================================
%                       Equações de Cinemática
%                      ------------------------
%
% A referência encontra-se disponível na equação 1.4-4, página 20 do
% livro do Lewis, 3ª Edição. 
% =========================================================================
MATRIX = [ 1,   sin(phi)*tan(theta),  cos(phi)*tan(theta);
           0,              cos(phi),            -sin(phi);
           0,   sin(phi)/cos(theta),  cos(phi)/cos(theta)];

PROD   = MATRIX * omega_b;

xd(4)  = PROD(1, 1);
xd(5)  = PROD(2, 1);
xd(6)  = PROD(3, 1);


% =========================================================================
%                        Equações de Momento
%                      -----------------------
%
% A referência encontra-se disponível na equação 1.7-6, página 37 do
% livro do Lewis, 3ª Edição. 
%
% Determinação dos momentos, pág. 79. 
% =========================================================================
% Contribuição dos motores.
h_engines = [Hx; Hy; Hz];

% Contribuição da aerodinâmica.
T_B = [(1/2) * rho * (VT^2) * S * b     * CL;     % Momento de rolamento (L).
       (1/2) * rho * (VT^2) * S * c_bar * CM;     % Momento de arfagem (M).
       (1/2) * rho * (VT^2) * S * b     * CN];    % Momento de guinada (N).

% Cálculo das atualizações.
PROD  = inv(J) * (T_B - cross(omega_b, (J * omega_b) + h_engines) );

xd(7) = PROD(1, 1);
xd(8) = PROD(2, 1);
xd(9) = PROD(3, 1);


% =========================================================================
%                       Equações de Navegação
%                      -----------------------
%
% A referência encontra-se disponível na equação 1.7-6, página 37 do
% livro do Lewis, 3ª Edição. 
%
% Determinação dos momentos, pág. 79. 
% =========================================================================
% Produto matricial compacto para obter as taxas de posição [p_N_dot; p_E_dot; h_dot]
pos_dot = C_frd_to_NED * [U; V; W];

xd(10) = pos_dot(1);    % Velocidade de Norte (p_N_dot)
xd(11) = pos_dot(2);    % Velocidade de Leste (p_E_dot)
xd(12) = pos_dot(3);    % Velocidade Vertical / Taxa de altitude (h_dot)


% =========================================================================
%                       Saídas de interesse
%                      ---------------------
%
% =========================================================================
y(1) = 0.0;


end