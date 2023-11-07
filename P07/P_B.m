clear all
close all
warning('off','all')  % Desactivar todos los mensajes de advertencia

a = imread('peppers.png');
a = rgb2gray(a);

figure(1)
subplot(4, 1, 1)
imshow(a)
title('Imagen Original')

b = imnoise(a, 'salt & pepper', 0.04);
figure(1)
subplot(4, 1, 2)
imshow(b)
title('Imagen con ruido')

opc = 0;
while opc == 0 

    opc = input('Qué tipo de Suavizado quiere en su imagen: 1. Mediana 2. Media 3. Máximos y mínimos: ');

    switch opc
        case 1
            tam = input('¿Qué valor n de n*n desea para calcular la mediana?: ');
            c = medfilt2(b, [tam, tam]);
            subplot(4, 1, 3)
            imshow(c)
            title('Imagen suavizada con mediana')
            break;
        case 2
            tam = input('¿Qué valor n de n*n desea para calcular la moda?: ');
[m, n] = size(b);
filtro = zeros(m, n);
c=b;

for i = 1:m
    for j = 1:n  
        inicio_fila = i - tam;
        fin_fila = i + tam;
        inicio_col = j - tam;
        fin_col = j + tam;
        if inicio_fila <= 0
            inicio_fila = 1; 
        end
        if fin_fila > m
            fin_fila = m;
        end
        if inicio_col <= 0
            inicio_col = 1; 
        end
        if fin_col > n
            fin_col = n;
        end
        
        vecindad = b(inicio_fila:fin_fila, inicio_col:fin_col);
       
        d = mode(vecindad(:));  
        c(i, j) = d;
    end
end
subplot(4, 1, 3)
imshow(c)
title('Imagen suavizada con moda')

            break;
        case 3
            tam = input('¿Qué valor n de n*n desea para calcular los maximos y minimos?: ');
[m, n] = size(b);
filtro = zeros(m, n);
c=b;

for i = 1:m
    for j = 1:n  
    if c(i,j)==0
    c(i,j)=255;
    end;
    end;
end;
subplot(4, 1, 3)
imshow(c)
title('Imagen suavizada con maximos')

u=b;
for i = 1:m
    for j = 1:n  
    if u(i,j)==255
    u(i,j)=0;
    end;
    end;
end;
subplot(4, 1, 4)
imshow(u)
title('Imagen suavizada con minimos')
        otherwise
            disp('Terminando proceso');
    end

    opc = input('¿Desea probar otro filtro? 0. Si 1. No: ');

end