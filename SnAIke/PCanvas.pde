public class PCanvas {

  private PFont font;
  private PButton saveButton;
  private PButton loadButton;
  private PButton graphButton;
  private PButton increaseMutationRateButton;
  private PButton decreaseMutationRateButton;

  PCanvas() { 
    setFont();
    setButtons();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void setFont() {
    font = createFont("agencyfb-bold.ttf", 32);
    textFont(font);
  }
  private void setButtons() {
    saveButton = new PButton(50, 15, 100, 30, "Save");
    loadButton = new PButton(150, 15, 100, 30, "Load");
    graphButton = new PButton(250, 15, 100, 30, "Graph");
    increaseMutationRateButton = new PButton(225, 170, 20, 20, "+");
    decreaseMutationRateButton = new PButton(250, 170, 20, 20, "-");
  }
  public void setBackground() {
    background(20);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void showDividingLines() {
    stroke(255);
    line(400, 0, 400, height-350);
    line(0, 200, 400, 200);
    line(0, height-350, width, height-350);
    line(width/2.5, height-350, width/2.5, height);
  }
  public void showButtons() {
    saveButton.show();
    loadButton.show();
    graphButton.show();
    increaseMutationRateButton.show();
    decreaseMutationRateButton.show();
  }
  // Todos os métodos daqui pra baixo serão do tipo "public void show(Objeto objeto) {}".
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  //public void showParameters(Population population) {
  //  fill(150);
  //  textSize(20);
  //  textAlign(LEFT);
  //  text("SCORE : " + population.bestSnake.getScore(), 20, 60);
  //  text("BEST SCORE : " + population.getBestScore(), 180, 60); 
  //  text("LIVE SNAKES : " + population.getLiveSnakes() + "  /  " + population.getSize(), 20, 90);
  //  text("GENERATION : " + population.getGeneration() + "  /  " + population.getGenerationLimit(), 20, 120);
  //  text("REMAINING MOVES : " + population.bestSnake.getRemainingMoves(), 20, 150);
  //  text("MUTATION RATE : " + population.getMutationRate(), 20, 180);
  //}
  //public void showController(Snake snake) {
  //  snake.getController().show();
  //}
  public void show(PDashboard db) {//, Population pop) {
    //db.getScorePlot().setAxisLimits(0, pop.getGeneration()+1, 0, pop.getBestScore()+1);
    //db.getScorePlot().setAxisLimits(0, x, 0, x);
    //db.getScorePlot().setAxisInterval(x/500, x/500);
    //db.getScorePlot().addPoint(x, x);
    db.scorePlot.show();
    db.weightPlot.show();
  }

  public void show() {
  } 
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // Actors Objects show().
  public void show(ABoard board) {
    for (ZPixel pixel : board.getGrid()) {
      this.show(pixel);
    }
    noFill();
    stroke(255);
    rectMode(CORNER);
    rect(board.getPosition().getX(), board.getPosition().getY(), board.getWidth()-1, board.getHeight());
  } 
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // Z Objects show().
  public void show(ZVector2D vector) {
    push();
    stroke(255);
    fill(255);
    line(vector.getOrigin().x, vector.getOrigin().y, vector.getX(), vector.getY());
    PVector direction = new PVector(vector.getX() - vector.getOrigin().x, vector.getY() - vector.getOrigin().y);
    float tipSize = 8;
    translate(vector.getX(), vector.getY());
    rotate(direction.heading());
    triangle(-tipSize, tipSize/2, -tipSize, -tipSize/2, 0, 0);
    pop();
  }
  public void show(ZPixel pixel) {
    fill(pixel.getColor());
    stroke(pixel.getStroke());
    rectMode(CENTER);
    rect(pixel.getPosition().getX(), pixel.getPosition().getY(), pixel.getSize(), pixel.getSize());
    //this.show(pixel.getPosition());
    //this.show(pixel.getVelocity());
  }
}
