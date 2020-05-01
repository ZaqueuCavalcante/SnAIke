class Button {

  float x, y, bWidth, bHeight;
  String text;

  Button(float x_, float y_, float bWidth_, float bHeight_, String text_) {
    x = x_;
    y = y_;
    bWidth = bWidth_;
    bHeight = bHeight_;
    text = text_;
  }

  boolean collide(float xMouse, float yMouse) {
    boolean mouseInsideWidth = x-bWidth/2 <= xMouse && xMouse <= x+bWidth/2;
    boolean mouseInsideHeight = y-bHeight/2 <= yMouse && yMouse <= y+bHeight/2;
    if (mouseInsideWidth  &&  mouseInsideHeight) {
      return true;
    }
    return false;
  }

  void show() {
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(x, y, bWidth, bHeight);
    textSize(22);
    textAlign(CENTER, CENTER);
    fill(0);
    noStroke();
    text(text, x, y-3);
  }
}
