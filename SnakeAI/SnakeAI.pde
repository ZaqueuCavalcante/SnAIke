// Duas ou mais cobras competindo no mesmo ambiente. //<>// //<>// //<>// //<>//
// Uma pode matar a outra, se comer seu rabo.
// Adicionar obstáculos. Pedras. Análogo a classe Food.
// Depois que a AI estiver treinada, colocar as coordenadas da comida iguais as do mouse;
// Tentar fugir dela.

final float PIXEL_SIZE = 40.0;  // Length of the side of the elementary square that forms the snake, the food and the rink.
final int POP_SIZE = 5;
Canvas canvas;
Rink rink;

Population population;

boolean humanPlaying = true;

void setup() {
  size(1800, 920);
  canvas = new Canvas(width, height);
  canvas.setFPS(15);

  rink = new Rink();
  rink.setPosition(canvas);
  rink.setSideSizes(canvas);
  rink.setPixelPositions();

  population = new Population(POP_SIZE);
  population.setInitialSnakes(rink);
  population.setInitialRanking();

  for (Snake snake : population.snakes) {
    rink.determineFreePositions(snake);
    rink.addFood();
  }
}

void draw() {
  //canvas.setScore(rink.snake.score);
  //canvas.setBestScore(population.bestSnake.score);
  //canvas.setFitness(rink.snake.fitness);
  //canvas.setGeneration(population.generation);
  //canvas.setRemainingMoves(rink.snake.remainingMoves);
  //canvas.setMutationRate(population.mutationRate);
  canvas.show();

  rink.show();

  for (Snake snake : population.snakes) {
    rink.food.show();

    snake.show();
    snake.move(rink);
  }

  if (population.allSnakesIsDead()) {
    population = new Population(POP_SIZE);
    population.setInitialSnakes(rink);
    population.setInitialRanking();

    for (Snake snake : population.snakes) {
      rink.determineFreePositions(snake);
      rink.addFood();
    }
  }
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
          population.snakes[0].head.moveLeft();
          break;
        case RIGHT:
          population.snakes[0].head.moveRight();
          break;
        }
      }
    }
  }
