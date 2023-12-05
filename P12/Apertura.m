% Carga la imagen
imagen = imread('peppers.png'); % Reemplaza 'tu_imagen.jpg' con la ruta de tu imagen

% Muestra la imagen original
figure;
subplot(1, 3, 1);
imshow(imagen);
title('Imagen Original');

% Pregunta al usuario si quiere realizar apertura o cierre
opcion = input('¿Deseas realizar apertura (1) o cierre (2)? ');

% Realiza la apertura o cierre según la opción seleccionada
if opcion == 1 % Apertura
    % Erosión seguida de dilatación
    imagen_procesada = dilatacion(erosion(imagen));
    titulo = 'Imagen después de apertura';
elseif opcion == 2 % Cierre
    % Dilatación seguida de erosión
    imagen_procesada = erosion(dilatacion(imagen));
    titulo = 'Imagen después de cierre';
else
    disp('Opción no válida');
    return;
end

% Muestra la imagen después del proceso
subplot(1, 3, 3);
imshow(imagen_procesada);
title(titulo);

% Función de dilatación
function dilatada = dilatacion(imagen)
        [filas, columnas] = size(imagen);
    dilatada = false(filas, columnas);

    % Define el kernel de dilatación (3x3 en este caso)
    kernel = ones(3);

    % Aplica la dilatación
    for i = 2:filas-1
        for j = 2:columnas-1
            if any(any(imagen(i-1:i+1, j-1:j+1) & kernel))
                dilatada(i, j) = true;
            end
        end
    end
end

% Función de erosión
    function erosionada = erosion(imagen)
    [filas, columnas] = size(imagen);
    erosionada = true(filas, columnas);

    % Define el kernel de erosión (3x3 en este caso)
    kernel = ones(3);

    % Aplica la erosión
    for i = 2:filas-1
        for j = 2:columnas-1
            if all(all(imagen(i-1:i+1, j-1:j+1) & kernel))
                erosionada(i, j) = true;
            else
                erosionada(i, j) = false;
            end
        end
    end
end
