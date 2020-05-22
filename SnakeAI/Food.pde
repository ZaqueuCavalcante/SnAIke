public class Food {

  private Vector position;
  private int nutritionalValue;
  private color Color;

  // Fazer a comida se mexer -> Mais devagar que a cobra.
  // Comidas com cores diferentes -> Pontuações diferentes.
  // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
  // Várias comidas na tela.

  Food() {
    position = new Vector();
    Color = color(255, 0, 0);
    nutritionalValue = 1;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setPosition(float x, float y) {
    this.position.x = x;
    this.position.y = y;
  }
  public void setNutritionalValue(int nutritionalValue) {
    this.nutritionalValue = nutritionalValue;
  }
  public void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    fill(this.Color);
    stroke(255);
    rectMode(CENTER);
    rect(this.position.x, this.position.y, PIXEL_SIZE, PIXEL_SIZE);
    //position.show();
  }
}
