clc
close all
warning off all


%Compresion JPEG
%Leer imagen
a = imread('cameraman.tif'); 

% Convertir la imagen a escala de grises si es a color
if size(a, 3) == 3
    a = rgb2gray(a);
end

% Tabla de codificacion de Huffman
tabla = {
    [0,0,'101'];
    [0,1,'00'];
    [0,2,'01'];
    [0,3,'100'];
    [0,4,'1011'];
    [0,5,'11010'];
    [0,6,'111000'];
    [0,7,'1111000'];
    [0,8,'1111110110'];
    [0,9,'1111111110000010'];
    [0,10,'1111111110000011'];
    [1,1,'1100'];
    [1,2,'111001'];
    [1,3,'1111001'];
    [1,4,'111110110'];
    [1,5,'11111110110'];
    [1,6,'1111111110000100'];
    [1,7,'1111111110000101'];
    [1,8,'1111111110000110'];
    [1,9,'1111111110000111'];
    [1,10,'1111111110001000'];
    [2,1,'11011'];
    [2,2,'11111000'];
    [2,3,'1111110111'];
    [2,4,'111111110001001'];
    [2,5,'111111110001010'];
    [2,6,'111111110001011'];
    [2,7,'111111110001100'];
    [2,8,'111111110001101'];
    [2,9,'111111110001110'];
    [2,10,'111111110001111'];
    [3,1,'111010'];
    [3,2,'111110111'];
    [3,3,'11111110111'];
    [3,4,'1111111110010000'];
    [3,5,'1111111110010001'];
    [3,6,'1111111110010010'];
    [3,7,'1111111110010011'];
    [3,8,'1111111110010100'];
    [3,9,'1111111110010101'];
    [3,10,'1111111110010110'];
    [4,1,'111011'];
    [4,2,'1111111000'];
    [4,3,'1111111110010111'];
    [4,4,'1111111110011000'];
    [4,5,'1111111110011001'];
    [4,6,'1111111110011010'];
    [4,7,'1111111110011011'];
    [4,8,'1111111110011100'];
    [4,9,'1111111110011101'];
    [4,10,'1111111110011110'];
    [5,1,'1111010'];
    [5,2,'1111111001'];
    [5,3,'1111111110011111'];
    [5,4,'1111111110100000'];
    [5,5,'1111111110100001'];
    [5,6,'1111111110100010'];
    [5,7,'1111111110100011'];
    [5,8,'1111111110100100'];
    [5,9,'1111111110100101'];
    [5,10,'1111111110100110'];
    [6,1,'1111011'];
    [6,2,'11111111000'];
    [6,3,'1111111110100111'];
    [6,4,'1111111110101000'];
    [6,5,'1111111110101001'];
    [6,6,'1111111110101010'];
    [6,7,'1111111110101011'];
    [6,8,'1111111110101100'];
    [6,9,'1111111110101101'];
    [6,10,'1111111110101110'];
    [7,1,'11111001'];
    [7,2,'11111111001'];
    [7,3,'1111111110101111'];
    [7,4,'1111111110110000'];
    [7,5,'1111111110110001'];
    [7,6,'1111111110110010'];
    [7,7,'1111111110110011'];
    [7,8,'1111111110110100'];
    [7,9,'1111111110110101'];
    [7,10,'1111111110110110'];
    [8,1,'11111010'];
    [8,2,'111111111000000'];
    [8,3,'1111111110110111'];
    [8,4,'1111111110111000'];
    [8,5,'1111111110111001'];
    [8,6,'1111111110111010'];
    [8,7,'1111111110111011'];
    [8,8,'1111111110111100'];
    [8,9,'1111111110111101'];
    [8,10,'1111111110111110'];
    [9,1,'111111000'];
    [9,2,'1111111110111111'];
    [9,3,'1111111111000000'];
    [9,4,'1111111111000001'];
    [9,5,'1111111111000010'];
    [9,6,'1111111111000011'];
    [9,7,'1111111111000100'];
    [9,8,'1111111111000101'];
    [9,9,'1111111111000110'];
    [9,10,'1111111111000111'];
    [10,1,'111111001'];
    [10,2,'1111111111001000'];
    [10,3,'1111111111001001'];
    [10,4,'1111111111001010'];
    [10,5,'1111111111001011'];
    [10,6,'1111111111001100'];
    [10,7,'1111111111001101'];
    [10,8,'1111111111001110'];
    [10,9,'1111111111001111'];
    [10,10,'1111111111010000'];
    [11,1,'111111010'];
    [11,2,'1111111111010001'];
    [11,3,'1111111111010010'];
    [11,4,'1111111111010011'];
    [11,5,'1111111111010100'];
    [11,6,'1111111111010101'];
    [11,7,'1111111111010110'];
    [11,8,'1111111111010111'];
    [11,9,'1111111111011000'];
    [11,10,'1111111111011001'];
    [12,1,'1111111010'];
    [12,2,'1111111111011010'];
    [12,3,'1111111111011011'];
    [12,4,'1111111111011100'];
    [12,5,'1111111111011101'];
    [12,6,'1111111111011110'];
    [12,7,'1111111111011111'];
    [12,8,'1111111111100000'];
    [12,9,'1111111111100001'];
    [12,10,'1111111111100010'];
    [13,1,'11111111010'];
    [13,2,'1111111111100011'];
    [13,3,'1111111111100100'];
    [13,4,'1111111111100101'];
    [13,5,'1111111111100110'];
    [13,6,'1111111111100111'];
    [13,7,'1111111111101000'];
    [13,8,'1111111111101001'];
    [13,9,'1111111111101010'];
    [13,10,'1111111111101011'];
    [14,1,'111111110110'];
    [14,2,'1111111111101100'];
    [14,3,'1111111111101101'];
    [14,4,'11111111111011101'];
    [14,5,'1111111111101111'];
    [14,6,'1111111111110000'];
    [14,7,'1111111111110001'];
    [14,8,'1111111111110010'];
    [14,9,'1111111111110011'];
    [14,10,'1111111111110100'];
    [15,0,'111111110111'];
    [15,1,'1111111111110101'];
    [15,2,'1111111111110110'];
    [15,3,'1111111111110111'];
    [15,4,'1111111111111000'];
    [15,5,'1111111111111001'];
    [15,6,'1111111111111010'];
    [15,7,'1111111111111011'];
    [15,8,'1111111111111100'];
    [15,9,'1111111111111101'];
    [15,10,'1111111111111110'];
    };

