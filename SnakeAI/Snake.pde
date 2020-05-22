class Snake {

  Head head;
  Body body;
  Brain brain;
  Radar radar;

  int score; 
  int remainingMoves;  
  float fitness;  

  boolean dead;

  Snake() {
    head = new Head();
    body = new Body();
    brain = new Brain();
    radar = new Radar();

    setScore(0);
    setRemainingMoves(100);
    setFitness(0.0);

    live();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setInitialPosition(Rink rink) {
    //float x = rink.position.x + PIXEL_SIZE/2 + int(rink.horizontalPixelNumber/2)*PIXEL_SIZE;
    //float y = rink.position.y + PIXEL_SIZE/2 + int(rink.verticalPixelNumber/2)*PIXEL_SIZE;
    float x = rink.position.x + PIXEL_SIZE/2 + int(random(rink.horizontalPixelNumber))*PIXEL_SIZE;;
    float y = rink.position.y + PIXEL_SIZE/2 + int((rink.verticalPixelNumber-1))*PIXEL_SIZE;;
    head.setPosition(x, y);
    body.setFirstPixelPosition(x, y + PIXEL_SIZE);
  }
  void setBrain() {
    brain.setFirstLayerCenterPosition(80, 500);
    brain.setInputNeuronsNumber(4);
    brain.setHiddenNeuronsNumber(8);
    brain.setOutputNeuronsNumber(2);
    brain.setHorizontalDistanceBetweenLayers(120);
    brain.setVerticalDistanceBetweenNeurons(70);

    brain.setInputLayer();
    brain.setHiddenLayer();
    brain.setOutputLayer();

    brain.inputLayer.setNeuronInputName(0, "Bias");
    brain.inputLayer.setNeuronInputName(1, "Dx");
    brain.inputLayer.setNeuronInputName(2, "Dy");
    brain.inputLayer.setNeuronInputName(3, "Theta");

    brain.outputLayer.setNeuronOutputName(0, "Left");
    brain.outputLayer.setNeuronOutputName(0, "Right");

    brain.connectLayers(brain.inputLayer, brain.hiddenLayer);
    brain.connectLayers(brain.hiddenLayer, brain.outputLayer);
  }

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void eat() {
    body.addPixel();
    increaseScore(1);
    increaseRemainingMoves(100);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  boolean bodyCollide() {  // Check if the head collides with self body.
    for (int i = 0; i < body.position.size(); i++) {
      if (head.position.x == body.position.get(i).x && head.position.y == body.position.get(i).y) {
        return true;
      }
    }
    return false;
  }
  boolean foodCollide(Food food) {  // Checks if the head collides with the food.
    if (head.position.x == food.position.x && head.position.y == food.position.y) {
      return true;
    }
    return false;
  }
  boolean wallCollide(Rink rink) {  // Checks if the head collides with the rink's wall.
    boolean headInsideRinkWidth = (head.position.x < rink.position.x) || (head.position.x > rink.position.x+rink.Width);
    boolean headInsideRinkHeight = (head.position.y < rink.position.y) || (head.position.y > rink.position.y+rink.Height);
    if (headInsideRinkWidth || headInsideRinkHeight) {
      return true;
    }
    return false;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void move(Rink rink) { 
    if (wallCollide(rink)) {
      die();
    }
    if (bodyCollide()) {
      die();
    }
    if (remainingMovesFinish()) {
      die();
    }
    if (foodCollide(rink.food)) {
      eat();
      rink.determineFreePositions(this);
      rink.addFood();
    }
    if (isNotDead()) {
      PVector headPreviousPosition = new PVector(head.position.x, head.position.y);
      head.move();
      body.move(headPreviousPosition);
      decreaseRemainingMoves();
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setScore(int score_) {
    score = score_;
  }
  int getScore() {
    return score;
  }
  void increaseScore(int scoreIncrement) {
    score += scoreIncrement;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setRemainingMoves(int remainingMoves_) {
    remainingMoves = remainingMoves_;
  }
  int getRemainingMoves() {
    return remainingMoves;
  }
  void increaseRemainingMoves(int remainingMovesIncrement) {
    remainingMoves += remainingMovesIncrement;
  }
  void decreaseRemainingMoves() {
    remainingMoves --;
  }
  boolean remainingMovesFinish() {
    if (remainingMoves == 0) {
      return true;
    } else {
      return false;
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setFitness(float fitness_) {
    fitness = fitness_;
  }
  float getFitness() {
    return fitness;
  }
  void calculateFitness() {
    float fitnessCalculated  = score*10 + remainingMoves/10;
    setFitness(fitnessCalculated);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void live() { 
    dead = false;
  }
  void die() { 
    dead = true;
  }
  boolean isDead() { 
    return dead;
  }
  boolean isNotDead() { 
    return !dead;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  Snake clone() {
    Snake clonedSnake = new Snake();
    clonedSnake.brain = this.brain;
    return clonedSnake;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    head.show();
    body.show();
  }
}
