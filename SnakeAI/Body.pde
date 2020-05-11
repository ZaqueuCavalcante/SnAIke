class Body {

  ArrayList<PVector> position;
  float pixelSideSize;
  color Color;

  Body() {
    position = new ArrayList<PVector>();
    setColor(color(random(255), random(255), random(255)));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setFirstPixelPosition(float x_, float y_) {
    position.add(new PVector(x_, y_));
  }
  void setPixelSideSize(float pixelSideSize_) {
    pixelSideSize = pixelSideSize_;
  }
  void setColor(color Color_) {
    Color = Color_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void addPixel() {
    PVector newPixelPosition = new PVector();
    int lastPixelIndex = position.size() - 1;
    newPixelPosition.x = position.get(lastPixelIndex).x;
    newPixelPosition.y = position.get(lastPixelIndex).y + pixelSideSize;
    position.add(newPixelPosition);
    print(position.get(1).x);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void move(PVector headPosition) {
    float xFrontPixel = headPosition.x;
    float yFrontPixel = headPosition.y;
    float xBackPixel;
    float yBackPixel;
    for (int i = 0; i < position.size(); i++) {
      xBackPixel = position.get(i).x;
      yBackPixel = position.get(i).y;
      position.get(i).x = xFrontPixel;
      position.get(i).y = yFrontPixel;
      xFrontPixel = xBackPixel;
      yFrontPixel = yBackPixel;
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    fill(Color);
    stroke(255);
    for (int i = 0; i < position.size(); i++) {
      rectMode(CENTER);
      rect(position.get(i).x, position.get(i).y, pixelSideSize, pixelSideSize);
    }
  }
}
