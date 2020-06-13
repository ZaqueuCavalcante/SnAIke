class ZVector2D {

  private PVector origin;
  private float size;
  private float angle;  // Angle made with the x axis, measured clockwise.
  private float x, y;  // Coordinates of Vector2D tip.

  ZVector2D() {
    origin = new PVector();
  }
  ZVector2D(float x, float y) {
    origin = new PVector();
    this.x = x;
    this.y = y;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setOrigin(float x, float y) {
    origin.x = x;
    origin.y = y;
  }
  public PVector getOrigin() {
    return this.origin;
  }
  public void setSize(float newSize) {
    size = newSize;
  }
  public float getSize() {
    return size;
  }
  public void setAngle(float newAngle) {
    angle = newAngle;
  }
  public void incrementAngle(float angularIncrement) {
    angle += angularIncrement;
  }
  public float getAngle() {
    return angle;
  }
  public float getX() {
    return this.x;
  }
  public float getY() {
    return this.y;
  }
  public void setTip(float x, float y) {
    this.x = x;
    this.y = y;
  }
  public void updateTip() {
    x = origin.x + size*cos(angle);
    y = origin.y + size*sin(angle);
  }
}
