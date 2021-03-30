[S_0, v_0] = black_scholes_function(10, 5, 10, 0, 0.05, 0.01, 4, 4, 1);

for i = 3: 10

[S_1, v_1] = black_scholes_function(10, 5, 10, 0, 0.05, 0.01, 2*size(v_0, 1)-2, 2*size(v_0, 1)-2, 1);

del_x(i-2) = S_0(2) - S_0(1);

err = error_pde(v_0, v_1, del_x(i-2));

E(i-2) = err;

v_0 = v_1;
S_0 = S_1;
end

subplot(2, 1, 1)
plot(fliplr(del_x), E, 'r')
title('Error')


subplot(2, 1, 2)
loglog(fliplr(del_x), E, 'g')
title('Log Scale')


function err = error_pde(v_0, v_1, del_x)

err = sum(abs(del_x*(v_1(1:2:end)-v_0)));

end
