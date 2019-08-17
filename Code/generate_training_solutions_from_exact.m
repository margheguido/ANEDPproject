clear all
close all

SUPG_ANN_dataset = fopen( 'SUPG.txt', 'w' );

% Print headers
fprintf( SUPG_ANN_dataset, 'mu          \t' );
n_dofs = 9;         % n_dofs = 9 --> nRef = 1, n_dofs = 25 --> nRef = 2, n_dofs = 81 --> nRef = 3, ...
for i = 1 : n_dofs
    fprintf( SUPG_ANN_dataset, 'dof_%1.0f        \t', i );
end
fprintf( SUPG_ANN_dataset, '\n' );

for mu = 1 : -1e-1 : 0.1 % 0.5 * 1e-5 : 1e-6 : 1.5 * 1e-5 
    
%     [errors,solutions,femregion,Dati,Peclet,tau] = C_main2D('Test1',1,0,mu);
%     exact_solution = Dati.exact_sol;
%     n_dofs = femregion.ndof;

    % Exact solution
    exact_solution = '-atan(((x-0.5).^2+(y-0.5).^2-1/16)./(sqrt(mu)))';
    
    % Compute sampling points (mesh vertexes)
    h = 1 / ( sqrt( n_dofs ) - 1 );
    x = [];
    for i = 1 : sqrt( n_dofs )
       x = [ x, 0 : h : 1 ]; 
    end
    y = [];
    for i = 0 : sqrt( n_dofs ) - 1
       y = [ y, ones( 1, sqrt( n_dofs ) ) * h * i ]; 
    end
    
    % Evaluate exact solution at sampling points
    sampled_exact_solution = eval( exact_solution );
    
    % Print on file
    fprintf( SUPG_ANN_dataset, '%10.9f \t', mu );
    fprintf( SUPG_ANN_dataset, '%10.9f \t', sampled_exact_solution );
    fprintf( SUPG_ANN_dataset, '\n' );
    
end

fclose( SUPG_ANN_dataset );

