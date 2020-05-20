class Rink {

  Vector position;
  float Width;
  float Height;

  PVector[][] pixelPositions;
  int horizontalPixelNumber;
  int verticalPixelNumber;

  ArrayList<int[]> freePositions;

  Snake snake;
  Food food;

  Rink() {
    position = new Vector();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPosition(float x_, float y_) {
    position.x = x_;
    position.y = y_;
  }
  void setSideSizes(float Width_, float Height_) {
    Width = Width_;
    Height = Height_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPixelPositions() {
    horizontalPixelNumber = int(Width/PIXEL_SIDE_SIZE);
    verticalPixelNumber = int(Height/PIXEL_SIDE_SIZE);
    pixelPositions = new PVector[verticalPixelNumber][horizontalPixelNumber];
    for (int row = 0; row < verticalPixelNumber; row++) {
      for (int column = 0; column < horizontalPixelNumber; column++) {
        PVector currentPixelPosition = new PVector();
        currentPixelPosition.x = position.x + PIXEL_SIDE_SIZE/2 + column*PIXEL_SIDE_SIZE;
        currentPixelPosition.y = position.y + PIXEL_SIDE_SIZE/2 + row*PIXEL_SIDE_SIZE;
        pixelPositions[row][column] = currentPixelPosition;
        //print(currentPixelPosition);
      }
      //print('\n');
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setFreePositions() {
    freePositions = new ArrayList<int[]>();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void addFood() {
    food = new Food();
    float x = position.x + PIXEL_SIDE_SIZE/2 + int(random(Width/PIXEL_SIDE_SIZE))*PIXEL_SIDE_SIZE;
    float y = position.y + PIXEL_SIDE_SIZE/2 + int(random(Height/PIXEL_SIDE_SIZE))*PIXEL_SIDE_SIZE;
    food.setPosition(x, y);
    food.show();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void addSnake() {
    snake = new Snake();

    float x = position.x + PIXEL_SIDE_SIZE/2 + int(horizontalPixelNumber/2)*PIXEL_SIDE_SIZE;
    float y = position.y + PIXEL_SIDE_SIZE/2 + int(verticalPixelNumber/2)*PIXEL_SIDE_SIZE;
    snake.setInitialPosition(x, y);
    
    //snake.head.setVelocity();

    snake.radar.setHeadPosition(snake.head);

    snake.brain.setFirstLayerCenterPosition(80, 500);
    snake.brain.setInputNeuronsNumber(4);
    snake.brain.setHiddenNeuronsNumber(8);
    snake.brain.setOutputNeuronsNumber(2);
    snake.brain.setHorizontalDistanceBetweenLayers(120);
    snake.brain.setVerticalDistanceBetweenNeurons(70);

    snake.brain.setInputLayer();
    snake.brain.setHiddenLayer();
    snake.brain.setOutputLayer();

    snake.brain.inputLayer.neurons.get(0).setInputName("Bias");
    snake.brain.inputLayer.neurons.get(1).setInputName("Dx");
    snake.brain.inputLayer.neurons.get(2).setInputName("Dy");
    snake.brain.inputLayer.neurons.get(3).setInputName("Theta");

    snake.brain.outputLayer.neurons.get(0).setOutputName("Left");
    snake.brain.outputLayer.neurons.get(1).setOutputName("Right");

    snake.brain.connectLayers(snake.brain.inputLayer, snake.brain.hiddenLayer);
    snake.brain.connectLayers(snake.brain.hiddenLayer, snake.brain.outputLayer);

    snake.show();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void showPixelStrokes() {
    noFill();
    stroke(50);
    rectMode(CENTER);
    for (int row = 0; row < verticalPixelNumber; row++) {
      for (int column = 0; column < horizontalPixelNumber; column++) {
        rect(pixelPositions[row][column].x, pixelPositions[row][column].y, PIXEL_SIDE_SIZE, PIXEL_SIDE_SIZE);
      }
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    noFill();
    stroke(255);
    rectMode(CORNER);
    rect(position.x, position.y, Width, Height);
    position.show();
  }
}
