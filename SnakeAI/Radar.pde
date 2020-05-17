class Radar {

  PVector headPosition;
  PVector distanceToFood;

  float distanceToLeftWall;
  float distanceToFronttWall;
  float distanceToRightWall;

  color Color; 

  Radar() {
    headPosition = new PVector();
    distanceToFood = new PVector();

    Color = color(144, 238, 117);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setHeadPosition(Head head) {
    this.headPosition.x = head.position.x;
    this.headPosition.y = head.position.y;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void calculateDistanceToFood(Food food) {
    distanceToFood.x = food.position.x - headPosition.x;
    distanceToFood.y = food.position.y - headPosition.y;
    distanceToFood.z = sqrt(pow(distanceToFood.x, 2) + pow(distanceToFood.y, 2));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    stroke(Color);
  }
}
