// Duas ou mais cobras competindo no mesmo ambiente. //<>//
// Uma pode matar a outra, se comer seu rabo.
// Adicionar obstáculos. Pedras.
// Depois que a AI estiver treinada, colocar as coordenadas da comida iguais as do mouse;
// Tentar fugir dela.

final float PIXEL_SIDE_SIZE = 40.0;  // Length of the side of the elementary square that forms the snake, the food and the rink.

Screen screen;

Rink rink;

Population population;

boolean humanPlaying = true;

void setup() {
  size(1800, 920);
  screen = new Screen(width, height);
  screen.setFPS(10);
  screen.setDivisoryLine(440);

  rink = new Rink();
  rink.setPosition(screen.xDivisoryLine + PIXEL_SIDE_SIZE, PIXEL_SIDE_SIZE);
  rink.setSideSizes(width - screen.xDivisoryLine -2*PIXEL_SIDE_SIZE, height-2*PIXEL_SIDE_SIZE);
  rink.setPixelPositions();
  
  rink.addFood(); //<>//
  rink.addSnake();
  
  population = new Population(10);
}

void draw() {
  screen.setScore(rink.snake.score);
  //screen.setBestScore(population.bestSnake.score);
  screen.setFitness(rink.snake.fitness);
  //screen.setGeneration(population.generation);
  screen.setRemainingMoves(rink.snake.remainingMoves);
  //screen.setMutationRate(population.mutationRate);
  screen.show();

  rink.show();
  rink.showPixelStrokes();

  rink.snake.brain.links.get(3).Color = color(255, 0, 0);
  
  rink.snake.show();
  rink.food.show();
  rink.snake.move(rink);

  if (rink.snake.isDead()) { //<>//
    rink.addSnake();
  }
  
  population.show(5);
  population.setInitialSnakes();
}

void mousePressed() {
  if (screen.saveButton.mouseAbove(mouseX, mouseY)) {
    //selectOutput("Save Snake Model", "fileSelectedOut");
    print("Save Snake Model");
    print("\n");
  }
  if (screen.loadButton.mouseAbove(mouseX, mouseY)) {
    //selectInput("Load Snake Model", "fileSelectedIn");
    print("Load Snake Model");
    print("\n");
  }
  if (screen.graphButton.mouseAbove(mouseX, mouseY)) {
    //graph = new EvolutionGraph();
    print("New graph");
    print("\n");
  }
  if (screen.increaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
    //mutationRate += 0.5;
    print("MR ++");
    print("\n");
  }
  if (screen.decreaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
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
        rink.snake.head.moveLeft();
        break;
      case RIGHT:
        rink.snake.head.moveRight();
        break;
      }
    }
  }
}
