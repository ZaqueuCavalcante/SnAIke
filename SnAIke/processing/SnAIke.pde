PCanvas canvas;

CMaster master;
ABoard board;
 
CPopulation pop;
ArrayList<AFood> foodBasket;

RSnakeRadar radar;
CNeuralNetwork nn;

void setup() {

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
      nn.processDataAndMakeDecision(radar, currentSnake);
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
