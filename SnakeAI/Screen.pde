class Screen {

  int Width;
  int Height;
  int pixelSize;  // Length of the side of the elementary square that forms the snake, the food and the rink.
  int FPS;  // Frames per second.
  int xVerticalLine;

  PFont font;
  
  Button saveButton;
  Button loadButton;
  Button graphButton;
  Button increaseMutationRateButton;
  Button decreaseMutationRateButton;
  
  

  Screen(int Width_, int Height_, int pixelSize_, int xVerticalLine_, int FPS_) { 
    Width = Width_;
    Height = Height_;
    pixelSize = pixelSize_;
    xVerticalLine = xVerticalLine_;

    FPS = FPS_;
    frameRate(FPS);

    font = createFont("agencyfb-bold.ttf", 32);
    textFont(font);
    
    saveButton = new Button(50, 15, 100, 30, "Save");
    loadButton = new Button(150, 15, 100, 30, "Load");
    graphButton = new Button(250, 15, 100, 30, "Graph");
    increaseMutationRateButton = new Button(340, 85, 20, 20, "+");
    decreaseMutationRateButton = new Button(365, 85, 20, 20, "-");
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
    graphButton.show();
    loadButton.show();
    saveButton.show();
    increaseMutationRateButton.show();
    decreaseMutationRateButton.show();
  }
}
