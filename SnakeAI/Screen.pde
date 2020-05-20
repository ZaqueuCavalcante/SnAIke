class Screen {

  int Width;
  int Height;
  float FPS;
  float xDivisoryLine;

  PFont font;

  Button saveButton;
  Button loadButton;
  Button graphButton;
  Button increaseMutationRateButton;
  Button decreaseMutationRateButton;

  int score;
  int bestScore;
  float fitness;
  int generation;
  int remainingMoves;
  float mutationRate;

  Screen(int Width, int Height) { 
    this.Width = Width;
    this.Height = Height;
    setFont();
    setButtons();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setFPS(float FPS) {
    this.FPS = FPS;
    frameRate(FPS);
  }
  void setDivisoryLine(float xDivisoryLine) {
    this.xDivisoryLine = xDivisoryLine;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setFont() {
    font = createFont("agencyfb-bold.ttf", 32);
    textFont(font);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setButtons() {
    saveButton = new Button(50, 15, 100, 30, "Save");
    loadButton = new Button(150, 15, 100, 30, "Load");
    graphButton = new Button(250, 15, 100, 30, "Graph");
    increaseMutationRateButton = new Button(225, 170, 20, 20, "+");
    decreaseMutationRateButton = new Button(250, 170, 20, 20, "-");
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setScore(int score) {
    this.score = score;
  }
  void setBestScore(int bestScore) {
    this.bestScore = bestScore;
  }
  void setFitness(float fitness) {
    this.fitness = fitness;
  }
  void setGeneration(int generation) {
    this.generation = generation;
  }
  void setRemainingMoves(int remainingMoves) {
    this.remainingMoves = remainingMoves;
  }
  void setMutationRate(float mutationRate) {
    this.mutationRate = mutationRate;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void showDivisoryLine() {
    stroke(255);
    line(xDivisoryLine, 0, xDivisoryLine, Height);
  }
  void showButtons() {
    saveButton.show();
    loadButton.show();
    graphButton.show();
    increaseMutationRateButton.show();
    decreaseMutationRateButton.show();
  }
  void showParameters() {
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
  void show() {
    background(20);
    stroke(255);
    noFill();
    showDivisoryLine();
    showButtons();
    showParameters();
  }
}
