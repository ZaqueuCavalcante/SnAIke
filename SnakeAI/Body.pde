class Body {

  ArrayList<PVector> position;
  float pixelSideSize;
  color Color;

  Body() {
    this.position = new ArrayList<PVector>();
    this.setColor(color(random(255), random(255), random(255)));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setFirstPixelPosition(float x, float y) {
    this.position.add(new PVector(x, y));
  }
  void setPixelSideSize(float pixelSideSize) {
    this.pixelSideSize = pixelSideSize;
  }
  void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void addPixel() {
    PVector newPixelPosition = new PVector();
    this.position.add(newPixelPosition);
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
      rect(this.position.get(i).x, this.position.get(i).y, this.pixelSideSize, this.pixelSideSize);
    }
  }
}
