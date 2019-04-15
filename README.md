# Filtro de Recoloração de Imagens
<!-- ![GitHub release](https://img.shields.io/github/release/maurofalc/recoloration_filter.svg?style=social)
![GitHub](https://img.shields.io/github/license/maurofalc/recoloration_filter.svg?style=social) -->

Este projeto trata-se de uma implementação em MATLAB de uma ferramenta de recoloração de imagens cujo objetivo é facilitar a percepção de de imagens por pessoas portadoras de algum tipo de cegueira de cor.
 
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

Imagens coloridas consistem em múltiplas matrizes, conhecidas como canais, que agregam em si a informação de cor associada a cada matriz. Para este trabalho, utilizou-se o modelo de cores RGB para tratar as informações das imagens. Este modelo baseia-se nas coordenadas cartesianas de um espaço formado por um cubo, cujos vértices são constituídos pelas cores primárias juntamente com as cores branca, preta, ciano, magenta e amarela, conforme ilustrado abaixo. Nessa representação,, cada pixel constitui um vetor de três componentes, os quais caracterizam as intensidades de vermelho, verde e azul.

<p align="center">
<img src="https://i.postimg.cc/qByQLDjq/img-3.png" alt="Representação do cubo de cores RGB." width="30.0%" />
<br>
<i>Representação do Cubo de cores RGB.</i>
</p>

### Filtros de Aguçamento Baseados em Derivadas

O principal objetivo do aguçamento é salientar transições de intensidade para o aumento da nitidez de uma imagem. Nesse sentido, os filtros baseados em derivadas são utilizados para atenuar áreas de variação suave e realçar detalhes finos, como as bordas.

Para uma função digital, a derivada primeira é zero em áreas de intensidade constante, e diferente de zero no início de um degrau ou rampa e ao longo das rampas. Consequentemente, a derivada segunda deve ser zero em áreas constantes e ao longo de rampas de inclinação constante, e diferente de zero no início e no final de um degrau ou rampa.

Nas imagens digitais, as bordas são transições parecidas com rampas em termos de intensidade. Dessa forma, a derivada primeira de uma imagem resulta em bordas espessas, já que ela é diferente de zero ao longo de uma rampa. Por outro lado, a derivada segunda realça os detalhes finos da imagem, visto que gera uma dupla borda com a espessura de um pixel. Tal característica demonstra que filtros de derivada segunda são mais adequados para aguçamento de imagens.

### Filtro Laplaciano

O filtro laplaciano é o operador derivativo mais simples para uma função de imagem, e é definido como:
![](https://i.postimg.cc/tg9tB9v4/eq-1.png)

Contudo, em se tratando do contexto discreto das imagens digitais, tal operador não pode ser utilizado. Nesse caso, dada uma função contínua ![](https://i.postimg.cc/TYczk3CK/eq-2.png) obtida através da amostragem de ![](https://i.postimg.cc/j2YzJKfT/eq-14.png), é possível obter as seguintes aproximações para as derivadas parciais:
![](https://i.postimg.cc/bvPL4xr8/eq-3.png)

![](https://i.postimg.cc/G22P1qC0/eq-4.png)

Logo, o filtro laplaciano pode ser definido por:
![](https://i.postimg.cc/1tjGRwm8/eq-5.png)

Fazendo-se $\Delta x = \Delta y = 1$ na equação acima é possível obter uma máscara, ou *kernel*, de filtragem que representa uma implementação aproximada do laplaciano, da seguinte forma: 
![](https://i.postimg.cc/7P3d6LvK/eq-6.png)

A figura a seguir representa o efeito do realce do filtro laplaciano sobre uma imagem. Observa-se que, embora a tonalidade do fundo tenha permanecido praticamente intacta, as bordas e as descontiuidades foram realçadas e os detalhes finos tornaram-se mais nítidos.

<p align="center">
<img src="https://i.postimg.cc/cLz0mJLQ/img-4.png" alt="Efeito do realce gerado em uma imagem utilizando o filtro laplaciano." width="100.0%" />
<br>
<i>Efeito do realce gerado em uma imagem utilizando o filtro laplaciano.</i>
</p>

## Filtragem no Domínio da Frequência

### Transformada de Fourier 2-D

Seja ![](https://i.postimg.cc/j2YzJKfT/eq-14.png) uma imagem digital de dimensões $M$x$N$. As equações a seguir constituem o par de transformadas discretas de Fourier 2-D dessa imagem: 
![](https://i.postimg.cc/GhbNs1dd/eq-7.png)

![](https://i.postimg.cc/kXhcXr5j/eq-8.png)

### Filtro Laplaciano

Pelo teorema da convolução, sabe-se que a convolução de dois sinais em um domínio é análoga à multiplicação ponto a ponto das transformadas de Fourier desses sinais, isto é, ![](https://i.postimg.cc/Qtsgnh6M/eq-9.png). Dessa forma, o filtro laplaciano deduzido anteriormente também pode ser implementado no domínio da frequência utilizando a máscara de filtragem supramencionada.

## Metodologia

O filtro de recoloração consiste na aplicação do filtro laplaciano, para realçar a imagem, seguida da aplicação do filtro de recoloração, para aumentar o contraste entre o verde e o vermelho.

## Filtro de Recoloração

Na visão de um portador de daltonismo, sabe-se que, embora os contrastes
entre verde e vermelho sejam difíceis de serem percebidos, os contrastes
entre verde e azul e entre vermelho e azul são percebidos normalmente.
Dessa forma, é possível aplicar transformações no contraste de azul em
imagens com alta intensidade de vermelho ou verde, de modo a facilitar a
identificação das informações dessas imagens [@visocor].

Considerando-se o espaço de cores RGB, este filtro age na componente
azul da imagem por meio de um parâmetro $i$, que pode ser manipulado via
código, cuja função é definir o nível de contraste entre vermelho e azul
ou verde e azul por meio da alteração da intensidade de azul em
componentes com alta intensidade de vermelhou ou verde, conforme
elucidado na Figura [\[fig:recolor\]](#fig:recolor){reference-type="ref"
reference="fig:recolor"}.

Dado um valor de $i$, a heurística do filtro de recoloração funciona de
seguinte forma:

![](https://i.postimg.cc/sfTPwF5V/eq-10.png)

![](https://i.postimg.cc/hPhLYC0V/eq-11.png)

![](https://i.postimg.cc/65SrxdHg/eq-12.png)

Os parâmetros $\alpha$, $\beta$ e $\gamma$ são utilizados para calcular os novos pixels do canal azul da imagem, da seguinte maneira:
![](https://i.postimg.cc/bwtQysWJ/eq-13.png)
dessa forma, quando $i < 0$, por exemplo, então $\alpha > 0$ e
$\beta = 0$, logo a intensidade de azul será maior em pixels de cor vermelha.

## Resultados

Utilizou-se a ferramenta online Coblis (*Color Blindness Simulator*) para simular a visão de um daltônico para as imagens originais e compará-las com as obtidas pelo filtro de destaque.

## Referências

ASATO, A.; GONÇALVES, R. Visocor - sistema de acessibilidade visual. Universidade de São Paulo, 2009. Trabalho de Conclusão de Curso.

COLBLINDOR. Coblis - Color Blindness Simulator. 2006. Disponível em: <https://www.color-blindness.com/coblis-color-blindness-simulator/>.

GONZALEZ, R. C.; WOODS, R. C. Processamento Digital de Imagens. 3. ed. Av. Ermano Marchetti, 1435: Pearson Educación, 2009. v. 1. ISBN 978-85-8143-586-2.

KAK, A. C.; ROSENFELD, A. Digital picture processing. New York, 1982.

MATHWORKS. MATLAB for Deep Learning. 2018. Software Matlab. Disponível em: <https://www.mathworks.com/>.

NISHIMORI, R. A. V.; JR, R. H. Ferramenta de acessibilidade para deficientes visuais em cores. Universidade de São Paulo, 2013. Trabalho de Conclusão de Curso.

SOUZA, L. A. de. John Dalton. 2018. Disponível em: <https://mundoeducacao.bol.uol.com.br/quimica/john-dalton.htm>.

VARELLA, M. H. Daltonismo. 2015. Disponível em: <https://drauziovarella.uol.com.br/doencas-e-sintomas/daltonismo/>.