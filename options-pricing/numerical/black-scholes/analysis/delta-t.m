%% Parameters

N_list = [5, 10, 20, 40, 80, 160, 320, 640, 1280, 2560]';

T = 0.5;
K = 210;
S_0 = 230;
S_max = 1000;
S_min = 0;
sig = 0.25;
r = 0.04545;
M = 1000;
x = 1;


for i = 1: size(N_list, 1)
    [S, V_BS0] = black_scholes_function(T, K, S_max, S_min, sig, r, N_list(i), M, x);
    [row, col]  = find(S == S_0);
    V_list(i) = V_BS0(row, col);
end


figure(2)
plot(N_list, V_list)
