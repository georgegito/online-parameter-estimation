function dx = msd_3( t, x, u, r1, r2, A, B )
    
    % x = [y1, y2, a11_hat, a12_hat, a21_hat, a22_hat, b1_hat, b2_hat, y1_hat, y2_hat]
    % x1 = y1
    % x2 = y2
    % x3 = a11_hat
    % x4 = a12_hat
    % x5 = a21_hat
    % x6 = a22_hat
    % x7 = b1_hat
    % x8 = b2_hat
    % x9 = y1_hat
    % x10 = y2_hat
    
    dx( 1 ) = A( 1, 1 ) * x( 1 ) + A( 1, 2 ) * x( 2 ) + B( 1 ) * u( t );
    dx( 2 ) = A( 2, 1 ) * x( 1 ) + A( 2, 2 ) * x( 2 ) + B( 2 ) * u( t );
    dx( 3 ) = r1 * ( x( 1 ) - x( 9 ) ) * x( 9 );
    dx( 4 ) = r1 * ( x( 1 ) - x( 9 ) ) * x( 10 );
    dx( 5 ) = r1 * ( x( 2 ) - x( 10 ) ) * x( 9 );
    dx( 6 ) = r1 * ( x( 2 ) - x( 10 ) ) * x( 10 );
    dx( 7 ) = r2 * ( x( 1 ) - x( 9 ) ) * u( t );
    dx( 8 ) = r2 * ( x( 2 ) - x( 10 ) ) * u( t );
    dx( 9 ) = x( 3 ) * x( 9 ) + x( 4 ) * x( 10 ) + x( 7 ) * u( t );
    dx( 10 ) = x( 5 ) * x( 9 ) + x( 6 ) * x( 10 ) + x( 8 ) * u( t );
    
    dx = dx';

end