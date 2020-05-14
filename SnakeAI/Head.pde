class Head {
  
  PVector position;
  float pixelSideSize;
  color Color;

  Head() {
    position = new PVector();
    setColor(color(100));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPosition(float x_, float y_) {
    position.x = x_;
    position.y = y_;
  }
  void setPixelSideSize(float sideSize_) {
    pixelSideSize = sideSize_;
  }
  void setColor(color Color_) {
    Color = Color_;
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
    rect(position.x, position.y, pixelSideSize, pixelSideSize);
    //fill(255, 0, 0);
    //triangle(position.x, position.y-pixelSideSize/2,
    //         position.x-pixelSideSize/2, position.y,
    //         position.x+pixelSideSize/2, position.y);
  }
}
