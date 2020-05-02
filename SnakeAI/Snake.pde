class Snake {

  Head head;
  Body body;

  //  NeuralNet brain;  // Snakes brain.
  //  float[] vision;  // Snakes vision.
  //  float[] decision;  // Snakes decision.  
  boolean dead = false;
  //  boolean replay = false;  // If this snake is a replay of best snake.

  int xVelocity, yVelocity;  // Orthogonal components of snake speed.
  float theta;

  int score = 0;  // Length/amount of pixels of the snake.
  int remainingMoves = (rink.Width + rink.Height)/(2*screen.pixelSize);  // Amount of moves the snake can make before it dies.
  //  int lifetime = 0;  // Amount of time the snake has been alive.
  //  float fitness = 0;  // It measures how adapted the snake is, that is, how efficient it is in eating food and avoiding obstacles.

  //  Food food;
  //  ArrayList<Food> foodList;  // List of food positions (used to replay the best snake).
  //  int foodIterate = 0;  // Iterator to run through the foodList (used for replay).

  Snake() {
    setTheta();
    setVelocity();
    head = new Head();
    body = new Body();
    body.addPixel(head.x, head.y+screen.pixelSize);
    body.addPixel(head.x, head.y+2*screen.pixelSize);
    body.addPixel(head.x, head.y+3*screen.pixelSize);
    body.addPixel(head.x, head.y+4*screen.pixelSize);
    //body.addPixel(head.x, head.y+5*screen.pixelSize);
    //body.addPixel(head.x, head.y+6*screen.pixelSize);
    //body.addPixel(head.x, head.y+7*screen.pixelSize);
    //body.addPixel(head.x, head.y+8*screen.pixelSize);
    //body.addPixel(head.x, head.y+9*screen.pixelSize);
    //body.addPixel(head.x, head.y+10*screen.pixelSize);
    increaseScore();
  }

  void increaseScore() {
    score ++;
  }
  void increaseRemainingMoves() {
    remainingMoves += 100;
  }

  void setTheta() {
    theta = 3*PI/2;
  }

  void show() {
    head.show();
    body.show();
  }


  //  Snake() {
  //    head = new PVector(xInitialPosition, yInitialPosition);
  //    food = new Food();
  //    body = new ArrayList<PVector>();
  //    if (!humanPlaying) {
  //      vision = new float[inputNodesNumber];
  //      decision = new float[outputNodesNumber];
  //      foodList = new ArrayList<Food>();
  //      foodList.add(food.clone());
  //      brain = new NeuralNet(inputNodesNumber, hiddenNodesNumber, hiddenLayersNumber, outputNodesNumber);
  //      body.add(new PVector(xInitialPosition, yInitialPosition+SIZE));  
  //      score += 1;
  //    }
  //  }

  //  Snake(ArrayList<Food> foodsArray) {  // This constructor passes in a list of food positions so that a replay can replay the best snake.
  //    head = new PVector(xInitialPosition, yInitialPosition);
  //    replay = true;
  //    vision = new float[inputNodesNumber];
  //    decision = new float[outputNodesNumber];
  //    body = new ArrayList<PVector>();
  //    foodList = new ArrayList<Food>(foodsArray.size());
  //    for (Food f : foodsArray) {  // Clone all the food positions in the foodList.
  //      foodList.add(f.clone());
  //    }
  //    food = foodList.get(foodIterate);
  //    foodIterate ++;
  //    body.add(new PVector(xInitialPosition, yInitialPosition+SIZE));
  //    score += 1;
  //  }

  boolean bodyCollide() {  // Check if the head collides with self body.
    for (int i = 0; i < body.positions.size(); i++) {
      if (head.x == body.positions.get(i).x && head.y == body.positions.get(i).y) {
        return true;
      }
    }
    return false;
  }

  boolean foodCollide() {  // Checks if the head collides with the food.
    if (head.x == food.position.x && head.y == food.position.y) {
      return true;
    }
    return false;
  }

  boolean wallCollide() {  // Checks if the head collides with the wall.
    boolean headInsideRinkWidth = (head.x < rink.x) || (head.x > rink.x+rink.Width);
    boolean headInsideRinkHeight = (head.y < rink.y) || (head.y > rink.y+rink.Height);
    if (headInsideRinkWidth || headInsideRinkHeight) {
      return true;
    }
    return false;
  }

  void eat() {
    body.addPixel(head.x, head.y+screen.pixelSize);
    food = new Food();
    increaseScore();
    increaseRemainingMoves();
    
    //int snakeLength = body.size() - 1;
    //score ++;
    //if (!humanPlaying && !modelLoaded) {
    //  if (lifeLeft < 500) {
    //    if (lifeLeft > 400) {
    //      lifeLeft = 500;
    //    } else {
    //      lifeLeft += 100;
    //    }
    //  }
    //}
    //if (snakeLength >= 0) {
    //  body.add(new PVector(body.get(snakeLength).x, body.get(snakeLength).y));
    //} else {
    //  body.add(new PVector(head.x, head.y));
    //}
    //if (!replay) {
    //  food = new Food();
    //  while (bodyCollide(food.position.x, food.position.y)) {
    //    food = new Food();
    //  }
    //  if (!humanPlaying) {
    //    foodList.add(food);
    //  }
    //} else {  // If the snake is a replay, then we dont want to create new random foods, we want to see the positions the best snake had to collect.
    //  food = foodList.get(foodIterate);
    //  foodIterate ++;
    //}
  }

  void move() { 
    //if (!humanPlaying && !modelLoaded) {
    //  lifetime ++;
    //  lifeLeft --;
    //}
    if (wallCollide()) {
      die();
    }
    if (bodyCollide()) {
      die();
    }
    if (foodCollide()) {
      eat();
    }
    if (isNotDead()) {
      
      body.move();
      head.move();
    }
  }

  void die() {
    dead = true;
  }

  boolean isNotDead() {
    return !dead;
  }

  void setVelocity() {
    xVelocity = screen.pixelSize*int(cos(theta));
    yVelocity = screen.pixelSize*int(sin(theta));
  }
  void moveLeft() { 
    theta -= PI/2;
    setVelocity();
  }
  void moveRight() { 
    theta += PI/2;
    setVelocity();
  }

  //  Snake cloneForReplay() {  // Clone a version of the snake that will be used for a replay.
  //    Snake clone = new Snake(foodList);
  //    clone.brain = brain.clone();
  //    return clone;
  //  }

  //  Snake clone() {  // Clone the snake.
  //    Snake clone = new Snake();
  //    clone.brain = brain.clone();
  //    return clone;
  //  }

  //  Snake crossover(Snake parent) {  // Crossover the snake with another snake.
  //    Snake child = new Snake();
  //    child.brain = brain.crossover(parent.brain);
  //    return child;
  //  }

  //  void mutate() {  // Mutate the snakes brain.
  //    brain.mutate(mutationRate);
  //  }

  //  void calculateFitness() {  // Calculate the fitness of the snake.
  //    if (score < 10) {
  //      fitness = floor(lifetime*lifetime) * pow(2, score);
  //    } else {
  //      fitness = floor(lifetime*lifetime);
  //      fitness *= pow(2, 10);
  //      fitness *= (score-9);
  //    }
  //  }

  //  void look() {  // Look in all 8 directions and check for food, body and wall.
  //    vision = new float[24];
  //    float[] temp = lookInDirection(new PVector(-SIZE, 0));
  //    vision[0] = temp[0];
  //    vision[1] = temp[1];
  //    vision[2] = temp[2];
  //    temp = lookInDirection(new PVector(-SIZE, -SIZE));
  //    vision[3] = temp[0];
  //    vision[4] = temp[1];
  //    vision[5] = temp[2];
  //    temp = lookInDirection(new PVector(0, -SIZE));
  //    vision[6] = temp[0];
  //    vision[7] = temp[1];
  //    vision[8] = temp[2];
  //    temp = lookInDirection(new PVector(SIZE, -SIZE));
  //    vision[9] = temp[0];
  //    vision[10] = temp[1];
  //    vision[11] = temp[2];
  //    temp = lookInDirection(new PVector(SIZE, 0));
  //    vision[12] = temp[0];
  //    vision[13] = temp[1];
  //    vision[14] = temp[2];
  //    temp = lookInDirection(new PVector(SIZE, SIZE));
  //    vision[15] = temp[0];
  //    vision[16] = temp[1];
  //    vision[17] = temp[2];
  //    temp = lookInDirection(new PVector(0, SIZE));
  //    vision[18] = temp[0];
  //    vision[19] = temp[1];
  //    vision[20] = temp[2];
  //    temp = lookInDirection(new PVector(-SIZE, SIZE));
  //    vision[21] = temp[0];
  //    vision[22] = temp[1];
  //    vision[23] = temp[2];
  //  }

  //  float[] lookInDirection(PVector direction) {  // Look in a direction and check for food, body and wall.
  //    float look[] = new float[3];
  //    PVector virtualHeadPosition = new PVector(head.x, head.y);
  //    float distance = 0;
  //    boolean foodFound = false;
  //    boolean bodyFound = false;
  //    virtualHeadPosition.add(direction);
  //    distance += 1;
  //    while (!wallCollide(virtualHeadPosition.x, virtualHeadPosition.y)) {
  //      if (!foodFound && foodCollide(virtualHeadPosition.x, virtualHeadPosition.y)) {
  //        foodFound = true;
  //        look[0] = 1;
  //      }
  //      if (!bodyFound && bodyCollide(virtualHeadPosition.x, virtualHeadPosition.y)) {
  //        bodyFound = true;
  //        look[1] = 1;
  //      }
  //      if (replay && showSnakesVision) {
  //        stroke(0, 255, 0);
  //        point(virtualHeadPosition.x, virtualHeadPosition.y);
  //        if (foodFound) {
  //          noStroke();
  //          fill(255, 255, 51);
  //          ellipseMode(CENTER);
  //          ellipse(virtualHeadPosition.x, virtualHeadPosition.y, 5, 5);
  //        }
  //        if (bodyFound) {
  //          noStroke();
  //          fill(102, 0, 102);
  //          ellipseMode(CENTER);
  //          ellipse(virtualHeadPosition.x, virtualHeadPosition.y, 5, 5);
  //        }
  //      }
  //      virtualHeadPosition.add(direction);
  //      distance += 1;
  //    }
  //    if (replay && showSnakesVision) {
  //      noStroke();
  //      fill(0, 255, 0);
  //      ellipseMode(CENTER);
  //      ellipse(virtualHeadPosition.x, virtualHeadPosition.y, 10, 10);
  //    }
  //    look[2] = 1/distance;
  //    return look;
  //  }

  //  void think() {  // Think about what direction to move.
  //    decision = brain.output(vision);
  //    int maxIndex = 0;
  //    float max = 0;
  //    for (int i = 0; i < decision.length; i++) {
  //      if (decision[i] > max) {
  //        max = decision[i];
  //        maxIndex = i;
  //      }
  //    }

  //    switch(maxIndex) {
  //    case 0:
  //      moveUp();
  //      break;
  //    case 1:
  //      moveDown();
  //      break;
  //    case 2:
  //      moveLeft();
  //      break;
  //    case 3: 
  //      moveRight();
  //      break;
  //    }
  //  }
}
