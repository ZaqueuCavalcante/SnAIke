public class Canvas {

  private float xDivisoryLine;
  private PFont font;

  private Button saveButton;
  private Button loadButton;
  private Button graphButton;
  private Button increaseMutationRateButton;
  private Button decreaseMutationRateButton;

  Canvas() { 
    setFont();
    setButtons();
    setDivisoryLine(400);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setDivisoryLine(float xDivisoryLine) {
    this.xDivisoryLine = xDivisoryLine;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setFont() {
    font = createFont("agencyfb-bold.ttf", 32);
    textFont(font);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setButtons() {
    saveButton = new Button(50, 15, 100, 30, "Save");
    loadButton = new Button(150, 15, 100, 30, "Load");
    graphButton = new Button(250, 15, 100, 30, "Graph");
    increaseMutationRateButton = new Button(225, 170, 20, 20, "+");
    decreaseMutationRateButton = new Button(250, 170, 20, 20, "-");
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void showDivisoryLine() {
    stroke(255);
    line(xDivisoryLine, 0, xDivisoryLine, height);
  }
  public void showButtons() {
    saveButton.show();
    loadButton.show();
    graphButton.show();
    increaseMutationRateButton.show();
    decreaseMutationRateButton.show();
  }
  public void showParameters(Population population) {
    fill(150);
    textSize(20);
    textAlign(LEFT);
    Snake bestSnake = population.snakes[0];
    text("SCORE : " + bestSnake.score, 20, 60);
    text("BEST SCORE : " + population.getBestScore(), 180, 60); 
    text("FITNESS : " + bestSnake.fitness, 20, 90);
    text("GENERATION : " + population.getGeneration(), 20, 120);
    text("REMAINING MOVES : " + bestSnake.remainingMoves, 20, 150);
    text("MUTATION RATE : " + population.getMutationRate(), 20, 180);
  }
  public void show() {
    background(20);
    stroke(255);
    noFill();
    showDivisoryLine();
    showButtons();
  }
}
