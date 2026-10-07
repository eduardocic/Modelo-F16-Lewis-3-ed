function [Mach, Qbar, rho, T] = ADC (VT, Alt)
% Atmosphere Data Computer.

rho0 = 2.377e-3;                    % Densidade ao nivel do mar.

Tfac = 1.0 - 0.703e-5 * Alt;
T    = 519.0 * Tfac;                % Temperatura.

if (Alt >= 35000.0)
   T = 390.0;
end
rho = rho0 * (Tfac^(4.14));

Mach = VT/sqrt(1.4 * 1716.3 * T);   % Numero de Mach.
Qbar = 0.5 * rho * VT * VT;         % Pressão dinâmica.
% Cps  = 1715 *rho *T;                % Pressão estática.

end
