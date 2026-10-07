function [J] = momento_de_inercia()

Jxx   = 9496.0;
Jyy   = 55814.0;
Jzz   = 63100.0;
Jxz   = 982.0;
Jxy   = 0.0;            % Não explicitamente apresentado no livro.
Jyz   = 0.0;            % Não explicitamente apresentado no livro.


% Equação 1.7-3, página 36.
J = [  Jxx, -Jxy,  -Jxz;
      -Jxy,  Jyy,  -Jyz;
      -Jxz, -Jyz,   Jzz];

end