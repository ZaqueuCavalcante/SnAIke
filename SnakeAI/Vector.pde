class Vector {

  PVector originPoint;
  float x;
  float y;

  Vector() {
    this.originPoint = new PVector(0, 0);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setOriginPoint(float x, float y) {
    this.originPoint.x = x;
    this.originPoint.y = y;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    fill(255);
    stroke(255);
    line(this.originPoint.x, this.originPoint.y, this.x, this.y);
    pushMatrix();
    translate(this.x, this.y);
    float angle = atan2(this.originPoint.x - this.x, this.y - this.originPoint.y);
    rotate(angle);
    triangle(0, 0, -50, -120, 50, -120);
    popMatrix();
  }
}
