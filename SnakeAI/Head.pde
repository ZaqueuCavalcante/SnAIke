class Head {

  float x, y;
  color Color;

  Head() {
    x = screen.xVerticalLine + screen.pixelSize + screen.pixelSize/2 + rink.Width/2;
    y = screen.pixelSize + screen.pixelSize/2 + rink.Height/2;
    Color = color(100);
  }

  void move() {
    x += snake.xVelocity;
    y += snake.yVelocity;
  }

  void show() {
    fill(Color);
    stroke(255);
    rectMode(CENTER);
    rect(x, y, screen.pixelSize, screen.pixelSize);
  }
}
