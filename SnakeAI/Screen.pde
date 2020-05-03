class Screen {

  int Width;
  int Height;
  int FPS;  // Frames per second.
  int xVerticalLine;

  PFont font;

  Button saveButton;
  Button loadButton;
  Button graphButton;
  Button increaseMutationRateButton;
  Button decreaseMutationRateButton;

  Screen(int Width_, int Height_, int xVerticalLine_, int FPS_) { 
    Width = Width_;
    Height = Height_;
    xVerticalLine = xVerticalLine_;

    FPS = FPS_;
    frameRate(FPS);

    font = createFont("agencyfb-bold.ttf", 32);
    textFont(font);

    saveButton = new Button(50, 15, 100, 30, "Save");
    loadButton = new Button(150, 15, 100, 30, "Load");
    graphButton = new Button(250, 15, 100, 30, "Graph");
    increaseMutationRateButton = new Button(225, 170, 20, 20, "+");
    decreaseMutationRateButton = new Button(250, 170, 20, 20, "-");
  }

  void setAppearance(int backgroundColor, int strokeColor) {
    background(backgroundColor);
    stroke(strokeColor);
    noFill();
  }

  void drawVerticalLine() {
    stroke(255);
    line(xVerticalLine, 0, xVerticalLine, Height);
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
    text("SCORE : " + snake.score, 20, 60);
    text("BEST SCORE : ", 20, 90);
    text("GENERATION : ", 20, 120);
    text("REMAINING MOVES : " + snake.remainingMoves, 20, 150);
    text("MUTATION RATE : ", 20, 180);
  }
}
