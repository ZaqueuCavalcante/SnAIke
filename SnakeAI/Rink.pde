class Rink {

  Vector position;
  float Width;
  float Height;

  PVector[][] pixelPositions;
  int horizontalPixelNumber;
  int verticalPixelNumber;
  ArrayList<int[]> freePositions;

  Food food;

  Rink() {
    position = new Vector();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPosition(Canvas canvas) {
    position.x = canvas.xDivisoryLine + PIXEL_SIZE;
    position.y = PIXEL_SIZE;
  }
  void setSideSizes(Canvas canvas) {
    Width = width - canvas.xDivisoryLine - 2*PIXEL_SIZE;
    Height = height - 2*PIXEL_SIZE;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setDimensions() {
    horizontalPixelNumber = int(Width/PIXEL_SIZE);
    verticalPixelNumber = int(Height/PIXEL_SIZE);
    pixelPositions = new PVector[verticalPixelNumber][horizontalPixelNumber];
  }
  void setPixelPositions() {
    setDimensions();
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
  void determineFreePositions(Snake snake) {
    freePositions = new ArrayList<int[]>();
    for (int row = 0; row < verticalPixelNumber; row++) {
      for (int column = 0; column < horizontalPixelNumber; column++) {
        float pixelX = pixelPositions[row][column].x;
        float pixelY = pixelPositions[row][column].y;
        boolean headMatchX = (pixelX == snake.head.getPosition().x);
        boolean headMatchY = (pixelY == snake.head.getPosition().y);
        boolean headMatch = headMatchX && headMatchY;
        boolean bodyMatch = false;
        for (Vector bodyPosition : snake.body.position) {
          if (pixelX == bodyPosition.x && pixelY == bodyPosition.y) {
            bodyMatch = true;
            break;
          }
        }
        if (!headMatch && !bodyMatch) {
          int[] freePositonIndexes = new int[2];
          freePositonIndexes[0] = row;
          freePositonIndexes[1] = column;
          freePositions.add(freePositonIndexes);
          print(freePositonIndexes[0], freePositonIndexes[1]);
          print("\n");
        }
      }
    }
    print("------------\n");
  }
  void addFood() {
    food = new Food();
    int index = int(random(freePositions.size()));
    int[] freePosition = freePositions.get(index);
    int row = freePosition[0];
    print("Index", row, "\n");
    int column = freePosition[1];
    float x = pixelPositions[row][column].x;
    float y = pixelPositions[row][column].y;
    food.setPosition(x, y);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void showPixelStrokes() {
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
  void show() {
    noFill();
    stroke(255);
    rectMode(CORNER);
    rect(position.x, position.y, Width, Height);
    showPixelStrokes();
    //position.show();
  }
}
