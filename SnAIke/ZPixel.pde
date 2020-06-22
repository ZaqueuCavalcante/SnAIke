public class ZPixel {

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
  public void setPosition(ZPixel otherPixel) {
    float x = otherPixel.getPosition().getX();
    float y = otherPixel.getPosition().getY();
    this.setPosition(x, y);
  }
  public ZVector2D getPosition() {
    return this.position;
  }
  public ZVector2D getVelocity() {
    return this.velocity;
  }
  public float getSize() {
    return this.size;
  }
  private void pointTo(float angle) {
    this.velocity.setAngle(angle);
    this.velocity.updateTip();
  }
  public void pointToRight() {
    this.pointTo(0.0);
  }
  public void pointToDown() {
    this.pointTo(PI/2);
  }
  public void pointToLeft() {
    this.pointTo(PI);
  }
  public void pointToUp() {
    this.pointTo(3*PI/2);
  }
  public void move() {
    this.position.x += this.velocity.getSize() * int(cos(this.velocity.getAngle()));
    this.position.y += this.velocity.getSize() * int(sin(this.velocity.getAngle()));
    this.velocity.setOrigin(this.position.getX(), this.position.getY());
    this.velocity.updateTip();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setColor(color newColor) {
    this.colorr = newColor;
  }
  public color getColor() {
    return this.colorr;
  }
  public void setStrokee(color newStroke) {
    this.stroke = newStroke;
  }
  public color getStroke() {
    return this.stroke;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public boolean isAboveOf(ZPixel pixel) {
    float leftLimit = pixel.getPosition().getX() - pixel.getSize()/2;
    float rightLimit = pixel.getPosition().getX() + pixel.getSize()/2;
    float upLimit = pixel.getPosition().getY() - pixel.getSize()/2;
    float downLimit = pixel.getPosition().getY() + pixel.getSize()/2;
    return this.isInsideOf(leftLimit, rightLimit, upLimit, downLimit);
  }
  public boolean isInsideOf(float leftLimit, float rightLimit, float upLimit, float downLimit) {
    float x = this.position.getX();
    float y = this.position.getY();
    boolean insideWidth = (x > leftLimit) && (x < rightLimit);
    boolean insideHeight = (y > upLimit) && (y < downLimit);
    return (insideWidth && insideHeight);
  }
}
