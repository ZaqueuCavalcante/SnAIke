public class RSnakeRadar {

  private float distanceToFoodX;
  private float distanceToFoodY;
  private ZVector2D distanceToRight;
  private ZVector2D distanceToDown;
  private ZVector2D distanceToLeft;
  private ZVector2D distanceToUp;

  RSnakeRadar() {
    this.distanceToRight = new ZVector2D();
    this.distanceToDown = new ZVector2D();
    this.distanceToLeft = new ZVector2D();
    this.distanceToUp = new ZVector2D();
    this.distanceToRight.makeObservable();
    this.distanceToDown.makeObservable();
    this.distanceToLeft.makeObservable();
    this.distanceToUp.makeObservable();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public float getDistanceToFoodX() {
    return this.distanceToFoodX;
  }
  public float getDistanceToFoodY() {
    return this.distanceToFoodY;
  }
  public float getDistanceToRight() {
    return this.distanceToRight.getSize();
  }
  public float getDistanceToDown() {
    return this.distanceToDown.getSize();
  }
  public float getDistanceToLeft() {
    return this.distanceToLeft.getSize();
  }
  public float getDistanceToUp() {
    return this.distanceToUp.getSize();
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
  public void calculateDistanceToRight(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToRight, 0, snake, board);
  }
  public void calculateDistanceToDown(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToDown, PI/2, snake, board);
  }
  public void calculateDistanceToLeft(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToLeft, PI, snake, board);
  }
  public void calculateDistanceToUp(ASnake snake, ABoard board) {
    calculateDistanceTo(distanceToUp, 3*PI/2, snake, board);
  }

  public void normalizeDistances(ASnake snake, ABoard board) {
    float pixelSize = snake.getHead().getSize();
    float bWidth = board.getWidth() - pixelSize;
    float bHeight = board.getHeight() - pixelSize;

    this.distanceToFoodX = distanceToFoodX / bWidth;
    this.distanceToFoodY = distanceToFoodY / bHeight;
    this.distanceToLeft.setSize(distanceToLeft.getSize() / bWidth);
    this.distanceToUp.setSize(distanceToUp.getSize() / bHeight);
    this.distanceToRight.setSize(distanceToRight.getSize() / bWidth);
    this.distanceToDown.setSize(distanceToDown.getSize() / bHeight);

    //println("FoodX = ", distanceToFoodX);
    //println("FoodY = ", distanceToFoodY);
    //println("Right = ", distanceToRight.getSize());
    //println("Down = ", distanceToDown.getSize());
    //println("Left = ", distanceToLeft.getSize());
    //println("Up = ", distanceToUp.getSize());
    //println(" - - - - ");
  }

  public void calculateAndNormalizeDistances(ABoard board, ASnake snake, AFood food) {
    this.calculateDistanceToFood(snake, food);
    this.calculateDistanceToRight(snake, board);
    this.calculateDistanceToDown(snake, board);
    this.calculateDistanceToLeft(snake, board);
    this.calculateDistanceToUp(snake, board);
    //canvas.show(this);
    this.normalizeDistances(snake, board);
  }
}
