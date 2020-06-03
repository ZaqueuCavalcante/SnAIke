public class Radar {

  private Vector distanceToFood;
  private Vector distanceToLeft;

  private color Color;

  Radar() {
    distanceToFood = new Vector();
    distanceToLeft = new Vector();

    Color = color(144, 238, 117);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void calculateDistanceToFood(Head head, Food food) {
    distanceToFood.x = food.getPosition().x - head.getPosition().x;
    distanceToFood.y = food.getPosition().y - head.getPosition().y;
    distanceToFood.z = sqrt(pow(distanceToFood.x, 2) + pow(distanceToFood.y, 2));
  }
  private float calculateDistanceToLeft(Vector velocity, Rink rink) {
    distanceToLeft.setSize(velocity.getSize());
    float newTheta = velocity.getTheta() - PI/2;
    distanceToLeft.setTheta(newTheta);

    boolean snakeVertically = cos(distanceToLeft.getTheta()) == 0;
    boolean snakeHorizontally = sin(distanceToLeft.getTheta()) == 0;

    //if () {

    //}

    boolean widthOut = (distanceToLeft.x < rink.getPosition().x) || (distanceToLeft.x > rink.getPosition().x + rink.getWidth());
    boolean heightOut = (distanceToLeft.y < rink.getPosition().y) || (distanceToLeft.y > rink.getPosition().y + rink.getHeight());
    return 0.0;

  }
  public void calculateDistanceToWalls(Head head, Rink rink) {
    //distanceToLeftWall = 0;
    //distanceToFronttWall = 0;
    //distanceToRightWall = 0;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    stroke(Color);
  }
}
