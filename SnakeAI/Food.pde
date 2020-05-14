class Food {

  PVector position;
  float pixelSideSize;
  int nutritionalValue;
  color Color;

  // Fazer a comida se mexer -> Mais devagar que a cobra.
  // Comidas com cores diferentes -> Pontuações diferentes.
  // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
  // Várias comidas na tela.

  Food() {
    position = new PVector();
    setColor(color(255, 0, 0));
    setNutritionalValue(1);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPosition(float x_, float y_) {
    position.x = x_;
    position.y = y_;
  }
  void setPixelSideSize(float sideSize_) {
    pixelSideSize = sideSize_;
  }
  void setNutritionalValue(int nutritionalValue_) {
    nutritionalValue = nutritionalValue_;
  }
  void setColor(color Color_) {
    Color = Color_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    fill(Color);
    stroke(255);
    rectMode(CENTER);
    rect(position.x, position.y, pixelSideSize, pixelSideSize);
  }
}
