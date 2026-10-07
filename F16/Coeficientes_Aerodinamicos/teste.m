clear all; close all; clc; 

% alpha = 17;
% beta  = 2;

% CoeficienteRollingMoment = Cl(alpha, beta);
% vpa(CoeficienteRollingMoment)
% DampCoeficientes = Damping(alpha);
% vpa(DampCoeficientes)

alpha    = -0.1*(180/pi);
elevator = 0.32;
CoeficienteForcaX = Cx (alpha, elevator);
vpa(CoeficienteForcaX)


% beta     = -8;
% aileron  = -4;
% rudder   = 19;
% CoeficienteSideForce = Cy (beta, aileron, rudder);
% vpa(CoeficienteSideForce);

% alpha    = -3;
% beta     = -8;
% elevator = 11.9;
% CoeficienteForcaZ = Cz (alpha, beta, elevator);
% vpa(CoeficienteForcaZ)

% alpha    = -8;
% elevator = -4;
% CoeficientePitching = Cm (alpha, elevator);
% vpa(CoeficientePitching)

% beta  = -7.3;
% alpha = 11.1;
% CoeficienteMomentYawing = Cn(alpha, beta);
% vpa(CoeficienteMomentYawing)


% beta  = -4;
% alpha = -0.79;
% CoeficienteRollingMomentAileron = Dlda(alpha, beta);
% vpa(CoeficienteRollingMomentAileron)
% CoeficienteRollingMomentRudder = Dldr (alpha, beta);
% vpa(CoeficienteRollingMomentRudder)

% CoeficienteYawingMomentAileron = Dnda(alpha, beta);
% vpa(CoeficienteYawingMomentAileron)

% CoeficienteYawingMomentRudder = Dndr(alpha, beta);
% vpa(CoeficienteYawingMomentRudder)