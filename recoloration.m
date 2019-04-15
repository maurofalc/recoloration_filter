% Função de Recoloração
function [ alfa,beta,gama ] = recoloration(index)
    % heurística de decisão para aumento de contraste: 
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