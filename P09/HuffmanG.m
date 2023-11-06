% Leer la imagen RGB
a = imread('peppers.png');

% Calcular el histograma y las probabilidades de los niveles de gris
histograma = imhist(a);
total_pixeles = numel(a);
probabilidades = histograma / total_pixeles;

% Crear el conjunto de mensajes y el diccionario de Huffman
mensajes = 0:length(probabilidades)-1; % Ajustar el rango según la longitud de probabilidades
dict = huffmandict(mensajes, probabilidades);

% Codificar la imagen
a_vector = a(:); % Convertir la imagen en una matriz unidimensional
a_codificado = huffmanenco(a_vector, dict);

% Decodificar la imagen
a_decodificado = huffmandeco(a_codificado, dict);
a_decodificado = reshape(a_decodificado, size(a)); % Reconstruir la matriz

% Comprobar si la imagen decodificada es igual a la original
isequal(a, a_decodificado)

% Calcular la longitud promedio del código
L = 0;
for c = 1:length(probabilidades)
    cantidadBits = length(dict{c, 2});
    aux = cantidadBits * probabilidades(c);
    L = L + aux;
end
disp(['Longitud Promedio del Código (L): ' num2str(L)]);

% Calcular la cantidad de información
I = -log2(probabilidades);
disp('Cantidad de Información (I):');
for c = 1:length(I)
    disp(['Valor ' num2str(c-1) ': ' num2str(I(c))]);
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

% Comprobar el teorema de Shannon
if L >= H
    disp('Se cumple el teorema de Shannon');
end   