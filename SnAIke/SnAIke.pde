import grafica.*;

final float PIXEL_SIZE = 100.0;
Canvas canvas;
Board board;        
Population population;
Basket basket;

void setup() {
  size(1800, 900);
  //frameRate(10);
  canvas = new Canvas();
  board = new Board();

  population = new Population(500);
  population.setGenerationLimit(1000000);
  population.setPositions(board);
  population.setBrains();
  population.setInitialRanking();

  basket = new Basket(population.size);
  board.addInitialFoods(population, basket);
}

void draw() {
  canvas.setBackground(20);
  canvas.showButtons();
  canvas.showDividingLines();
  canvas.showParameters(population);
  
  board.show();

  for (int i = 0; i < population.size; i++) {
    Snake currentSnake = population.snakes[i];
    Food currentFood = basket.foods[i];
    if (currentSnake.isNotDead()) {
      // currentSnake.show();population.ranking[0]
      population.snakes[population.ranking[0]].show();
      board.addFood(currentSnake, currentFood);
      // currentFood.show();
      basket.foods[population.ranking[0]].show();
      

      currentSnake.move(board, currentFood);
    }
  }
  population.setLiveSnakes();

  if (population.allSnakesIsDead()) {
    //population.snakes[0].brain.printWeights();
    population.updateRanking();
    population.generateNewPopulation();

    population.reliveSnakes();
    population.resetRemainingMoves();
    population.setPositions(board);
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
    g = new Graph();
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
