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
    brain = new Brain();
    radar = new Radar();

    setScore(0);
    setRemainingMoves(100);
    setFitness(0.0);

    live();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setInitialPosition(Rink rink) {
    float x = rink.position.x + PIXEL_SIZE/2 + int(rink.horizontalPixelNumber/2)*PIXEL_SIZE;
    float y = rink.position.y + PIXEL_SIZE/2 + int(rink.verticalPixelNumber/2)*PIXEL_SIZE;
    //float x = rink.position.x + PIXEL_SIZE/2 + int(random(rink.horizontalPixelNumber))*PIXEL_SIZE;;
    //float y = rink.position.y + PIXEL_SIZE/2 + int(random(rink.verticalPixelNumber))*PIXEL_SIZE;;
    head.setPosition(x, y);
    body.setFirstPixelPosition(x, y + PIXEL_SIZE);
  }
  public void setBrain() {
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
  public void eat() {
    body.addPixel();
    increaseScore(1);
    increaseRemainingMoves(100);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public boolean bodyCollide() {  // Check if the head collides with self body.
    for (int i = 0; i < body.position.size(); i++) {
      if (head.position.x == body.position.get(i).x && head.position.y == body.position.get(i).y) {
        return true;
      }
    }
    return false;
  }
  public boolean foodCollide(Food food) {  // Checks if the head collides with the food.
    if (head.position.x == food.position.x && head.position.y == food.position.y) {
      return true;
    }
    return false;
  }
  public boolean wallCollide(Rink rink) {  // Checks if the head collides with the rink's wall.
    boolean headInsideRinkWidth = (head.position.x < rink.position.x) || (head.position.x > rink.position.x+rink.Width);
    boolean headInsideRinkHeight = (head.position.y < rink.position.y) || (head.position.y > rink.position.y+rink.Height);
    if (headInsideRinkWidth || headInsideRinkHeight) {
      return true;
    }
    return false;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void move(Rink rink) { 
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
  public void setScore(int score_) {
    score = score_;
  }
  public int getScore() {
    return score;
  }
  public void increaseScore(int scoreIncrement) {
    score += scoreIncrement;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setRemainingMoves(int remainingMoves_) {
    remainingMoves = remainingMoves_;
  }
  public int getRemainingMoves() {
    return remainingMoves;
  }
  public void increaseRemainingMoves(int remainingMovesIncrement) {
    remainingMoves += remainingMovesIncrement;
  }
  public void decreaseRemainingMoves() {
    remainingMoves --;
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
