public class ASnake {

  private ZPixel head;
  private ArrayList<ZPixel> body;
  private color colorr;

  private int score; 
  private int remainingMoves;    
  private boolean dead;

  private FloatList genes;
  
  int apagar = 50;

  ASnake(float x, float y) {
    this.head = new ZPixel(x, y);
    this.body = new ArrayList<ZPixel>();
    this.body.add(new ZPixel(x, y));
    this.colorr = color(random(255), random(255), random(255));
    this.body.get(0).setColor(this.colorr);

    this.score = 0;
    this.remainingMoves = apagar;
    this.dead = false;

    //this.head.getVelocity().setColor(color(255, 255, 0));
    //this.head.getVelocity().setStrokeWeight(5);
    //this.head.getVelocity().makeObservable();

    this.genes = new FloatList();
    this.randomGenes();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void randomGenes() {
    int neuralNetworkLinksNumber = 10 * 10;  // 10 * número de camadas ocultas.
    for (int c = 0; c < neuralNetworkLinksNumber; c++) {
      this.genes.append(random(-10.0, 10.0));
    }
  }
  public FloatList getGenes() {
    return this.genes;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public ZPixel getHead() {
    return this.head;
  }
  public ArrayList<ZPixel> getBody() {
    return this.body;
  }
  private void bodyAddPixel() {
    float x = this.body.get(0).getPosition().getX();
    float y = this.body.get(0).getPosition().getY();
    this.body.add(new ZPixel(x, y));
    this.body.get(body.size()-1).setColor(this.colorr);
  }
  public void eat() {
    this.bodyAddPixel();
    this.increaseScore(+1);
    this.incrementRemainingMoves(+apagar);
  }
  public color getColor() {
    return this.colorr;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void move() {
    float frontPixelX = this.head.getPosition().getX();
    float frontPixelY = this.head.getPosition().getY();
    this.head.move();
    float backPixelX;
    float backPixelY;
    for (ZPixel pixel : this.body) {
      backPixelX = pixel.getPosition().getX();
      backPixelY = pixel.getPosition().getY();
      pixel.setPosition(frontPixelX, frontPixelY);
      frontPixelX = backPixelX;
      frontPixelY = backPixelY;
    }
    this.incrementRemainingMoves(-1);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void resetScore() {
    this.score = 0;
  }
  public int getScore() {
    return this.score;
  }
  public void increaseScore(int scoreIncrement) {
    this.score += scoreIncrement;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void resetRemainingMoves() {
    this.remainingMoves = apagar;
  }
  public int getRemainingMoves() {
    return this.remainingMoves;
  }
  public void incrementRemainingMoves(int increment) {
    this.remainingMoves += increment;
  }
  public boolean remainingMovesIsEnded() {
    return (this.remainingMoves <= 0);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void live() { 
    this.dead = false;
  }
  public void die() { 
    this.dead = true;
  }
  public boolean isDead() { 
    return this.dead;
  }
  public boolean isNotDead() { 
    return !this.dead;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public boolean selfCollide() {
    for (ZPixel pixel : this.body) {
      if (this.head.isAboveOf(pixel)) {
        return true;
      }
    }
    return false;
  }
  public boolean collide(ABoard board) {
    float leftLimit = board.getPosition().getX();
    float rightLimit = board.getPosition().getX() + board.getWidth();
    float upLimit = board.getPosition().getY();
    float downLimit = board.getPosition().getY() + board.getHeight();
    if (this.head.isInsideOf(leftLimit, rightLimit, upLimit, downLimit)) {
      return false;
    }
    return true;
  }
  public boolean collide(ARock rock) {
    return (this.head.isAboveOf(rock));
  }
  public boolean collide(AFood food) {
    return (this.head.isAboveOf(food));
  }

  public ASnake clone() {
    ASnake clonedSnake = new ASnake(-500, -500);
    for (int c = 0; c < this.genes.size(); c++) {
      clonedSnake.getGenes().set(c, this.genes.get(c));
    }
    clonedSnake.colorr = this.colorr;
    return clonedSnake;
  }
}
