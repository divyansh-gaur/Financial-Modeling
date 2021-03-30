%% Parameters

%[P, Q] = size(S);    
P = 7;               % P is the number of Paths
Q = 3;               
S0 = 1;              % S0 is the current stock price
T = Q-1;             % Number of periods
r = 0.06;            % Interest Rate
E = 1.1;             % Exercise Price

%% Generating Stock Value Matrix

F = rand(P, Q);
S = zeros(size(F));
S(:, 1) = S0;

for i = 1:P
    for j = 2:Q
        n = randi(2);
        if n == 1
            S(i,j) = S(i,j-1) + F(i,j)*S(i,j-1);
        else
            S(i,j) = S(i,j-1) - F(i,j)*S(i,j-1);
        end
    end
end

%S = xlsread('american_puts.xlsx'); % Import the datafile with stock paths

%% Check whether "in the money"

C = zeros(P, T); % Cash Flow Matrix

for i = 1:P
    if S(i, end)<E
        C(i, end) = E - S(i, end);
    end
end


for k = 1 : T-1
    
%% Regression
X = zeros(P, 2);

for i = 1:P
    if S(i, end-k) < E
        X(i, 1) = S(i, end-k);
    end
end

% Discounting next year's Cash Flows 
X(:, 2) = C(:, end-k+1)/(1+r);

% Dropping zero valued entries
indices = find(X(:,1)==0);
X(indices,:) = [];

% Least Square Regression
A = polyfit(X(:, 1),X(:, 2),2)';


%% Projection

D = zeros(P, 2);

for i = 1:P
    if S(i, end-k) < E
        
        D(i, 1) = E - S(i, end-k);
        D(i, 2) = (A(3) + A(2)*S(i, end-k) + A(1)* S(i,end-k).^2);
        
        if D(i, 1)>D(i, 2)
                C(i, end-k) = D(i, 1);
                C(i, end-k+1:end) = 0;
        
        end
    end
end
end

spy(C);
