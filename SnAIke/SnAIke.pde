PCanvas canvas;
import grafica.*;
PDashboard dashboard;

CGod god;

ABoard board;
// - - - 
int popSize;
CPopulation pop;
ArrayList<AFood> foodBasket;
// - - - 
RSnakeRadar radar;
CNeuralNetwork nn;

boolean showAllPop = false;

void setup() {
  size(1900, 1050);
  canvas = new PCanvas();
  dashboard = new PDashboard(this);

  god = new CGod();
  board = new ABoard();

  popSize = 8001;
  pop = new CPopulation(popSize);
  pop.setGenerationLimit(1000000);
  foodBasket = new ArrayList<AFood>();

  for (int c = 0; c < popSize; c++) {
    AFood food = new AFood(475, 475);
    ASnake snake = new ASnake(-500, -500);
    god.setSnakePosition(snake, board);
    god.setFoodPosition(food, board, snake);
    foodBasket.add(food);
    pop.getSnakes().add(snake);
  }

  pop.setInitialRanking();


  radar = new RSnakeRadar();
  nn = new CNeuralNetwork(10);
}

void draw() {
  //frameRate(100);
  canvas.setBackground();
  canvas.showButtons();
  canvas.showDividingLines();
  canvas.showParameters(pop);
  //canvas.showController(population.getBestSnake());  // Mostra uma Rede Neural ou 3 Setas (<^>).
  dashboard.getWeightPlot().setPoints(pop.getSnakes().get( 0 ).getGenes()); // 
  //dashboard.getScorePlot().addPoint(pop.getGeneration(), pop.snakes.get(pop.ranking[0]).getScore());//pop.getBestScore());
  canvas.show(dashboard);
  canvas.show(board);

  if (pop.getLiveSnakesNumber() < 100) {
    showAllPop = true;
  }


  // Mostra os atores (Melhor cobra da população e maçã associada)
  if (!showAllPop) {
    canvas.show(foodBasket.get( 0 ));
    canvas.show(pop.getSnakes().get( 0 ));
  }

  for (int c = 0; c < popSize; c++) {
    ASnake currentSnake = pop.getSnakes().get(c);
    AFood currentFood = foodBasket.get(c);
    if (currentSnake.isNotDead()) {
      if (showAllPop) {
        canvas.show(currentFood);
        canvas.show(currentSnake);
      }

      // Radar é usado e mostrado (para cada cobra da população)
      radar.calculateDistanceToLeft(currentSnake, board);
      radar.calculateDistanceToUp(currentSnake, board);
      radar.calculateDistanceToRight(currentSnake, board);
      radar.calculateDistanceToDown(currentSnake, board);
      radar.calculateDistanceToFood(currentSnake, currentFood);
      //canvas.show(radar);
      radar.normalizeDistances(currentSnake, board);

      // Tomada de decisão, mudando o estado do atores.
      // Aqui entra o Controller humano ou da Rede Neural.
      nn.processAndMakeDecision(radar, currentSnake);
      //if (c == pop.getBestSnakeIndex()) {
      //  canvas.show(nn);  // Somente para a melhor cobra
      //}
      currentSnake.move();

      // God check tudo que aconteceu no board.
      god.checksSnakeSelfCollide(currentSnake);
      god.checksSnakeBoardCollide(currentSnake, board);
      god.checksSnakeFoodCollide(currentSnake, currentFood, board);
      god.checksSnakeRemainingMoves(currentSnake);
    }
  }

  if (pop.allSnakesIsDead()) {
    pop.updateRanking();
    dashboard.getScorePlot().addPoint(pop.getGeneration(), pop.getBestScore());
    pop.generateNewPopulation();

    for (int c = 0; c < popSize; c++) {
      ASnake snake = pop.getSnakes().get(c);
      god.setSnakePosition(snake, board);
      god.resetSnake(snake);
    }

    pop.updateGeneration();
    showAllPop = false;
  }

  // Quando o loop chega aqui, todas as cobras VIVAS da população terão andado UM pixel.
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
      //case RIGHT:
      //  pop.getSnakes().get(0).head.pointToRight();
      //  break;
      //case DOWN:
      //  pop.getSnakes().get(0).head.pointToDown();
      //  break;
      //case LEFT:
      //  pop.getSnakes().get(0).head.pointToLeft();
      //  break;
      //case UP:
      //  pop.getSnakes().get(0).head.pointToUp();
      //  break;
      //case CONTROL:
      //  pop.getSnakes().get(0).move();
      //  break;
    case LEFT:
      for (int c = 50; c < popSize; c++) {
        pop.getSnakes().get(c).die();
      }
      break;
    case RIGHT:
      for (int c = 500; c < popSize; c++) {
        pop.getSnakes().get(c).die();
      }
      break;
    case UP:
      for (int c = 0; c < popSize; c++) {
        pop.getSnakes().get(c).die();
      }
      break;
    case DOWN:
      showAllPop = !showAllPop;
      break;
    }
  }
}
