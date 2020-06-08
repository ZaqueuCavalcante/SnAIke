public class Radar {

  private Vector distanceToFood;
  private Vector distanceToLeft;
  private Vector distanceToFront;
  private Vector distanceToRight;

  private color Color;

  Radar() {
    distanceToFood = new Vector();
    distanceToLeft = new Vector();
    distanceToFront = new Vector();
    distanceToRight = new Vector();

    Color = color(144, 238, 117);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void calculateDistanceToFood(Head head, Food food) {
    distanceToFood.x = food.getPosition().x - head.getPosition().x;
    distanceToFood.y = food.getPosition().y - head.getPosition().y;
  }
  private boolean vectorInsideRink(Vector vector, Rink rink) {
    boolean tipInsideWidth = (vector.x > rink.getPosition().x) && (vector.x < rink.getPosition().x + rink.getWidth());
    boolean tipInsideHeight = (vector.y > rink.getPosition().y) && (vector.y < rink.getPosition().y + rink.getHeight());
    return (tipInsideWidth && tipInsideHeight);
  }
  private boolean vectorNotAboveBody(Vector vector, Body body) {
    for (Vector bodyPosition : body.getPosition()) {
      boolean tipInsideWidth = (vector.x > bodyPosition.x - PIXEL_SIZE/2) && (vector.x < bodyPosition.x + PIXEL_SIZE/2);
      boolean tipInsideHeight = (vector.y > bodyPosition.y - PIXEL_SIZE/2) && (vector.y < bodyPosition.y + PIXEL_SIZE/2);
      if (tipInsideWidth && tipInsideHeight) {
        return false;
      }
    }
    return true;
  }
  private void calculateDistanceTo(Vector direction, float thetaUpdate, Snake snake, Rink rink) {    
    direction.setOrigin(snake.head.getPosition().x, snake.head.getPosition().y);
    direction.setSize(PIXEL_SIZE);
    float newTheta = snake.head.velocity.getTheta() + thetaUpdate;
    direction.setTheta(newTheta);
    direction.updateTip();
    while (vectorInsideRink(direction, rink) && vectorNotAboveBody(direction, snake.body)) {
      float newSize = direction.getSize() + PIXEL_SIZE;
      direction.setSize(newSize);
      direction.updateTip();
    }
    direction.setSize(direction.getSize() - PIXEL_SIZE);
    direction.updateTip();
  }
  public void calculateDistanceToLeft(Snake snake, Rink rink) {
    calculateDistanceTo(distanceToLeft, -PI/2, snake, rink);
  }
  public void calculateDistanceToFront(Snake snake, Rink rink) {
    calculateDistanceTo(distanceToFront, 0, snake, rink);
  }
  public void calculateDistanceToRight(Snake snake, Rink rink) {
    calculateDistanceTo(distanceToRight, +PI/2, snake, rink);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    distanceToLeft.show();
    distanceToFront.show();
    distanceToRight.show();
    stroke(Color);
  }
}
