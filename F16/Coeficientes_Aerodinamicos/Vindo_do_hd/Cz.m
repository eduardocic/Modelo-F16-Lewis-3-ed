function CoeficienteForcaZ = Cz (alpha, beta, elevator)
% =========================================================================
%
%                        Coeficiente Forçaa no eixo Z
%                       -----------------------------
% 
% -- Os valores do AoA (ângulo de ataque) varia de -10° a 45° em passos de
%    5°;
%
% -- A tabela abaixo tem a seguinte equivalência:
%      x: AoA;
%
% Última revisão: 19/09/2017.
% Eduardo H. Santos
% =========================================================================
A = [ 0.770  0.241  -0.100  -0.416  -0.731  -1.053  -1.366  -1.646  -1.917  -2.120  -2.248  -2.229];


% Encontrando o valor interpolado.
ALPHA = linspace(-10,45,12);
S = spline(ALPHA, A, alpha);

CoeficienteForcaZ = S*(1-(beta/57.3)^2) - 0.19*(elevator/25.0);

end