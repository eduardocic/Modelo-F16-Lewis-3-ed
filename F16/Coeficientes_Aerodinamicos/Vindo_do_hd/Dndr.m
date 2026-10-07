function CoeficienteYawingMomentRudder = Dndr (alpha, beta)
% =========================================================================
%
%                        Momento de Yaw devido ao rudder 
%                       ---------------------------------
% 
% -- Os valores do AoA (ângulo de ataque) varia de -10º a 45º em passos de
%    5º;
%
% -- Os valores de derrapagem varia de -30º a 30º em passos de 10º;
%
% -- A tabela abaixo tem a seguinte equivalência:
%      x: AoA; e
%      y: beta.
%
% -- Atentar que a tabela em se reflete de forma que cresce da seguinte
%    da seguinte forma: (-10,45), ou seja da esquerda para a direita, e
%    (-30,30) de cima para baixo.
%
% -- Para acessarmos o valor correspondente para um determinado 'alpha' e
%    'beta' a gente chama da forma 'A(beta, alpha)', pois as variáveis 
%    variam de acordo com 'A(linha, coluna)'.
%               
% -- Com a coluna variando diz respeito aos parâmetros 'alpha' e as linhas
%    dizem respeito aos parâmetros 'beta', a chamada do valor da
%    interpolação será dado por 'A(beta, alpha)'.
%
% Última revisão: 19/09/2017.
% Eduardo H. Santos
% =========================================================================

Dndr = [ -0.018  -0.052  -0.052  -0.052  -0.054  -0.049  -0.059  -0.051  -0.030  -0.037  -0.026  -0.013;
         -0.028  -0.051  -0.043  -0.046  -0.045  -0.049  -0.057  -0.052  -0.030  -0.033  -0.030  -0.008;
         -0.037  -0.041  -0.038  -0.040  -0.040  -0.038  -0.037  -0.030  -0.027  -0.024  -0.019  -0.013;
         -0.048  -0.045  -0.045  -0.045  -0.044  -0.045  -0.047  -0.048  -0.049  -0.045  -0.033  -0.016;
         -0.043  -0.044  -0.041  -0.041  -0.040  -0.038  -0.034  -0.035  -0.035  -0.029  -0.022  -0.009;
         -0.052  -0.034  -0.036  -0.036  -0.035  -0.028  -0.024  -0.023  -0.020  -0.016  -0.010  -0.014;
         -0.062  -0.034  -0.027  -0.028  -0.027  -0.027  -0.023  -0.023  -0.019  -0.009  -0.025  -0.010;];

% Encontrando a célula de interpolação.
% 'AoA'.
S = alpha/5;
x = floor(S);
if(x <= -2)
    x = -2;
end
if(x >= 9)
    x = 8;
end

% 'beta'
S = beta/10;
y = floor(S);
if(y <= -3)
    y = -3;
end
if(y >= 3)
    y = 2;
end

% Valores dos retângulos.
x1 = 5*x;
x2 = 5*(x+1);
y1 = 10*y;
y2 = 10*(y+1);

% Ajuste para pegar os valores das tabelas.
xc  = x + 3;
yc  = y + 4;
Q11 = Dndr(yc, xc);
Q12 = Dndr(yc+1, xc);
Q21 = Dndr(yc, xc+1);
Q22 = Dndr(yc+1, xc+1);

% 5. Realiza o cálculo da interpolação.
Q = [Q11 Q12;
     Q21 Q22];
X = [ x1 1;
      x2 1];
Y = [ y1 1;
      y2 1];

CoeficienteYawingMomentRudder = [beta 1]*inv(Y)*(Q')*inv(X)'*[alpha 1]';

end