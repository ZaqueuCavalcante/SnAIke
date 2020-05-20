class Body {

  ArrayList<Vector> position;
  color Color;

  Body() {
    this.position = new ArrayList<Vector>();
    this.setColor(color(0,0,255));//(color(random(255), random(255), random(255)));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setFirstPixelPosition(float x, float y) {
    this.position.add(new Vector(x, y));
  }
  ArrayList<Vector> getPosition() {
    return position;
  }
  void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void addPixel() {
      Vector newPixelPosition = new Vector();
      int lastIndex = position.size()-1;
      newPixelPosition.x = position.get(lastIndex).x;
      newPixelPosition.y = position.get(lastIndex).y;
      position.add(newPixelPosition);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void move(PVector headPosition) {
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
  void show() {
    fill(this.Color);
    stroke(255);
    for (int i = 0; i < this.position.size(); i++) {
      rectMode(CENTER);
      rect(this.position.get(i).x, this.position.get(i).y, PIXEL_SIZE, PIXEL_SIZE);
    }
  }
}
