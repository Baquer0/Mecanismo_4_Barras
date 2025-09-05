% SECCIÓN 1: POSICIONES EXTREMAS (EXTENDIDA Y TRASLAPANTE)
disp('--- POSICIONES EXTREMAS DEL MECANISMO ---');

a = 5;   % cm (manivela)
b = 12;  % cm (biela)

% Extendida: theta2 = 0°, theta3 = 180°
theta2_ext = 0;
theta3_ext = 180;
d_ext = a*cosd(theta2_ext) - b*cosd(theta3_ext);

fprintf('Máxima:\n');
fprintf('  theta2 = %.0f°, theta3 = %.0f°, d = %.2f cm\n', theta2_ext, theta3_ext, d_ext);

% Traslapante: theta2 = 180°, theta3 = 180°
theta2_tras = 180;
theta3_tras = 180;
d_tras = a*cosd(theta2_tras) - b*cosd(theta3_tras);

fprintf('Mínima:\n');
fprintf('  theta2 = %.0f°, theta3 = %.0f°, d = %.2f cm\n\n', theta2_tras, theta3_tras, d_tras);

% SECCIÓN 2: CASO GENERAL PARA theta2 = 305°
disp('--- Cuando θ2 = 305° ---');

theta2 = 305; % grados
c = 0; % Según tus imágenes, c=0 (corredera sobre eje Y)

% Cálculo de seno para θ3 según ecuación (2.13)
seno_theta3 = (a * sind(theta2) - c) / b;

% Dos posibles soluciones para θ3
theta3_1 = asind( seno_theta3 ); % Primer ensamble
theta3_2 = asind(-seno_theta3 ) + 180; % Segundo ensamble

% Ajuste para reportar θ3 entre 0 y 360°
theta3_1_mod = mod(theta3_1, 360);
theta3_2_mod = mod(theta3_2, 360);

fprintf('Configuración 1:\n');
fprintf('  theta3_1 = %.2f° / %.2f°\n', theta3_1, theta3_1_mod);

fprintf('Configuración 2:\n');
fprintf('  theta3_2 = %.2f°\n', theta3_2_mod);

% Desplazamientos correspondientes
d_1 = a*cosd(theta2) - b*cosd(theta3_1_mod);
d_2 = a*cosd(theta2) - b*cosd(theta3_2_mod);

fprintf('\nDesplazamientos para d:\n');
fprintf('  Para θ3_1 = %.2f°: d = %.2f cm\n', theta3_1_mod, d_1);
fprintf('  Para θ3_2 = %.2f°: d = %.2f cm\n\n', theta3_2_mod, d_2);
%% Gráfica de la primera configuración para θ2 = 305°

% Parámetros
a = 5;   % cm (manivela)
b = 12;  % cm (biela)
theta2_user = 305; % ángulo desde eje Y positivo
theta3 = 340.04;   % ángulo de la biela respecto a Y (primera configuración)

% Conversión ángulo MATLAB
theta2 = 450 - theta2_user;
if theta2 >= 360
    theta2 = theta2 - 360;
end

% Cálculo punto A
xA = a * cosd(theta2);
yA = a * sind(theta2);

% Primera configuración (biela abajo)
yB = yA - sqrt(b^2 - xA^2);
d = yB;

% Reflejar respecto al eje Y
xA_ref = -xA;
xB_ref = 0;
xO_ref = 0;

% Rectángulo en B
rect_ancho = 1;
rect_largo = 2;
rect_x = [xB_ref - rect_ancho/2, xB_ref + rect_ancho/2, xB_ref + rect_ancho/2, xB_ref - rect_ancho/2];
rect_y = [yB - rect_largo/2, yB - rect_largo/2, yB + rect_largo/2, yB + rect_largo/2];

% Graficar
figure; hold on; axis equal;
xlabel('X (cm)'); ylabel('Y (cm)');
title('Primera configuración reflejada con etiquetas de distancia y valores de ángulo');
set(gca, 'FontSize', 12);
grid on;

% Puntos
plot(xO_ref, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'w');
plot(xA_ref, yA, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'w');
text(xO_ref + 0.5, 0, 'O', 'FontSize',12, 'HorizontalAlignment','center');
text(xA_ref - 0.5, yA, 'A', 'FontSize',12, 'HorizontalAlignment','center');
plot(xB_ref, yB, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'w');
text(xB_ref - 0.5, yB, 'B', 'FontSize', 12, 'Color', 'r');

% Manivela y biela reflejados
plot([xO_ref xA_ref], [0 yA], 'b-', 'LineWidth', 2);
plot([xA_ref xB_ref], [yA yB], 'r-', 'LineWidth', 2);

% Rectángulo relleno en B
fill(rect_x, rect_y, [0 1 0], 'FaceAlpha', 0.4, 'EdgeColor', 'g', 'LineWidth', 2);

% Corredera (eje Y)
plot([0 0], ylim, 'k--');

