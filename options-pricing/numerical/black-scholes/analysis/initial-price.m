%% Parameters
S0_list = [10, 15, 20, 25, 30];
T = 0.5;
K = 20;
S_max = 1000;
S_min = 0;
sig = 0.25;
r = 0.04545;
M = 1000;
N = 1000;
x = 1;


[S, V_BS0] = black_scholes_function(T, K, S_max, S_min, sig, r, N, M, x);
V_list = zeros(size(S0_list));
for i = 1: length(S0_list)
    [row, col]  = find(S == S0_list(i));
    V_list(i) = V_BS0(row, col);
end


figure(2)
plot(S0_list, V_list)
