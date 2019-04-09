function [ A ] = C_A_adv_2D( BJ, w_2D, pphys_2D, Grad, dphiq, nln, Dati )

detB = det( BJ( :, :, 1 ) );
invB = inv( BJ( :, :, 1 ) );
A = zeros( nln, nln );
x = pphys_2D( :, 1 );
y = pphys_2D( :, 2 );
b1_phys = eval( Dati.b1 );
b2_phys = eval( Dati.b2 );
b_phys = [ b1_phys, b2_phys ];       % i = nodo, j = direzione

for i = 1 : nln
    for j = 1 : nln
        for q = 1 : length(w_2D)
            A( i, j ) = A( i, j ) + w_2D(q) * detB .* dphiq( 1, q, i ) * ( b_phys( q, : ) * ( Grad( q, :, j ) * invB )');
        end
    end
end

end
