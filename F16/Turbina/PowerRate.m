function Saida = PowerRate (P3, P1)

% Faz o calculo da mudanca de potencia.
%
% Variaveis de entrada.
% P3 = Potencia atual; e
% P1 = O comando de Potência.

if (P1 >= 50)
    if( P3 >= 50.0)
        T  = 5.0;
        P2 = P1;
    else
        P2 = 60.0;
        T  = Rtau(P2 - P3);        
    end
else
    if (P3 >= 50.0)
        T  = 5.0;
        P2 = 40.0;
    else
        P2 = P1;
        T  = Rtau(P2-P3);
    end     
end

Saida = T*(P2-P3);

end