exact_sol_train = fopen( 'exact_sol_train.txt', 'w' );
mu_train = fopen( 'mu_train.txt', 'w' );

for mu = 1e-2 : -1e-4 : 0.98 * 1e-2 
    [errors,solutions,femregion,Dati,Peclet,tau] = C_main2D('Test1',3,0,mu);
    fprintf( exact_sol_train, '%7.6f\t', full(solutions.uh) );
    fprintf( exact_sol_train, '\n' );
    fprintf( mu_train, '%7.6f', mu );
    fprintf( mu_train, '\n' );
end

fclose( exact_sol_train );
fclose( mu_train );