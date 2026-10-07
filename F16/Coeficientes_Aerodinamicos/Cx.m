function Cx = Cx(alpha, elevator)
    % Tabela A(elev = -2:2, alpha = -2:9)
    A = [ -0.099  -0.081  -0.081  -0.063  -0.025   0.044   0.097   0.113   0.145   0.167   0.174   0.166;
          -0.048  -0.038  -0.040  -0.021   0.016   0.083   0.127   0.137   0.162   0.177   0.179   0.167;
          -0.022  -0.020  -0.021  -0.004   0.032   0.094   0.128   0.130   0.154   0.161   0.155   0.138;
          -0.040  -0.038  -0.039  -0.025   0.006   0.062   0.087   0.085   0.100   0.110   0.104   0.091;
          -0.083  -0.073  -0.076  -0.072  -0.046   0.012   0.024   0.025   0.043   0.053   0.047   0.040 ];

    % --- alpha ---
    S  = 0.2 * alpha;
    K  = fix(S);
    K  = max(min(K, 8), -1);          % clamp [-1,8]
    DA = S - K;
    K  = K + 3;                       % → coluna MATLAB
    L  = K + fix(sign(DA) * 1.1);

    % --- elevator ---
    S  = elevator / 12;
    M  = fix(S);
    M  = max(min(M, 1), -1);          % clamp [-1,1]
    DE = S - M;
    M  = M + 3;                       % → linha MATLAB
    N  = M + fix(sign(DE) * 1.1);

    % Interpolação bilinear
    T  = A(M, K);
    U  = A(N, K);
    V  = T + abs(DA) * (A(M, L) - T);
    W  = U + abs(DA) * (A(N, L) - U);
    Cx = V + (W - V) * abs(DE);
end