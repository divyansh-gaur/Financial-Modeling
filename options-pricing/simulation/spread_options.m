function [Price_option] = spread_options(S0, r, g, sig, correl, expiry_days, simulation_count, pre_spread)

%% Parameters

% S0 is a vector of values of underlying assets
% r is the current interest rate
% g is a vector of drift growth rate of the underlying assets
% sig is a vector of volatilities of the underlying assets
% correl is the correlation matrix of the underlying assets

% expiry_days is the number of days left till the expiry of the option
% simulation_count is the number of asset paths being simulated
% pre_spread is the constant pre-specified maximum allowable spread

dt = 1/365;
T = dt*expiry_days;

%% Assets paths generated
S = correlated_monte_carlo(S0,g,sig,correl,dt,expiry_days,simulation_count);

%% Computation of Payoff
payoff = zeros(simulation_count,1);

for p = 1:simulation_count
    
    maximum_diff = diff(squeeze(S(:,p,:)),1,2);
    
    maximum_spread = max(abs(maximum_diff));
    
    if any(maximum_spread>pre_spread)
        payoff(p) = 0;
    else
        payoff(p) = maximum_spread;
    end
    
end

%% Evaluation of the option price
Price_option = mean(payoff)*exp(-r*T);
end

%% Simulate correlated asset paths
function S = correlated_monte_carlo(S0,g,sig,correl,dt,expiry_days,simulation_count)

%% Parameters
number_of_assets = length(S0);   % Number of correlated assets ascertained
beta = g - (sig.^2)/2; % Computation of the drift term
F = chol(correl);  % Cholesky factorization of the correlation matrix
S = zeros(expiry_days+1, simulation_count, number_of_assets); % Initialize matrix

%% Paths and sequences
for j = 1:simulation_count

    phi = randn(expiry_days,size(correl,2));  % Uncorrelated random sequence being generated
    z = phi*F;    % Random sequences being correlated
    
    % Asset Paths being simulated
    S(:,j,:) = [ones(1,number_of_assets); cumprod(exp(repmat(beta*dt,expiry_days,1)+z*diag(sig)*sqrt(dt)))]*diag(S0);

end

end
