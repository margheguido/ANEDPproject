exact_sol_train = fopen( 'exact_sol_train.txt', 'w' );


for mu = 1 : -0.0030 : 1e-1
    [errors,solutions,femregion,Dati,Peclet,tau] = C_main2D('Test2',3,0,mu);
    fprintf( exact_sol_train, '%7.6f', mu );

    fprintf( exact_sol_train, '\t%7.6f', full(solutions.uh) );
    fprintf( exact_sol_train, '\n' );

end

fclose( exact_sol_train );
