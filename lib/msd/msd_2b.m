function dx = msd_2b( t, x, u, theta_m, r1, r2, a, b, n )

    % x = [y, theta1_hat, theta2_hat, y_hat]
    
    dx( 1 ) = -a * x( 1 ) + b * u( t );
    dx( 2 ) = -r1 * ( x( 1 ) + n( t ) - x( 4 ) ) * x( 1 );
    dx( 3 ) = r2 * ( x( 1 ) + n( t ) - x( 4 ) ) * u( t );
    dx( 4 ) = -x( 2 ) * ( x( 1 ) + n( t ) ) + x( 3 ) * u( t ) + theta_m * ( x( 1 ) + n( t ) - x( 4 ) ); 
    
    dx = dx';

end