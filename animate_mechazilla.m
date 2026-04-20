%% --- ANIMAZIONE MECHAZILLA (Con salvataggio GIF) ---

function animation = animate_mechazilla(x_sol, t)

    par = get_params();
    W_rocket = par.rock.b;
    H_rocket = par.rock.h;
    Y_target = par.env.target_py;

    py_max = 200;
    px_max = par.env.px_max;
    px_min = -px_max;

    Tolerance_W = W_rocket + 5;
    Tolerance_H = H_rocket + 5;
    
    % --- SETUP GIF ---
    filename = 'mechazilla_landing.gif'; % Nome del file in uscita
    
    h_fig = figure('Name', 'Animazione Mechazilla', 'Color', 'w', ...
                   'WindowStyle', 'normal', 'NumberTitle', 'off'); 

    hold on; axis equal;
    xlim([px_min, px_max]);
    ylim([0, py_max + 20]);
    xlabel('X [m]'); ylabel('Y [m]');
   
    line([px_min, px_max], [0, 0], 'Color', 'k', 'LineWidth', 2);
    
    X_zone = [-Tolerance_W/2, Tolerance_W/2, Tolerance_W/2, -Tolerance_W/2];
    Y_zone = [Y_target - Tolerance_H/2, Y_target - Tolerance_H/2, ...
              Y_target + Tolerance_H/2, Y_target + Tolerance_H/2];
    
    patch(X_zone, Y_zone, [0 0.75 0.39], 'FaceAlpha', 0.2, 'EdgeColor', [0 0.5 0], ...
          'LineWidth', .5, 'LineStyle', '--');
    
    text(0, 10, 'TARGET ZONE', ...
         'Color', 'k', 'HorizontalAlignment', 'center', 'FontWeight', 'bold');

    X_rel = [-W_rocket/2, W_rocket/2, W_rocket/2, -W_rocket/2];
    Y_rel = [-H_rocket/2, -H_rocket/2, H_rocket/2, H_rocket/2];
    
    h_rocket = patch(X_rel, Y_rel, [1 0.19 0.19], 'EdgeColor', 'k', 'LineWidth', .5);
    h_title = title('Ready...');
    
    n_steps = length(t);
    step_skip = max(1, floor(n_steps / 100)); 

    for k = 1:step_skip:n_steps
        
        if ~ishandle(h_rocket), break; end
    
        px = x_sol(1, k);
        py = x_sol(2, k);
        theta = x_sol(3, k);
        
        R = [cos(theta), -sin(theta); sin(theta), cos(theta)];
        coords_rot = R * [X_rel; Y_rel];
        
        X_cur = coords_rot(1, :) + px;
        Y_cur = coords_rot(2, :) + py;
        
        set(h_rocket, 'XData', X_cur, 'YData', Y_cur);
        set(h_title, 'String', sprintf('Time: %.2fs | Y: %.1fm', t(k), py));
        
        drawnow;

        % --- LOGICA DI SALVATAGGIO GIF ---
        % Cattura il frame della figura
        frame = getframe(h_fig);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256); % Converte in immagine indicizzata (standard GIF)

        if k == 1
            % Crea il file sovrascrivendo eventuali versioni precedenti
            imwrite(imind, cm, filename, 'gif', 'Loopcount', inf, 'DelayTime', 0.1);
        else
            % Aggiunge i frame successivi
            imwrite(imind, cm, filename, 'gif', 'WriteMode', 'append', 'DelayTime', 0.1);
        end
        % ---------------------------------

        pause(0.1); 
    end

end