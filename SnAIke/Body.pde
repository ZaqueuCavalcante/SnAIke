public class Body {

  private ArrayList<Vector2D> position;
  private color Color;

  Body() {
    position = new ArrayList<Vector2D>();
    Color = color(random(255), random(255), random(255));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setFirstPixelPosition(float x, float y) {
    position.add(new Vector2D(x, y));
  }
  public ArrayList<Vector2D> getPosition() {
    return position;
  }
  public void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void addPixel() {
    Vector2D newPixelPosition = new Vector2D();
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
    fill(Color);
    stroke(255);
    for (int i = 0; i < position.size(); i++) {
      rectMode(CENTER);
      rect(position.get(i).x, position.get(i).y, PIXEL_SIZE, PIXEL_SIZE);
    }
  }
}
