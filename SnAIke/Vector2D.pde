class Vector2D {

  PVector origin;
  float size;
  float angle;  // Angle made with the x axis, measured clockwise.
  float x, y;  // Coordinates of Vector2D tip.
  
  Vector2D() {
    origin = new PVector();
  }
  Vector2D(float x, float y) {
    origin = new PVector();
    this.x = x;
    this.y = y;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setOrigin(float x, float y) {
    origin.x = x;
    origin.y = y;
  }
  void setSize(float newSize) {
    size = newSize;
  }
  float getSize() {
    return size;
  }
  void setAngle(float newAngle) {
    angle = newAngle;
  }
  void incrementAngle(float angularIncrement) {
    angle += angularIncrement;
  }
  float getAngle() {
    return angle;
  }
  void updateTip() {
    x = origin.x + size*cos(angle);
    y = origin.y + size*sin(angle);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    push();
    stroke(255);
    fill(255);
    line(origin.x, origin.y, x, y);
    PVector direction = new PVector(x - origin.x, y - origin.y);
    float tipSize = 8;
    translate(x, y);
    rotate(direction.heading());
    triangle(-tipSize, tipSize/2, -tipSize, -tipSize/2, 0, 0);
    pop();
  }
}
