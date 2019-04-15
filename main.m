% Universidade Federal do Ceará - Campus Sobral
% Processamento Digital de Sinais
% Francisco Mauro Falcão Matias Filho

% aquisição das imagens
imagefiles = dir(fullfile('images', '*.jpg'));
nfiles = length(imagefiles);
for j = 1:nfiles
    filename = imagefiles(j).name;
    currentimage = imread(strcat('images/', filename));
    image = im2double(currentimage);

    % número de linhas, colunas e dimensões da imagem, respectivamente
    [ lin, col, dim ] = size(image); 

    red = image(:, :, 1); % canal vermelho
    green = image(:, :, 2); % canal verde
    blue = image(:, :, 3); % canal azul

    fred = fft2(red);     % transformada de Fourier da matriz do canal vermelho
    fgreen = fft2(green); % transformada de Fourier da matriz do canal verde
    fblue = fft2(blue);   % transformada de Fourier da matriz do canal azul

    % realce da imagem
    [ lred,lgreen,lblue ] = laplacian(lin, col, fred, fgreen, fblue);
    limage = cat(3, red-lred, green-lgreen, blue-lblue);

    % recoloração da imagem
    i = -0.95; %indicador ajustável de contraste
    [ A, B, G] = recoloration(i);

    new_red = limage(:, :, 1); %canal vermelho
    new_green = limage(:, :, 2); %canal verde
    new_blue = limage(:, :, 3); %canal azul

    result = cat(3, new_red, new_green, new_red.*A+new_green.*B+new_blue.*G);
    imwrite(result, strcat('results/', 'filtered', filename));
end