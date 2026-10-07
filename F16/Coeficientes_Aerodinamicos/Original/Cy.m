function CoeficienteSideForce = Cy (beta, aileron, rudder)

CoeficienteSideForce = -0.02*beta + 0.021*(aileron/20.0) + 0.086*(rudder/30);

end