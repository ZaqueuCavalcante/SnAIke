class Radar {

  PVector originPoint;
  PVector destinyPoint;
  PVector distanceToDistinyPoint;  // x -> Horizontal distance; y -> Vertical distance; z -> Euclidean distance.

  color Color;

  Radar() {
    originPoint = new PVector();
    destinyPoint = new PVector();
    distanceToDistinyPoint = new PVector();

    Color = color(144, 238, 117);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setOriginPoint(PVector originPoint_) {
    originPoint = originPoint_;
  }
  void setDestinyPoint(PVector destinyPoint_) {
    destinyPoint = destinyPoint_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void calculateDistance() {
    distanceToDistinyPoint.x = destinyPoint.x - originPoint.x;
    distanceToDistinyPoint.y = destinyPoint.y - originPoint.y;
    distanceToDistinyPoint.z = sqrt(pow(distanceToDistinyPoint.x, 2) + pow(distanceToDistinyPoint.y, 2));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    stroke(Color);
    line(originPoint.x, originPoint.y, destinyPoint.x, originPoint.y);
    line(destinyPoint.x, originPoint.y, destinyPoint.x, destinyPoint.y);
  }
}
