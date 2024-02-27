% Lee la imagen
imagen = imread('mar.jpg');  % Cambia 'tu_imagen.jpg' al nombre de tu imagen

% Muestra la imagen
figure;
imshow(imagen);
title('Selecciona un punto en la imagen (presiona Ctrl+C para salir)');

while true
    % Permite al usuario seleccionar un punto
    [x, y] = ginput(1);
    x = round(x);
    y = round(y);
    
    % Obtiene los valores RGB del punto seleccionado
    pixel_values = impixel(imagen, x, y);
    
    % Muestra los valores en la consola
    fprintf('Punto seleccionado: (%d, %d)\n', x, y);
    fprintf('Valor en rojo: %d\n', pixel_values(1));
    fprintf('Valor en verde: %d\n', pixel_values(2));
    fprintf('Valor en azul: %d\n', pixel_values(3));
    
    % Pide al usuario si desea seleccionar otro punto o salir
    respuesta = input('¿Quieres seleccionar otro punto? (s/n): ', 's');
    
    % Si la respuesta no es 's', sale del bucle
    if ~strcmpi(respuesta, 's')
        break;
    end
end

disp('Programa finalizado.');