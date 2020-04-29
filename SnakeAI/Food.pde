class Food {
  
  PVector position;
  
  // Ideias futuras:
    // Fazer a comida se mexer -> Mais devagar que a cobra.
    // Comidas com cores diferentes -> Pontuações diferentes.
    // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
    // Várias comidas na tela.

  Food() {
    int x = 400 + SIZE + floor(random(38))*SIZE;
    int y = SIZE + floor(random(38))*SIZE;
    position = new PVector(x, y);
  }

  void show() {
    stroke(0);
    fill(255, 0, 0);
    rect(position.x, position.y, SIZE, SIZE);
  }

  Food clone() {
    Food clone = new Food();
    clone.position.x = position.x;
    clone.position.y = position.y;
    return clone;
  }
}
