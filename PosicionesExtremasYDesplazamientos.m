% SECCIÓN 1: POSICIONES EXTREMAS 
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