function CoeficienteMomentYawing = Cn(alpha, beta)
% =========================================================================
%
%                       Momento de Yawing 
%                      --------------------
% 
% -- Os valores do AoA (ângulo de ataque) varia de -10º a 45º em passos de
%    5º;
%
% -- Os valores de derrapagem varia de 0° a 30° em passos de 5°;
%
% -- A tabela abaixo tem a seguinte equivalência:
%      x: AoA; e
%      y: beta.
%
% -- Atentar que a tabela em se reflete de forma que cresce da seguinte
%    da seguinte forma: (-10,45), ou seja da esquerda para a direita, e
%    (0,30) de cima para baixo.
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
Cn = [ 0.000  0.000  0.000  0.000  0.000  0.000  0.000  0.000  0.000   0.000   0.000   0.000;
       0.018  0.019  0.018  0.019  0.019  0.018  0.013  0.007  0.004  -0.014  -0.017  -0.033;
       0.038  0.042  0.042  0.042  0.043  0.039  0.030  0.017  0.004  -0.035  -0.047  -0.057;
       0.056  0.057  0.059  0.058  0.058  0.053  0.032  0.012  0.002  -0.046  -0.071  -0.073;
       0.064  0.077  0.076  0.074  0.073  0.057  0.029  0.007  0.012  -0.034  -0.065  -0.041;
       0.074  0.086  0.093  0.089  0.080  0.062  0.049  0.022  0.028  -0.012  -0.002  -0.013;
       0.079  0.090  0.106  0.106  0.096  0.080  0.068  0.030  0.064   0.015   0.011  -0.001];

% Encontrando a c�lula de interpola��o.
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
S = beta/5;
y = floor(S);
if(y <= 0)
    y = 0;
end
if(y >= 6)
    y = 5;
end

% Valores dos ret�ngulos.
x1 = 5*x;
x2 = 5*(x+1);
y1 = 5*y;
y2 = 5*(y+1);

% Ajuste para pegar os valores das tabelas.
xc  = x + 3;
yc  = y + 1;
Q11 = Cn(yc, xc);
Q12 = Cn(yc+1, xc);
Q21 = Cn(yc, xc+1);
Q22 = Cn(yc+1, xc+1);

% 5. Realiza o c�lculo da interpola��o.
Q = [Q11 Q12;
     Q21 Q22];
X = [ x1 1;
      x2 1];
Y = [ y1 1;
      y2 1];

 
CoeficienteMomentYawing = [beta 1]*inv(Y)*(Q')*inv(X)'*[alpha 1]';
   
end