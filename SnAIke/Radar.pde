public class Radar {

  private Vector2D distanceToFood;
  private Vector2D distanceToLeft;
  private Vector2D distanceToFront;
  private Vector2D distanceToRight;

  private color Color;

  Radar() {
    distanceToFood = new Vector2D();
    distanceToLeft = new Vector2D();
    distanceToFront = new Vector2D();
    distanceToRight = new Vector2D();

    Color = color(144, 238, 117);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void calculateDistanceToFood(Head head, Food food) {
    distanceToFood.x = food.getPosition().x - head.getPosition().x;
    distanceToFood.y = food.getPosition().y - head.getPosition().y;
  }
  private boolean vectorInsideBoard(Vector2D vector, Board board) {
    boolean tipInsideWidth = (vector.x > board.getPosition().x) && (vector.x < board.getPosition().x + board.getWidth());
    boolean tipInsideHeight = (vector.y > board.getPosition().y) && (vector.y < board.getPosition().y + board.getHeight());
    return (tipInsideWidth && tipInsideHeight);
  }
  private boolean vectorNotAboveBody(Vector2D vector, Body body) {
    for (Vector2D bodyPosition : body.getPosition()) {
      boolean tipInsideWidth = (vector.x > bodyPosition.x - PIXEL_SIZE/2) && (vector.x < bodyPosition.x + PIXEL_SIZE/2);
      boolean tipInsideHeight = (vector.y > bodyPosition.y - PIXEL_SIZE/2) && (vector.y < bodyPosition.y + PIXEL_SIZE/2);
      if (tipInsideWidth && tipInsideHeight) {
        return false;
      }
    }
    return true;
  }
  private void calculateDistanceTo(Vector2D direction, float AngleUpdate, Snake snake, Board board) {    
    direction.setOrigin(snake.head.getPosition().x, snake.head.getPosition().y);
    direction.setSize(PIXEL_SIZE);
    float newAngle = snake.head.velocity.getAngle() + AngleUpdate;
    direction.setAngle(newAngle);
    direction.updateTip();
    while (vectorInsideBoard(direction, board) && vectorNotAboveBody(direction, snake.body)) {
      float newSize = direction.getSize() + PIXEL_SIZE;
      direction.setSize(newSize);
      direction.updateTip();
    }
    direction.setSize(direction.getSize() - PIXEL_SIZE);
    direction.updateTip();
  }
  public void calculateDistanceToLeft(Snake snake, Board board) {
    calculateDistanceTo(distanceToLeft, -PI/2, snake, board);
  }
  public void calculateDistanceToFront(Snake snake, Board board) {
    calculateDistanceTo(distanceToFront, 0, snake, board);
  }
  public void calculateDistanceToRight(Snake snake, Board board) {
    calculateDistanceTo(distanceToRight, +PI/2, snake, board);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    distanceToLeft.show();
    distanceToFront.show();
    distanceToRight.show();
    stroke(Color);
  }
}
