class Food {

  Vector position;
  int nutritionalValue;
  color Color;

  // Fazer a comida se mexer -> Mais devagar que a cobra.
  // Comidas com cores diferentes -> Pontuações diferentes.
  // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
  // Várias comidas na tela.

  Food() {
    this.position = new Vector();
    this.setColor(color(255, 0, 0));
    this.setNutritionalValue(1);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPosition(float x, float y) {
    this.position.x = x;
    this.position.y = y;
  }
  void setNutritionalValue(int nutritionalValue) {
    this.nutritionalValue = nutritionalValue;
  }
  void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    fill(this.Color);
    stroke(255);
    rectMode(CENTER);
    rect(this.position.x, this.position.y, PIXEL_SIZE, PIXEL_SIZE);
    //position.show();
  }
}
