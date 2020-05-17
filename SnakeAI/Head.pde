class Head {

  PVector position;
  float theta;
  Vector velocity;
  color Color;

  Head() {
    position = new PVector();
    this.setTheta(3*PI/2);
    velocity = new Vector();
    setColor(color(100));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPosition(float x, float y) {
    this.position.x = x;
    this.position.y = y;
  }
  void setTheta(float newTheta) {
    theta += newTheta;
  }
  float getTheta() {
    return theta;
  }
  void setVelocity() {
    velocity.setOriginPoint(this.position.x, this.position.y);
    velocity.x = PIXEL_SIDE_SIZE*int(cos(getTheta()));
    velocity.y = PIXEL_SIDE_SIZE*int(sin(getTheta()));
  }
  void moveLeft() { 
    setTheta(-PI/2);
    setVelocity();
  }
  void moveRight() { 
    setTheta(PI/2);
    setVelocity();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void move() {
    this.setVelocity();
    position.x += velocity.x;
    position.y += velocity.y;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    fill(Color);
    stroke(255);
    rectMode(CENTER);
    rect(position.x, position.y, PIXEL_SIDE_SIZE, PIXEL_SIDE_SIZE);
    
    velocity.show();
    
    //fill(255, 0, 0);
    //triangle(position.x, position.y-pixelSideSize/2,
    //         position.x-pixelSideSize/2, position.y,
    //         position.x+pixelSideSize/2, position.y);
  }
}
