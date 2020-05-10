class Rink {

  PVector position;
  int Width;
  int Height;
  int pixelSize;  // Length of the side of the elementary square that forms the snake, the food and the rink.

  PVector[][] pixelPositions;
  int horizontalPixelNumber;
  int verticalPixelNumber;

  ArrayList<int[]> freePositions;

  Snake snake;
  Food food;

  Rink() {
    position = new PVector();
  }

  void setPosition(float x_, float y_) {
    position.x = x_;
    position.y = y_;
  }
  void setSideSizes(int Width_, int Height_) {
    Width = Width_;
    Height = Height_;
  }
  void setPixelSize(int pixelSize_) {
    pixelSize = pixelSize_;
  }
  void setPixelPositions() {
    horizontalPixelNumber = int(Width/pixelSize);
    verticalPixelNumber = int(Height/pixelSize);
    pixelPositions = new PVector[horizontalPixelNumber][verticalPixelNumber];
    for (int row = 0; row < horizontalPixelNumber; row++) {
      for (int column = 0; column < verticalPixelNumber; column++) {
        PVector currentPixelPosition = new PVector();
        currentPixelPosition.x = position.x + pixelSize/2 + column*pixelSize;
        currentPixelPosition.y = position.y + pixelSize/2 + row*pixelSize;
        pixelPositions[row][column] = currentPixelPosition;
        //print(currentPixelPosition);
      }
      //print('\n');
    }
  }

  void setFreePositions() {
    freePositions = new ArrayList<int[]>();
  }

  void addFood() {
    food = new Food();
    float x = position.x + pixelSize/2 + floor(random(Width/pixelSize))*pixelSize;
    float y = position.y + pixelSize/2 + floor(random(Height/pixelSize))*pixelSize;
    food.setPosition(x, y);
    food.setPixelSideSize(pixelSize);
    food.show();
  }

  void addSnake() {
    snake = new Snake();

    float x = position.x + pixelSize/2 + Width/2;
    float y = position.y + pixelSize/2 + Height/2;
    snake.head.setPosition(x, y);
    snake.head.setPixelSideSize(pixelSize);

    snake.setInitialVelocity();

    snake.body.setFirstPixelPosition(x, y + pixelSize);
    snake.body.setPixelSideSize(pixelSize);

    snake.radar.setOriginPoint(snake.head.position);
    snake.radar.setDestinyPoint(food.position);

    snake.brain.setFirstLayerCenterPosition(80, 500);
    snake.brain.setInputNeuronsNumber(4);
    snake.brain.setHiddenNeuronsNumber(8);
    snake.brain.setOutputNeuronsNumber(2);
    snake.brain.setHorizontalDistanceBetweenLayers(120);
    snake.brain.setVerticalDistanceBetweenNeurons(70);

    snake.brain.setInputLayer();
    snake.brain.setHiddenLayer();
    snake.brain.setOutputLayer();

    snake.brain.connectLayers(snake.brain.inputLayer, snake.brain.hiddenLayer);
    snake.brain.connectLayers(snake.brain.hiddenLayer, snake.brain.outputLayer);

    snake.show();
  }

  void showPixelStrokes() {
    noFill();
    stroke(50);
    rectMode(CENTER);
    for (int row = 0; row < horizontalPixelNumber; row++) {
      for (int column = 0; column < verticalPixelNumber; column++) {
        rect(pixelPositions[row][column].x, pixelPositions[row][column].y, pixelSize, pixelSize);
      }
    }
  }

  void show() {
    noFill();
    stroke(255);
    rectMode(CORNER);
    rect(position.x, position.y, Width, Height);
  }
}
