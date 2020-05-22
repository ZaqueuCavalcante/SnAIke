public class Canvas {

  private float xDivisoryLine;
  private PFont font;

  private Button saveButton;
  private Button loadButton;
  private Button graphButton;
  private Button increaseMutationRateButton;
  private Button decreaseMutationRateButton;

  private int score;
  private int bestScore;
  private float fitness;
  private int generation;
  private int remainingMoves;
  private float mutationRate;

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
  public void setScore(int score) {
    this.score = score;
  }
  public void setBestScore(int bestScore) {
    this.bestScore = bestScore;
  }
  public void setFitness(float fitness) {
    this.fitness = fitness;
  }
  public void setGeneration(int generation) {
    this.generation = generation;
  }
  public void setRemainingMoves(int remainingMoves) {
    this.remainingMoves = remainingMoves;
  }
  public void setMutationRate(float mutationRate) {
    this.mutationRate = mutationRate;
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
  public void showParameters() {
    fill(150);
    textSize(20);
    textAlign(LEFT);
    text("SCORE : " + score, 20, 60);
    text("BEST SCORE : " + bestScore, 180, 60);
    text("FITNESS : " + fitness, 20, 90);
    text("GENERATION : " + generation, 20, 120);
    text("REMAINING MOVES : " + remainingMoves, 20, 150);
    text("MUTATION RATE : " + mutationRate, 20, 180);
  }
  public void show() {
    background(20);
    stroke(255);
    noFill();
    showDivisoryLine();
    showButtons();
    showParameters();
  }
}
