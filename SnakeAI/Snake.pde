class Snake {

  boolean dead;

  Head head;
  Body body;

  Brain brain;
  Radar radar;

  float theta;
  PVector velocity;

  int score;  // Length/amount of pixels of the snake.
  int remainingMoves;  // Amount of moves the snake can make before it dies.
  float fitness;  // It measures how adapted the snake is, that is, how efficient it is in eating food and avoiding obstacles.

  Snake() {
    live();

    head = new Head();
    body = new Body();

    radar = new Radar();

    brain = new Brain();

    score = 0;
    remainingMoves = 100;
    fitness = 0;
  }

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

  void increaseScore(int scoreIncrement) {
    score += scoreIncrement;
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

  void setInitialVelocity() {
    setTheta(3*PI/2);
    velocity = new PVector();
    setVelocity();
  }

  void show() {
    head.show();
    body.show();
    radar.show();
    brain.show();
  }

  void calculateFitness() {
    fitness = score*10 + remainingMoves/10;
  }

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

  void eat() {
    body.addPixel();
    increaseScore(1);
    increaseRemainingMoves(100);
  }

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
      radar.setDestinyPoint(rink.food.position);
    }
    if (isNotDead()) {
      PVector headPreviousPosition = new PVector(head.position.x, head.position.y);
      head.move(velocity.x, velocity.y);
      body.move(headPreviousPosition);
      decreaseRemainingMoves();
      radar.calculateDistance();
      calculateFitness();
      //print(radar.distanceToDistinyPoint);
      //print("\n");
    }
  }

  void setTheta(float newTheta) {
    theta += newTheta;
  }
  void setVelocity() {
    velocity.x = head.pixelSideSize*int(cos(theta));
    velocity.y = head.pixelSideSize*int(sin(theta));
  }
  void moveLeft() { 
    setTheta(-PI/2);
    setVelocity();
  }
  void moveRight() { 
    setTheta(PI/2);
    setVelocity();
  }
}
