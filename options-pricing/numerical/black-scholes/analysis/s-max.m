%% Parameters

S_max_list = [40, 50, 80, 100, 150, 200, 250, 400, 500, 600]';

T = 0.5;
K = 20;
S_min = 0;
S_0 = 30;
sig = 0.25;
r = 0.04545;
M = S_max_list(end, 1);
x = 1;
N = 500;

V_list = zeros(size(S_max_list, 1), 1);

for i = 1: size(S_max_list, 1)
    [S, V_BS0] = black_scholes_function(T, K, S_max_list(i), S_min, sig, r, N, M, x);
    [row, col]  = find(S == S_0);
    V_list(i) = V_BS0(row, col);
end

plot(S_max_list, V_list)
