# Snake-AI

Antes de começar, sinta-se um idoso vendo esse GIF nostálgico.

<img src='images\snake-nokia.GIF' width='400' height='300' title="snake-nokia"/>

## Parte 0 - O Projeto

Tentei fazer uma Rede Neural simples aprender a jogar o famoso 'Jogo da Cobrinha'. 

Vou dividir a explicação em duas partes: 
- Parte 1 - Implementação completa do jogo;
- Parte 2 - Explicação sobre o funcionamento da Rede Neural e do Algoritmo Genético utilizado.

Em resumo, vamos gerar várias cobras, isto é, uma *população* delas. Todas terão livre arbítrio para fazer o que quiserem entre as quatro paredes, mas somente as mais *adaptadas* terão mais chance de se *alimentar*, se *reproduzir* e de passar seus *genes* para as próximas *gerações*. 

A cada geração, cobras mais adaptadas surgirão (espero eu), até que a cobra perfeita nascerá para zerar o jogo com a menor quantidade possível de movimentos.

Para rodar o jogo, basta clonar o repositório e instalar o [Processing](https://processing.org/) na sua máquina de computar. 

#### Futuro
- Adicionar obstáculos, pedras. Análogo a classe Food.
- Depois que a AI estiver treinada, colocar as coordenadas da comida iguais as do mouse e 
tentar fugir dela;
#### Futuro

## Parte 1 - O Jogo

### 1.0 - Canvas

Será nossa *tela de pintura*, onde tudo vai acontecer. Nele, teremos:
- botões, para interagir com o programa em execução;
- parâmetros, sobre a população de cobras;
- o habitat das cobras;
- as cobras;
- as maçãs;
- o cérebro (Rede Neural) da melhor cobra da geração;

Todos os objetos mostrados em tela possuem um **vetor posição**, como mostrado a seguir:

### GIF da tela com a cobra se mexendo e com alguns objetos e seus vetores posição.

### 1.1 - Rink

É o local onde as cobras poderão se locomover. Modelei como um *pista de patinação*, daquelas que só se vê nas olimpíadas de inverno. Como não combina muito com as cobras, se você tiver um nome melhor, avise nos comentários.

É possível controlar a suas dimensões através da variável global PIXEL_SIZE.

## Parte 2 - Rede Neural + Algoritmo Genético

### 2.0 - Representação de cada indivíduo/cobra

Como cada cobra será representada, em termos da RN. Em síntese, um **vetor de pesos** basta para definir e diferenciar uma cobra da outra.

- Salvar pesos em um arquivo para poder recarregar depois;
- Plotar a configuração de pesos ao longo das gerações, para acompanhar a convergência da rede;

### 2.1 - Geração da população inicial

Geração aleatória de pesos para cada cobra.

Definição dos parâmetros principais:
- Tamanho da população;
- Número máximo de gerações, como critério de parada;
- Taxa de mutação;

### 2.2 - Ciclo Evolutivo

Aqui é onde a mágica vai acontecer. Na verdade, tudo consiste em fazer umas multiplicações e soma de maneira esperta, como veremos adiante. Este ciclo vai se repetir até que p número máximo de gerações seja atingido. Para ser mais didático, vou dividir a explicação.

#### 2.2.0 - Avaliação da Aptidão da População

Nessa etapa, todas as cobras da população serão avaliadas em relação à sua **aptidão**. Ou seja, à sua capacidade de chegar até a comida, pelo menor caminho possível, sem esbarrar nas paredes ou em si mesma.

#### 2.2.1 - Ranking de Aptidão

A seguir, a população será ordenada da cobra de maior aptidão até a de menor, formando um **ranking**, igual o das Olimpíadas. As cobras mais ao topo terão maiores chances de ser reproduzir e propagar seus genes (ou pesos da rede neural), para a próxima geração.

Perceba que para montar o ranking, precisamos apenas dos índices de cada cobra no vetor de snakes. É bem mais fácil e barato trabalhar com índices, ao invés de ficar mudando as cobras toda hora de lugar no array.

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
    

Como adiantado acima, aqui as cobras se **reproduzirão** e sofrerão eventuais **mutações** para formar uma prole que **herde** as características das mochilas mais aptadas.

<img src='images\snake-MIT-1985.GIF' width='400' height='300' title="snake-MIT-1985"/>

Desta forma, se pretende que as populações apresentem mochilas cada vez melhores ao passar das gerações, convergindo para as melhores soluções ao final.











> Computadores fazem arte, artistas fazem dinheiro...
