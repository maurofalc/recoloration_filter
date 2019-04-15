% Fun��o de Recolora��o
function [ alfa,beta,gama ] = recoloration(index)
    % heur�stica de decis�o para aumento de contraste: 
    % para i>0, aumenta-se a intensidade do azul nos pixels com alta 
    % intensidade de vermelho
    if index >= 0
        alfa = 0;
    else
        alfa = -index;
    end

    % para i<0, aumenta-se a intensidade do azul nos pixels com alta 
    % intensidade de verde
    if index <= 0
        beta = 0;
    else
        beta = index;
    end

    gama = 1 - (alfa + beta); % indicador de contraste
end