class Rink {

  int x;
  int y;
  int Width;
  int Height;

  Rink(int x_, int y_, int Width_, int Height_) {
    x = x_;
    y = y_;
    Width = Width_;
    Height = Height_;
  }

  void show() {
    stroke(255);
    rectMode(CORNER);
    rect(x, y, Width, Height);
  }
}
