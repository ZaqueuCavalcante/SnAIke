class Snake {

  int score = 1;  // Length/amount of squares of the snake.
  int lifeLeft = 200;  // Amount of moves the snake can make before it dies.
  int lifetime = 0;  // Amount of time the snake has been alive.
  int xVel, yVel;  // Orthogonal components of snake speed.
  int foodIterate = 0;  // Iterator to run through the foodlist (used for replay).

  float fitness = 0;

  boolean dead = false;
  boolean replay = false;  // If this snake is a replay of best snake.

  float[] vision;  // Snakes vision.
  float[] decision;  // Snakes decision.

  PVector head;  // Head of snake.

  ArrayList<PVector> body;  // Snakes body.
  ArrayList<Food> foodList;  // List of food positions (used to replay the best snake).

  Food food;
  NeuralNet brain;

  Snake() {
    this(hidden_layers);
  }

  Snake(int layers) {
    head = new PVector(800, height/2);
    food = new Food();
    body = new ArrayList<PVector>();
    if (!humanPlaying) {
      vision = new float[24];
      decision = new float[4];
      foodList = new ArrayList<Food>();
      foodList.add(food.clone());
      brain = new NeuralNet(24, hidden_nodes, 4, layers);
      body.add(new PVector(800, (height/2)+SIZE));  
      body.add(new PVector(800, (height/2)+(2*SIZE)));
      score += 2;
    }
  }

  Snake(ArrayList<Food> foods) {  // This constructor passes in a list of food positions so that a replay can replay the best snake.
    replay = true;
    vision = new float[24];
    decision = new float[4];
    body = new ArrayList<PVector>();
    foodList = new ArrayList<Food>(foods.size());
    for (Food f : foods) {  // Clone all the food positions in the foodList.
      foodList.add(f.clone());
    }
    food = foodList.get(foodIterate);
    foodIterate ++;
    head = new PVector(800, height/2);
    body.add(new PVector(800, (height/2)+SIZE));
    body.add(new PVector(800, (height/2)+(2*SIZE)));
    score += 2;
  }

  boolean bodyCollide(float x, float y) {  // Check if a position collides with the snakes body.
    for (int i = 0; i < body.size(); i++) {
      if (x == body.get(i).x && y == body.get(i).y) {
        return true;
      }
    }
    return false;
  }

  boolean foodCollide(float x, float y) {  // Check if a position collides with the food.
    if (x == food.position.x && y == food.position.y) {
      return true;
    }
    return false;
  }

  boolean wallCollide(float x, float y) {  // Check if a position collides with the wall.
    if (x >= width-(SIZE) || x < 400+SIZE || y >= height-(SIZE) || y < SIZE) {
      return true;
    }
    return false;
  }

  void show() {
    food.show();
    fill(255);
    stroke(0);
    for (int i = 0; i < body.size(); i++) {
      rect(body.get(i).x, body.get(i).y, SIZE, SIZE);
    }
    if (dead) {
      fill(150);
    } else {
      fill(255);
    }
    rect(head.x, head.y, SIZE, SIZE);
  }
  
  void eat() { 
    int snakeLength = body.size() - 1;
    score ++;  // Mudar a depender da cor da comida.
    if (!humanPlaying && !modelLoaded) {
      if (lifeLeft < 500) {
        if (lifeLeft > 400) {
          lifeLeft = 500;
        } else {
          lifeLeft += 100;
        }
      }
    }
    if (snakeLength >= 0) {
      body.add(new PVector(body.get(snakeLength).x, body.get(snakeLength).y));
    } else {
      body.add(new PVector(head.x, head.y));
    }
    if (!replay) {
      food = new Food();
      while (bodyCollide(food.position.x, food.position.y)) {
        food = new Food();
      }
      if (!humanPlaying) {
        foodList.add(food);
      }
    } else {  // If the snake is a replay, then we dont want to create new random foods, we want to see the positions the best snake had to collect.
      food = foodList.get(foodIterate);
      foodIterate ++;
    }
  }
  
  void move() {
    if (!dead) {
      if (!humanPlaying && !modelLoaded) {
        lifetime ++;
        lifeLeft --;
      }
      if (foodCollide(head.x, head.y)) {
        eat();
      }
      shiftBody();
      if (wallCollide(head.x, head.y)) {
        dead = true;
      } else if (bodyCollide(head.x, head.y)) {
        dead = true;
      } else if (lifeLeft <= 0 && !humanPlaying) {
        dead = true;
      }
    }
  }

  void shiftBody() {  // Shift the body to follow the head.
    float xFrontSquarePosition = head.x;
    float yFrontSquarePosition = head.y;
    head.x += xVel;
    head.y += yVel;
    float xBackSquarePosition;
    float yBackSquarePosition;
    for (int i = 0; i < body.size(); i++) {
      xBackSquarePosition = body.get(i).x;
      yBackSquarePosition = body.get(i).y;
      body.get(i).x = xFrontSquarePosition;
      body.get(i).y = yFrontSquarePosition;
      xFrontSquarePosition = xBackSquarePosition;
      yFrontSquarePosition = yBackSquarePosition;
    }
  }

  Snake cloneForReplay() {  // Clone a version of the snake that will be used for a replay.
    Snake clone = new Snake(foodList);
    clone.brain = brain.clone();
    return clone;
  }

  Snake clone() {  // Clone the snake.
    Snake clone = new Snake(hidden_layers);
    clone.brain = brain.clone();
    return clone;
  }

  Snake crossover(Snake parent) {  // Crossover the snake with another snake.
    Snake child = new Snake(hidden_layers);
    child.brain = brain.crossover(parent.brain);
    return child;
  }

  void mutate() {  // Mutate the snakes brain.
    brain.mutate(mutationRate);
  }

  void calculateFitness() {  // Calculate the fitness of the snake.
    if (score < 10) {
      fitness = floor(lifetime*lifetime) * pow(2, score);
    } else {
      fitness = floor(lifetime*lifetime);
      fitness *= pow(2, 10);
      fitness *= (score-9);
    }
  }

  void look() {  // Look in all 8 directions and check for food, body and wall.
    vision = new float[24];
    float[] temp = lookInDirection(new PVector(-SIZE/4, 0));
    vision[0] = temp[0];
    vision[1] = temp[1];
    vision[2] = temp[2];
    temp = lookInDirection(new PVector(-SIZE/4, -SIZE/4));
    vision[3] = temp[0];
    vision[4] = temp[1];
    vision[5] = temp[2];
    temp = lookInDirection(new PVector(0, -SIZE/4));
    vision[6] = temp[0];
    vision[7] = temp[1];
    vision[8] = temp[2];
    temp = lookInDirection(new PVector(SIZE/4, -SIZE/4));
    vision[9] = temp[0];
    vision[10] = temp[1];
    vision[11] = temp[2];
    temp = lookInDirection(new PVector(SIZE/4, 0));
    vision[12] = temp[0];
    vision[13] = temp[1];
    vision[14] = temp[2];
    temp = lookInDirection(new PVector(SIZE/4, SIZE/4));
    vision[15] = temp[0];
    vision[16] = temp[1];
    vision[17] = temp[2];
    temp = lookInDirection(new PVector(0, SIZE/4));
    vision[18] = temp[0];
    vision[19] = temp[1];
    vision[20] = temp[2];
    temp = lookInDirection(new PVector(-SIZE/4, SIZE/4));
    vision[21] = temp[0];
    vision[22] = temp[1];
    vision[23] = temp[2];
  }

  float[] lookInDirection(PVector direction) {  // Look in a direction and check for food, body and wall.
    float look[] = new float[3];
    PVector virtualHeadPosition = new PVector(head.x, head.y);
    float distance = 0;
    boolean foodFound = false;
    boolean bodyFound = false;
    virtualHeadPosition.add(direction);  // Tudo se passa como se a cabeça estivesse um quadrado a frente, na direção escolhida.
    distance += 1;
    while (!wallCollide(virtualHeadPosition.x, virtualHeadPosition.y)) {
      if (!foodFound && foodCollide(virtualHeadPosition.x, virtualHeadPosition.y)) {
        foodFound = true;
        look[0] = 1;
      }
      if (!bodyFound && bodyCollide(virtualHeadPosition.x, virtualHeadPosition.y)) {
        bodyFound = true;
        look[1] = 1;
      }
      if (replay && showSnakesVision) {
        stroke(0, 255, 0);
        point(virtualHeadPosition.x, virtualHeadPosition.y);
        if (foodFound) {
          noStroke();
          fill(255, 255, 51);
          ellipseMode(CENTER);
          ellipse(virtualHeadPosition.x, virtualHeadPosition.y, 5, 5);
        }
        if (bodyFound) {
          noStroke();
          fill(102, 0, 102);
          ellipseMode(CENTER);
          ellipse(virtualHeadPosition.x, virtualHeadPosition.y, 5, 5);
        }
      }
      virtualHeadPosition.add(direction);
      distance += 1;
    }
    if (replay && showSnakesVision) {
      noStroke();
      fill(0, 255, 0);
      ellipseMode(CENTER);
      ellipse(virtualHeadPosition.x, virtualHeadPosition.y, 5, 5);
    }
    look[2] = 1/distance;
    return look;
  }

  void think() {  // Think about what direction to move.
    decision = brain.output(vision);
    int maxIndex = 0;
    float max = 0;
    for (int i = 0; i < decision.length; i++) {
      if (decision[i] > max) {
        max = decision[i];
        maxIndex = i;
      }
    }

    switch(maxIndex) {
    case 0:
      moveUp();
      break;
    case 1:
      moveDown();
      break;
    case 2:
      moveLeft();
      break;
    case 3: 
      moveRight();
      break;
    }
  }

  void moveUp() { 
    if (yVel != SIZE) {
      xVel = 0; 
      yVel = -SIZE;
    }
  }
  void moveDown() { 
    if (yVel != -SIZE) {
      xVel = 0; 
      yVel = SIZE;
    }
  }
  void moveLeft() { 
    if (xVel != SIZE) {
      xVel = -SIZE; 
      yVel = 0;
    }
  }
  void moveRight() { 
    if (xVel != -SIZE) {
      xVel = SIZE; 
      yVel = 0;
    }
  }
}
