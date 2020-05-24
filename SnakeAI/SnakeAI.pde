// Duas ou mais cobras competindo no mesmo ambiente. //<>// //<>//
// Uma pode matar a outra, se comer seu rabo.
// Adicionar obstáculos. Pedras. Análogo a classe Food.
// Depois que a AI estiver treinada, colocar as coordenadas da comida iguais as do mouse;
// Tentar fugir dela.

final float PIXEL_SIZE = 40.0;  // Length of the side of the elementary square that forms the snake, the food and the rink.
final int POP_SIZE = 10;

Canvas canvas;
Rink rink;

Population population;
Basket basket;

boolean humanPlaying = true;

void setup() {
  size(1800, 920);
  frameRate(15);
  canvas = new Canvas();

  rink = new Rink();
  rink.autoSize(canvas);

  population = new Population(POP_SIZE);
  population.randomInitialSnakes(rink);
  population.setInitialRanking();

  basket = new Basket(POP_SIZE);
  basket.setInitialFoods();

  for (int i = 0; i < POP_SIZE; i++) {
    rink.addFood(population.snakes[i], basket.foods[i]);
  }
}

void draw() {
  canvas.show();
  canvas.showParameters(population);
  
  rink.show();

  for (int i = 0; i < POP_SIZE; i++) {
    Snake currentSnake = population.snakes[i];
    Food currentFood = basket.foods[i];

    currentSnake.show();
    currentSnake.brain.show();
    rink.addFood(currentSnake, currentFood);
    currentFood.show();
    currentSnake.move(rink, currentFood);
  }

  if (population.allSnakesIsDead()) {
    setup();
  }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
void mousePressed() {
  if (canvas.saveButton.mouseAbove(mouseX, mouseY)) {
    //selectOutput("Save Snake Model", "fileSelectedOut");
  }
  if (canvas.loadButton.mouseAbove(mouseX, mouseY)) {
    //selectInput("Load Snake Model", "fileSelectedIn");
  }
  if (canvas.graphButton.mouseAbove(mouseX, mouseY)) {
    //graph = new EvolutionGraph();
  }
  if (canvas.increaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
    population.updateMutationRate(+1.0);
  }
  if (canvas.decreaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
    population.updateMutationRate(-1.0);
  }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
void keyPressed() {
  if (humanPlaying) {
    if (key == CODED) {
      switch(keyCode) {
      case LEFT:
        population.snakes[0].head.moveLeft();
        break;
      case RIGHT:
        population.snakes[0].head.moveRight();
        break;
      }
    }
  }
}