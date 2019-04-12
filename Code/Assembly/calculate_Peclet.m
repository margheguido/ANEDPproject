function [ Peclet ] = calculate_Peclet( femregion, Dati, pphys_2D )

x = pphys_2D( :, 1 );
y = pphys_2D( :, 2 );
b1_phys = eval( Dati.b1 );
b2_phys = eval( Dati.b2 );
b_phys = [ b1_phys, b2_phys ];    % i = nodo, j = direzione
b_phys_mean = mean( b_phys, 1 );

Peclet = norm( b_phys_mean ) * femregion.h / ( 2 * Dati.mu );

end