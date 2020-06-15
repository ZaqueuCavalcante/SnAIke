public class RSnakeRadar {

  private int snakeVx;
  private int snakeVy;
  private float distanceToFoodX;
  private float distanceToFoodY;
  private ZVector2D distanceToLeft;
  private ZVector2D distanceToFront;
  private ZVector2D distanceToRight;

  RSnakeRadar() {
    this.distanceToLeft = new ZVector2D();
    this.distanceToFront = new ZVector2D();
    this.distanceToRight = new ZVector2D();
    this.distanceToLeft.makeObservable();
    this.distanceToFront.makeObservable();
    this.distanceToRight.makeObservable();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public int getSnakeVx() {
    return this.snakeVx;
  }
  public int getSnakeVy() {
    return this.snakeVy;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public float getDistanceToFoodX() {
    return this.distanceToFoodX;
  }
  public float getDistanceToFoodY() {
    return this.distanceToFoodY;
  }
  public float getDistanceToLeft() {
    return this.distanceToLeft.getSize();
  }
  public float getDistanceToFront() {
    return this.distanceToFront.getSize();
  }
  public float getDistanceToRight() {
    return this.distanceToRight.getSize();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void calculateDistanceToFood(ASnake snake, AFood food) {
    ZPixel head = snake.getHead();
    this.distanceToFoodX = food.getPosition().getX() - head.getPosition().getX();
    this.distanceToFoodY = food.getPosition().getY() - head.getPosition().getY();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private boolean vectorInsideBoard(ZVector2D vector, ABoard board) {
    float leftLimit = board.getPosition().getX();
    float rightLimit = board.getPosition().getX() + board.getWidth();
    float upLimit = board.getPosition().getY();
    float downLimit = board.getPosition().getY() + board.getHeight();
    return vector.tipIsInsideOf(leftLimit, rightLimit, upLimit, downLimit);
  }

  private boolean vectorOutsideBody(ZVector2D vector, ArrayList<ZPixel> body) {
    float leftLimit, rightLimit, upLimit, downLimit;
    for (ZPixel pixel : body) {
      leftLimit = pixel.getPosition().getX() - pixel.getSize()/2;
      rightLimit = pixel.getPosition().getX() + pixel.getSize()/2;
      upLimit = pixel.getPosition().getY() - pixel.getSize()/2;
      downLimit = pixel.getPosition().getY() + pixel.getSize()/2;
      if (vector.tipIsInsideOf(leftLimit, rightLimit, upLimit, downLimit)) {
        return false;
      }
    }
    return true;
  }
  private void calculateDistanceTo(ZVector2D direction, float angleUpdate, ASnake snake, ABoard board) {    
    direction.setOrigin(snake.getHead().getPosition().getX(), snake.getHead().getPosition().getY());
    float pixelSize = snake.getHead().getSize();
    direction.setSize(pixelSize);
    float directionAngle = snake.getHead().getVelocity().getAngle() + angleUpdate;
    direction.setAngle(directionAngle);
    direction.updateTip();
    float newSize;
    while (vectorInsideBoard(direction, board) && vectorOutsideBody(direction, snake.getBody())) {
      newSize = direction.getSize() + pixelSize;
      direction.setSize(newSize);
      direction.updateTip();
    }
    direction.setSize(direction.getSize() - pixelSize);
    direction.updateTip();
  }
  public void calculateDistanceToLeft(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToLeft, -PI/2, snake, board);
  }
  public void calculateDistanceToFront(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToFront, 0, snake, board);
  }
  public void calculateDistanceToRight(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToRight, +PI/2, snake, board);
  }

  public void normalizeDistances(ASnake snake, ABoard board) {
    this.snakeVx = int(cos(snake.getHead().getVelocity().getAngle()));
    this.snakeVy = int(sin(snake.getHead().getVelocity().getAngle()));
    float pixelSize = snake.getHead().getSize();
    float bWidth = board.getWidth() - pixelSize;
    float bHeight = board.getHeight() - pixelSize;

    this.distanceToFoodX = distanceToFoodX / bWidth;
    this.distanceToFoodY = distanceToFoodY / bHeight;

    if (snakeVx == 0) {
      this.distanceToLeft.setSize(distanceToLeft.getSize() / bWidth);
      this.distanceToFront.setSize(distanceToFront.getSize() / bHeight);
      this.distanceToRight.setSize(distanceToRight.getSize() / bWidth);
    } else {
      this.distanceToLeft.setSize(distanceToLeft.getSize() / bHeight);
      this.distanceToFront.setSize(distanceToFront.getSize() / bWidth);
      this.distanceToRight.setSize(distanceToRight.getSize() / bHeight);
    }

    //println("Vx = ", snakeVx);
    //println("Vy = ", snakeVy);
    //println("FoodX = ", distanceToFoodX);
    //println("FoodY = ", distanceToFoodY);
    //println("Left = ", distanceToLeft.getSize());
    //println("Front = ", distanceToFront.getSize());
    //println("Right = ", distanceToRight.getSize());
  }
}
