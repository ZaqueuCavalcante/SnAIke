PCanvas canvas;
import grafica.*;
PDashboard dashboard;

ABoard board;

void setup() {
  size(1900, 1050);
  canvas = new PCanvas();
  dashboard = new PDashboard(this);
  
  board = new ABoard();
}

void draw() {
  canvas.setBackground();
  canvas.showButtons();
  canvas.showDividingLines();
  //canvas.showParameters(population);
  //canvas.showController(population.getBestSnake());  // Mostra uma Rede Neural ou 3 Setas (<^>).
  //dashboard.getWeightPlot().setPoints(population.getBestSnake().getBrain().getLinks()); // 
  canvas.show(dashboard); 
  canvas.show(board);
  


  // Quando o loop chega aqui, todas as cobras VIVAS da população andaram UM pixel.
}

// Os métodos abaixo servem para monitorar os inputs dos usuário (Mouse e Teclado).

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
    case LEFT:
      //p.turnLeft();
      break;
    case RIGHT:
      //p.turnRight();
      break;
    case UP:
      //p.move();
      break;
    }
  }
}
