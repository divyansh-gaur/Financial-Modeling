% This function evaluates an american put option through monte-carlo simulation and regression
function value_option = longstaff_schwartz(S0,K,r,sig,T,N,M,f)

%% Parameters

% S0 is the initial value of the underlying asset
% K is the strike price.
% r is the rate of interest
% sig is the volatility
% T is the number of days left till maturity
% N is the number of discrete time steps available in each path
% M is the number of paths simulated
% f (0<f<6) is the number of basis functions used to regress in the model

dt = T/N;
t = 0:dt:T;

u = randn(M/2,1); % Random number to simulate fluctuations in the underlying asset
h = (r-sig^2/2)*T + sig*sqrt(T)*[u;-u]; %

S = S0*exp(h); % Populating the asset price matrix for the f

Payoff = max(K-S,0); % payoff of an American put when exercised

for i = N:-1:2
   
    u = randn(M/2,1);
    h = t(i)*h/t(i+1) + sig*sqrt(dt*t(i)/t(i+1))*[u; -u];
    S = S0.*exp(h);
    
    money_paths = find(K-S>0); % Paths which are in the money
    P = S(money_paths); % Prices of money paths
    Q = Payoff(money_paths)*exp(-r*dt); % Present value of payoffs
    
    G = BasisFunct(P,f);
    coefficient = G\Q; % Calculation of the regression coefficient
    Value_continue = G*coefficient; % Predicted value of continuing
    Value_current = K-P; % Value_current gives the payoff if exercised now
    
    Exercise_paths = money_paths(Value_continue<Value_current); % The paths where one should exercise
    Other_paths = setdiff(1:M,Exercise_paths); % The paths where not to exercise
    
    Payoff(Exercise_paths) = Value_current(Value_continue<Value_current);
    Payoff(Other_paths) = Payoff(Other_paths)*exp(-r*dt);

end

value_option = mean(Payoff*exp(-r*dt)); % Value of the American Put Option

end


%% Polynomial Basis functions for regression

function G = BasisFunct(P,f)

if f == 1
    G = [ones(size(P)) (1-P)];

elseif f == 2
    G = [ones(size(P)) (1-P) 1/2*(2-4*P+P.^2)];

elseif f == 3
    G = [ones(size(P)) (1-P) 1/2*(2-4*P+P.^2) 1/6*(6-18*P+9*P.^2-P.^3)];

elseif f == 4
    G = [ones(size(P)) (1-P) 1/2*(2-4*P+P.^2) 1/6*(6-18*P+9*P.^2-P.^3) 1/24*(24-96*P+72*P.^2-16*P.^3+P.^4)];

elseif f == 5
    G = [ones(size(P)) (1-P) 1/2*(2-4*P+P.^2) 1/6*(6-18*P+9*P.^2-P.^3) 1/24*(24-96*P+72*P.^2-16*P.^3+P.^4) 1/120*(120-600*P+600*P.^2-200*P.^3+25*P.^4-P.^5)];

end


end
