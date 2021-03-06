function [ tau ] = calculate_tau_SUPG( femregion, pphys_2D, Dati ,Peclet)

delta = coth(Peclet)-1/Peclet;
delta2=delta*1e12;
delta3=delta*1e-2;

x = pphys_2D( :, 1 );
y = pphys_2D( :, 2 );
b1_phys = eval( Dati.b1 );
b2_phys = eval( Dati.b2 );
b_phys = [ b1_phys, b2_phys ];    % i = nodo, j = direzione
b_phys_mean = mean( b_phys, 1 );

tau = delta* femregion.h / norm( b_phys_mean );

end

