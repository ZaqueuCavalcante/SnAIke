# Snake-AI

Antes de começar, um pouco de nostalgia.

<img src='images\snake-nokia.GIF' width='400' height='300' title="snake-nokia"/>

## 0 - Por quê?

Minha principal inspiração para este projeto foi [este vídeo do Code Bullet](https://youtu.be/tjQIO1rqTBE). Nele, o objetivo é construir um algoritmo que zere o *Snake Game*, de modo que a cobra percorra a menor distância possível durante o jogo.

A princípio, não parece um *big deal*. Se fizer-mos a cobra se mover por um caminho que passe por todos os pontos do *grid* e não se auto-intercepte, eventualmente ganharemos o jogo.

Descendo "um pouco" o nível de abastração, o [John Tapsell](https://johnflux.com/2015/05/02/nokia-6110/) implementou esta solução (Pertubated Hamiltonian Cycle) direto no [Nokia 6110](https://youtu.be/d3ggLzatg9Y).

No entanto, essa abordagem é extremamente ineficiente e inviável para ambiente maiores, pois a cobra precisa percorrer todo o *grid* a cada maçã comida (no pior dos casos).

Assim, meu objetivo aqui é tentar zerar o jogo da maneira mais eficiente possível. Além disso, este projeto serviu de base para o estudo de diversos outros assuntos, como **Redes Neurais**, **Algoritmos de Busca de Caminhos** e **Ciclos Halmiltonianos**.


## 1 - O Jogo (The Hamiltonicity Of Arbitrary Bipartite Rectangular Grid Graphs)

O jogo foi feito em *JavaScript*, utilizando a biblioteca [p5.js](https://p5js.org/) na parte gráfica.

Ele está dividido nos módulos a seguir:
- **Actors**
	- Elementos que compõe a estrutura do jogo, como a cobra e a maçã.
- **Controllers**
	- Master, que controla as regras do jogo. Por exemplo, ele decide o que ocorre quando a cobra colide com uma maça, com as paredes ou com sigo mesma. 
	- Player, que controla apenas a cobra. Pode ser um humano, uma Rede Neural, um algoritmo ou qualquer outro agente capaz de receber informações do jogo (como posição da cobra, da maçã e das paredes...), processá-las e decidir pra que direção a cobra deve ir a cada movimento.
- **Radars**
	- Classes que servem como interfaces entre objetos dos módulos Actors e Controllers.
	- Por exemplo, se uma Rede Neural (Controller) quiser saber a distância entre a cabeça da cobra e a maçã, basta utilizar um método da classe SnakeRadar. 
- **Utils**
	- Abriga classes úteis para o desenvolvimento do jogo. Por exemplo, a classe ZPixel modela um pixel, utilizado nas classes Snake, Food e Board.
- **View**
	- Possui apenas uma classe, que é exclusivamente responsável por exibir tudo que é visto na tela.


#### Planos futuros
- Adicionar obstáculos (pedras) ao game.
- Fazer uma versão onde a comida se move também, como se fosse uma presa que a cobra está caçando. Ela poderia ser controlada tanto pelo teclado (player humano) ou ter sua própria Rede Neural;
- Utilizar outros algoritmos de solução. Comparar suas performaces;
- Fazer uma versão web utilizando o P5.JS e o TensorFlow.JS; 
  // Comidas com cores diferentes -> Pontuações diferentes.
  // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
  // Várias comidas na tela.


## 2 - Rede Neural + Algoritmo Genético

Aqui, tentei fazer uma *Rede Neural* simples aprender a jogar, através de uma *meta-heurística* conhecida como *Algoritmo Genético*.

Em resumo, vamos gerar várias cobras, isto é, uma *população* delas. Todas terão livre arbítrio para fazer o que quiserem entre as quatro paredes, mas somente as mais *adaptadas* terão mais chance de se *alimentar*, se *reproduzir* e de passar seus *genes* para as próximas *gerações*. 

A cada geração, cobras mais adaptadas surgirão (espero eu), até que a cobra perfeita nascerá para zerar o jogo, perfomando com a menor quantidade possível de movimentos entre uma maçã e outra.

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
