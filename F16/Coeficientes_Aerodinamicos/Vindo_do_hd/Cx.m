function CoeficienteForcaX = Cx (alpha, elevator)
% =========================================================================
%
%                        Coeficiente Força no Eixo X
%                       -----------------------------
% 
% -- Os valores do AoA (ângulo de ataque) varia de -10° a 45° em passos de
%    5º;
%
% -- Os valores de derrapagem varia de -25° a 25° em passos de 12,5°;
%
% -- A tabela abaixo tem a seguinte equivalência:
%      x: AoA; e
%      y: Elevator.
%
% -- Atentar que a tabela em se reflete de forma que cresce da seguinte
%    da seguinte forma: (-10,45), ou seja da esquerda para a direita, e
%    (-25,25) de cima para baixo.
%
% -- Para acessarmos o valor correspondente para um determinado 'alpha' e
%    'elevator' a gente chama da forma 'A(elevator, alpha)', pois as 
%    variáveis variam de acordo com 'A(linha, coluna)'.
%               
% -- Com a coluna variando diz respeito aos parâmetros 'alpha' e as linhas
%    dizem respeito aos parâmetros 'elevator', a chamada do valor da
%    interpolação será dado por 'A(elevator, alpha)'.
%
% Última revisão: 19/09/2017.
% Eduardo H. Santos
% =========================================================================

Cx = [ -0.099  -0.081  -0.081  -0.063  -0.025  0.044  0.097  0.113  0.145  0.167  0.174  0.166;
       -0.048  -0.038  -0.040  -0.021   0.016  0.083  0.127  0.137  0.162  0.177  0.179  0.167;
       -0.022  -0.020  -0.021  -0.004   0.032  0.094  0.128  0.130  0.154  0.161  0.155  0.138;
       -0.040  -0.038  -0.039  -0.025   0.006  0.062  0.087  0.085  0.100  0.110  0.104  0.091;
       -0.083  -0.073  -0.076  -0.072  -0.046  0.012  0.024  0.025  0.043  0.053  0.047  0.040];

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

% Elevator
S = elevator/12;
y = floor(S);
if(y <= -2)
    y = -2;
end
if(y >= 2)
    y = 1;
end


% Valores dos retângulos.
x1 = 5*x;
x2 = 5*(x+1);
y1 = 12*y;
y2 = 12*(y+1);

% Ajuste para pegar os valores das tabelas.
xc  = x + 3;
yc  = y + 3;
Q11 = Cx(yc, xc);
Q12 = Cx(yc+1, xc);
Q21 = Cx(yc, xc+1);
Q22 = Cx(yc+1, xc+1);

% 5. Realiza o cálculo da interpolação.
Q = [Q11 Q12;
     Q21 Q22];
X = [ x1 1;
      x2 1];
Y = [ y1 1;
      y2 1];
  
CoeficienteForcaX = [elevator 1]*inv(Y)*(Q')*inv(X)'*[alpha 1]';
end