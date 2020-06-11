public class Head {

  private Vector2D position;
  private Vector2D velocity;
  private color Color;

  Head() {
    position = new Vector2D();
    velocity = new Vector2D();
    velocity.setSize(PIXEL_SIZE);
    velocity.setAngle(3*PI/2);
    Color = color(100);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setPosition(float x, float y) {
    position.x = x;
    position.y = y;
    velocity.setOrigin(x, y);
  }
  public Vector2D getPosition() {
    return position;
  }
  public  void turnLeft() { 
    velocity.incrementAngle(-PI/2);
  }
  public void turnRight() { 
    velocity.incrementAngle(PI/2);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void move() {
    position.x += velocity.size*int(cos(velocity.getAngle()));
    position.y += velocity.size*int(sin(velocity.getAngle()));
    velocity.setOrigin(position.x, position.y);
    velocity.updateTip();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    fill(Color);
    stroke(255);
    rectMode(CENTER);
    rect(position.x, position.y, PIXEL_SIZE, PIXEL_SIZE);
    position.show();
    velocity.show();
  }
}
