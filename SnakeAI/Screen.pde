class Screen {

  int Width;
  int Height;
  float FPS;  // Frames per second.
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

  Screen(int Width_, int Height_) { 
    Width = Width_;
    Height = Height_;
    setFont();
    setButtons();
  }

  void setFPS(float FPS_) {
    FPS = FPS_;
    frameRate(FPS);
  }
  void setDivisoryLine(float xDivisoryLine) {
    this.xDivisoryLine = xDivisoryLine;
  }

  void setFont() {
    font = createFont("agencyfb-bold.ttf", 32);
    textFont(font);
  }

  void setButtons() {
    saveButton = new Button(50, 15, 100, 30, "Save");
    loadButton = new Button(150, 15, 100, 30, "Load");
    graphButton = new Button(250, 15, 100, 30, "Graph");
    increaseMutationRateButton = new Button(225, 170, 20, 20, "+");
    decreaseMutationRateButton = new Button(250, 170, 20, 20, "-");
  }

  void setScore(int score_) {
    score = score_;
  }
  void setBestScore(int bestScore_) {
    bestScore = bestScore_;
  }
  void setFitness(float fitness_) {
    fitness = fitness_;
  }
  void setGeneration(int generation_) {
    generation = generation_;
  }
  void setRemainingMoves(int remainingMoves_) {
    remainingMoves = remainingMoves_;
  }
  void setMutationRate(float mutationRate_) {
    mutationRate = mutationRate_;
  }

  void setAppearance(int backgroundColor, int strokeColor) {
    background(backgroundColor);
    stroke(strokeColor);
    noFill();
  }
  void showVerticalLine() {
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
    setAppearance(20, 255);
    showVerticalLine();
    showButtons();
    showParameters();
  }
}
