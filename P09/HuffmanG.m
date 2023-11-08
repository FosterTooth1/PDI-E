% Leer la imagen RGB
a = imread('peppers.png');

% Calcular el histograma y las probabilidades de los niveles de pixeles
histograma = imhist(a);
total_pixeles = numel(a);
probabilidades = histograma / total_pixeles;

% Crear el conjunto de mensajes y el diccionario de Huffman
mensajes = 0:length(probabilidades)-1; % Ajustar el rango según la longitud de probabilidades
dict = huffmandict(mensajes, probabilidades);

% Mostrar los códigos Huffman
for i = 1:length(dict)
    fprintf('Símbolo %d: Codeword ', i-1);
    disp(dict{i, 2});
end

% Mostrar los códigos Huffman en el fichero
fichero = fopen('P09\Codes.txt', 'w');
for i = 1:length(dict)
    fprintf(fichero, 'Símbolo %d: Codeword %s\n', i-1, num2str(dict{i, 2}));
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

% Comprobar si la imagen decodificada es igual a la original
isequal(a, a_decodificado)

% Calcular la longitud promedio del código
L = 0;
for i = 1:length(dict)
    cantidadBits = length(dict{i, 2});
    aux = cantidadBits * probabilidades(i);
    L = L + aux;
end
disp(['Longitud Promedio del Código Huffman (L): ' num2str(L)]);

% Calcular la cantidad de información
I = -log2(probabilidades);
disp('Cantidad de Información (I):');
for i = 1:length(I)
    disp(['Valor ' num2str(i-1) ': ' num2str(I(i))]);
end

% Calcular la entropía
H = sum(probabilidades .* I);
disp(['Entropía (H): ' num2str(H)]);

% Calcular el rendimiento
Z = (H / L)*100;
disp(['Rendimiento (Z): ' num2str(Z)]);

% Calcular la redundancia
R = 100 - Z;
disp(['Redundancia (R): ' num2str(R)]);