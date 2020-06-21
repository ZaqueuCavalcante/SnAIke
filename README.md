# Snake-AI

Antes de começar, um pouco de nostalgia.

<img src='images\snake-nokia.GIF' width='400' height='300' title="snake-nokia"/>

## Parte 0 - O Projeto

- Presentation:
	- Canvas;
		- Button;
		- Dashboard;
			- Plot;

- Actor:
	- Snake:
		- Head:
			- Pixel;
		- Body:
			- Pixels; 
	- Food:
		- Pixel;
	- Obstacle / Rock:
		- Pixel;
	- Board:
		- Matriz de Pixels;

- Radar:  // Interface entre o Actor e o Controller;
	- Existe apenas UM de cada tipo;
	- Radar usado por cobras;
		- É compartilhado por todas as cobras, uma usa de cada vez;
		- Não armazena informação, apenas as recebe, processa e as retorna;
		- Pega as seguintes informações:
			- Snake, food, board;
			- Deixar estendível para pegar obstáculos também; 
		- Retorna para o Controller as seguintes informações:
			- Distâncias da Snake até a Food (com sinal + -, variando de -1.0 a 1.0):
				- Delta x;
				- Delta y;
			- Velocidade da Snake (com sinal + -, cada componente pode assumir -1, 0 ou 1):
				- Velocity x;
				- Velocity y;
			- Distâncias da Snake até o obstáculo mais próximo, à Left, Front e Right (sem sinal, variando de 0.0 a 1.0):
				- O obstáculo pode ser:
					- Parede do Board;
					- O próprio Body da Snake;
					- Um obstáculo, Rock;
	- Radar usado por Foods / presas;
	- Radar usado por obstáculos / Rock;

- Controller:
	- Master:
		- Controla as REGRAS DO GAME;
		- Dita as Leis e as faz cumprir;
		- Pode controlar os seguintes Actors:
			- Snake;
			- Food;
			- Obstacle;
			- Board;
	- Human Player;
		- Pode controlar os seguintes Actors:
			- Snake;
			- Food;
			- Obstacle;
	- Neural Network + Genetic Algorithm:
		- Pode controlar os seguintes Actors:
			- Snake;
			- Food;
			- Obstacle;
	- Other thing:
		- Outro algoritmo capaz de decidir o que o Actor deve fazer;



Tentei fazer uma *Rede Neural* simples aprender a jogar o famoso 'Jogo da Cobrinha', através de uma *meta-heurística* conhecida como *Algoritmo Genético*.

Vou dividir a explicação em duas partes: 
- Parte 1 - Implementação completa do jogo;
- Parte 2 - Explicação sobre o funcionamento da Rede Neural e do Algoritmo Genético utilizado.

Em resumo, vamos gerar várias cobras, isto é, uma *população* delas. Todas terão livre arbítrio para fazer o que quiserem entre as quatro paredes, mas somente as mais *adaptadas* terão mais chance de se *alimentar*, se *reproduzir* e de passar seus *genes* para as próximas *gerações*. 

A cada geração, cobras mais adaptadas surgirão (espero eu), até que a cobra perfeita nascerá para zerar o jogo, perfomando com a menor quantidade possível de movimentos entre uma maçã e outra.

