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
    brain = new Brain(7, 10, 2);
    radar = new Radar();

    score = 0;
    remainingMoves = 100;
    fitness = 0.0;

    live();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setInitialPosition(Rink rink) {
    float x = rink.position.x + PIXEL_SIZE/2 + int(rink.horizontalPixelNumber/2)*PIXEL_SIZE;
    float y = rink.position.y + PIXEL_SIZE/2 + int(rink.verticalPixelNumber/2)*PIXEL_SIZE;
    head.setPosition(x, y);
    body.setFirstPixelPosition(x, y + PIXEL_SIZE);
  }
  public void randomInitialPosition(Rink rink) {
    float x = rink.position.x + PIXEL_SIZE/2 + int(random(rink.horizontalPixelNumber))*PIXEL_SIZE;;
    float y = rink.position.y + PIXEL_SIZE/2 + int(random(rink.verticalPixelNumber))*PIXEL_SIZE;;
    head.setPosition(x, y);
    body.setFirstPixelPosition(x, y + PIXEL_SIZE);
  }
  public void setBrain() {
    brain.setFirstLayerCenterPosition(100, 550);
    brain.setHorizontalDistanceBetweenLayers(110);
    brain.setVerticalDistanceBetweenNeurons(70);

    brain.setInputLayer();
    brain.setHiddenLayer();
    brain.setOutputLayer();

    brain.inputLayer.setNeuronInputName(0, "Bias");
    brain.inputLayer.setNeuronInputName(1, "Dx");
    brain.inputLayer.setNeuronInputName(2, "Dy");
    brain.inputLayer.setNeuronInputName(3, "Theta");
    brain.inputLayer.setNeuronInputName(4, "Left Wall");
    brain.inputLayer.setNeuronInputName(5, "Front Wall");
    brain.inputLayer.setNeuronInputName(6, "Right Wall");

    brain.outputLayer.setNeuronOutputName(0, "Left");
    brain.outputLayer.setNeuronOutputName(1, "Right");

    brain.connectLayers(brain.inputLayer, brain.hiddenLayer);
    brain.connectLayers(brain.hiddenLayer, brain.outputLayer);
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
  public void setFitness(float fitness_) {
    fitness = fitness_;
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