% Matriz de division

standard_luminance_quantization_table = [
    16, 11, 10, 16, 24, 40, 51, 61;
    12, 12, 14, 19, 26, 58, 60, 55;
    14, 13, 16, 24, 40, 57, 69, 56;
    14, 17, 22, 29, 51, 87, 80, 62;
    18, 22, 37, 56, 68, 109, 103, 77;
    24, 35, 55, 64, 81, 104, 113, 92;
    49, 64, 78, 87, 103, 121, 120, 101;
    72, 92, 95, 98, 112, 100, 103, 99
];

% Tamaño del bloque (8x8)
block_size = 8;

% Obtener dimensiones de la imagen
[filas, columnas] = size(a);

% Obtener el número de bloques en filas y columnas
nbloquesFilas = floor(filas / block_size); % floor sirve para truncar los decimales 
nbloquesColum = floor(columnas / block_size);



%Seleccionar una sección de la DCT
fila = input('Ingrese la fila de la sección 8x8: ');
columna = input('Ingrese la columna de la sección 8x8: ');


% Obtener el bloque seleccionado de la imagen
selected_block = double(a((fila-1)*block_size + 1 : fila*block_size, (columna-1)*block_size + 1 : columna*block_size));
%(fila-1) * block_size +1: fila*block_size = Esta parte calcula los indices
%de la fila que se utilizaran para seleccionar el bloque. 
disp('Seccion seleccionada-->')
disp(selected_block);
% Restar 128 al bloque seleccionado
selected_block = selected_block - 128;
disp('Seccion seleccionada (-128)-->');
disp(selected_block);
% Aplicar DCT al bloque restado 128
dct_block = dct2(selected_block); %dtc2 funcion para aplicar la transformada discreta del coseno
disp('Seccion aplicado al DCT -->');
disp(round(dct_block));
% Dividir el bloque DCT por standard_luminance_quantization_table
DCT_luminance = round(dct_block) / standard_luminance_quantization_table;
disp('Seccion dividida por la matriz de luminosidad estándar --> ')
disp(round(DCT_luminance));

