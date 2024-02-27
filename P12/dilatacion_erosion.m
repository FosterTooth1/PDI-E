image = imread('rorscharh.jpg');
binaryImage = imbinarize(rgb2gray(image));

opcion = input('Selecciona ''d'' para dilatacion o ''e'' para erosion: ', 's');
if opcion == 'd'
    resultado = operacionmorf(binaryImage, 'dilatacion');
    operacion = 'dilatacion';
elseif opcion == 'e'
    resultado = operacionmorf(binaryImage, 'erosion');
    operacion = 'erosion';
else
    disp('Opción no válida. Por favor, elige ''d'' o ''e''.');
    return;
end

figure;
subplot(1, 2, 1);
imshow(binaryImage);
title('Imagen Original');

subplot(1, 2, 2);
imshow(resultado);
title(['Imagen después de ', operacion]);

[m, n] = size(image);
result = zeros(m, n); % Inicializar la matriz de resultado

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

