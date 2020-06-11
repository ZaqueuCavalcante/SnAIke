public class Button {

  private float x, y;
  private float Width, Height;
  private String text;

  Button(float x, float y, float Width, float Height, String text) {
    this.x = x;
    this.y = y;
    this.Width = Width;
    this.Height = Height;
    this.text = text;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public boolean mouseAbove(float xMouse, float yMouse) {
    boolean mouseInsideWidth = (x-Width/2 < xMouse) && (xMouse < x+Width/2);
    boolean mouseInsideHeight = (y-Height/2 < yMouse) && (yMouse < y+Height/2);
    if (mouseInsideWidth  &&  mouseInsideHeight) return true;
    else return false;
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