% --- Distancia desde O hasta B ---
plot([xO_ref xB_ref], [0 yB], 'g', 'LineWidth', 2);
mid_d = yB/2;
text(-1.3, mid_d, ['d = ', num2str(d, '%.2f'), ' cm'], 'FontSize', 12, ...
    'Color', 'g','BackgroundColor','w','EdgeColor','r','Margin',2,'HorizontalAlignment','right');

% --- Etiqueta ángulo θ3 ---
text(xB_ref - 2, yB - 1.5, ['\theta_3 = ', num2str(theta3, '%.2f'), '°'], 'Color', 'r', 'FontSize', 12, ...
    'BackgroundColor', 'w', 'HorizontalAlignment', 'center');

% --- Etiqueta ángulo θ2 ---
text(xA_ref/2 - 0.5, yA/2 + 0.5, ['\theta_2 = ', num2str(theta2_user), '°'], 'Color', 'b', 'FontSize', 12, ...
    'BackgroundColor', 'w', 'HorizontalAlignment', 'center');

legend({'O', 'A', 'B', 'Manivela (5 cm)', 'Biela (12 cm)', ...
    'Rectángulo en B', 'Corredera eje Y', 'Distancia d'}, 'Location', 'southwest');


%% Gráfica de la segunda configuración para θ2 = 305°
% Parámetros
a = 5;   % cm (manivela)
b = 12;  % cm (biela)
theta2_user = 305; % ángulo desde eje Y positivo
theta3 = 199.96;   % ángulo de la biela respecto a Y

% Conversión ángulo MATLAB
theta2 = 450 - theta2_user;
if theta2 >= 360
    theta2 = theta2 - 360;
end

% Cálculo punto A
xA = a * cosd(theta2);
yA = a * sind(theta2);

% Segunda configuración (biela arriba)
yB = yA + sqrt(b^2 - xA^2);
xB = 0;
d = yB;

% Reflejar respecto al eje Y
xA_ref = -xA;
xB_ref = 0;
xO_ref = 0;

% Rectángulo en B
rect_ancho = 1;
rect_largo = 2;
rect_x = [xB_ref - rect_ancho/2, xB_ref + rect_ancho/2, xB_ref + rect_ancho/2, xB_ref - rect_ancho/2];
rect_y = [yB - rect_largo/2, yB - rect_largo/2, yB + rect_largo/2, yB + rect_largo/2];

% Configuración gráfica
figure; hold on; axis equal;
xlabel('X (cm)'); ylabel('Y (cm)');
title('Segunda configuración reflejada con etiquetas de distancia y valores de ángulo');
set(gca, 'FontSize', 12);
grid on;

% Puntos
plot(xO_ref, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'w');
plot(xA_ref, yA, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'w');
text(xO_ref + 0.5, 0, 'O', 'FontSize',12, 'HorizontalAlignment','center');
text(xA_ref - 0.5, yA, 'A', 'FontSize',12, 'HorizontalAlignment','center');
plot(xB_ref, yB, 'mo', 'MarkerSize', 8, 'MarkerFaceColor', 'w');
text(xB_ref - 0.5, yB, 'B', 'FontSize', 12, 'Color', 'm');

% Manivela y biela reflejados
plot([xO_ref xA_ref], [0 yA], 'b-', 'LineWidth', 2);
plot([xA_ref xB_ref], [yA yB], 'm-', 'LineWidth', 2);

% Rectángulo relleno en B
fill(rect_x, rect_y, [0 1 0], 'FaceAlpha', 0.4, 'EdgeColor', 'g', 'LineWidth', 2);

% Corredera (eje Y)
plot([0 0], ylim, 'k--');

% --- Distancia desde O hasta B ---
plot([xO_ref xB_ref], [0 yB], 'g', 'LineWidth', 2);
mid_d = yB/2;
text(-1.3, mid_d, ['d = ', num2str(d, '%.2f'), ' cm'], 'FontSize', 12, ...
    'Color', 'g','BackgroundColor','w','EdgeColor','r','Margin',2,'HorizontalAlignment','right');

% --- Etiqueta ángulo θ2 ---
text(xA_ref/2 - 0.5, yA/2 + 0.5, ['\theta_2 = ', num2str(theta2_user), '°'], 'Color', 'b', 'FontSize', 12, ...
    'BackgroundColor', 'w', 'HorizontalAlignment', 'center');

% --- Etiqueta ángulo θ3 ---
text(xB_ref + 1, yB - 1, ['\theta_3 = ', num2str(theta3, '%.2f'), '°'], 'Color', 'm', 'FontSize', 12, ...
    'BackgroundColor', 'w', 'HorizontalAlignment', 'center');

legend({'O', 'A', 'B', 'Manivela (5 cm)', 'Biela (12 cm)', ...
    'Rectángulo en B', 'Corredera eje Y', 'Distancia d'}, 'Location', 'southwest');
