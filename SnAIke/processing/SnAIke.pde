PCanvas canvas;
import grafica.*;
PDashboard dashboard;

CMaster master;
ABoard board;
 
CPopulation pop;
ArrayList<AFood> foodBasket;

RSnakeRadar radar;
CNeuralNetwork nn;

void setup() {
  size(1900, 1050);
  canvas = new PCanvas();
  dashboard = new PDashboard(this);

  master = new CMaster();
  board = new ABoard();

  pop = new CPopulation(1);
  pop.setGenerationLimit(1000);
  foodBasket = new ArrayList<AFood>();

  radar = new RSnakeRadar();
  nn = new CNeuralNetwork(8);

  master.setInitialSnakesAndFoods(board, pop, foodBasket, nn);
}

void draw() {
  canvas.setBackground();
  canvas.showButtons();
  canvas.showDividingLines();
  canvas.show(pop);

  dashboard.getWeightPlot().setPoints(pop.getSnakes().get( 0 ).getGenes()); 

  canvas.show(dashboard);
  canvas.show(board);

  canvas.show(pop, foodBasket);

  for (int c = 0; c < pop.getSize(); c++) {
    ASnake currentSnake = pop.getSnakes().get(c);
    AFood currentFood = foodBasket.get(c);
    if (currentSnake.isNotDead()) {
      radar.calculateAndNormalizeDistances(board, currentSnake, currentFood);
      //nn.processDataAndMakeDecision(radar, currentSnake);
      master.checkSnakeStatus(board, currentSnake, currentFood);
    }
  }

  if (pop.allSnakesIsDead()) {
    pop.updateRanking();
    dashboard.getScorePlot().addPoint(pop.getGeneration(), pop.getBestScore());
    pop.generateNewPopulation();
    master.resetPopulation(board, pop);
    pop.updateGeneration();
  }
}

// Os métodos abaixo servem para monitorar os inputs do usuário (Mouse e Teclado).
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
    pop.updateMutationRate(+5.0);
  }
  if (canvas.decreaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
    pop.updateMutationRate(-5.0);
  }
}
void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
      case RIGHT:
        pop.getSnakes().get(0).head.pointToRight();
        break;
      case DOWN:
        pop.getSnakes().get(0).head.pointToDown();
        break;
      case LEFT:
        pop.getSnakes().get(0).head.pointToLeft();
        break;
      case UP:
        pop.getSnakes().get(0).head.pointToUp();
        break;
      case CONTROL:
        pop.getSnakes().get(0).move();
        break;
    }
  }
}
