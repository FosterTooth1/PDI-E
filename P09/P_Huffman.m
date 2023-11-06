clc
clear all
close all
warning off all

a = imread('peppers.png');

%Mostrando la imagen original
figure(1)
subplot(3, 2, 1)
imshow(a)
title('Imagen Original')

%Mostrando el histograma original
%El histograma representa la distribución de intensidades de píxeles en la imagen
subplot(3, 2, 2)
imhist(a)
title('Histograma Original')

b=rgb2gray(a);
subplot(3, 2, 3)
imshow(b)
title('Imagen a grises')

subplot(3, 2, 4)
imhist(b)
title('Histograma a grises')

arr=imhist(a);

%{
matriz = zeros(256, 2);
for i = 1:256
    matriz(i,1)=i-1;
    matriz(i,2)=arr(i);
end
[n, ~] = size(matriz);
ordenado = false;
while ~ordenado
    ordenado = true;
    for i = 1:n - 1
        if matriz(i, 2) < matriz(i + 1, 2)
            % Intercambiar filas si el elemento actual es menor que el siguiente en la segunda columna
            temp = matriz(i, :);
            matriz(i, :) = matriz(i + 1, :);
            matriz(i + 1, :) = temp;
            ordenado = false;
        end
    end
end
[m,n,l]=size(a);
denominador=m*n*l;
matriz(:,2)=matriz(:,2)/denominador;
matriz
%}

[m,n,l]=size(a);
denominador=m*n*l;

arr_1=sort(arr,"descend");
arr_1=(arr_1)/denominador;

resultado = encontrarDosMasPequenos(arr_1)


function resultado = encontrarDosMasPequenos(arr)
    if length(arr) <= 2
        arr = sort(arr, 'descend');
        resultado = arr;
    else
        % Ordenar el arreglo en orden descendente
        arr = sort(arr, 'descend');
        
        % Obtener los dos valores más pequeños
        valor1 = arr(end);
        valor2 = arr(end - 1);
        
        % Sumar los dos valores
        suma = valor1 + valor2;
        
        % Eliminar los dos valores más pequeños del arreglo
        arr = arr(1:end-2);
        
        % Agregar la suma al inicio del arreglo
        arr = [suma; arr];
        
        % Llamar a la función de manera recursiva
        resultado = encontrarDosMasPequenos(arr);
    end
     
end






