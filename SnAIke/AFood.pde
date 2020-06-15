class AFood extends ZPixel {

  private int nutritionalValue;
  boolean outsideOfBoard;

  AFood(float x, float y) {
    super(x, y);
    this.setColor(color(255, 0, 0));
    this.nutritionalValue = 1;
    this.outsideOfBoard = true;
    //super.position.makeObservable();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public int getNutritionalValue() {
    return this.nutritionalValue;
  }
}
