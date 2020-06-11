public class Canvas {

  private PFont font;
  private Button saveButton;
  private Button loadButton;
  private Button graphButton;
  private Button increaseMutationRateButton;
  private Button decreaseMutationRateButton;

  Canvas() { 
    setFont();
    setButtons();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void setFont() {
    font = createFont("agencyfb-bold.ttf", 32);
    textFont(font);
  }
  private void setButtons() {
    saveButton = new Button(50, 15, 100, 30, "Save");
    loadButton = new Button(150, 15, 100, 30, "Load");
    graphButton = new Button(250, 15, 100, 30, "Graph");
    increaseMutationRateButton = new Button(225, 170, 20, 20, "+");
    decreaseMutationRateButton = new Button(250, 170, 20, 20, "-");
  }
  public void setBackground(int bgColor) {
    background(bgColor);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void showDividingLines() {
    stroke(255);
    line(400, 0, 400, height);
    line(0, 200, 400, 200);
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
    text("SCORE : " + population.bestSnake.getScore(), 20, 60);
    text("BEST SCORE : " + population.getBestScore(), 180, 60); 
    text("LIVE SNAKES : " + population.getLiveSnakes() + "  /  " + population.getSize(), 20, 90);
    text("GENERATION : " + population.getGeneration() + "  /  " + population.getGenerationLimit(), 20, 120);
    text("REMAINING MOVES : " + population.bestSnake.getRemainingMoves(), 20, 150);
    text("MUTATION RATE : " + population.getMutationRate(), 20, 180);
  }
  public void showController(Snake snake) {
    snake.getController().show();
  }
}
