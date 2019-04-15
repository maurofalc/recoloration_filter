% Função do Filtro Laplaciano
function [ cr,cg,cb ] = laplacian(num_lin, num_col, f_red, f_green, f_blue)
    % matriz kernel do filtro
    k = [ num_lin; num_col ];
    k(2,1) = 1; 
    k(1,2) = 1; 
    k(1,1) = -4; 
    k(num_lin,1) = 1; 
    k(1,num_col) = 1;
    K = fft2(k); % transformada de Fourier do filtro
    
    Cr = f_red.*K;   % canal vermelho filtrado na frequência
    Cg = f_green.*K; % canal verde filtrado na frequência
    Cb = f_blue.*K;  % canal azul filtrado na frequência
    
    cr = ifft2(Cr); % transformada inversa do canal vermelho
    cg = ifft2(Cg); % transformada inversa do canal verde
    cb = ifft2(Cb); % transformada inversa do canal azul
end