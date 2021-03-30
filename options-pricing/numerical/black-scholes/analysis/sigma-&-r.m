%% Parameters

sig_list = [0.2, 0.25, 0.3, 0.4, 0.5, 0.6, 0.7, 0.75, 0.8, 0.9]';
r_list = [0.01, 0.02, 0.04, 0.05, 0.08, 0.09, 0.10, 0.12, 0.13, 0.15]';

T = 0.5;
K = 210;
S_0 = 230;
S_max = 1000;
S_min = 0;
N = 500;
M = 500;
x = 1;


for i = 1: size(sig_list, 1)
    for j = 1: size(r_list, 1)
    [S, V_BS0] = black_scholes_function(T, K, S_max, S_min, sig_list(i), r_list(j), N, M, x);
    [row, col]  = find(S == S_0);
    V_list(i, j) = V_BS0(row, col);
    end
end

surf(sig_list, r_list, V_list)
