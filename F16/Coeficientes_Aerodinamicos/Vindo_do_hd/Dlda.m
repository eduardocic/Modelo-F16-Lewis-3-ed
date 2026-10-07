function CoeficienteRollingMomentAileron = Clda (alpha, beta)
% =========================================================================
%
%                  Momento de Rolling devido ao Aileron 
%                 --------------------------------------
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

Dlda = [ -0.041  -0.052  -0.053  -0.056  -0.050  -0.056  -0.082  -0.059  -0.042  -0.038  -0.027  -0.017;
         -0.041  -0.053  -0.053  -0.053  -0.050  -0.051  -0.066  -0.043  -0.038  -0.027  -0.023  -0.016;
         -0.042  -0.053  -0.052  -0.051  -0.049  -0.049  -0.043  -0.035  -0.026  -0.016  -0.018  -0.014;
         -0.040  -0.052  -0.051  -0.052  -0.048  -0.048  -0.042  -0.037  -0.031  -0.026  -0.017  -0.012;
         -0.043  -0.049  -0.048  -0.049  -0.043  -0.042  -0.042  -0.036  -0.025  -0.021  -0.016  -0.011;
         -0.044  -0.048  -0.048  -0.047  -0.042  -0.041  -0.020  -0.028  -0.013  -0.014  -0.011  -0.010;
         -0.043  -0.049  -0.047  -0.045  -0.042  -0.037  -0.003  -0.013  -0.010  -0.003  -0.007  -0.008];

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
Q11 = Dlda(yc, xc);
Q12 = Dlda(yc+1, xc);
Q21 = Dlda(yc, xc+1);
Q22 = Dlda(yc+1, xc+1);

% 5. Realiza o cálculo da interpolação.
Q = [Q11 Q12;
     Q21 Q22];
X = [ x1 1;
      x2 1];
Y = [ y1 1;
      y2 1];
  
CoeficienteRollingMomentAileron = [beta 1]*inv(Y)*(Q')*inv(X)'*[alpha 1]';

end