% Lee la imagen
imagen = imread('peppers.png'); % Reemplaza 'nombre_de_tu_imagen.jpg' con la ruta de tu imagen

% Obtiene las dimensiones de la imagen
[filas, columnas, ~] = size(imagen);

% Convierte la imagen a escala de grises si es a color
if size(imagen, 3) == 3
    imagen_gris = rgb2gray(imagen);
else
    imagen_gris = imagen;
end

imagen_gris = medfilt2(imagen_gris);

% Encuentra el índice del píxel más brillante
[brillo_maximo, indice_maximo] = max(imagen_gris(:));

% Calcula las coordenadas (fila, columna) del píxel más brillante
[fila_maxima, columna_maxima] = ind2sub([filas, columnas], indice_maximo);

% Muestra la imagen original
imshow(imagen);

% Muestra un círculo rojo en el píxel más brillante
hold on;
plot(columna_maxima, fila_maxima, 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold off;

% Muestra información sobre el píxel más brillante
fprintf('El píxel más brillante tiene un valor de intensidad de %d en las coordenadas (%d, %d).\n', brillo_maximo, fila_maxima, columna_maxima);

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