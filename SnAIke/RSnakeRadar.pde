public class RSnakeRadar {

  private float distanceToFoodX;
  private float distanceToFoodY;
  private ZVector2D distanceToRight;
  private ZVector2D distanceToDown;
  private ZVector2D distanceToLeft;
  private ZVector2D distanceToUp;

  private ZVector2D D0;
  private ZVector2D D1;
  private ZVector2D D2;
  private ZVector2D D3;

  RSnakeRadar() {
    this.distanceToRight = new ZVector2D();
    this.distanceToDown = new ZVector2D();
    this.distanceToLeft = new ZVector2D();
    this.distanceToUp = new ZVector2D();
    this.distanceToRight.makeObservable();
    this.distanceToDown.makeObservable();
    this.distanceToLeft.makeObservable();
    this.distanceToUp.makeObservable();

    D0 = new ZVector2D();
    D1 = new ZVector2D();
    D2 = new ZVector2D();
    D3 = new ZVector2D();
    D0.makeObservable();
    D1.makeObservable();
    D2.makeObservable();
    D3.makeObservable();
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

  public float getD0() {
    return this.D0.getSize();
  }
  public float getD1() {
    return this.D1.getSize();
  }
  public float getD2() {
    return this.D3.getSize();
  }
  public float getD3() {
    return this.D3.getSize();
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
  
  public void calculateDistanceToD0(ASnake snake, ABoard board) {
    calculateDistanceTo(D0, PI/4, snake, board);
  }
  public void calculateDistanceToD1(ASnake snake, ABoard board) {
    calculateDistanceTo(D1, 3*PI/4, snake, board);
  }
  public void calculateDistanceToD2(ASnake snake, ABoard board) {
    calculateDistanceTo(D2, 5*PI/4, snake, board);
  }  
  public void calculateDistanceToD3(ASnake snake, ABoard board) {
    calculateDistanceTo(D3, 7*PI/4, snake, board);
  }
  
  public void normalizeDistances(ASnake snake, ABoard board) {
    float pixelSize = snake.getHead().getSize();
    float bWidth = board.getWidth() - pixelSize;
    float bHeight = board.getHeight() - pixelSize;

    this.distanceToFoodX = distanceToFoodX / bWidth;
    this.distanceToFoodY = distanceToFoodY / bHeight;
    this.distanceToRight.setSize(distanceToRight.getSize() / bWidth);
    this.distanceToDown.setSize(distanceToDown.getSize() / bHeight);
    this.distanceToLeft.setSize(distanceToLeft.getSize() / bWidth);
    this.distanceToUp.setSize(distanceToUp.getSize() / bHeight);
    
    
    float bDia = sqrt(2*bHeight*bHeight);
    this.D0.setSize(D0.getSize() / bDia);
    this.D1.setSize(D1.getSize() / bDia);
    this.D2.setSize(D2.getSize() / bDia);
    this.D3.setSize(D3.getSize() / bDia);

    // Gambiarra a seguir =>
    //if (distanceToFoodX > (pixelSize/bWidth)/2) distanceToFoodX = 0.5*distanceToFoodX + 0.4;
    //if (distanceToFoodX < -(pixelSize/bWidth)/2) distanceToFoodX = 0.5*distanceToFoodX - 0.4;

    //if (distanceToFoodY > (pixelSize/bHeight)/2) distanceToFoodY = 0.5*distanceToFoodY + 0.4;
    //if (distanceToFoodY < -(pixelSize/bHeight)/2) distanceToFoodY = 0.5*distanceToFoodY - 0.4;

    //if (distanceToRight.getSize() > (pixelSize/bWidth)) distanceToRight.setSize( 0.5*distanceToRight.getSize() + 0.4 );
    //if (distanceToDown.getSize() > (pixelSize/bHeight)) distanceToDown.setSize( 0.5*distanceToDown.getSize() + 0.4 );
    //if (distanceToLeft.getSize() > (pixelSize/bWidth)) distanceToLeft.setSize( 0.5*distanceToLeft.getSize() + 0.4 );
    //if (distanceToUp.getSize() > (pixelSize/bHeight)) distanceToUp.setSize( 0.5*distanceToUp.getSize() + 0.4 );
    
    //if (D0.getSize() > (1.4142*pixelSize/bDia)) D0.setSize( 0.5*D0.getSize() + 0.4 );
    //if (D1.getSize() > (1.4142*pixelSize/bDia)) D1.setSize( 0.5*D1.getSize() + 0.4 );
    //if (D2.getSize() > (1.4142*pixelSize/bDia)) D2.setSize( 0.5*D2.getSize() + 0.4 );
    //if (D3.getSize() > (1.4142*pixelSize/bDia)) D3.setSize( 0.5*D3.getSize() + 0.4 );
    // Fim da gambiarra <=

    //println("FoodX = ", distanceToFoodX);
    //println("FoodY = ", distanceToFoodY);
    //println("Right = ", distanceToRight.getSize());
    //println("Down = ", distanceToDown.getSize());
    //println("Left = ", distanceToLeft.getSize());
    //println("Up = ", distanceToUp.getSize());
    //println("D0 = ", D0.getSize());
    //println("D1 = ", D1.getSize());
    //println("D2 = ", D2.getSize());
    //println("D3 = ", D3.getSize());
    //println(" - - - - ");
  }

  public void calculateAndNormalizeDistances(ABoard board, ASnake snake, AFood food) {
    this.calculateDistanceToFood(snake, food);
    this.calculateDistanceToRight(snake, board);
    this.calculateDistanceToDown(snake, board);
    this.calculateDistanceToLeft(snake, board);
    this.calculateDistanceToUp(snake, board);
    //canvas.show(this);
    
    calculateDistanceToD0(snake, board);
    calculateDistanceToD1(snake, board);
    calculateDistanceToD2(snake, board);
    calculateDistanceToD3(snake, board);
    
    //canvas.show(this);
    
    this.normalizeDistances(snake, board);
  }
}
