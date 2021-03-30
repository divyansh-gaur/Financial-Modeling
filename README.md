# financial-modeling

## Options Pricing

### Simulation
Includes options evaluated through monte-carlo simulations

1. **[Monte Carlo Options](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/simulation/monte_carlo_options.m)**
     European, Asian, Lookback, Binary, Barrier, Double Trigger and Range Options

2. **[Spread Options](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/simulation/spread_options.m)**
     Spread Options evaluated for a basket of correlated assets
     
3. **[Longstaff Schwartz](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/simulation/longstaff_schwartz.m)**
     Evaluates American puts using Longstaff Schwartz approach

4. **[Bermuda Options](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/simulation/bermuda_option_regression.m)**
     Uses regression to evaluate Bermuda Options

5. **[Heston Model](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/simulation/heston_simulation.m)**
     Prices european options using the Heston Framework



### Numerical
Includes options evaluated through finite-difference Schemes

#### Black-Scholes Model

1. **[Black Scholes Function](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/black_scholes_function.m)**
     A function that uses the explicit approach to model the Black-Scholes equation

2. **[Black Scholes European](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/black_scholes_european.m)**
     Heat Equation transfromation for the Black-Scholes equation for European Calls and Puts
     
3. **[Black Scholes American](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/black_scholes_american_put.m)**
     Extension of Heat Equation transfromation for the Black-Scholes equation for American Puts

4. **[Greeks](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/greeks.m)**
     Computes the delta, gamma, theta, vega and rho greeks for options

5. **[Implied Volatility](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/implied_volatility.m)**
     Computes the implied volatility from the black-scholes model


#### _Analysis_
Includes codes that analyse the Black-Scholes Function

1. **[Error Analysis](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/analysis/error-analysis.m)**
     Error trucation with finer grids

2. **[Delta t](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/analysis/delta-t.m)**
     Options price vs delta t
     
3. **[S max](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/analysis/s-max.m)**
     Options price vs S max

4. **[S0: Initial Price](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/analysis/initial-price.m)**
     Options price vs S0

5. **[Volatility & Interest Rates](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/black-scholes/analysis/sigma-%26-r.m)**
     Options price vs volatility and interest rates




#### Heston Model
     

1. **[European Call](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/heston/euro_call.m)**
     Evaluates European Calls using Heston Model

2. **[European Put](https://github.com/div-gaur/financial-modeling/blob/master/options-pricing/numerical/heston/euro_put.m)**
     Evaluates European Puts using Heston Model





## Interest Rate Models


1. **[Vasicek Model](https://github.com/div-gaur/financial-modeling/blob/master/interest-rates/vacisek.m)**
     Evaluates Zero coupon bond prices

2. **[Hull-White Model](https://github.com/div-gaur/financial-modeling/blob/master/interest-rates/hull-white.m)**
     Extends the Vasicek model to disallow negative interest rates
     
3. **[Cox–Ingersoll–Ross model](https://github.com/div-gaur/financial-modeling/tree/master/interest-rates)**
     Calculates Short rate using the Cox–Ingersoll–Ross model







