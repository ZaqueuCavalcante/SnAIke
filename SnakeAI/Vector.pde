class Vector {

  PVector origin;
  float size;
  float theta;  // Angle made with the x axis, measured clockwise.
  float x;
  float y;
  float z;

  Vector() {
    origin = new PVector();
  }
  Vector(float x, float y) {
    origin = new PVector();
    this.x = x;
    this.y = y;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setOrigin(float x, float y) {
    origin.x = x;
    origin.y = y;
    updateTip();
  }
  void setSize(float newSize) {
    size = newSize;
  }
  float getSize() {
    return size;
  }
  void setTheta(float newTheta) {
    theta = newTheta;
  }
  void incrementTheta(float angularIncrement) {
    theta += angularIncrement;
  }
  float getTheta() {
    return theta;
  }
  void updateTip() {
    x = origin.x + size*cos(theta);
    y = origin.y + size*sin(theta);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    fill(255);
    stroke(255);
    line(origin.x, origin.y, x, y);
    pushMatrix();
    translate(x, y);
    float angle = atan2(origin.x - x, y - origin.y);
    rotate(angle);
    triangle(0, 0, -5, -12, 5, -12);
    popMatrix();
  }
}
