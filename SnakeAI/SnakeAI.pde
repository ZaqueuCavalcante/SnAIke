final float PIXEL_SIZE = 25.0;
Canvas canvas;
Rink rink;        
Population population;
Basket basket;

void setup() {
  size(1800, 900);
  //frameRate(10);
  canvas = new Canvas();
  rink = new Rink(canvas);

  population = new Population(1200);
  population.setGenerationLimit(1000000);
  population.setPositions(rink);
  population.setBrains();
  population.setInitialRanking();

  basket = new Basket(population.size);
  rink.addInitialFoods(population, basket);
}

void draw() {
  //frameRate(fr);
  canvas.show();
  canvas.showParameters(population);
  //canvas.showBestSnakeBrain(population);
  rink.show();

  for (int i = 0; i < population.size; i++) {
    Snake currentSnake = population.snakes[i];
    Food currentFood = basket.foods[i];
    if (currentSnake.isNotDead()) {
      // currentSnake.show();population.ranking[0]
      population.snakes[population.ranking[0]].show();
      rink.addFood(currentSnake, currentFood);
      // currentFood.show();
      basket.foods[population.ranking[0]].show();
      

      currentSnake.move(rink, currentFood);
    }
  }

  if (population.allSnakesIsDead()) {
    //population.snakes[0].brain.printWeights();
    population.updateRanking();
    population.generateNewPopulation();

    population.reliveSnakes();
    population.resetRemainingMoves();
    population.setPositions(rink);
    population.updateGeneration();

    println("BestSnakeIndex = ", population.ranking[0]);
  }
  if (population.aboveGenerationLimit()) {
    noLoop();
  }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
void mousePressed() {
  if (canvas.saveButton.mouseAbove(mouseX, mouseY)) {
    selectOutput("Save Snake Model", "fileSelectedOut");
  }
  if (canvas.loadButton.mouseAbove(mouseX, mouseY)) {
    selectInput("Load Snake Model", "fileSelectedIn");
  }
  if (canvas.graphButton.mouseAbove(mouseX, mouseY)) {
    // graph = new Graph();
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
  Snake playerSnake = population.snakes[population.ranking[0]];
  if (key == CODED) {
    switch(keyCode) {
    case LEFT:
      playerSnake.head.turnLeft();
      break;
    case RIGHT:
      playerSnake.head.turnRight();
      break;
    }
  }
}
