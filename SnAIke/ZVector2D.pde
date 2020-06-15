class ZVector2D {

  private PVector origin;
  private float size;
  private float angle;  // Angle made with the x axis, measured clockwise.
  private float x, y;  // Coordinates of Vector2D tip.
  private boolean observable;
  private color colorr;
  private float strokeWeight;

  ZVector2D() {
    this.origin = new PVector();
    this.observable = false;
    this.colorr = color(255);
    this.strokeWeight = 1;
  }
  ZVector2D(float x, float y) {
    this.origin = new PVector();
    this.x = x;
    this.y = y;
    this.observable = false;
    this.colorr = color(255);
    this.strokeWeight = 1;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setOrigin(float x, float y) {
    this.origin.x = x;
    this.origin.y = y;
  }
  public PVector getOrigin() {
    return this.origin;
  }
  public void setSize(float newSize) {
    this.size = newSize;
  }
  public float getSize() {
    return this.size;
  }
  public void setAngle(float newAngle) {
    this.angle = newAngle;
  }
  public void incrementAngle(float angularIncrement) {
    this.angle += angularIncrement;
  }
  public float getAngle() {
    return this.angle;
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
    this.x = this.origin.x + this.size*cos(this.angle);
    this.y = this.origin.y + this.size*sin(this.angle);
  }
  public void makeObservable() {
    this.observable = true;
  }
  public void makeUnobservable() {
    this.observable = false;
  }
  public boolean isObservable() {
    return this.observable;
  }
  public boolean tipIsInsideOf(float leftLimit, float rightLimit, float upLimit, float downLimit) {
    boolean insideWidth = (this.x > leftLimit) && (this.x < rightLimit);
    boolean insideHeight = (this.y > upLimit) && (this.y < downLimit);
    return (insideWidth && insideHeight);
  }
  public void setColor(color colorr) {
    this.colorr = colorr;
  }
  public color getColor() {
    return this.colorr;
  }
  public void setStrokeWeight(float value) {
    this.strokeWeight = value;
  }
  public float getStrokeWeight() {
    return this.strokeWeight;
  }
}