% Definir la matriz A
A = round(DCT_luminance);  % A == vector
vector = round(DCT_luminance);
% Reemplazar los valores de acuerdo con los rangos de la tabla dada
for i = 1:numel(A) %numel devuelve el numero total de elementos de una matriz
    valor = A(i);
    % Verificar en qué rango se encuentra el valor y asignar la categoría correspondiente
    if valor == 0 
        A(i) = 0; % Asignar la categoría correspondiente
    elseif valor >= -1 && valor <= 1
        A(i) = 1;
    elseif valor >= -3 && valor <= 3
        A(i) = 2;
    elseif valor >= -7 && valor <= 7
        A(i) = 3;
    elseif valor >= -15 && valor <= 15
        A(i) = 4;
    elseif valor >= -31 && valor <= 31
        A(i) = 5;
    elseif valor >= -63 && valor <= 63
        A(i) = 6;
    elseif valor >= -127 && valor <= 127
        A(i) = 7;
    elseif valor >= -255 && valor <= 255
        A(i) = 8;
    elseif valor >= -511 && valor <= 511
        A(i) = 9;
    elseif valor >= -1023 && valor <= 1023
        A(i) = 10;
    elseif valor >= -2047 && valor <= 2047
        A(i) = 11;
    elseif valor >= -4095 && valor <= 4095
        A(i) = 12;
    elseif valor >= -8191 && valor <= 8191
        A(i) = 13;
    elseif valor >= -16383 && valor <= 16383
        A(i) = 14;
    elseif valor >= -32767 && valor <= 32767
        A(i) = 15;
    else
        % Asignar un valor predeterminado o manejar los casos fuera de los rangos definidos
        A(i) = NaN;%NaN representa el resultado de operaciones matemáticas indefinidas
    end
end

disp('Matriz de intervalos a los que pertenecen -->');
disp(A);
% Se comienza la codificacion
valor = A(1:1);

% Crear una serie de condicionales para asignar los códigos según los valores
if valor == 0
    resultado = '01000';
elseif valor == 1
    resultado = '01111';
elseif valor == 2
    resultado = '1001010';
elseif valor == 3
    resultado = '001111';
elseif valor == 4
    resultado = '101100100';
elseif valor == 5
    resultado = '110101101';
elseif valor == 6
    resultado = '1110110110';
elseif valor == 7
    resultado = '11110111111';
elseif valor == 8
    resultado = '11111010001000';
elseif valor == 9
    resultado = '111111010011001';
elseif valor == 10 
    resultado = '1111111010101010';
elseif valor == 11
    resultado = '11111111010111011';
else
    resultado = 'Valor no encontrado'; % Para manejar casos no especificados
end

matriz = A; 

% Inicialización de variables
[m, n] = size(matriz);
%disp (size(matriz));
resultados = zeros(1, m*n); 
orden = zeros(1,m*n);
row = 1;
col = 1;
index = 1;
goingUp = true;

% Recorrido en zigzag
while row <= m && col <= n
    % Guardar el elemento actual en el vector de resultados
    resultados(index) = matriz(row, col);
    orden(index) = vector(row,col);
    index = index + 1;

    % Si va hacia arriba
    if goingUp
        if col == n
            row = row + 1;
            goingUp = false;
        elseif row == 1
            col = col + 1;
            goingUp = false;
        else
            row = row - 1;
            col = col + 1;
        end
    % Si va hacia abajo
    else
        if row == m
            col = col + 1;
            goingUp = true;
        elseif col == 1
            row = row + 1;
            goingUp = true;
        else
            row = row + 1;
            col = col - 1;
        end
    end
end

% Obtener la representación binaria correspondiente para cada valor en 'resultados'
vect = cell(1, length(resultados));  % Inicializar un cell array del mismo tamaño que 'resultados'
i = 1;  % Inicializar el contador i
k = 1;
while i <= length(resultados)
    valor_actual = resultados(i);  % Obtener el valor actual de 'resultados'
    j = 1;  % Inicializar la variable de iteración j

    % Buscar el valor en la tabla y reemplazarlo con su representación binaria
    while j <= size(tabla, 1)
        if k == tabla{j}(1) % Comparar con el valor en el primer elemento de la fila
            % Verificar si el segundo elemento de la fila coincide con el valor actual
            if (i+1 <= length(resultados)) && (resultados(i) == tabla{j}(2))  % Asegurar que i+1 no exceda el tamaño del vector resultados
                % Asignar la representación binaria al cell array 'vect'
                vect{i} = regexprep(tabla{j}, '[^01]', '');%regexprep se utiliza para realizar sustituciones de patrones mediante expresiones regulares en una cadena de texto
                break; % Salir del bucle mientras se haya encontrado una coincidencia
            end
        end
        j = j + 1; % Incrementar j para buscar en la siguiente fila de la tabla
    end
    
    i = i + 1; % Incrementar i para pasar al siguiente elemento de 'resultados'
    if valor_actual ~= 0
        k = k + 1;
    else
        k = 1;
    end
end


disp('')
vect{1} = resultado;
vect{end} = '1010';

for i = 1:length(vect)
    Sorden= sprintf('[%d]\t',orden(i));
    Svector= sprintf('[%s',vect{i});
    auxorden = dec2bin(orden(i));
    Sorden2= sprintf('%s]\n',auxorden);
    X = [Sorden, Svector, Sorden2];
    disp(X);
end



disp('THE END...');