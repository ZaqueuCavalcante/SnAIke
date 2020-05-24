public class Rink {

  private Vector position;
  private float Width;
  private float Height;

  private PVector[][] pixelPositions;
  private int horizontalPixelNumber;
  private int verticalPixelNumber;
  
  private ArrayList<int[]> freePositions;

  Rink() {
    position = new Vector();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void autoSize(Canvas canvas) {
    setPosition(canvas.xDivisoryLine);
    setSideSizes(canvas.xDivisoryLine);
    setDimensions();
    setPixelPositions();
  }
  private void setPosition(float offsetX) {
    position.x = offsetX + PIXEL_SIZE;
    position.y = PIXEL_SIZE;
  }
  private void setSideSizes(float offsetX) {
    Width = width - offsetX - 2*PIXEL_SIZE;
    Height = height - 2*PIXEL_SIZE;
  }
  private void setDimensions() {
    horizontalPixelNumber = int(Width/PIXEL_SIZE);
    verticalPixelNumber = int(Height/PIXEL_SIZE);
    pixelPositions = new PVector[verticalPixelNumber][horizontalPixelNumber];
  }
  private void setPixelPositions() {
    for (int row = 0; row < verticalPixelNumber; row++) {
      for (int column = 0; column < horizontalPixelNumber; column++) {
        PVector currentPixelPosition = new PVector();
        currentPixelPosition.x = position.x + PIXEL_SIZE/2 + column*PIXEL_SIZE;
        currentPixelPosition.y = position.y + PIXEL_SIZE/2 + row*PIXEL_SIZE;
        pixelPositions[row][column] = currentPixelPosition;
      }
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private boolean checksHeadMatch(float x, float y, Head head) {
    return (x == head.getPosition().x) && (y == head.getPosition().y);
  }
  private boolean checksBodyMatch(float x, float y, Body body) {
    for (Vector bodyPosition : body.position) {
      if ((pixelX == bodyPosition.x) && (pixelY == bodyPosition.y)) {
        return true;
      }
    }
    return false;
  }
  public void determineFreePositions(Snake snake) {
    freePositions = new ArrayList<int[]>();
    for (int row = 0; row < verticalPixelNumber; row++) {
      for (int column = 0; column < horizontalPixelNumber; column++) {
        float pixelX = pixelPositions[row][column].x;
        float pixelY = pixelPositions[row][column].y;

        boolean headMatch = checksHeadMatch(pixelX, pixelY, snake.head);
        boolean bodyMatch = checksBodyMatch(pixelX, pixelY, snake.body);

        if (!headMatch && !bodyMatch) {
          int[] freePositonIndexes = new int[2];
          freePositonIndexes[0] = row;
          freePositonIndexes[1] = column;
          freePositions.add(freePositonIndexes);
        }
      }
    }
    print("Free positions = ", freePositions.size());
    print("\n");
  }
  public void addFood(Snake snake, Food food) {
    boolean foodOutside = (food.getPosition().x == 0.0) && (food.getPosition().y);
    if (foodOutside) {
      determineFreePositions(snake);
      int index = int(random(freePositions.size()));
      int[] freePosition = freePositions.get(index);
      int row = freePosition[0];
      int column = freePosition[1];
      food.setPosition(pixelPositions[row][column].x, pixelPositions[row][column].y);
    } else {
      food.show();
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void showPixelStrokes() {
    noFill();
    stroke(50);
    rectMode(CENTER);
    for (int row = 0; row < verticalPixelNumber; row++) {
      for (int column = 0; column < horizontalPixelNumber; column++) {
        rect(pixelPositions[row][column].x, pixelPositions[row][column].y, PIXEL_SIZE, PIXEL_SIZE);
      }
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    noFill();
    stroke(255);
    rectMode(CORNER);
    rect(position.x, position.y, Width, Height);
    showPixelStrokes();
  }
}
