%% Parameters
S0 = 10;
K = 5;
T = 10;
sig = 0.2;
r = 0.03;
greek = "gamma";
x = 1;
M = 1000;
N = 1000;
S_min = 0;    
S_max = 20;

%% Greeks

if greek == "delta"
    [S, V_BS] = black_scholes_function(T, K, S_max, S_min, sig, r, N, M, x);
    delta  = diff(V_BS)./diff(S);
    plot(S(2:end-1), delta(1:end-1))
    ylabel('Delta');
    xlabel('Price of Underlying Asset');
    
elseif greek == "gamma"
    [S, V_BS] = black_scholes_function(T, K, S_max, S_min, sig, r, N, M, x);
    delta  = diff(V_BS)./diff(S);
    gamma  = diff(delta)./diff(S(2:end));
    plot(S(3:end-1), gamma(1:end-1))
    ylabel('Gamma');
    xlabel('Price of Underlying Asset');
    
elseif greek == "vega"
    sig_min = 0.1;
    sig_max = 0.8;
    sig = linspace(sig_min, sig_max, 10)';
    V = zeros(length(sig), 1);
    for i = 1:length(sig)
        [S, V_BS] = black_scholes_function(T, K, S_max, S_min, sig(i), r, N, M, x);
        [row, col] = find(S==S0);
        V(i, 1) = V_BS(row, col);
    end
    
    vega = diff(V)./diff(sig);
    plot(sig(2:end-1), vega(1:end-1))
    ylabel('Vega');
    xlabel('Volatility of the Underlying Asset');
    
elseif greek == "theta"
    T_min = 5;
    T_max = 1;
    T = linspace(T_min, T_max, 10)';
    V = zeros(length(T), 1);
    for i = 1:length(T)
        [S, V_BS] = black_scholes_function(T(i), K, S_max, S_min, sig, r, N, M, x);
        [row, col] = find(S==S0);
        V(i, 1) = V_BS(row, col);
    end
    
    theta = diff(V)./diff(T);
    plot(T(2:end-1), theta(1:end-1))
    ylabel('Theta');
    xlabel('Time to maturity');
    
elseif greek == "rho"
    r_min = 0.01;
    r_max = 0.11;
    r = linspace(r_min, r_max, 10)';
    V = zeros(length(r), 1);
    for i = 1:length(r)
        [S, V_BS] = black_scholes_function(T, K, S_max, S_min, sig, r(i), N, M, x);
        [row, col] = find(S==S0);
        V(i, 1) = V_BS(row, col);
    end
    
    rho = diff(V)./diff(r);
    plot(r(2:end-1), rho(1:end-1))
    ylabel('Rho');
    xlabel('Risk free interest rate');
    
end
