// Duas ou mais cobras competindo no mesmo ambiente. //<>// //<>// //<>//
// Uma pode matar a outra, se comer seu rabo.
// Adicionar obstáculos. Pedras. Análogo a classe Food.
// Depois que a AI estiver treinada, colocar as coordenadas da comida iguais as do mouse;
// Tentar fugir dela.

final float PIXEL_SIZE = 40.0;  // Length of the side of the elementary square that forms the snake, the food and the rink.
Canvas canvas;
Rink rink;

Snake snake;

boolean humanPlaying = true;

void setup() {
  size(1800, 920);
  canvas = new Canvas(width, height);
  canvas.setFPS(15);

  rink = new Rink();
  rink.setPosition(canvas);
  rink.setSideSizes(canvas);
  rink.setPixelPositions();

  snake = new Snake();
  snake.setInitialPosition(rink);
  snake.setBrain();

  rink.determineFreePositions(snake);
  rink.addFood();
}

void draw() {
  //canvas.setScore(rink.snake.score);
  //canvas.setBestScore(population.bestSnake.score);
  //canvas.setFitness(rink.snake.fitness);
  //canvas.setGeneration(population.generation);
  //canvas.setRemainingMoves(rink.snake.remainingMoves);
  //canvas.setMutationRate(population.mutationRate);
  canvas.show(); //<>//

  rink.show();
  rink.food.show();

  snake.show();
  snake.move(rink);

  if (snake.isDead()) {
    snake = new Snake();
    snake.setInitialPosition(rink);
    snake.setBrain();

    rink.determineFreePositions(snake);
    rink.addFood();
  }
  //population.show(5);
  //population.setInitialSnakes();
}

void mousePressed() {
  if (canvas.saveButton.mouseAbove(mouseX, mouseY)) {
    //selectOutput("Save Snake Model", "fileSelectedOut");
    print("Save Snake Model");
    print("\n");
  }
  if (canvas.loadButton.mouseAbove(mouseX, mouseY)) {
    //selectInput("Load Snake Model", "fileSelectedIn");
    print("Load Snake Model");
    print("\n");
  }
  if (canvas.graphButton.mouseAbove(mouseX, mouseY)) {
    //graph = new EvolutionGraph();
    print("New graph");
    print("\n");
  }
  if (canvas.increaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
    //mutationRate += 0.5;
    print("MR ++");
    print("\n");
  }
  if (canvas.decreaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
    //mutationRate -= 0.5;
    print("MR --");
    print("\n");
  }
}

void keyPressed() {
  if (humanPlaying) {
    if (key == CODED) {
      switch(keyCode) {
      case LEFT:
        snake.head.moveLeft();
        break;
      case RIGHT:
        snake.head.moveRight();
        break;
      }
    }
  }
}
