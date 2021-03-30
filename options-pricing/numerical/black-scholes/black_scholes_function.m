function [S, V_BS] = black_scholes_function(T, K, S_max, S_min, sig, r, N, M, x)
%% Parameters
dt = (T/N);      % Time step
ds = S_max/M;    % Underlying Asset Value step

S = linspace(S_min, S_max, M+1)';    % Underlying Asset Value Grid
t = linspace(0, T, N+1)';            % Time Grid

%% Final and Boundary Conditions

V = zeros(M+1, N+1);
o = 0:N;

% Call Option
if x == 1 
    % Boundary Conditions
    V(1, :) = 0;
    V(end, :) = (S_max - K*exp(-r*dt*(N-o)));
    % Final Conditions
    V(:, end) = max((S - K), 0);
    
%Put Option    
   else 
    % Boundary Conditions
     V(1, :) = K*exp(-r*dt*(N-o));
     V(end, :) = 0;
     % Final Conditions
     V(:, end) = max(K-S,0);
end

%% Tridiagonal Matrix

j = 0:M;

a = 0.5*dt*(r*j-sig^2*j.^2);
b = 1+dt*(sig^2*j.^2+r);
c = -0.5*dt*(sig^2*j.^2+r*j);

P = diag(a(3:M),-1) + diag(b(2:M)) + diag(c(2:M-1), 1);

%% Solution

Q = zeros(size(P, 2), 1);

for i = N: -1: 1
    Q(1) = a(2)*V(1,i); % For Puts
    
    Q(end) = c(end)* V(end, i); % For Calls
    
    V(2:M, i) = P\(V(2:M, i+1) - Q);
end
V_BS = V(:, 1);

end
