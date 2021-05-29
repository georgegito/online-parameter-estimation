function t_set = sim_3( r1, r2 )

%% data
    % parameters
    A = [ -0.25, 3; -5, -1 ];
    B = [ 1; 2.2 ];
    u = @( t ) ...
           10 * sin( 2 * t ) + 5 * sin( 7.5 * t );
    
    % initial state
    x0( 1: 10 ) = 0;

    t_span = 0: 0.01: 100;
    N = length( t_span );
    
%% compute states by solving the differential equations of the system
    [ ~, x ] = ode45( @( t, x ) msd_3( t, x, u, r1, r2, A, B ), t_span, x0 );

    y1 = x( :, 1 );
    y2 = x( :, 2 );
    a11_hat = x( :, 3 );
    a12_hat = x( :, 4 );
    a21_hat = x( :, 5 );
    a22_hat = x( :, 6 );
    b1_hat = x( :, 7 );
    b2_hat = x( :, 8 );
    y1_hat = x( :, 9 );
    y2_hat = x( :, 10 );
    
%% squared error
    sq_err = zeros( N, 1 );
    for i = 1: N
        sq_err( i ) = (y1( i ) - y1_hat( i ) )^2 + (y2( i ) - y2_hat( i ) )^2;
    end
    
%% percentage error
    perc_err = zeros( N, 1 );
    for i = 1: N
        perc_err( i ) = sqrt( ( ( y1( i ) - y1_hat( i ) ) /  y1( i ) )^2 + ( ( y2( i ) - y2_hat( i ) ) /  y2( i ) )^2 );
    end
    
%% settling time
    t_set = -1;
    for i = 1: N
        if t_set < 0 && perc_err( i ) < 0.05
            t_set = t_span( i );
        end
        if perc_err( i ) >= 0.05
            t_set = -1;
        end
    end
    
%% plots
%     figure( 1 )
%     hold on;
%     plot( t_span, y1, 'Linewidth', 0.5 );
%     plot( t_span, y2, 'Linewidth', 0.5 );
%     plot( t_span, y1_hat, 'Linewidth', 0.5 );
%     plot( t_span, y2_hat, 'Linewidth', 0.5 );
%     hold off;
%     grid on;
%     legend('$y_1$', '$y_2$', '$\hat{y_1}$', '$\hat{y_2}$', 'interpreter', 'latex', 'FontWeight', 'bold');

    figure( 2 )
    plot( t_span, sq_err, 'Linewidth', 0.8 );
    grid on;
    xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('squared error', 'interpreter', 'latex', 'FontWeight', 'bold');
    legend('$(y_1-\hat{y_1})^2 + (y_2-\hat{y_2})^2$', 'interpreter', 'latex', 'FontWeight', 'bold');
    
    figure( 3 )
    hold on;
    plot( t_span, a11_hat, 'Linewidth', 0.8 );
    plot( t_span, a12_hat, 'Linewidth', 0.8 ); 
    plot( t_span, a21_hat, 'Linewidth', 0.8 ); 
    plot( t_span, a22_hat, 'Linewidth', 0.8 ); 
    plot( t_span, b1_hat, 'Linewidth', 0.8 );
    plot( t_span, b2_hat, 'Linewidth', 0.8 );
    hold off;
    grid on;
    xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('estimated parameters', 'interpreter', 'latex', 'FontWeight', 'bold');
    legend('$\hat{a_{11}}$', '$\hat{a_{12}}$', '$\hat{a_{21}}$', '$\hat{a_{22}}$', '$\hat{b_1}$', '$\hat{b_2}$', 'interpreter', 'latex', 'FontWeight', 'bold');
    
end