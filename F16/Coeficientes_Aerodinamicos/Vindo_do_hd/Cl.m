function CoeficienteRollingMoment = Cl(alpha, beta)
% =========================================================================
%
%                       Momento de Rolling 
%                      --------------------
% 
% -- Os valores do AoA (angulo de ataque) varia de -10º a 45º em passos de
%    5º;
%
% -- Os valores de derrapagem varia de 0º a 30º em passos de 5º;
%
% -- A tabela abaixo tem a seguinte equivalºncia:
%      x: AoA; e
%      y: beta.
%
% -- Atentar que a tabela em se reflete de forma que cresce da seguinte
%    da seguinte forma: (-10,45), ou seja da esquerda para a direita, e
%    (0,30) de cima para baixo.
%
% -- Para acessarmos o valor correspondente para um determinado 'alpha' e
%    'beta' a gente chama da forma 'A(beta, alpha)', pois as variºveis 
%    variam de acordo com 'A(linha, coluna)'.
%               
% -- Com a coluna variando diz respeito aos parºmetros 'alpha' e as linhas
%    dizem respeito aos parºmetros 'beta', a chamada do valor da
%    interpolacao sera dado por 'A(beta, alpha)'.
%
% Ultima revisao: 19/09/2017.
% Eduardo H. Santos
% =========================================================================
Cl = [   0.000   0.000   0.000   0.000   0.000   0.000   0.000   0.000   0.000   0.000   0.000   0.000;
        -0.001  -0.004  -0.008  -0.012  -0.016  -0.019  -0.020  -0.020  -0.015  -0.008  -0.013  -0.015;
        -0.003  -0.009  -0.017  -0.024  -0.030  -0.034  -0.040  -0.037  -0.016  -0.002  -0.010  -0.019;
        -0.001  -0.010  -0.020  -0.030  -0.039  -0.044  -0.050  -0.049  -0.023  -0.006  -0.014  -0.027;
         0.000  -0.010  -0.022  -0.034  -0.047  -0.046  -0.059  -0.061  -0.033  -0.036  -0.035  -0.035;
         0.007  -0.010  -0.023  -0.034  -0.049  -0.046  -0.068  -0.071  -0.060  -0.058  -0.062  -0.059;
         0.009  -0.011  -0.023  -0.037  -0.050  -0.047  -0.074  -0.079  -0.091  -0.076  -0.077  -0.076];
    
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
S = beta/5;
y = floor(S);
if(y <= 0)
    y = 0;
end
if(y >= 6)
    y = 5;
end

% Valores dos retangulos.
x1 = 5*x;
x2 = 5*(x+1);
y1 = 5*y;
y2 = 5*(y+1);

% Ajuste para pegar os valores das tabelas.
xc  = x + 3;
yc  = y + 1;
Q11 = Cl(yc, xc);
Q12 = Cl(yc+1, xc);
Q21 = Cl(yc, xc+1);
Q22 = Cl(yc+1, xc+1);

% 5. Realiza o calculo da interpolacao.
Q = [Q11 Q12;
     Q21 Q22];
X = [ x1 1;
      x2 1];
Y = [ y1 1;
      y2 1];

CoeficienteRollingMoment = [beta 1]*inv(Y)*(Q')*inv(X)'*[alpha 1]';
end
 
    
    