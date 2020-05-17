class Vector {
  
  PVector originPoint;
  PVector destinyPoint;

  Vector() {
    this.originPoint = new PVector(0, 0);
    this.destinyPoint = new PVector(100, 100);
  }
  
  void setDestinyPoint(float x, float y) {
    this.destinyPoint.x = x;
    this.destinyPoint.y = y;
  }
  
  void show() {
    stroke(255);
    line(this.originPoint.x, this.originPoint.y, this.destinyPoint.x, this.destinyPoint.y);
  }
}
