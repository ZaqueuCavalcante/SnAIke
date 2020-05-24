// Duas ou mais cobras competindo no mesmo ambiente. //<>//
// Uma pode matar a outra, se comer seu rabo.
// Adicionar obstáculos. Pedras. Análogo a classe Food.
// Depois que a AI estiver treinada, colocar as coordenadas da comida iguais as do mouse;
// Tentar fugir dela.

final float PIXEL_SIZE = 40.0;  // Length of the side of the elementary square that forms the snake, the food and the rink.
final int POP_SIZE = 1;

Canvas canvas;

Rink rink;

Population population;
// population = new Population(POP_SIZE);
// population.setInitialSnakes(rink);
// population.setInitialRanking();

boolean humanPlaying = true;

void setup() {
  size(1800, 920);
  frameRate(15);
  canvas = new Canvas();

  rink = new Rink();
  rink.autoSize(canvas);

  for (Snake snake : population.snakes) {
    rink.addFood(snake, food);
  }
}

void draw() {
  canvas.show();
  canvas.showParameters(population);

  rink.show();

  for (Snake snake : population.snakes) {
    //rink.food.show();

    snake.show();
    int rf = int(random(0, 4));
    if (rf == 0) {
      snake.head.moveLeft();
    } else if (rf == 1) {
      snake.head.moveRight();
    }
    snake.move(rink, food);
  }

  if (population.allSnakesIsDead()) {
    population = new Population(POP_SIZE);
    population.setInitialSnakes(rink);
    population.setInitialRanking();

    for (Snake snake : population.snakes) {
      rink.determineFreePositions(snake);
      //rink.addFood();
    }
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
