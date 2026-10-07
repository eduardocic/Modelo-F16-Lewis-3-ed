function Saida = TGear (Thtl)      
    
% Esta funcao faz a relacao entre o comando entre as relacoes existentes
% entre o POWER COMMAND VS. THROATLE para o F16.
% A sua codificação se encontra na página 635 do livro do Lewis.

if (Thtl <= 0.77)
    Saida = 64.94 * Thtl;
else
    Saida = 217.38 * Thtl - 117.38;
end

end