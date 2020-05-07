class Body {

  ArrayList<PVector> position;
  float pixelSideSize;
  color Color;

  Body() {
    position = new ArrayList<PVector>();
    setColor(color(random(255), random(255), random(255)));
  }

  void setFirstPixelPosition(float x_, float y_) {
    position.add(new PVector(x_, y_));
  }
  void setPixelSideSize(float pixelSideSize_) {
    pixelSideSize = pixelSideSize_;
  }
  void setColor(color Color_) {
    Color = Color_;
  }

  void addPixel() {
    PVector newPixelPosition = new PVector();
    newPixelPosition.x = position.get(0).x;
    newPixelPosition.y = position.get(0).y + pixelSideSize;
    position.add(newPixelPosition);
  }

  void show() {
    fill(Color);
    stroke(255);
    for (int i = 0; i < position.size(); i++) {
      rectMode(CENTER);
      rect(position.get(i).x, position.get(i).y, pixelSideSize, pixelSideSize);
    }
  }

  void move() {  // Shift the body to follow the head.
    float xFrontPixel;
    float yFrontPixel;
    float xBackPixel;
    float yBackPixel;
    for (int i = 0; i < position.size(); i++) {
      xFrontPixel = position.get(i).x;
      yFrontPixel = position.get(i).y;
      xBackPixel = position.get(i+1).x;
      yBackPixel = position.get(i+1).y;
      position.get(i+1).x = xFrontPixel;
      position.get(i).y = yFrontPixel;
      xFrontPixel = xBackPixel;
      yFrontPixel = yBackPixel;
    }
  }
}
