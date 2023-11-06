clear all
close all
warning('off','all')  % Desactivar todos los mensajes de advertencia

a = imread('peppers.png');
a = rgb2gray(a);

figure(1)
subplot(3, 1, 1)
imshow(a)
title('Imagen Original')

b = imnoise(a, 'salt & pepper');
figure(1)
subplot(3, 1, 2)
imshow(b)
title('Imagen con ruido')

opc = 0;
while opc == 0 

    opc = input('Qué tipo de Suavizado quiere en su imagen: 1. Mediana 2. Media 3. Máximos y mínimos: ');

    switch opc
        case 1
            tam = input('¿Qué valor n de n*n desea para calcular la mediana?: ');
            c = medfilt2(b, [tam, tam]);
            subplot(3, 1, 3)
            imshow(c)
            title('Imagen suavizada con mediana')
            break;
        case 2
            tam = input('¿Qué valor n de n*n desea para calcular la media?: ');
            kernel = fspecial('average', [tam, tam]);
            c = imfilter(b, kernel);
            subplot(3, 1, 3)
            imshow(c)
            title('Imagen suavizada con media')
            break;
        case 3
            tam = input('¿Qué valor n de n*n desea para calcular los máximos y mínimos?: ');
            kernel = [tam, tam];
            minimos = imdilate(b, strel('square', tam));
            c = imerode(minimos, strel('square', tam));
            subplot(3, 1, 3)
            imshow(c)
            title('Imagen suavizada con máximos y mínimos')
            break;
        otherwise
            disp('Terminando proceso');
    end

    opc = input('¿Desea probar otro filtro? 0. Si 1. No: ');

end
