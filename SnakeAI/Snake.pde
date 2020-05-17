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
    this.head = new Head();
    this.body = new Body();
    this.radar = new Radar();
    this.brain = new Brain();

    this.setScore(0);
    this.setRemainingMoves(100);
    this.setFitness(0.0);

    this.live();
  }

  void setInitialPosition(float x, float y) {
    this.head.setPosition(x, y);
    this.body.setFirstPixelPosition(x, y + PIXEL_SIDE_SIZE);
  }

  //  snake.radar.setOriginPoint(snake.head.position);
  //  snake.radar.setDestinyPoint(food.position);

  //  snake.brain.setFirstLayerCenterPosition(80, 500);
  //  snake.brain.setInputNeuronsNumber(4);
  //  snake.brain.setHiddenNeuronsNumber(8);
  //  snake.brain.setOutputNeuronsNumber(2);
  //  snake.brain.setHorizontalDistanceBetweenLayers(120);
  //  snake.brain.setVerticalDistanceBetweenNeurons(70);

  //  snake.brain.setInputLayer();
  //  snake.brain.setHiddenLayer();
  //  snake.brain.setOutputLayer();

  //  snake.brain.inputLayer.neurons.get(0).setInputName("Bias");
  //  snake.brain.inputLayer.neurons.get(1).setInputName("Dx");
  //  snake.brain.inputLayer.neurons.get(2).setInputName("Dy");
  //  snake.brain.inputLayer.neurons.get(3).setInputName("Theta");

  //  snake.brain.outputLayer.neurons.get(0).setOutputName("Left");
  //  snake.brain.outputLayer.neurons.get(1).setOutputName("Right");

  //  snake.brain.connectLayers(snake.brain.inputLayer, snake.brain.hiddenLayer);
  //  snake.brain.connectLayers(snake.brain.hiddenLayer, snake.brain.outputLayer);



  //  setTheta(3*PI/2);
  //  setVelocity();

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
  //void setTheta(float newTheta) {
  //  theta += newTheta;
  //}
  //float getTheta() {
  //  return theta;
  //}
  //void setVelocity() {
  //  velocity.x = PIXEL_SIDE_SIZE*int(cos(getTheta()));
  //  velocity.y = PIXEL_SIDE_SIZE*int(sin(getTheta()));
  //}
  //void moveLeft() { 
  //  setTheta(-PI/2);
  //  setVelocity();
  //}
  //void moveRight() { 
  //  setTheta(PI/2);
  //  setVelocity();
  //}
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
    // Todos os atributos têm que ser repassados por valor --_--.

    float x = head.position.x;
    float y = head.position.y;
    clonedSnake.head.setPosition(x, y);

    return clonedSnake;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    head.show();
    body.show();
    radar.show();
    brain.show();
  }
}
