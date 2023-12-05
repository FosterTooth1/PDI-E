image = imread('shrek.jpg');
image = rgb2gray(image);
image = im2double(image); % Normalizar los valores de píxeles

% Matriz lleno de unos para las operaciones
kernel = ones(3, 3);

% Aplicar apertura o cierre según la elección del usuario
opcion = input('Selecciona ''a'' para apertura o ''c'' para cierre: ', 's');
if opcion == 'a'
    resultado = apertura(image, kernel);
    operacion = 'Apertura';
elseif opcion == 'c'
    resultado = cierre(image, kernel);
    operacion = 'Cierre';
else
    disp('Opción no válida. Por favor, elige ''a'' o ''c''.');
    return;
end

% Mostrar las imágenes original y procesada
figure;
subplot(1, 2, 1);
imshow(image);
title('Imagen Original');

subplot(1, 2, 2);
imshow(resultado);
title(['Imagen después de ', operacion]);

% Función de erosión
function result = erosion(image, kernel)
    %Se obtienen las medidas de la imagen y del kernel
    [m, n] = size(image);
    [km, kn] = size(kernel);
    %Se crea una matriz, con la imagen original adentro y los bordes llenos
    %de ceros para evitar errores en los calculos de los pixeles de los
    %bordes
    pad_height = (km - 1) / 2;
    pad_width = (kn - 1) / 2;
    padded_image = zeros(m + 2 * pad_height, n + 2 * pad_width);
    padded_image(pad_height + 1:m + pad_height, pad_width + 1:n + pad_width) = image;

    result = zeros(m, n);

    for i = 1:m
        for j = 1:n
            %Se selecciona un pedazo de la imagen del tanaño del kernel
            patch = padded_image(i:i + km - 1, j:j + kn - 1);
            %Devuelve el valor minimo donde el kernel=1
            result(i, j) = min(patch(kernel == 1));
        end
    end
end


% Función de dilatación
function result = dilatacion(image, kernel)
    [m, n] = size(image);
    [km, kn] = size(kernel);
    
    pad_height = (km - 1) / 2;
    pad_width = (kn - 1) / 2;
    
    padded_image = zeros(m + 2 * pad_height, n + 2 * pad_width);
    padded_image(pad_height + 1:m + pad_height, pad_width + 1:n + pad_width) = image;

    result = zeros(m, n);

    for i = 1:m
        for j = 1:n
            patch = padded_image(i:i + km - 1, j:j + kn - 1);
            result(i, j) = max(patch(kernel == 1));
        end
    end
end


% Apertura morfológica (erosión seguida de dilatación)
function result = apertura(image, kernel)
    eroded = erosion(image, kernel);
    opened = dilatacion(eroded, kernel);
    result = opened;
end

% Cierre morfológico (dilatación seguida de erosión)
function result = cierre(image, kernel)
    dilated = dilatacion(image, kernel);
    closed = erosion(dilated, kernel);
    result = closed;
end


