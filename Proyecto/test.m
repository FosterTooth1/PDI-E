clc
close all
warning off all
clear

% Lee la imagen
imagen_original = imread('mar2.jpg');
imagen = imagen_original;

% Obtiene las dimensiones de la imagen
[filas, columnas, ~] = size(imagen);

% Calcula el umbral para el filtro de objetos pequeños
pixeles_binarios = filas * columnas;
pixeles_binarios = pixeles_binarios * 0.05;

% Muestra la imagen original
figure;
imshow(imagen);
title('Imagen Original');

% Aplica la condición y actualiza la imagen
for i = 1:filas
    for j = 1:columnas
        % Aplica la condición RGB para detectar ciertos píxeles
        if imagen(i, j, 1) > 100 && imagen(i, j, 2) > 100 && imagen(i, j, 3) > 200
            % Asigna negro al píxel que cumple la condición
            imagen(i, j, :) = [0, 0, 0];
        else 
            % Asigna blanco a los píxeles que no cumplen la condición
            imagen(i,j,:) = [255, 255, 255];
        end
    end
end

% Muestra la imagen modificada
figure;
imshow(imagen);
title('Imagen Modificada');

disp('Programa finalizado.');

% Convierte la imagen a escala de grises y aplica un filtro de mediana
bw = rgb2gray(imagen);
bw = medfilt2(bw);

% Binariza la imagen
binaryImage = imbinarize(bw);

% Realiza operaciones de dilatación y erosión
dilatada = dilatacion(binaryImage, 3);
resultado = erosion(dilatada, 3);

% Invierte la imagen binaria
resultado = ~resultado;

% Etiqueta y filtra objetos conectados
[L, num] = bwlabel(resultado);

% Obtener propiedades de los objetos
propiedades = regionprops(L, 'Area');

% Filtra objetos basándose en el área
I_filtrada = false(size(resultado));
for k = 1:num
    disp(k + " - " + propiedades(k).Area);
    if propiedades(k).Area >= pixeles_binarios
        I_filtrada = I_filtrada | (L == k);
    end
end

I = I_filtrada;

% Procesamiento y visualización
figure(); imshow(imagen_original); hold on;

for k = 1:num
    objeto = (L == k) & I;
    if any(objeto(:))
        % Obtención de características        
        stats = regionprops(objeto, 'Centroid');
        disp("X: " + stats.Centroid(1) + "     Y: " + stats.Centroid(2));
        
        % Encuentra los puntos más bajos o más altos de cada columna
        boundary = bwboundaries(objeto);
        [minY, minYIdx] = min(boundary{1}(:, 1));
        [maxY, maxYIdx] = max(boundary{1}(:, 1));
        
        %Dibuja el contorno del objeto en rojo
        plot(boundary{1}(:,2), boundary{1}(:,1), 'r', 'LineWidth', 2);
        
        % Dibuja una línea simulando el contorno inferior o superior
        if stats.Centroid(2) > size(imagen_original, 1)*(2) / 3
            % Centroide por encima de la mitad del eje vertical y
            % Muestra los puntos más bajos de cada columna
            plot(boundary{1}(minYIdx, 2), boundary{1}(minYIdx, 1), 'g.', 'MarkerSize', 10);
            plot(boundary{1}(:, 2), minY * ones(size(boundary{1}, 1), 1), 'g', 'LineWidth', 2);
        else
            % Centroide por debajo de la mitad del eje vertical y
            % Muestra los puntos más altos de cada columna
            plot(boundary{1}(maxYIdx, 2), boundary{1}(maxYIdx, 1), 'g.', 'MarkerSize', 10);
            plot(boundary{1}(:, 2), maxY * ones(size(boundary{1}, 1), 1), 'g', 'LineWidth', 2);
        end
    end
end

hold off;

% Función de erosión
function result = erosion(image, tam)
    [m, n] = size(image);
    result = zeros(m, n);

    for i = 1:m
        for j = 1:n
            inicio_fila = max(1, i - tam);
            fin_fila = min(m, i + tam);
            inicio_col = max(1, j - tam);
            fin_col = min(n, j + tam);

            vecindad = image(inicio_fila:fin_fila, inicio_col:fin_col);

            if all(vecindad(:) == 1)
                result(i, j) = image(i, j);
            else
                result(i, j) = 0;
            end
        end
    end
end

% Función de dilatación
function result = dilatacion(image, tam)
    [m, n] = size(image);
    result = zeros(m, n);

    for i = 1:m
        for j = 1:n
            inicio_fila = max(1, i - tam);
            fin_fila = min(m, i + tam);
            inicio_col = max(1, j - tam);
            fin_col = min(n, j + tam);

            vecindad = image(inicio_fila:fin_fila, inicio_col:fin_col);

            if any(vecindad(:) == 1)
                result(i, j) = 1;
            else
                result(i, j) = 0;
            end
        end
    end
end