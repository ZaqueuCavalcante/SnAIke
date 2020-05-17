class Head {
  
  PVector position;
  Vector velocity;
  color Color;

  Head() {
    position = new PVector();
    velocity = new Vector();
    setColor(color(100));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPosition(float x, float y) {
    this.position.x = x;
    this.position.y = y;
  }
  void setVelocity() {
    
  }
  void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void move(float xVelocity, float yVelocity) {
    position.x += xVelocity;
    position.y += yVelocity;
  }
 // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    fill(Color);
    stroke(255);
    rectMode(CENTER);
    rect(position.x, position.y, PIXEL_SIDE_SIZE, PIXEL_SIDE_SIZE);
    //fill(255, 0, 0);
    //triangle(position.x, position.y-pixelSideSize/2,
    //         position.x-pixelSideSize/2, position.y,
    //         position.x+pixelSideSize/2, position.y);
  }
}
