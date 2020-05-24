public class Head {

  private Vector position;
  private Vector velocity;
  private color Color;

  Head() {
    position = new Vector();
    velocity = new Vector();
    velocity.setSize(PIXEL_SIZE);
    velocity.setTheta(3*PI/2);
    Color = color(100);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setPosition(float x, float y) {
    position.x = x;
    position.y = y;
    velocity.setOrigin(x, y);
  }
  public Vector getPosition() {
    return position;
  }
  public  void moveLeft() { 
    velocity.incrementTheta(-PI/2);
  }
  public void moveRight() { 
    velocity.incrementTheta(PI/2);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void move() {
    position.x += velocity.size*int(cos(velocity.getTheta()));
    position.y += velocity.size*int(sin(velocity.getTheta()));
    velocity.setOrigin(position.x, position.y);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    fill(Color);
    stroke(255);
    rectMode(CENTER);
    rect(position.x, position.y, PIXEL_SIZE, PIXEL_SIZE);
  }
}
