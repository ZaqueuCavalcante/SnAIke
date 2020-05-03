class Body {

  ArrayList<PVector> positions;
  color Color;

  Body() {
    positions = new ArrayList<PVector>();
    Color = color(random(255), random(255), random(255));
  }

  void addPixel(float xPixel, float yPixel) {
    PVector newPixel = new PVector(xPixel, yPixel);
    positions.add(newPixel);
  }

  void show() {
    fill(Color);
    stroke(255);
    for (int i = 0; i < positions.size(); i++) {
      rectMode(CENTER);
      rect(positions.get(i).x, positions.get(i).y, rink.pixelSize, rink.pixelSize);
    }
  }

  void move() {  // Shift the body to follow the head.
    float xFrontPixel = snake.head.position.x;
    float yFrontPixel = snake.head.position.y;
    float xBackPixel;
    float yBackPixel;
    for (int i = 0; i < positions.size(); i++) {
      xBackPixel = positions.get(i).x;
      yBackPixel = positions.get(i).y;
      positions.get(i).x = xFrontPixel;
      positions.get(i).y = yFrontPixel;
      xFrontPixel = xBackPixel;
      yFrontPixel = yBackPixel;
    }
  }
}
