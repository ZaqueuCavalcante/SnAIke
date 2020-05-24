public class Food {
  // Fazer a comida se mexer -> Mais devagar que a cobra.
  // Comidas com cores diferentes -> Pontuações diferentes.
  // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
  // Várias comidas na tela.

  private Vector position;
  private int nutritionalValue;
  private color Color;

  Food() {
    position = new Vector(0.0, 0.0);
    Color = color(255, 0, 0);
    nutritionalValue = 1;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setPosition(float x, float y) {
    position.x = x;
    position.y = y;
  }
  public Vector getPosition() {
    return position;
  }
  public void setNutritionalValue(int nutritionalValue) {
    this.nutritionalValue = nutritionalValue;
  }
  public void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    fill(Color);
    stroke(255);
    rectMode(CENTER);
    rect(position.x, position.y, PIXEL_SIZE, PIXEL_SIZE);
  }
}