function dx = msd_2a( t, x, u, r1, r2, a, b, n )

    % x = [y, theta1_hat, theta2_hat, y_hat]

    dx( 1 ) = -a * x( 1 ) + b * u( t );
    dx( 2 ) = -r1 * ( x( 1 ) + n( t ) - x( 4 ) ) * x( 4 );
    dx( 3 ) = r2 * ( x( 1 ) + n( t ) - x( 4 ) ) * u( t );
    dx( 4 ) = -x( 2 ) * x( 4 ) + x( 3 ) * u( t ); 
    
    dx = dx';

end