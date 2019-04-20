# Filtro de Recoloração de Imagens
<!-- ![GitHub release](https://img.shields.io/github/release/maurofalc/recoloration_filter.svg?style=social)
![GitHub](https://img.shields.io/github/license/maurofalc/recoloration_filter.svg?style=social) -->

Este projeto trata-se de uma implementação em MATLAB de uma ferramenta de recoloração de imagens cujo objetivo é facilitar a percepção de imagens por pessoas portadoras de algum tipo de cegueira de cor.
 
## Introdução

Cegueira de cores é um tipo de deficiência visual que dificulta ou impossibilita a visualização de determinadas cores. Essa doença, também conhecida como daltonismo, é caracterizada pela insuficiência, ou não funcionamento, das células oculares chamadas de cones, que são responsáveis pela diferenciação das cores. Indivíduos portadores de cegueira de cores têm dificuldades em perceber contrastes entre verde e vermelho, conforme pode ser observado na imagem abaixo.

<p align="center">
<img src="https://i.postimg.cc/6pYMZ7zh/img-1.png" alt="Uma imagem de uma paisagem e a representação dela vista por um daltônico." width="80.0%" />
<br>
<i>Uma imagem de uma paisagem e a representação dela vista por um daltônico.</i>
</p>

Entretanto, os contrastes entre verde e azul e entre vermelho e azul são percebidos normalmente. Dessa forma, utilizando técnicas de processamento de imagens, é possível aplicar transformações nos canais de cores das imagens de modo a aumentar o contraste de azul em imagens com alta intensidade de vermelho ou verde.

## Fundamentação Teórica

### Imagem Digital

Uma imagem digital, no domínio do espaço, consiste na representação de uma imagem bidimensional por meio de um conjunto finito de pontos, que agregam um valor numérico em si, formando uma matriz em que cada elemento é denominado pixel. Tipicamente, uma imagem monocromática é caracterizada por uma função ![i[x,y]](https://i.postimg.cc/P51nmQ0k/eq-15.png) de duas dimensões. 

<p align="center">
<img src="https://i.postimg.cc/kMbYHgXn/img-2.png" alt="Representação de uma imagem digital no domínio do espaço." width="30.0%" />
<br>
<i>Representação de uma imagem digital no domínio do espaço.</i>
</p>

Imagens coloridas consistem em múltiplas matrizes, conhecidas como canais, que agregam em si a informação de cor associada a cada matriz. Para este trabalho, utilizou-se o modelo de cores RGB para tratar as informações das imagens. Este modelo baseia-se nas coordenadas cartesianas de um espaço formado por um cubo, cujos vértices são constituídos pelas cores primárias juntamente com as cores branca, preta, ciano, magenta e amarela, conforme ilustrado abaixo. Nessa representação, cada pixel constitui um vetor de três componentes, os quais caracterizam as intensidades de vermelho, verde e azul.

<p align="center">
<img src="https://i.postimg.cc/qByQLDjq/img-3.png" alt="Representação do cubo de cores RGB." width="40.0%" />
<br>
<i>Representação do cubo de cores RGB.</i>
</p>

### Filtros de Aguçamento Baseados em Derivadas

O principal objetivo do aguçamento é salientar transições de intensidade para o aumento da nitidez de uma imagem. Nesse sentido, os filtros baseados em derivadas são utilizados para atenuar áreas de variação suave e realçar detalhes finos, como as bordas.

Para uma função digital, a derivada primeira é zero em áreas de intensidade constante, e diferente de zero no início de um degrau ou rampa e ao longo das rampas. Consequentemente, a derivada segunda deve ser zero em áreas constantes e ao longo de rampas de inclinação constante, e diferente de zero no início e no final de um degrau ou rampa.

Nas imagens digitais, as bordas são transições parecidas com rampas em termos de intensidade. Dessa forma, a derivada primeira de uma imagem resulta em bordas espessas, já que ela é diferente de zero ao longo de uma rampa. Por outro lado, a derivada segunda realça os detalhes finos da imagem, visto que gera uma dupla borda com a espessura de um pixel. Tal característica demonstra que filtros de derivada segunda são mais adequados para aguçamento de imagens.

### Filtro Laplaciano

O filtro laplaciano é o operador derivativo mais simples para uma função de imagem, e é definido como:

![](https://i.postimg.cc/PJdQRT54/eq-30.png)

Contudo, em se tratando do contexto discreto das imagens digitais, tal operador não pode ser utilizado. Nesse caso, dada uma função contínua ![f(x,y)](https://i.postimg.cc/T2ZRg1hg/eq-16.png) obtida através da amostragem de ![i[x,y]](https://i.postimg.cc/P51nmQ0k/eq-15.png), é possível obter as seguintes aproximações para as derivadas parciais:

![](https://i.postimg.cc/G2FjKHdt/eq-29.png)

![](https://i.postimg.cc/2jxwBb0X/eq-31.png)

Logo, o filtro laplaciano pode ser definido por:

![](https://i.postimg.cc/mDfw7QxK/eq-28.png)

Fazendo-se [![eq-37.png](https://i.postimg.cc/vTWHcwrp/eq-37.png)](https://postimg.cc/V0kcVTHR) na equação acima é possível obter uma máscara, ou *kernel*, de filtragem que representa uma implementação aproximada do laplaciano, da seguinte forma: 

![](https://i.postimg.cc/bv2gGm5Q/eq-27.png)

A figura a seguir representa o efeito do realce do filtro laplaciano sobre uma imagem. Observa-se que, embora a tonalidade do fundo tenha permanecido praticamente intacta, as bordas e as descontiuidades foram realçadas e os detalhes finos tornaram-se mais nítidos.

<p align="center">
<img src="https://i.postimg.cc/cLz0mJLQ/img-4.png" alt="Efeito do realce gerado em uma imagem utilizando o filtro laplaciano." width="100.0%" />
<br>
<i>Efeito do realce gerado em uma imagem utilizando o filtro laplaciano.</i>
</p>

## Filtragem no Domínio da Frequência

### Transformada de Fourier 2-D

Seja ![i[x,y]](https://i.postimg.cc/P51nmQ0k/eq-15.png) uma imagem digital de dimensões [![eq-38.png](https://i.postimg.cc/QMrmTQZw/eq-38.png)](https://postimg.cc/WdX0RJ3w). As equações a seguir constituem o par de transformadas discretas de Fourier 2-D dessa imagem: 

[![eq-35.png](https://i.postimg.cc/nzSh61HP/eq-35.png)](https://postimg.cc/ZB3mNpv8)

[![eq-36.png](https://i.postimg.cc/1tX9cNpc/eq-36.png)](https://postimg.cc/G80wbtgH)

### Filtro Laplaciano

Pelo teorema da convolução, sabe-se que a convolução de dois sinais em um domínio é análoga à multiplicação ponto a ponto das transformadas de Fourier desses sinais, isto é, ![](https://i.postimg.cc/xdTYnbFD/eq-17.png). Dessa forma, o filtro laplaciano deduzido anteriormente também pode ser implementado no domínio da frequência utilizando a máscara de filtragem supramencionada.

## Filtro de Recoloração

Na visão de um portador de daltonismo, sabe-se que, embora os contrastes
entre verde e vermelho sejam difíceis de serem percebidos, os contrastes
entre verde e azul e entre vermelho e azul são percebidos normalmente.
Dessa forma, é possível aplicar transformações no contraste de azul em
imagens com alta intensidade de vermelho ou verde, de modo a facilitar a
identificação das informações dessas imagens.

Considerando-se o espaço de cores RGB, este filtro age na componente
azul da imagem por meio de um parâmetro ![i](https://i.postimg.cc/rpbH3dB9/eq-26.png), que pode ser manipulado via
código, cuja função é definir o nível de contraste entre vermelho e azul
ou verde e azul por meio da alteração da intensidade de azul em
componentes com alta intensidade de vermelhou ou verde.

<p align="center">
<img src="https://i.postimg.cc/sfS2n7kw/img-5.png" alt="Representação do contraste entre as cores para diferentes valores de i.." width="60.0%" />
<br>
<i>Representação do contraste entre as cores para diferentes valores de i.</i>
</p>

Dado um valor de ![i](https://i.postimg.cc/rpbH3dB9/eq-26.png), a heurística do filtro de recoloração funciona de
seguinte forma:

![](https://i.postimg.cc/jddh6x9q/eq-32.png)

[![eq-33.png](https://i.postimg.cc/LsdfW2y1/eq-33.png)](https://postimg.cc/9DprR5Hm)

[![eq-34.png](https://i.postimg.cc/FRpL1chy/eq-34.png)](https://postimg.cc/r0dmPD0s)

Os parâmetros ![\alpha](https://i.postimg.cc/d01MzcLJ/eq-20.png), ![\beta](https://i.postimg.cc/50Yh25BG/eq-21.png) e ![\gamma](https://i.postimg.cc/7hSjgxQn/eq-22.png) são utilizados para calcular os novos pixels do canal azul da imagem, da seguinte maneira ![](https://i.postimg.cc/XJt0f1N4/eq-18.png). Dessa forma, quando ![i < 0](https://i.postimg.cc/WprRRnbq/eq-23.png), por exemplo, então ![\alpha > 0](https://i.postimg.cc/xTyW81m0/eq-24.png) e ![\beta = 0](https://i.postimg.cc/0yVFGXZF/eq-25.png), logo a intensidade de azul será maior em pixels de cor vermelha.

## Metodologia

O filtro de recoloração consiste na aplicação do filtro laplaciano, para realçar a imagem, seguida da aplicação do filtro de recoloração, para aumentar o contraste entre o verde e o vermelho.

## Resultados

Utilizou-se a ferramenta online *Color Blindness Simulator* ([Coblis](https://www.color-blindness.com/coblis-color-blindness-simulator/)) para simular a visão de um daltônico para as imagens originais e compará-las com as obtidas pelo filtro de recoloração.

<p align="center">
<img src="https://i.postimg.cc/MGysPsYz/img-6.png" alt="Mapa de Sobral e a simulação dele visto por um daltônico." width="80.0%" />
<br>
<i>Mapa de Sobral e a simulação dele visto por um daltônico.</i>
</p>

<p align="center">
<img src="https://i.postimg.cc/NFT7FFPB/img-7.png" alt="Mapa de Sobral após aplicação do filtro de recoloração e a simulação dele visto por um daltônico." width="80.0%" />
<br>
<i>Mapa de Sobral após aplicação do filtro de recoloração e a simulação dele visto por um daltônico.</i>
</p>

Comparando-se as imagens após a aplicação do filtro é possível notar que o contraste entre as cores aumentou significativamente devido à recoloração. Observa-se, também, que as linhas finas do mapa ficaram mais nítidas, em virtude do realce aplicado pelo filtro laplaciano.

## Referências

ASATO, A.; GONÇALVES, R. Visocor - sistema de acessibilidade visual. Universidade de São Paulo, 2009. Trabalho de Conclusão de Curso.

COLBLINDOR. Coblis - Color Blindness Simulator. 2006. Disponível em: <https://www.color-blindness.com/coblis-color-blindness-simulator/>.

GONZALEZ, R. C.; WOODS, R. C. Processamento Digital de Imagens. 3. ed. Av. Ermano Marchetti, 1435: Pearson Educación, 2009. v. 1. ISBN 978-85-8143-586-2.

KAK, A. C.; ROSENFELD, A. Digital picture processing. New York, 1982.

MATHWORKS. MATLAB for Deep Learning. 2018. Software Matlab. Disponível em: <https://www.mathworks.com/>.

NISHIMORI, R. A. V.; JR, R. H. Ferramenta de acessibilidade para deficientes visuais em cores. Universidade de São Paulo, 2013. Trabalho de Conclusão de Curso.

SOUZA, L. A. de. John Dalton. 2018. Disponível em: <https://mundoeducacao.bol.uol.com.br/quimica/john-dalton.htm>.

VARELLA, M. H. Daltonismo. 2015. Disponível em: <https://drauziovarella.uol.com.br/doencas-e-sintomas/daltonismo/>.
