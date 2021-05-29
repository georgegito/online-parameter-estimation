function [t_set, max_e] = sim_1( r, am )

%% data
    % parameters
    a = 2;
    b = 1;
    u = @( t ) ...
           5 * sin( 3 * t );
    
    % x = [y, theta1_hat, theta2_hat, phi1, phi2, y_hat]
    
    % initial state: x0 = [y0, theta1_hat0, theta2_hat0, phi1_0, phi2_0, y_hat0]
    x0( 1: 6 ) = 0;
    
    t_span = 0: 0.01: 15;
    N = length( t_span );

%% compute states by solving the differential equations of the system
    [ ~, x ] = ode45( @( t, x ) msd_1( t, x, u, am, r, a, b ), t_span, x0 );
    
    y = x( :, 1 );
    theta1_hat = x( :, 2 );
    theta2_hat = x( :, 3 );
    y_hat = x( :, 6 );
    
    % a_hat
    a_hat = zeros( N, 1 );
    for i = 1: N
        a_hat( i ) = am - theta1_hat( i );
    end
    
    % b_hat
    b_hat = theta2_hat;
    
%% squared error
    sq_err = zeros( N, 1 );
    for i = 1: N
        sq_err( i ) = (y( i ) - y_hat( i ) )^2;
    end
    
%% percentage error
    perc_err = zeros( N, 1 );
    for i = 1: N
        perc_err( i ) = abs( ( y( i ) - y_hat( i ) ) /  y( i ) );
    end
    
%% max error
    max_e = 0;
    for i = 1: N
        e_ = ( y( i ) - y_hat( i ) ) ^ 2;
        if e_ > max_e
            max_e = e_;
        end
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
    figure( 1 )
    hold on;
    plot( t_span, y, 'Linewidth', 1 );
    plot( t_span, y_hat, 'Linewidth', 1 );
    hold off;
    grid on;
    xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('real \& estimated output',  'interpreter', 'latex', 'FontWeight', 'bold');
    legend('$y$', '$\hat{y}$', 'interpreter', 'latex', 'FontWeight', 'bold');
    
    figure( 2 )
    hold on;
    plot( t_span, a_hat, 'Linewidth', 1 ); 
    plot( t_span, b_hat, 'Linewidth', 1 );
    hold off;
    grid on;
    xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('estimated parameters', 'interpreter', 'latex', 'FontWeight', 'bold');
    legend('$\hat{a}$', '$\hat{b}$', 'interpreter', 'latex', 'FontWeight', 'bold');

    figure( 3 )
    plot( t_span, sq_err, 'Linewidth', 1 );
    grid on;
    xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('squared error', 'interpreter', 'latex', 'FontWeight', 'bold');
    legend('$(y-\hat{y})^2$', 'interpreter', 'latex', 'FontWeight', 'bold');

    figure( 4 )
    plot( t_span, perc_err, 'Linewidth', 1 );
    grid on;
    xlabel('time (s)', 'interpreter', 'latex', 'FontWeight', 'bold');
    title('$error \%$', 'interpreter', 'latex', 'FontWeight', 'bold');
    legend('$\frac{y-\hat{y}}{y}$', 'interpreter', 'latex', 'FontWeight', 'bold');
    
end
    
    
    
    