Para rodar o jogo, basta clonar o repositório e instalar o [Processing](https://processing.org/) na sua máquina de computar. Usei a versão baseada em Java, mas existe suporte para Python e JavaScript também.

#### Planos futuros
- Adicionar obstáculos (pedras) ao game. A cobra agora teria que aprender a desviar das paredes, do seu próprio corpo e delas;
- Fazer uma versão onde a comida se move também, como se fosse uma presa que a cobra está caçando. Ela poderia ser controlado tanto pelo teclado (player humano) ou ter sua própria Rede Neural;
- Utilizar outros algoritmos de solução. Comparar suas performaces;
- Fazer uma versão web utilizando o P5.JS e o TensorFlow.JS; 
  // Comidas com cores diferentes -> Pontuações diferentes.
  // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
  // Várias comidas na tela.

## Parte 1 - O Jogo

### 1.0 - Canvas

Será nossa *tela de pintura*, onde tudo vai acontecer. Nele, teremos:
- botões, para interagir com o programa em execução;
- parâmetros, sobre a população de cobras;
- o habitat das cobras (cercado que limita seus movimentos);
- as cobras;
- as maçãs (e os possíveis obstáculos);
- o cérebro (Rede Neural) da melhor cobra da geração;

Todos os objetos mostrados em tela possuem um **vetor posição**, como mostrado a seguir:

### GIF da tela aqui

### 1.1 - Board

É o local onde as cobras poderão se locomover. 

É possível controlar a suas dimensões através da variável global PIXEL_SIZE.

## Parte 2 - Rede Neural + Algoritmo Genético

### 2.0 - Representação de cada indivíduo/cobra

Como cada cobra será representada, em termos da Rede Neural. Em síntese, um **vetor de pesos** basta para definir e diferenciar uma cobra da outra. 

Em uma analogia com a Biologia, esse **vetor** representaria um **cromosomo** e cada **elemento** seu, um **gene**.

- Salvar pesos em um arquivo para poder recarregar depois;
- Plotar a configuração de pesos ao longo das gerações, para acompanhar a convergência da rede;

### 2.1 - Geração da população inicial

Geração aleatória de pesos (genes) para cada cobra.

Definição dos parâmetros principais:
- Tamanho da população;
- Número máximo de gerações, como critério de parada;
- Taxa de mutação;

### 2.2 - Ciclo Evolutivo

Aqui é onde a mágica vai acontecer. Na verdade, tudo consiste em fazer algumas multiplicações e somas de maneira esperta, como veremos adiante. Este ciclo vai se repetir até que o número máximo de gerações seja atingido. Para ser mais didático, vou dividir a explicação.

#### 2.2.0 - Avaliação da Aptidão da População

Nessa etapa, todas as cobras da população serão avaliadas em relação à sua **aptidão**. Ou seja, à sua capacidade de chegar até a comida, pelo menor caminho possível, sem esbarrar nas paredes, nos obstáculos ou em si mesma.

#### 2.2.1 - Ranking de Aptidão

A seguir, a população será ordenada da cobra de maior aptidão até a de menor, formando um **ranking**, igual o das Olimpíadas. As cobras mais ao topo terão maiores chances de ser reproduzir e propagar seus genes (ou pesos da rede neural), para a próxima geração.

Perceba que para montar o ranking, precisamos apenas dos índices de cada cobra no vetor de snakes. Obviamente, é bem mais fácil e barato trabalhar com índices, ao invés de ficar mudando as cobras toda hora de lugar no array.

#### 2.2.2 - Seleção do Pais

Vamos dar uma olhada no método `selectCouple()`, da classe `Population`:
``` Java 
public int[] selectCouple() {
    int[] coupleIndexes = new int[2];
    coupleIndexes[0] = indexesArray[int(random(indexesArray.length))];  // Mother index.
    coupleIndexes[1] = indexesArray[int(random(indexesArray.length))];  // Father index.
    return coupleIndexes;
  }
```
Ele, como o próprio nome diz, seleciona duas cobras para formar um casal, retornando um vetor com seus respectivos índices. Essa seleção é ponderada, ou seja, a probabilidade de ser escolhida depende da posição no ranking, como explicado a seguir.

Existem mesmo cobras hermafroditas?

Os índices de cada cobra do casal vêm do vetor `indexesArray`. Ele possuiria os seguintes valores, para uma população de 5 cobras:

``` Java
indexesArray = [0, 0, 0, 0, 0,
                1, 1, 1, 1,
                2, 2, 2,
                3, 3,
                4];
```

Cada cobra do ranking terá uma probabilidade de ser escolhida para ser mãe ou pai.
Esta probabilidade é proporcional à posição da cobra no ranking. 
Quanto menor o index, maior a chance de ser escolhido.
Note que eventualmente mãe e pai podem ser a mesma cobra. Equivaleria a um clone ou elitismo.
    
#### 2.2.3 - Cruzamento

<img src='images\snake-MIT-1985.GIF' width='400' height='300' title="snake-MIT-1985"/>

#### 2.2.4 - Mutação

Como adiantado acima, aqui as cobras se **reproduzirão** e sofrerão eventuais **mutações** para formar uma prole que **herde** as características das mais adaptadas.

#### 2.2.5 - Melhor Cobra

Ao final de cada geração, se pretende que surjam cobras cada vez melhores, convergindo uma solução ótima (ou perto disso) ao final do ciclo evolutivo.


> Computadores fazem arte, artistas fazem dinheiro...
