public class PCanvas {

  private PFont font;
  private PButton saveButton;
  private PButton loadButton;
  private PButton graphButton;
  private PButton increaseMutationRateButton;
  private PButton decreaseMutationRateButton;

  PCanvas() { 
    setFont();
    setButtons();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void setFont() {
    font = createFont("agencyfb-bold.ttf", 32);
    textFont(font);
  }
  private void setButtons() {
    saveButton = new PButton(50, 15, 100, 30, "Save");
    loadButton = new PButton(150, 15, 100, 30, "Load");
    graphButton = new PButton(250, 15, 100, 30, "Graph");
    increaseMutationRateButton = new PButton(225, 170, 20, 20, "+");
    decreaseMutationRateButton = new PButton(250, 170, 20, 20, "-");
  }
  public void setBackground() {
    background(20);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void showDividingLines() {
    stroke(255);
    line(400, 0, 400, height-350);
    line(0, 200, 400, 200);
    line(0, height-350, width, height-350);
    line(width/2.5, height-350, width/2.5, height);
  }
  public void showButtons() {
    saveButton.show();
    loadButton.show();
    graphButton.show();
    increaseMutationRateButton.show();
    decreaseMutationRateButton.show();
  }
  // Todos os métodos daqui pra baixo serão do tipo "public void show(Objeto objeto) {}".
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void showParameters(CPopulation population) {
    fill(150);
    textSize(20);
    textAlign(LEFT);
    ASnake bestSnake = population.getSnakes().get( population.getBestSnakeIndex() );
    text("SCORE : " + bestSnake.getScore(), 20, 60);
    text("BEST SCORE : " + population.getBestScore(), 180, 60); 
    text("LIVE SNAKES : " + population.getLiveSnakesNumber() + "  /  " + population.getSize(), 20, 90);
    text("GENERATION : " + population.getGeneration() + "  /  " + population.getGenerationLimit(), 20, 120);
    text("REMAINING MOVES : " + bestSnake.getRemainingMoves(), 20, 150);
    text("MUTATION RATE : " + population.getMutationRate() + " % ", 20, 180);
  }
  //public void showController(Snake snake) {
  //  snake.getController().show();
  //}
  public void show(PDashboard db) {//, Population pop) {
    //db.getScorePlot().setAxisLimits(0, pop.getGeneration()+1, 0, pop.getBestScore()+1);
    //db.getScorePlot().setAxisLimits(0, x, 0, x);
    //db.getScorePlot().setAxisInterval(x/500, x/500);
    //db.getScorePlot().addPoint(x, x);
    db.scorePlot.show();
    db.weightPlot.show();
  }

  public void show() {
  }
  
  
  
  

  public void show(CNeuralNetwork nn) {
    for (CLink link : nn.links) {
      this.show(link);
    }
    this.show(nn.inputLayer);
    this.show(nn.hiddenLayer);
    this.show(nn.outputLayer);
  }
  public void show(CLayer layer) {
    for (CNeuron neuron : layer.neurons) {
      this.show(neuron);
    }
  }
  public void show(CLink link) {
    stroke(link.getColor());
    line(link.sourceNeuron.position.x, link.sourceNeuron.position.y, link.arrivalNeuron.position.x, link.arrivalNeuron.position.y);
  }
  public void show(CNeuron neuron) {
    float x = neuron.position.getX();
    float y = neuron.position.getY();
    float r = neuron.radius;
    fill(neuron.getColor());
    stroke(255);
    ellipseMode(CENTER);
    ellipse(x, y, r, r);
    if (neuron.inputName != "" || neuron.outputName != "") {
      fill(150);
      textSize(20);
      textAlign(RIGHT);
      text(neuron.inputName, x - r, y + 0.30*r);
      textAlign(LEFT);
      text(neuron.outputName, x + r, y + 0.30*r);
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // Actors Objects show().
  public void show(ABoard board) {
    for (ZPixel pixel : board.getGrid()) {
      this.show(pixel);
    }
    noFill();
    stroke(255);
    rectMode(CORNER);
    rect(board.getPosition().getX(), board.getPosition().getY(), board.getWidth()-1, board.getHeight());
  }
  public void show(ASnake snake) {
    for (ZPixel pixel : snake.getBody()) {
      this.show(pixel);
    }
    this.show(snake.getHead());
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // R Objects show().
  public void show(RSnakeRadar radar) {
    this.show(radar.distanceToLeft);
    this.show(radar.distanceToUp);
    this.show(radar.distanceToRight);
    this.show(radar.distanceToDown);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // Z Objects show().
  public void show(ZVector2D vector) {
    if (vector.isObservable()) {
      push();
      stroke(vector.getColor());
      fill(vector.getColor());
      strokeWeight(vector.getStrokeWeight());
      line(vector.getOrigin().x, vector.getOrigin().y, vector.getX(), vector.getY());
      PVector direction = new PVector(vector.getX() - vector.getOrigin().x, vector.getY() - vector.getOrigin().y);
      float tipSize = 8;
      translate(vector.getX(), vector.getY());
      rotate(direction.heading());
      triangle(-tipSize, tipSize/2, -tipSize, -tipSize/2, 0, 0);
      pop();
    }
  }
  public void show(ZPixel pixel) {
    fill(pixel.getColor());
    stroke(pixel.getStroke());
    rectMode(CENTER);
    rect(pixel.getPosition().getX(), pixel.getPosition().getY(), pixel.getSize(), pixel.getSize());
    this.show(pixel.getPosition());
    this.show(pixel.getVelocity());
  }
}
