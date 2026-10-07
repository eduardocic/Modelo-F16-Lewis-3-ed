function Saida = Rtau(DP)

% Funcao utilizada pela funcao PowerRate

if (DP <= 25.0)
    Saida = 1.0;
elseif(DP >= 50.0)
    Saida = 0.1;
else
    Saida = 1.9 - 0.036*DP;
end

end