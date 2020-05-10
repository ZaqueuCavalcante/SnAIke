// Duas ou mais cobras competindo no mesmo ambiente.
// Uma pode matar a outra, se comer seu rabo.
// Adicionar obstáculos.

Screen screen;
Rink rink;

boolean humanPlaying = true;


void setup() {
  size(1200, 800);
  screen = new Screen(width, height);
  screen.setFPS(20);

  rink = new Rink();
  rink.setPosition(420, 20);
  rink.setSideSizes(800-2*20, 800-2*20);
  rink.setPixelSize(20);
  rink.setPixelPositions();

  rink.addFood();
  rink.addSnake();

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

  rink.snake.show();
  rink.food.show();
  rink.snake.move(rink);

  if (rink.snake.isDead()) {
    rink.addSnake();
  }
 //<>//
  //if (rink.snake.isDead()) {
  //  rink.addSnake();
  //}

  //int index = int(random(0, 4));
  //int[] values = {10, 6, 12, 42};
  //print(random(0, 255));
  //print('\n');
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
        rink.snake.moveLeft();
        break;
      case RIGHT:
        rink.snake.moveRight();
        break;
      }
    }
  }
}
