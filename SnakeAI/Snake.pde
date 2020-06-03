public class Snake {

  private Head head;
  private Body body;
  private Brain brain;
  private Radar radar;

  private int score; 
  private int remainingMoves;  
  private float fitness;  

  private boolean dead;

  Snake() {
    head = new Head();
    body = new Body();
    brain = new Brain(10);
    radar = new Radar();

    score = 0;
    remainingMoves = 1000;
    fitness = 0.0;

    live();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setInitialPosition(Rink rink) {
    body = new Body();
    float x = rink.position.x + PIXEL_SIZE/2 + int(rink.horizontalPixelNumber/2)*PIXEL_SIZE;
    float y = rink.position.y + PIXEL_SIZE/2 + int(rink.verticalPixelNumber/2)*PIXEL_SIZE;
    head.setPosition(x, y);
    body.setFirstPixelPosition(x, y + PIXEL_SIZE);
  }
  public void setBrain() {
    brain.setDistances(110, 70);
    brain.setLayersPositions(100, 550);
  }
  public void setRemainingMoves(int remainingMoves) {
    this.remainingMoves = remainingMoves;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void eat() {
    body.addPixel();
    increaseScore(1);
    increaseRemainingMoves(100);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public boolean bodyCollide() {
    for (int i = 0; i < body.position.size(); i++) {
      if (head.position.x == body.position.get(i).x && head.position.y == body.position.get(i).y) {
        return true;
      }
    }
    return false;
  }
  public boolean foodCollide(Food food) {
    if (head.position.x == food.position.x && head.position.y == food.position.y) {
      return true;
    }
    return false;
  }
  public boolean wallCollide(Rink rink) {
    boolean headInsideRinkWidth = (head.position.x < rink.position.x) || (head.position.x > rink.position.x+rink.Width);
    boolean headInsideRinkHeight = (head.position.y < rink.position.y) || (head.position.y > rink.position.y+rink.Height);
    if (headInsideRinkWidth || headInsideRinkHeight) {
      return true;
    }
    return false;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void move(Rink rink, Food food) { 
    if (wallCollide(rink)) {
      die();
    }
    if (bodyCollide()) {
      die();
    }
    if (remainingMovesFinish()) {
      die();
    }
    if (foodCollide(food)) {
      eat();
      food.setPosition(0.0, 0.0);
    }
    if (isNotDead()) {
      PVector headPreviousPosition = new PVector(head.position.x, head.position.y);
      head.move();
      body.move(headPreviousPosition);
      decreaseRemainingMoves(1);
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public int getScore() {
    return score;
  }
  public void increaseScore(int scoreIncrement) {
    score += scoreIncrement;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public int getRemainingMoves() {
    return remainingMoves;
  }
  public void increaseRemainingMoves(int increment) {
    remainingMoves += increment;
  }
  public void decreaseRemainingMoves(int decrement) {
    remainingMoves -= decrement;
  }
  public boolean remainingMovesFinish() {
    if (remainingMoves == 0) {
      return true;
    } else {
      return false;
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setFitness(float fitness) {
    this.fitness = fitness;
  }
  public float getFitness() {
    return fitness;
  }
  public void calculateFitness() {
    float fitnessCalculated  = score*10 + remainingMoves/10;
    setFitness(fitnessCalculated);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void live() { 
    dead = false;
  }
  public void die() { 
    dead = true;
  }
  public boolean isDead() { 
    return dead;
  }
  public boolean isNotDead() { 
    return !dead;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public Snake clone() {
    Snake clonedSnake = new Snake();
    clonedSnake.brain = this.brain;
    return clonedSnake;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    head.show();
    body.show();
  }
}
