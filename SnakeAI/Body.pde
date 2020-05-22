public class Body {

  private ArrayList<Vector> position;
  private color Color;

  Body() {
    this.position = new ArrayList<Vector>();
    this.setColor(color(random(255), random(255), random(255)));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setFirstPixelPosition(float x, float y) {
    this.position.add(new Vector(x, y));
  }
  public ArrayList<Vector> getPosition() {
    return position;
  }
  public void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void addPixel() {
      Vector newPixelPosition = new Vector();
      int lastIndex = position.size()-1;
      newPixelPosition.x = position.get(lastIndex).x;
      newPixelPosition.y = position.get(lastIndex).y;
      position.add(newPixelPosition);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void move(PVector headPosition) {
    float xFrontPixel = headPosition.x;
    float yFrontPixel = headPosition.y;
    float xBackPixel;
    float yBackPixel;
    for (int i = 0; i < this.position.size(); i++) {
      xBackPixel = this.position.get(i).x;
      yBackPixel = this.position.get(i).y;
      this.position.get(i).x = xFrontPixel;
      this.position.get(i).y = yFrontPixel;
      xFrontPixel = xBackPixel;
      yFrontPixel = yBackPixel;
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    fill(this.Color);
    stroke(255);
    for (int i = 0; i < this.position.size(); i++) {
      rectMode(CENTER);
      rect(this.position.get(i).x, this.position.get(i).y, PIXEL_SIZE, PIXEL_SIZE);
    }
  }
}
