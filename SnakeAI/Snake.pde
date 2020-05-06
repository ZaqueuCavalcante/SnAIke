class Snake {

  Head head;
  Body body;
  Brain brain;
  Radar radar;
  
  boolean dead;

  PVector velocity;
  float theta;

  int score;  // Length/amount of pixels of the snake.
  int remainingMoves;  // Amount of moves the snake can make before it dies.
  float fitness;  // It measures how adapted the snake is, that is, how efficient it is in eating food and avoiding obstacles.

  Snake() {
    dead = false;
    score = 0;
    remainingMoves = 100;
    fitness = 0;
    
    setTheta();
    velocity = new PVector();
    setVelocity();
    head = new Head();
    body = new Body();
    body.addPixel(head.position.x, head.position.y+rink.pixelSize);
    increaseScore();

    radar = new Radar(head.position, rink.food.position);
    
    brain = new Brain(4, 8, 2);
  }

  void increaseScore() {
    score ++;
  }
  void increaseRemainingMoves() {
    remainingMoves += 100;
  }
  void decreaseRemainingMoves() {
    remainingMoves --;
  }
  boolean remainingMovesEnd() {
    if (remainingMoves == 0) {
      return true;
    } else {
      return false;
    }
  }

  void setTheta() {
    theta = 3*PI/2;
  }

  void show() {
    head.show();
    body.show();
    radar.show();
  }
  
  void calculateFitness() {
    fitness = this.score*10 + this.remainingMoves/10;
  }
  
  //Snake deepCopy() {
  //  Snake snakeCopy = new Snake();
    
  //}

  boolean bodyCollide() {  // Check if the head collides with self body.
    for (int i = 0; i < body.positions.size(); i++) {
      if (head.position.x == body.positions.get(i).x && head.position.y == body.positions.get(i).y) {
        return true;
      }
    }
    return false;
  }

  boolean foodCollide() {  // Checks if the head collides with the food.
    if (head.position.x == rink.food.position.x && head.position.y == rink.food.position.y) {
      return true;
    }
    return false;
  }

  boolean wallCollide() {  // Checks if the head collides with the wall.
    boolean headInsideRinkWidth = (head.position.x < rink.x) || (head.position.x > rink.x+rink.Width);
    boolean headInsideRinkHeight = (head.position.y < rink.y) || (head.position.y > rink.y+rink.Height);
    if (headInsideRinkWidth || headInsideRinkHeight) {
      return true;
    }
    return false;
  }

  void eat() {
    body.addPixel(head.position.x, head.position.y+rink.pixelSize);
    rink.addFood();
    radar.changeDestinyPoint(rink.food.position);
    increaseScore();
    increaseRemainingMoves();
  }

  void move() { 
    if (wallCollide()) {
      die();
    }
    if (bodyCollide()) {
      die();
    }
    if (remainingMovesEnd()) {
      die();
    }
    if (foodCollide()) {
      eat();
    }
    if (isNotDead()) {
      body.move();
      head.move();
      decreaseRemainingMoves();
      radar.calculateDistance();
      snake.calculateFitness();
      print(radar.distanceToDistinyPoint);
      //print(fitness);
      print("\n");
    }
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
  
  void setVelocity() {
    velocity.x = rink.pixelSize*int(cos(theta));
    velocity.y = rink.pixelSize*int(sin(theta));
  }
  void moveLeft() { 
    theta -= PI/2;
    setVelocity();
  }
  void moveRight() { 
    theta += PI/2;
    setVelocity();
  }
}
