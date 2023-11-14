% Leer la imagen RGB
a = imread('cameraman.tif');

% Calcular el histograma y las probabilidades de los niveles de pixeles
histograma = imhist(a);
total_pixeles = numel(a);
probabilidades = histograma / total_pixeles;

% Crear el conjunto de mensajes y el diccionario de Huffman
mensajes = 0:length(probabilidades)-1; % Ajustar el rango según la longitud de probabilidades
dict = huffmandict(mensajes, probabilidades);
dictaux=dict;

%{
% Mostrar los códigos Huffman
for i = 1:length(dict)
    fprintf('Símbolo %d: Codeword ', i-1);
    disp(dict{i, 2});
end
%}

% Obtener las longitudes de cada uno de los códigos Huffman
longitudes_codigos = cellfun('length', dict(:, 2));

% Ordenar el diccionario en función de las longitudes de los códigos (mayor a menor)
% "s" no sirve (es el arreglo ordenado), idx es el indice en el que quedaron acomodados
[s, idx] = sort(longitudes_codigos, 'descend');

dict = dict(idx, :);

fichero = fopen('P09\Codes.txt', 'w');
for i = 1:length(dict)
    fprintf(fichero, 'Símbolo %d: Codeword %s\n', (dict{i, 1}), num2str(dict{i, 2}));
end
fclose(fichero);

% Codificar la imagen
a_vector = a(:); % Convertir la imagen en una matriz unidimensional
a_codificado = huffmanenco(a_vector, dict);

% Decodificar la imagen
a_decodificado = huffmandeco(a_codificado, dict);

% Comprobar si la el vector decodificado es igual a el vector de la imagen original
isequal(a_vector, a_decodificado)

a_decodificado = reshape(a_decodificado, size(a)); % Reconstruir la matriz

% Comprobar si la imagen decodificada es igual a la imagen original
isequal(a_decodificado, a)

e = 1e-10;

% Calcular la longitud promedio del código
L = 0;
for i = 1:length(dictaux)
    cantidadBits = length(dictaux{i, 2});
    aux = cantidadBits * probabilidades(i);
    L = L + aux;
end
disp(['Longitud Promedio del Código Huffman (L): ' num2str(L)]);

% Calcular la cantidad de información
I = -log2(probabilidades + e);
disp('Cantidad de Información (I):');
for i = 1:length(I)
    disp(['Valor ' num2str(i-1) ': ' num2str(I(i))]);
end

% Calcular la entropía
H = sum((probabilidades) .* I);
disp(['Entropía (H): ' num2str(H)]);

% Calcular el rendimiento
Z = (H / L)*100;
disp(['Rendimiento (Z): ' num2str(Z)]);

% Calcular la redundancia
R = 100 - Z;
disp(['Redundancia (R): ' num2str(R)]);