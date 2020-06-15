PCanvas canvas;
import grafica.*;
PDashboard dashboard;

CGod god;

ABoard board;
// - - - 
int popSize;
CPopulation pop;
ArrayList<AFood> foodBasket;
AFood food;
ASnake snake;
// - - - 
RSnakeRadar radar;
CNeuralNetwork nn;

void setup() {
  size(1900, 1050);
  canvas = new PCanvas();
  dashboard = new PDashboard(this);

  god = new CGod();

  board = new ABoard();
  
  popSize = 1000;
  pop = new CPopulation(popSize);
  pop.setGenerationLimit(1000000);
  
  foodBasket = new ArrayList<AFood>();
  
  food = new AFood(475, 475);
  snake = new ASnake(-500, -500);
  god.setSnakePosition(snake, board);
  god.setFoodPosition(food, board, snake);
  
  
  radar = new RSnakeRadar();
  nn = new CNeuralNetwork(10);
}

void draw() {
  //frameRate(100);
  canvas.setBackground();
  canvas.showButtons();
  canvas.showDividingLines();
  //canvas.showParameters(population);
  //canvas.showController(population.getBestSnake());  // Mostra uma Rede Neural ou 3 Setas (<^>).
  //dashboard.getWeightPlot().setPoints(population.getBestSnake().getBrain().getLinks()); // 
  canvas.show(dashboard);
  canvas.show(board);





  // Mostra os atores (Melhor cobra da população e maçã associada)
  canvas.show(food);
  canvas.show(snake);

  // Radar é usado e mostrado (para cada cobra da população)
  radar.calculateDistanceToLeft(snake, board);
  radar.calculateDistanceToFront(snake, board);
  radar.calculateDistanceToRight(snake, board);
  radar.calculateDistanceToFood(snake, food);
  //canvas.show(radar);
  radar.normalizeDistances(snake, board);
  

  // Tomada de decisão, mudando o estado do atores.
  // Aqui entra o Controller humano ou da Rede Neural.
  nn.processAndMakeDecision(radar, snake);
  canvas.show(nn);  // Somente para a melhor cobra
  snake.move();

  // God check tudo que aconteceu no board.
  god.checksSnakeSelfCollide(snake);
  god.checksSnakeBoardCollide(snake, board);
  god.checksSnakeFoodCollide(snake, food, board);
  god.checksSnakeIsDead(snake, board);






  // Quando o loop chega aqui, todas as cobras VIVAS da população terão andado UM pixel.
}

// Os métodos abaixo servem para monitorar os inputs do usuário (Mouse e Teclado).
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case LEFT:
      snake.getHead().turnLeft();
      break;
    case RIGHT:
      snake.getHead().turnRight();
      break;
    case UP:
      snake.move();
      break;
    case DOWN:
      snake.eat();
      break;
    }
  }
}
