public class Button {

  private float x, y;
  private float Width, Height;
  private String text;

  Button(float x_, float y_, float Width_, float Height_, String text_) {
    x = x_;
    y = y_;
    Width = Width_;
    Height = Height_;
    text = text_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public boolean mouseAbove(float xMouse, float yMouse) {
    boolean mouseInsideWidth = x-Width/2 <= xMouse && xMouse <= x+Width/2;
    boolean mouseInsideHeight = y-Height/2 <= yMouse && yMouse <= y+Height/2;
    if (mouseInsideWidth  &&  mouseInsideHeight) {
      return true;
    }
    return false;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(x, y, Width, Height);
    textSize(22);
    textAlign(CENTER, CENTER);
    fill(0);
    text(text, x, y-3);
  }
}
