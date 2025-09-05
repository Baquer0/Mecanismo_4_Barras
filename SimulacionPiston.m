% Parámetros del mecanismo
a = 5;   % Longitud manivela (cm)
b = 12;  % Longitud biela (cm)
rect_ancho = 1;   % cm
rect_largo = 2;   % cm

% Parámetros de animación
delta_theta = 1;   % Incremento de ángulo (más grande = más rápido)
theta2 = 0;        % Ángulo inicial de la manivela (grados)

% Crear figura para la animación
f = figure;
axis equal;
xlim([-15 15]);
ylim([-5 20]);
hold on;
xlabel('X (cm)');
ylabel('Y (cm)');
title('Mecanismo de 4 barras animado');
grid on;

while ishandle(f) % Se ejecuta mientras la figura exista
    x0 = 0; y0 = 0; % Origen fijo O

    % Posición extremo de manivela (A)
    xA = a * cosd(theta2);
    yA = a * sind(theta2);

    % Posición extremo B sobre eje Y (corredera vertical)
    xB = 0;
    argumento = b^2 - xA^2;
    if argumento < 0
        theta2 = theta2 + delta_theta;
        if theta2 >= 360
            theta2 = theta2 - 360;
        end
        continue
    end
    yB_1 = yA + sqrt(argumento); % Ensamble superior

    yB = yB_1;  % Elige el ensamble superior

    % Rectángulo centrado en B
    rect_x = [xB - rect_ancho/2, xB + rect_ancho/2, xB + rect_ancho/2, xB - rect_ancho/2];
    rect_y = [yB - rect_largo/2, yB - rect_largo/2, yB + rect_largo/2, yB + rect_largo/2];

    % Limpiar y graficar
    cla;
    plot([x0 xA], [y0 yA], 'bo-', 'LineWidth', 2);
    plot([xA xB], [yA yB], 'ro-', 'LineWidth', 2);
    fill(rect_x, rect_y, [0 1 0], 'FaceAlpha', 0.4, 'EdgeColor', 'g', 'LineWidth', 2);
    plot([xA xB], [yA yB], 'ro-', 'LineWidth', 2);
    plot([-15 15], [0 0], 'k--'); % eje X
    plot([0 0], [-5 20], 'k--');  % eje Y
    text(x0, y0-0.7, 'O', 'fontsize', 12, 'HorizontalAlignment', 'center');
    text(xA, yA+0.7, 'A', 'fontsize', 12, 'HorizontalAlignment', 'center');
    text(xB, yB+0.7, 'B', 'fontsize', 12, 'HorizontalAlignment', 'center');
    legend({'Manivela (5 cm)','Biela (12 cm)', 'Rectángulo relleno'},'Location','northwest');
    drawnow limitrate;

    % Incrementar ángulo
    theta2 = theta2 + delta_theta;
    if theta2 >= 360
        theta2 = theta2 - 360;
    end
end