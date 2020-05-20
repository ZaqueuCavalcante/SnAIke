class Head {

  Vector position;
  Vector velocity;
  color Color;

  Head() {
    position = new Vector();
    velocity = new Vector();
    velocity.setSize(PIXEL_SIDE_SIZE);
    velocity.setTheta(3*PI/2);
    setColor(color(100));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPosition(float x, float y) {
    position.x = x;
    position.y = y;
    velocity.setOrigin(x, y);
  }
  void moveLeft() { 
    velocity.incrementTheta(-PI/2);
  }
  void moveRight() { 
    velocity.incrementTheta(PI/2);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void move() {
    position.x += velocity.size*int(cos(velocity.getTheta()));
    position.y += velocity.size*int(sin(velocity.getTheta()));
    velocity.setOrigin(position.x, position.y);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    fill(Color);
    stroke(255);
    rectMode(CENTER);
    rect(position.x, position.y, PIXEL_SIDE_SIZE, PIXEL_SIDE_SIZE);
    position.show();
    velocity.show();
  }
}
