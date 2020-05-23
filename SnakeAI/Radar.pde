public class Radar {

  private Vector headPosition;
  private Vector distanceToFood;

  private float distanceToLeftWall;
  private float distanceToFronttWall;
  private float distanceToRightWall;

  private color Color; 

  Radar() {
    headPosition = new Vector();
    distanceToFood = new Vector();

    Color = color(144, 238, 117);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setHeadPosition(Head head) {
    this.headPosition.x = head.position.x;
    this.headPosition.y = head.position.y;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void calculateDistanceToFood(Food food) {
    distanceToFood.x = food.position.x - headPosition.x;
    distanceToFood.y = food.position.y - headPosition.y;
    distanceToFood.z = sqrt(pow(distanceToFood.x, 2) + pow(distanceToFood.y, 2));
  }
  public void calculateDistanceToWalls(Head head, Rink rink) {
    
    
    distanceToLeftWall;
    distanceToFronttWall;
    distanceToRightWall;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    stroke(Color);
  }
}
