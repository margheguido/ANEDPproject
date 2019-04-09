function [ load ] = C_load_SUPG( BJ, w_2D, pphys_2D, nln, Grad, Dati )

detB = det( BJ( :, :, 1 ) );
invB = inv( BJ( :, :, 1 ) );
load = zeros( nln, 1 );
x = pphys_2D( :, 1 );
y = pphys_2D( :, 2 );
F = eval( Dati.force );
b1_phys = eval( Dati.b1 );
b2_phys = eval( Dati.b2 );
b_phys = [ b1_phys, b2_phys ];    % i = nodo, j = direzione

for i = 1 : nln
    for q = 1 : length(w_2D)
        load( i ) = load( i ) + w_2D(q) * detB * b_phys( q, : ) * (Grad( q, :, i ) * invB)' * F( q );
    end
end

end