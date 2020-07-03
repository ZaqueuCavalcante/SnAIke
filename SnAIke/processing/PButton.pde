public class PButton {

  private float x, y;
  private float widthh, heightt;
  private String text;

  PButton(float x, float y, float widthh, float heightt, String text) {
    this.x = x;
    this.y = y;
    this.widthh = widthh;
    this.heightt = heightt;
    this.text = text;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public boolean mouseAbove(float xMouse, float yMouse) {
    boolean mouseInsideWidth = (this.x-this.widthh/2 < xMouse) && (xMouse < this.x+this.widthh/2);
    boolean mouseInsideHeight = (this.y-this.heightt/2 < yMouse) && (yMouse < this.y+this.heightt/2);
    return (mouseInsideWidth  &&  mouseInsideHeight);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    fill(255);
    stroke(0);
    rectMode(CENTER);
    rect(this.x, this.y, this.widthh, this.heightt);
    textSize(22);
    textAlign(CENTER, CENTER);
    fill(0);
    text(this.text, this.x, this.y-3);
  }
}
