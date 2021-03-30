%% Parameters

V0 = 0.01; % V_0 is the current variance of the underlying asset 
S0 = 10; % S_0 is the initial price of the underlying asset 
r = 0.05; % Risk Free rate of return
kappa = 2; % Kappa is the rate of reversion
mu = 0.01; % mu is the average return of the asset
sig = 0.1; % sig is the volatility of the volatility
rho = 0.5; % Correlation of the two Stochastic Processes
T = 1; % Time to maturity
N = 100; % Number of time steps
simulation_count = 1000; % Number of simulations
dt = T/N;



% Initialize the vectors
V = [V0 zeros(1,simulation_count)];
S = [S0 zeros(1,simulation_count)];

for i=1:1:1000

% Randomize the two stochastic processes
chance1 = randn(1);
chance2 = randn(1);

F = chance1;
G = rho * chance1 + sqrt(1-rho^2) * chance2;

V(i+1) = abs(V(i) + kappa * (mu - V(i)) * dt + sig * sqrt(V(i)) * sqrt(dt) * G); 
S(i+1) = S(i) + r * S(i) * dt + S(i) * sqrt(dt) * sqrt(V(i)) * F;

end

V_avg = mean(V)
S_avg = mean(S)

subplot(2, 1, 1)
title('Asset Simulation');
xlabel('Paths'); ylabel('Underlying Stock');
plot(1:simulation_count,S(1:simulation_count))

subplot(2, 1, 2)
title('Variance Simulation');
xlabel('Paths'); ylabel('Variance');
plot(1:simulation_count,V(1:simulation_count))
