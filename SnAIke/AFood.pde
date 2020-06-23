class AFood extends ZPixel {

  private int nutritionalValue;

  AFood(float x, float y) {
    super(x, y);
    this.setColor(color(255, 0, 0));
    this.nutritionalValue = 2;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public int getNutritionalValue() {
    return this.nutritionalValue;
  }
}
