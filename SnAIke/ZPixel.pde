public class ZPixel implements IDynamic {

  private ZVector2D position;
  private ZVector2D velocity;
  private float size;
  private color colorr;
  private color stroke;

  ZPixel(float x, float y) {
    this.position = new ZVector2D(x, y);
    this.size = 50.0;
    this.velocity = new ZVector2D(0.0, 0.0);
    this.velocity.setOrigin(x, y);
    this.velocity.setSize(this.size);
    this.velocity.setAngle(0.0);
    this.velocity.updateTip();
    this.colorr = color(100);
    this.stroke = color(255);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setPosition(float x, float y) {
    this.position.x = x;
    this.position.y = y;
    this.velocity.setOrigin(x, y);
    this.velocity.updateTip();
  }
  public ZVector2D getPosition() {
    return this.position;
  }
  public ZVector2D getVelocity() {
    return this.velocity;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void turnLeft() {
    this.velocity.incrementAngle(-PI/2);
    this.velocity.updateTip();
  }
  public void turnRight() {
    this.velocity.incrementAngle(PI/2);
    this.velocity.updateTip();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void pointToRight() {
    this.velocity.setAngle(0.0);
  }
  public void pointToDown() {
    this.velocity.setAngle(PI/2);
  }
  public void pointToLeft() {
    this.velocity.setAngle(-PI);
  }
  public void pointToUp() {
    this.velocity.setAngle(-3*PI/2);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void move() {
    position.x += velocity.size*int(cos(velocity.getAngle()));
    position.y += velocity.size*int(sin(velocity.getAngle()));
    velocity.setOrigin(position.x, position.y);
    this.velocity.updateTip();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public float getSize() {
    return this.size;
  }
  public void setColor(color colorr) {
    this.colorr = colorr;
  }
  public color getColor() {
    return this.colorr;
  }
  public void setStrokee(color stroke) {
    this.stroke = stroke;
  }
  public color getStroke() {
    return this.stroke;
  }
}
