function sim_2a( r1, r2, n0, f )

%% data
    % parameters
    a = 2;
    b = 1;
    u = @( t ) ...
           5 * sin( 3 * t );
    n = @( t ) ...
            n0 * sin( 2 * pi * f * t );
    
    % x = [y, theta1_hat, theta2_hat, y_hat]
    
    % initial state: x0 = [y0, theta1_hat0, theta2_hat0, phi1_0, phi2_0, y_hat0]
    x0( 1: 4 ) = 0;
    
    t_span = 0: 0.01: 20;
    N = length( t_span );

%% compute states by solving the differential equations of the system
    [ ~, x ] = ode45( @( t, x ) msd_2a( t, x, u,r1, r2, a, b, n ), t_span, x0 );
    
    y = x( :, 1 );
    theta1_hat = x( :, 2 );
    theta2_hat = x( :, 3 );
    y_hat = x( :, 4 );
    
    a_hat = theta1_hat;
    b_hat = theta2_hat;

%% noisy output
    y_n = zeros( N, 1 );
    for i = 1: N
        y_n( i ) = y( i ) + n( t_span( i ) );
    end
    
%% squared error
    sq_err = zeros( N, 1 );
    for i = 1: N
        sq_err( i ) = (y( i ) - y_hat( i ) )^2;
    end
    
%% Lyapunov function
    V = zeros( N, 1 );
    for i = 1: N
        V( i ) = ( 1 / 2 ) * ( y( i ) - y_hat( i ) ) ^ 2 + ...
                    ( 1 / ( 2 * r1 ) ) * (theta1_hat( i ) - a ) ^ 2 + ...
                    ( 1 / (2 * r2 ) ) * ( theta2_hat( i ) - b ) ^ 2;
    end
    
%% plots 
    figure( 1 )
    hold on;
    plot( t_span, y, 'Linewidth', 1 );
    plot( t_span, y_n, 'Linewidth', 0.5 );
    plot( t_span, y_hat, 'Linewidth', 1 );
    hold off;
    grid on;
    xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('real, noisy \& estimated output (P)',  'interpreter', 'latex', 'FontWeight', 'bold');
    legend('$y$', '$y_n$', '$\hat{y}$', 'interpreter', 'latex', 'FontWeight', 'bold');

%     figure( 2 )
%     hold on;
%     plot( t_span, y, 'Linewidth', 1 );
%     plot( t_span, y_hat, 'Linewidth', 1 );
%     hold off;
%     grid on;
%     xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
%     title('real \& estimated output',  'interpreter', 'latex', 'FontWeight', 'bold');
%     legend('$y$', '$\hat{y}$', 'interpreter', 'latex', 'FontWeight', 'bold');

    figure( 3 )
    hold on;
    plot( t_span, a_hat, 'Linewidth', 1 ); 
    plot( t_span, b_hat, 'Linewidth', 1 );
    hold off;
    grid on;
    xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('estimated parameters (P)', 'interpreter', 'latex', 'FontWeight', 'bold');
    legend('$\hat{a}$', '$\hat{b}$', 'interpreter', 'latex', 'FontWeight', 'bold');

    figure( 4 )
    plot( t_span, sq_err, 'Linewidth', 1 );
    grid on;
    xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('squared error (P)', 'interpreter', 'latex', 'FontWeight', 'bold');
    legend('$(y-\hat{y})^2$', 'interpreter', 'latex', 'FontWeight', 'bold');
    
%     figure( 5 )
%     plot( t_span, V, 'Linewidth', 1 );
%     grid on;
%     xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
%     title('Lyapunov function', 'interpreter', 'latex', 'FontWeight', 'bold');
%     legend('$V(e, \bar{\theta}_1, \bar{\theta}_2, \gamma_1, \gamma_2)$', 'interpreter', 'latex', 'FontWeight', 'bold');

end
    
    