% Function that uses Monte-Carlo simulation to evaluate vanilla and exotic options

function  [V_call, V_put] = monte_carlo_options(S0, K, g, sig, r, expiry_days, option_type, simulation_count)

%% Parameters

% S0 is the initial value of the underlying asset
% K is the strike price. !! For binary options it is the value of the payoff in the future!!
% g is the drift growth rate of the underlying asset
% sig is the volatility
% r is the rate of interest
% expiry_days is the number of days left till the expiry of the option
% option_type specifies the type of option to be evaluated
% simulation_count is the number of asset paths being simulated

dt = 1/365;
T = dt * expiry_days;

%% Evaluation of options

% Asset Paths being simulated
S = monte_carlo_paths(S0,g,sig,dt,expiry_days,simulation_count);


% European Options
if option_type == "european"
    payoff_put = max(K - (S(end, :)),0);
    payoff_call = max((S(end, :)) - K,0);
    
% Lookback Options
elseif option_type == "lookback"
    payoff_put = max(max(S) - (S(end, :)),0);
    payoff_call = max((S(end, :)) - min(S),0);
    
% Asian Options    
elseif option_type == "asian"
    payoff_put = max(K - mean(S),0);
    payoff_call = max(mean(S) - K,0);
    

% Binary Option (Single Trigger) Valution
elseif option_type == "binary"
   % Specify the condition
     condition = rand(1);
   % specify probability
     p = 0.3;
     if condition >= p
        payoff_put = K;
        payoff_call = payoff_put;
    else
        payoff_put = 0;
        payoff_call = payoff_put;
     end

% Barrier Options (European)
elseif option_type == "barrier"
    prompt_1 = "Specify the barrier option type";   
    x = input(prompt_1);
    prompt_2 = "Specify the barrier limit";
    y = input(prompt_2);
    
    Q = mean(S');
    
    if x == "knock-in"
        if Q>= y 
             payoff_put = max(K - (S(end, :)),0);
             payoff_call = max((S(end, :)) - K,0);
        else
             payoff_put = 0;
             payoff_call = 0;
        end
        
    elseif x == "knock-out" 
        if Q>= y
             payoff_put = 0;
             payoff_call = 0;
        else
             payoff_put = max(K - (S(end, :)),0);
             payoff_call = max((S(end, :)) - K,0);
        end
    end

% Double Trigger Options    
elseif option_type == "double_trigger"
    % Specify 1st condition
    condition_1 = randi(2);
    
    % Specify 2nd condition
    condition_2 = randi(2);
    
    if condition_1 == 2 && condition_2 == 2
        payoff_put = K;
        payoff_call = payoff_put;
    else
        payoff_put = 0;
        payoff_call = payoff_put;
    end
        
% Range Options    
elseif option_type == "range"
    
    prompt_1 = "Specify the lower limit";
    x = input(prompt_1);
    prompt_2 = "Specify the upper limit";
    y = input(prompt_2);
    
    if mean(S(end, :))<x || mean(S(end, :))>y
        payoff_put = 0;
        payoff_call = 0;
    else
        payoff_put = max(K - (S(end, :)),0);
        payoff_call = max((S(end, :)) - K,0);
    end
    
end

%% Discounting to arrive at the present value
V_put = mean(payoff_put) * exp(-r*T)
V_call = mean(payoff_call) * exp(-r*T)

end


function S = monte_carlo_paths(S0,g,sig,dt,expiry_days,simulation_count)

% Computation of the drift term
beta = g - (sig^2)/2;

% Simulating Asset Paths
S = S0*[ones(1,simulation_count); cumprod(exp(beta*dt + sig*sqrt(dt)*randn(expiry_days,simulation_count)),1)]; 
end
