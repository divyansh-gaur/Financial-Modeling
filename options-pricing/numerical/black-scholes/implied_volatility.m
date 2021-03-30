%% Parameters
S0 = 450;
K = 410;
T = 0.2466;
r = 0.02;
x = 1;
M = 1000;
N = 1000;
S_min = 0;    
S_max = 500;
option_val = 45;
sig_vec = linspace(0, 1, 19);


%% Interpolation
for i = 1:length(sig_vec)
  [S, V_BS] = black_scholes_function(T, K, S_max, S_min, sig_vec(i), r, N, M, x);
  [row, col] = find(S==S0);
  options_vec(i) = V_BS(row, col);
end

sig = interp1(options_vec, sig_vec,option_val);
