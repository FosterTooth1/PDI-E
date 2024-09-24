%%PRACTICA 3
%%El programa selecciona representantes de un area definida
clc
clear all
close all
warning off all

% Lectura de la imagen "mar.jpg" y obtención de las dimensiones de la imagen
a = imread("mar.jpg");
[m, n, ~] = size(a);    % Obtiene las dimensiones de la imagen en 'm' (alto) y 'n' (ancho)

% Solicitar al usuario el número de puntos deseados en cada clase
cielo = input('Ingrese el número de puntos que desea en el cielo: ');
mar = input('Ingrese el número de puntos que desea en el mar: ');
arena = input('Ingrese el número de puntos que desea en la arena: ');

% Crear una nueva figura y mostrar la imagen en ella
figure;
imshow(a);

% Generar coordenadas aleatorias para puntos en las clases: cielo, mar y arena
c1x = randi([10, n - 10], 1, cielo);  % Genera 'cielo' coordenadas x aleatorias entre 10 y 'n-10'
c1y = randi([10, round(m / 6)], 1, cielo);  % Genera 'cielo' coordenadas y aleatorias entre 10 y 'm/3'

c2x = randi([10, n - 10], 1, mar);  % Genera 'mar' coordenadas x aleatorias entre 10 y 'n-10'
c2y = randi([round(m / 6) + 1, round(2 * m / 3)], 1, mar);  % Genera 'mar' coordenadas y aleatorias entre m/3+1 y 2*m/3

c3x = randi([10, n - 10], 1, arena);  % Genera 'arena' coordenadas x aleatorias entre 10 y 'n-10'
c3y = randi([round(2 * m / 3) + 1, m - 10], 1, arena);  % Genera 'arena' coordenadas y aleatorias entre 2*m/3+1 y 'm-10'

% Asignar valores RGB a los puntos y dibujarlos en la figura
hold on;  % Permite superponer gráficos en la figura actual
grid on;  % Activa la cuadrícula en la figura
z1 = impixel(a, c1x, c1y);  % Obtiene los valores RGB de la imagen 'a' en las coordenadas (c1x, c1y)
plot(c1x, c1y, 'ob', 'Markersize', 5, 'MarkerFaceColor', 'b');  % Dibuja puntos azules en la posición de (c1x, c1y)

z2 = impixel(a, c2x, c2y);  % Obtiene los valores RGB de la imagen 'a' en las coordenadas (c2x, c2y)
plot(c2x, c2y, 'or', 'Markersize', 5, 'MarkerFaceColor', 'r');  % Dibuja puntos rojos en la posición de (c2x, c2y)

z3 = impixel(a, c3x, c3y);  % Obtiene los valores RGB de la imagen 'a' en las coordenadas (c3x, c3y)
plot(c3x, c3y, 'og', 'Markersize', 5, 'MarkerFaceColor', 'g');  % Dibuja puntos verdes en la posición de (c3x, c3y)

% Calcular el valor promedio (color) de cada clase
total_cielo = mean(z1);  % Calcula el valor promedio de color en 'z1' y lo almacena en 'total_cielo'
total_mar = mean(z2);    % Calcula el valor promedio de color en 'z2' y lo almacena en 'total_mar'
total_arena = mean(z3);  % Calcula el valor promedio de color en 'z3' y lo almacena en 'total_arena'

% Bucle para que el usuario seleccione un punto desconocido y clasificarlo
usuario = 0;  % Inicializa la variable 'usuario' en 0 para entrar en el bucle
while usuario == 0  % Mientras 'usuario' sea 0, continuará el bucle
    clear desconocido;  % Borra datos previos del punto desconocido
    figure(2);  % Cambia a la figura 2
    desconocido = impixel(a);  % El usuario selecciona un punto en la imagen
    
    figure(3);  % Cambia a la figura 3
    % Mostrar los puntos de referencia y el punto desconocido en un espacio 3D
    plot3(total_mar(1), total_mar(2), total_mar(3), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'r')  % Dibuja un punto negro en 'total_mar'
    grid on;  % Activa la cuadrícula en la figura 3
    hold on;  % Permite superponer gráficos en la figura 3
    plot3(total_arena(1), total_arena(2), total_arena(3), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'g')  % Dibuja un punto negro en 'total_arena'
    plot3(total_cielo(1), total_cielo(2), total_cielo(3), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'b')  % Dibuja un punto negro en 'total_cielo'
    plot3(desconocido(1), desconocido(2), desconocido(3), 'ko', 'MarkerSize', 10, 'MarkerFaceColor', 'k')  % Dibuja un punto negro en 'desconocido'
    
    % Mostrar los puntos de referencia de cada clase
    plot3(z3(:,1), z3(:,2), z3(:,3), 'go', 'MarkerSize', 5, 'MarkerFaceColor', 'g')  % Dibuja puntos verdes para 'z3'
    plot3(z2(:,1), z2(:,2), z2(:,3), 'ro', 'MarkerSize', 5, 'MarkerFaceColor', 'r')  % Dibuja puntos rojos para 'z2'
    plot3(z1(:,1), z1(:,2), z1(:,3), 'bo', 'MarkerSize', 5, 'MarkerFaceColor', 'b')  % Dibuja puntos azules para 'z1'
    
    % Mostrar una leyenda para las clases
    legend('Mar', 'Arena', 'Cielo', 'Desconocido')
    
    % Calcular distancias entre el punto desconocido y los puntos de referencia
    distancia_mar = norm(total_mar - desconocido);  % Calcula la distancia entre 'total_mar' y 'desconocido'
    distancia_cielo = norm(total_cielo - desconocido);  % Calcula la distancia entre 'total_cielo' y 'desconocido'
    distancia_arena = norm(total_arena - desconocido);  % Calcula la distancia entre 'total_arena' y 'desconocido'
    
    % Almacenar distancias en un arreglo y encontrar la clase más cercana
    arreglo_distancias = [distancia_cielo, distancia_mar, distancia_arena];  % Almacena las distancias en un arreglo
    [min_distancia, indice] = min(arreglo_distancias);  % Encuentra el índice de la distancia mínima
    
    % Mostrar la clasificación del punto desconocido
    if indice == 2  % Si el índice es 2, significa que el punto está más cerca del mar
        disp('El punto coincide con mar')
    elseif indice == 1  % Si el índice es 1, significa que el punto está más cerca del cielo
        disp('El punto coincide con cielo')
    else  % De lo contrario, el punto está más cerca de la arena
        disp('El punto coincide con la arena')
    end
    
    % Solicitar al usuario si desea verificar otro punto desconocido o salir
    usuario = input('Introduzca 0 si quiere verificar otro pixel o 1 si quiere salir: ');  % Pregunta al usuario si quiere continuar o salir
end

% Mostrar un mensaje de despedida
disp('Fin del programa, gracias por usarlo')  % Muestra un mensaje de despedida en la ventana de comandos