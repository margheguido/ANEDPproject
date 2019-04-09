function [ A ] = C_A_diff_2D( BJ, w_2D, Grad, nln )

detB = det( BJ( :, :, 1 ) );
invB = inv( BJ( :, :, 1 ) );
A = zeros( nln, nln );
for i = 1 : nln
    for j = 1 : nln
        for q = 1 : length(w_2D)
            A( i, j ) = A( i, j ) + w_2D(q) * detB * Grad( q, :, j ) * invB * invB' * Grad( q, :, i )';
        end
    end
end

end