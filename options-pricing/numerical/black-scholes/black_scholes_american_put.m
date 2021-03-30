%% Parameters

x_min = -10; % Space variable lower limit
x_max = 10; % Space variable upper limit
K = 100; % Strike Price
T = 0.5; % Time to maturity
r = 0.05; % Risk free interest rate
sig = 0.4; % Volatility of the underlying asset
M = 1000; % Space variable nodes
N = 1000; % Time variable nodes

alpha = (2*r)/(sig^2); % recurring coefficient 

space_var = linspace(x_min,x_max,M+2)'; 
x = space_var(2:length(space_var)-1); % Internal nodes of space variable
dx = x(2) - x(1);

time_var = linspace(0,T*(sig^2)/2,N+1);
dtau = time_var(2) - time_var(1);

V = zeros(length(x),length(time_var));

%% Boundary Conditions

E = @(tau) 0;
dE = @(tau) 0;
F = @(tau) exp(0.5*(alpha-1)*x_max+0.25*((alpha-1)^2)*tau);
dF = @(tau) 0.25*((alpha-1)^2)*F(tau);
H = @(h,tau) (E(tau)-F(tau)).*((h-x_min)/(x_max - x_min))+F(tau);
    

%% Initial Conditions

J = @(x) max(exp(x.*((1/2)*(alpha-1)))-exp((x.*((1/2)*(alpha+1)))),0);
V(:,1) = J(x) - H(x,0);


%% Setting up the matrices

% e Matrix

P = @(p,tau) dx*(((p-x_min)/(x_max-x_min)) * (-dF(tau))+dF(tau));
for i = 1:length(time_var)
    e(:,i) = P(x,time_var(i));
end

% Matrix A (Tridiagonal)
A = zeros(M,M);
diag_elements = [-1,2,-1];

for i=2:M-1
    A(i,i-1:i+1) = diag_elements;
end

A(1,1:2) = [2,-1];
A(M,M-1:M) = [-1,2];

A = (1/dx) * A;

% Matrix B (Tridiagonal)

B = zeros(M,M);
diag_elements = [1,4,1];

for i=2:M-1
    B(i,i-1:i+1) = diag_elements;
end

B(1,1:2) = [4,1];
B(M,M-1:M) = [1,4];

B = (dx/6)*B;

W = B - (dtau/2) * A;
U = inv(B + (dtau/2) * A);

%% Solution to the PDE


V1(:,1) = J(x);
for i=2:length(time_var)
    V(:,i)=U*(W*V(:,i-1)-(dtau/2)*(e(:,i)+e(:,i-1)));
    g(:,i)=exp(0.25*(alpha+1)^2*time_var(i)).*max(exp(0.5*(alpha-1).*x)-exp(0.5*(alpha+1).*x),0);
    V1(:,i)=V(:,i)+H(x,time_var(i));
    for j=1:length(x)
        if V1(j,i) - g(j,i)<0 
            V1(j,i) = g(j,i);
        end
    end
    V(:,i)=V1(:,i)-H(x,time_var(i));
end


% All values computation
Base = zeros(length(space_var),length(time_var));

for i=1:length(space_var)
    for k=1:length(time_var)
        Base(i,k) = H(space_var(i),time_var(k));
    end
end

end_points = zeros(1,length(time_var));
V_complete = [end_points; V; end_points] + Base;

space_mat = (-0.5)*(alpha-1) * space_var;
tau_mat = (-0.25)*((alpha+1)^2)*time_var;

for i = 1:length(space_var)
    
    for k=1:length(time_var)
        
        V_complete (i,k)=(K*exp(space_mat(i)+tau_mat(k))) * V_complete(i,k);
    
    end
end


%% Converting back to financial variables

asset_price = K * exp(space_var);
time = T - time_var*2/sig^2;

%% Plot

% Usable range
upper_lim = 550;
lower_lim = 250;

figure;
mesh(time',asset_price(lower_lim:upper_lim),V_complete(lower_lim:upper_lim,:));
title('Black Scholes Model: American Put');
ylabel('Asset Price');
xlabel('Time to Maturity');
zlabel('Value of the Option');
