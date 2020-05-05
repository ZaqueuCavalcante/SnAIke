class Food {

  PVector position;
  color Color;
  
  Rink rink;

  // Ideias futuras:
  // Fazer a comida se mexer -> Mais devagar que a cobra.
  // Comidas com cores diferentes -> Pontuações diferentes.
  // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
  // Várias comidas na tela.

  Food(Rink rink_) {
    rink = rink_;
    float x = screen.xVerticalLine + rink.pixelSize + rink.pixelSize/2 + floor(random(rink.Width/rink.pixelSize))*rink.pixelSize;
    float y = rink.pixelSize + rink.pixelSize/2 + floor(random(rink.Height/rink.pixelSize))*rink.pixelSize;
    position = new PVector(x, y);
    Color = color(255, 0, 0);
    // A comida não pode ser gerada em cima da cobra!!
    // O vetor de posições do corpo da cobra deve ser global, para evitar choque.
  }

  void show() {
    stroke(255);
    fill(Color);
    rectMode(CENTER);
    rect(position.x, position.y, rink.pixelSize, rink.pixelSize);
  }
}
