class Food {

  PVector position;
  color Color;

  // Ideias futuras:
  // Fazer a comida se mexer -> Mais devagar que a cobra.
  // Comidas com cores diferentes -> Pontuações diferentes.
  // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
  // Várias comidas na tela.

  Food() {
    float x = screen.xVerticalLine + screen.pixelSize + screen.pixelSize/2 + floor(random(rink.Width/screen.pixelSize))*screen.pixelSize;
    float y = screen.pixelSize + screen.pixelSize/2 + floor(random(rink.Height/screen.pixelSize))*screen.pixelSize;
    position = new PVector(x, y);
    Color = color(255, 0, 0);
    // A comida não pode ser gerada em cima da cobra!!
    // O vetor de posições do corpo da cobra deve ser global, para evitar choque.
  }

  void show() {
    stroke(0);
    fill(Color);
    rectMode(CENTER);
    rect(position.x, position.y, screen.pixelSize, screen.pixelSize);
  }

  Food clone() {
    Food clone = new Food();
    clone.position.x = position.x;
    clone.position.y = position.y;
    return clone;
  }
}
