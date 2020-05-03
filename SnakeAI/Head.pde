class Head {

  PVector position;
  color Color;

  Head() {
    position = new PVector();
    position.x = screen.xVerticalLine + rink.pixelSize + rink.pixelSize/2 + rink.Width/2;
    position.y = rink.pixelSize + rink.pixelSize/2 + rink.Height/2;
    Color = color(100);
  }

  void move() {
    position.x += snake.velocity.x;
    position.y += snake.velocity.y;
  }

  void show() {
    fill(Color);
    stroke(255);
    rectMode(CENTER);
    rect(position.x, position.y, rink.pixelSize, rink.pixelSize);
  }
}
