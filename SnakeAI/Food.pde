class Food {

  PVector position;

  // Ideias futuras:
  // Fazer a comida se mexer -> Mais devagar que a cobra.
  // Comidas com cores diferentes -> Pontuações diferentes.
  // Comidas tóxicas ou venenos -> Ingerir pode reduzir seu tamanho ou matar a cobra.
  // Várias comidas na tela.

  Food() {
    int x = xDivisoryLine + SIZE + SIZE/2 + floor(random(rinkWidth/SIZE))*SIZE;
    int y = SIZE + SIZE/2 + floor(random(rinkHeight/SIZE))*SIZE;
    position = new PVector(x, y);
    // A comida não pode ser gerada em cima da cobra!!
    // O vetor de posições do corpo da cobra deve ser global, para evitar choque.
  }

  void show() {
    stroke(0);
    fill(255, 0, 0);
    rectMode(CENTER);
    rect(position.x, position.y, SIZE, SIZE);
  }

  Food clone() {
    Food clone = new Food();
    clone.position.x = position.x;
    clone.position.y = position.y;
    return clone;
  }
}
