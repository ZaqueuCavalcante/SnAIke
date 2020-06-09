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
    brain = new Brain(9);
    radar = new Radar();

    score = 1;
    remainingMoves = 100;
    fitness = 0.0;

    live();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setInitialPosition(Rink rink) {
    body = new Body();
    float x = rink.position.x + PIXEL_SIZE/2 + int(rink.horizontalPixelNumber/2)*PIXEL_SIZE;
    float y = rink.position.y + PIXEL_SIZE/2 + int(rink.verticalPixelNumber/2)*PIXEL_SIZE;
    head.setPosition(x, y);
    
    if (body.position.size() < 5) {
      body.setFirstPixelPosition(x, y + PIXEL_SIZE);
      body.addPixel();
      body.addPixel();
      body.addPixel();
    }
    // println(body.position.size());
  }
  public void setInitialRandomPosition(Rink rink) {
    body = new Body();
    float x = rink.position.x + PIXEL_SIZE/2 + int(random(rink.horizontalPixelNumber))*PIXEL_SIZE;
    float y = rink.position.y + PIXEL_SIZE/2 + int(random(rink.verticalPixelNumber))*PIXEL_SIZE;
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
      score = -1;
      die();
    }
    if (bodyCollide()) {
      score = -5;
      die();
    }
    if (remainingMovesFinish()) {
      die();
    }
    if (foodCollide(food)) {
      eat();
      food.outside = true;
    }
    if (isNotDead()) {
      radar.calculateDistanceToFood(head, food);
      radar.calculateDistanceToLeft(this, rink);
      radar.calculateDistanceToFront(this, rink);
      radar.calculateDistanceToRight(this, rink);

      brain.flowInputLayer(head, radar, rink);
      brain.flowValuesInputToHidden();
      brain.flowHiddenLayer();
      brain.flowValuesHiddenToOutput();
      brain.flowOutputLayer();
      brain.clearValuesHiddenAndOutput();
      //radar.show();

      brain.decideTurn(head);

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
    float aux = 1 - pow(brain.inputLayer.neurons.get(3).getOutputValue(), 2)
                   - pow(brain.inputLayer.neurons.get(4).getOutputValue(), 2);
    float fitnessCalculated;

    fitnessCalculated = score*10 + aux;

    if (fitnessCalculated > 100) {println(fitnessCalculated);}
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
    clonedSnake.body.Color = this.body.Color;
    return clonedSnake;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    head.show();
    body.show();
    // radar.show();
  }
}
