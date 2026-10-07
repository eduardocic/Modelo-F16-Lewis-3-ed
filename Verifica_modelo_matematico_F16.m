close all; clear all; clc;

% Carrega as páginas relativas a simulação.
MainPath = pwd;
Folders = {'F16'; 
           'F16\Planeta_Terra';
           'F16\Atmosfera';
           'F16\Turbina';
           'F16\Coeficientes_Aerodinamicos';
           'F16\Massa';
           'F16\Inercia'};

% Adiciona as pastas no caminho.
for i = 1:numel(Folders) 
    Pasta = fullfile(MainPath, Folders{i}); 
    
    if isfolder(Pasta) 
        addpath(Pasta); 
    else 
        error('Pasta não encontrada: %s', Pasta); 
    end
end


% Seta as condições iniciais.
x = [500 0.5 -0.2 -1 1 -1 0.7 -0.8 0.9 1000 900 10000 90];
Parametro = 0.4;                                           
u = [0.9 20 -15 -20 Parametro];
t = 0.0;

% Resultado.
[xd, y] = F16_aircraft(x, u, t);

vpa(xd')
