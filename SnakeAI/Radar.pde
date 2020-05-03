class Radar {

  PVector originPoint;
  PVector destinyPoint;
  PVector distanceToDistinyPoint;  // x -> Horizontal distance; y -> Vertical distance; z -> Euclidean distance.
  color Color;

  Radar(PVector originPoint_, PVector destinyPoint_) {
    originPoint = originPoint_;
    destinyPoint = destinyPoint_;
    distanceToDistinyPoint = new PVector();
    Color = color(144, 238, 117);
  }

  void show() {
    stroke(Color);
    //strokeWeight(random(1, 2));
    line(originPoint.x, originPoint.y, destinyPoint.x, originPoint.y);
    line(destinyPoint.x, originPoint.y, destinyPoint.x, destinyPoint.y);
    //strokeWeight(1);
  }
  
  void changeDestinyPoint(PVector newDestinyPoint) {
    destinyPoint = newDestinyPoint;
  }
  
  PVector calculateDistance() {
    distanceToDistinyPoint.x = abs(destinyPoint.x - originPoint.x);
    distanceToDistinyPoint.y = abs(destinyPoint.y - originPoint.y);
    distanceToDistinyPoint.z = sqrt(pow(distanceToDistinyPoint.x, 2) + pow(distanceToDistinyPoint.y, 2));
    return distanceToDistinyPoint;
  }
}
