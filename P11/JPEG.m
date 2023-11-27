clc; % Limpia la ventana de comandos
clear all; % Limpia todas las variables del espacio de trabajo

% Lee una imagen y la almacena en la variable 'I'
I = imread('cameraman.tif');

I1 = I; % Crea una copia de la imagen original y la guarda en 'I1'
[row, coln] = size(I); % Obtiene las dimensiones de la imagen

I = double(I); % Convierte la imagen a tipo de datos 'double'

% Resta 128 a cada píxel de la imagen
I = I - (128 * ones(size(I)));

% Solicita al usuario la calidad de compresión deseada
quality = input('¿Qué calidad de compresión requiere? - ');

% Matriz de calidad predefinida para la compresión JPEG
Q50 = [16 11 10 16 24 40 51 61;
       12 12 14 19 26 58 60 55;
       14 13 16 24 40 57 69 56;
       14 17 22 29 51 87 80 62;
       18 22 37 56 68 109 103 77;
       24 35 55 64 81 104 113 92;
       49 64 78 87 103 121 120 101;
       72 92 95 98 112 100 103 99];

% Ajusta la matriz de calidad según la calidad ingresada por el usuario
if quality > 50
    QX = round(Q50 .* (ones(8) * ((100 - quality) / 50)));
    QX = uint8(QX);
elseif quality < 50
    QX = round(Q50 .* (ones(8) * (50 / quality)));
    QX = uint8(QX);
elseif quality == 50
    QX = Q50;
end

% Calcula la transformada discreta del coseno (DCT) y su inversa
DCT_matrix8 = dct(eye(8));
iDCT_matrix8 = DCT_matrix8';

% Inicializa matrices para el proceso de compresión JPEG
dct_domain = zeros(row, coln);
dct_quantized = zeros(row, coln);
dct_dequantized = zeros(row, coln);
dct_restored = zeros(row, coln);

% Transformada de coseno directa (DCT)
for i1 = 1:8:row
    for i2 = 1:8:coln
        zBLOCK = I(i1:i1+7, i2:i2+7);
        win1 = DCT_matrix8 * zBLOCK * iDCT_matrix8;
        dct_domain(i1:i1+7, i2:i2+7) = win1;
    end
end

% Cuantización de los coeficientes DCT
for i1 = 1:8:row
    for i2 = 1:8:coln
        win1 = dct_domain(i1:i1+7, i2:i2+7);
        win2 = round(win1 ./ QX);
        dct_quantized(i1:i1+7, i2:i2+7) = win2;
    end
end

% Descompresión JPEG (Decuantización de coeficientes DCT)
for i1 = 1:8:row
    for i2 = 1:8:coln
        win2 = dct_quantized(i1:i1+7, i2:i2+7);
        win3 = win2 .* QX;
        dct_dequantized(i1:i1+7, i2:i2+7) = win3;
    end
end

% Transformada de coseno inversa (IDCT)
for i1 = 1:8:row
    for i2 = 1:8:coln
        win3 = dct_dequantized(i1:i1+7, i2:i2+7);
        win4 = iDCT_matrix8 * win3 * DCT_matrix8;
        dct_restored(i1:i1+7, i2:i2+7) = win4;
    end
end

% Restaura la imagen original a partir de los coeficientes DCT
I2 = dct_restored;

% Convierte la matriz de la imagen a una imagen de intensidad
K = mat2gray(I2);

% Muestra las imágenes original y restaurada obtenidas a partir de la transformada de coseno discreta (DCT)
figure(1); imshow(I1); title('Imagen original');
figure(2); imshow(K); title('Imagen restaurada a partir de DCT');

