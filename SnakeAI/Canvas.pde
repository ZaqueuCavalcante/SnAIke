public class Canvas {

  private PFont font;
  private float xDivisoryLine;

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
  private void setFont() {
    font = createFont("agencyfb-bold.ttf", 32);
    textFont(font);
  }
  private void setDivisoryLine(float xDivisoryLine) {
    this.xDivisoryLine = xDivisoryLine;
  }
  private void setButtons() {
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
    text("SCORE : " + bestSnake.getScore(), 20, 60);
    text("BEST SCORE : " + population.getBestScore(), 180, 60); 
    text("FITNESS : " + bestSnake.getFitness(), 20, 90);
    text("GENERATION : " + population.getGeneration(), 20, 120);
    text("REMAINING MOVES : " + bestSnake.getRemainingMoves(), 20, 150);
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