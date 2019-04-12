function [ load ] = C_load( BJ, w_2D, pphys_2D, dphiq, nln, Dati )

detB = det( BJ( :, :, 1 ) );
load = zeros( nln, 1 );
x = pphys_2D( :, 1 );
y = pphys_2D( :, 2 );

b1_phys = eval( Dati.b1 );
b2_phys = eval( Dati.b2 );
F = eval(Dati.force);

for i = 1 : nln
    for q = 1 : length(w_2D)
        load( i ) = load( i ) + w_2D(q) * detB * dphiq( 1, q, i ) * F( q );
    end
end

end