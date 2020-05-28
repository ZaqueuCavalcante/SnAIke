# Snake-AI

Antes de começar, sinta-se um idoso vendo esse GIF nostálgico.

<img src='images\snake-nokia.GIF' width='400' height='300' title="snake-nokia" />

## Parte 0 - O projeto

Tentei fazer uma Rede Neural simples aprender a jogar o famoso 'Jogo da Cobrinha'. 

Vou dividir a explicação em duas partes: 
- Parte 1 - Implementação completa do jogo;
- Parte 2 - Explicação sobre o funcionamento da Rede Neural e do Algoritmo Genético utilizado.

Em resumo, vamos gerar várias cobras, isto é, uma *população* delas. Todas terão livre arbítrio para fazer o que quiserem entre as quatro paredes, mas somente as mais *adaptadas* terão mais chance de se *alimentar*, se *reproduzir* e de passar seus *genes* para as próximas *gerações*. 

A cada geração, cobras mais adaptadas surgirão (espero eu), até que a cobra perfeita nascerá para zerar o jogo com a menor quantidade possível de movimentos.

<img src='images\snake-MIT-1985.GIF' width='400' height='300' title="snake-MIT-1985" />

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
- o habittat das cobras;
- as cobras;
- as maçãs;
- o cérebro (Rede Neural) da melhor cobra da geração;

Todos os objetos mostrados em tela possuem um **vetor posição**, como mostrado a seguir:

### GIF da tela com a cobra se mexendo e com alguns objetos e seus vetores posição.

### 1.1 - Rink

É o local onde as cobras poderão se locomover. Modelei como um *pista de patinação*, daquelas que só se vê nas olimpíadas de inverno. Como não combina muito com as cobras, se você tiver um nome melhor, avise nos comentários.

É possível controlar a suas dimensões através da variável global PIXEL_SIZE. 











> Computadores fazem arte, artistas fazem dinheiro...
