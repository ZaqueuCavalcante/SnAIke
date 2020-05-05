class Rink {

  int x;
  int y;
  int Width;
  int Height;
  int pixelSize;  // Length of the side of the elementary square that forms the snake, the food and the rink.
  Food food;

  Rink(int x_, int y_, int Width_, int Height_, int pixelSize_) {
    x = x_;
    y = y_;
    Width = Width_;
    Height = Height_;
    pixelSize = pixelSize_;
    addFood();
  }
  
  void addFood() {
    food = new Food(this);
  }

  void show() {
    noFill();
    stroke(255);
    rectMode(CORNER);
    rect(x, y, Width, Height);
  }
}
