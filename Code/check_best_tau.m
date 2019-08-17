clear all
close all

%% Test1

mu = 1e-5;
nRef = 3;

ii = 1;
stabilization_amount = 10.^[ -2, -1, -0.5, -0.2, 0, 0.2, 0.5, 1, 2 ]; %( -2 : 3 );
for stab = stabilization_amount
    [ errors, solutions, femregion, Dati, Peclet, tau ] = C_main2D( 'Test1', nRef, stab, mu );
    err_L2( ii ) = errors.Error_L2;
    err_H1( ii ) = errors.Error_H1;
    ii = ii + 1;
end

figure
subplot( 2, 1, 1 )
semilogx( stabilization_amount, err_L2, '.-' )
subplot( 2, 1, 2 )
semilogx( stabilization_amount, err_H1, '.-' )

