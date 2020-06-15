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
  dashboard.getWeightPlot().setPoints(pop.getSnakes().get( pop.getBestSnakeIndex() ).getGenes()); // 
  dashboard.getScorePlot().addPoint(pop.getGeneration(), pop.getBestScore());
  canvas.show(dashboard);
  canvas.show(board);


  // Mostra os atores (Melhor cobra da população e maçã associada)
  //canvas.show(foodBasket.get( pop.getBestSnakeIndex() ));
  //canvas.show(pop.getSnakes().get( pop.getBestSnakeIndex() ));

  for (int c = 0; c < popSize; c++) {
    ASnake currentSnake = pop.getSnakes().get(c);
    AFood currentFood = foodBasket.get(c);
    if (currentSnake.isNotDead()) {
      canvas.show(currentFood);
      canvas.show(currentSnake);

      // Radar é usado e mostrado (para cada cobra da população)
      radar.calculateDistanceToLeft(currentSnake, board);
      radar.calculateDistanceToFront(currentSnake, board);
      radar.calculateDistanceToRight(currentSnake, board);
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
      //god.checksSnakeIsDead(currentSnake, board);
    }
  }

  //for (int c = 0; c < 10; c++) {
  //  int index = pop.ranking[c];
  //  ASnake currentSnake = pop.getSnakes().get(index);
  //  AFood currentFood = foodBasket.get(index);
  //  canvas.show(currentFood);
  //  canvas.show(currentSnake);
  //}

  if (pop.allSnakesIsDead()) {
    pop.updateRanking();
    pop.generateNewPopulation();

    for (int c = 0; c < popSize; c++) {
      //AFood food = foodBasket.get(c);
      ASnake snake = pop.getSnakes().get(c);
      god.setSnakePosition(snake, board);
      //god.setFoodPosition(food, board, snake);
      god.resetSnake(snake);
    }

    pop.updateGeneration();
  }

  // Quando o loop chega aqui, todas as cobras VIVAS da população terão andado UM pixel.
}

// Os métodos abaixo servem para monitorar os inputs do usuário (Mouse e Teclado).
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case LEFT:
      //snake.getHead().turnLeft();
      break;
    case RIGHT:
      //snake.getHead().turnRight();
      break;
    case UP:
      //snake.move();
      break;
    case DOWN:
      //snake.eat();
      break;
    }
  }
}
