public class RSnakeRadar {

  private float distanceToFoodX;
  private float distanceToFoodY;
  private ZVector2D distanceToLeft;
  private ZVector2D distanceToUp;
  private ZVector2D distanceToRight;
  private ZVector2D distanceToDown;

  RSnakeRadar() {
    this.distanceToLeft = new ZVector2D();
    this.distanceToUp = new ZVector2D();
    this.distanceToRight = new ZVector2D();
    this.distanceToDown = new ZVector2D();
    this.distanceToLeft.makeObservable();
    this.distanceToUp.makeObservable();
    this.distanceToRight.makeObservable();
    this.distanceToDown.makeObservable();
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
  public float getDistanceToUp() {
    return this.distanceToUp.getSize();
  }
  public float getDistanceToRight() {
    return this.distanceToRight.getSize();
  }
  public float getDistanceToDown() {
    return this.distanceToDown.getSize();
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
  private void calculateDistanceTo(ZVector2D direction, float directionAngle, ASnake snake, ABoard board) {    
    direction.setOrigin(snake.getHead().getPosition().getX(), snake.getHead().getPosition().getY());
    float pixelSize = snake.getHead().getSize();
    direction.setSize(pixelSize);
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
    calculateDistanceTo(distanceToLeft, PI, snake, board);
  }
  public void calculateDistanceToUp(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToUp, 3*PI/2, snake, board);
  }
  public void calculateDistanceToRight(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToRight, 0, snake, board);
  }
  public void calculateDistanceToDown(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToDown, PI/2, snake, board);
  }

  public void normalizeDistances(ASnake snake, ABoard board) {
    float pixelSize = snake.getHead().getSize();
    float bWidth = board.getWidth() - pixelSize;
    float bHeight = board.getHeight() - pixelSize;

    //this.distanceToFoodX = distanceToFoodX / bWidth;
    //this.distanceToFoodY = distanceToFoodY / bHeight;
    //this.distanceToLeft.setSize(distanceToLeft.getSize() / bWidth);
    //this.distanceToUp.setSize(distanceToUp.getSize() / bHeight);
    //this.distanceToRight.setSize(distanceToRight.getSize() / bWidth);
    //this.distanceToDown.setSize(distanceToDown.getSize() / bHeight);
    float fx, fy, exp = 0.25;
    //if (distanceToFoodX < 0) {
    //  fx = -pow(-distanceToFoodX / bWidth, exp*10); // Colorar exp maior, dando mais imprtancia.
    //} else {
    //  fx = pow(distanceToFoodX / bWidth, exp*10);
    //}
    //if (distanceToFoodY < 0) {
    //  fy = -pow(-distanceToFoodY / bHeight, exp*10);
    //} else {
    //  fy = pow(distanceToFoodY / bHeight, exp*10);
    //}

    this.distanceToFoodX = distanceToFoodX / bWidth;
    this.distanceToFoodY = distanceToFoodY / bHeight;
    this.distanceToLeft.setSize(pow(distanceToLeft.getSize() / bWidth, exp));
    this.distanceToUp.setSize(pow(distanceToUp.getSize() / bHeight, exp));
    this.distanceToRight.setSize(pow(distanceToRight.getSize() / bWidth, exp));
    this.distanceToDown.setSize(pow(distanceToDown.getSize() / bHeight, exp));

    //println("FoodX = ", distanceToFoodX);
    //println("FoodY = ", distanceToFoodY);
    //println("Right = ", distanceToRight.getSize());
    //println("Down = ", distanceToDown.getSize());
    //println("Left = ", distanceToLeft.getSize());
    //println("Up = ", distanceToUp.getSize());
    //println(" - - - - ");
  }
}
