class View {
  constructor() {

  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // Actors objects show()
  showBoard(board) {
    for (let pixel of board.grid) {
      this.showZPixel(pixel);
    }
    noFill();
    stroke(255);
    rectMode(CORNER);
    rect(board.position.x, board.position.y, board.width, board.height);
  }
  showSnake(snake) {
    for (let pixel of snake.body) {
      this.showZPixel(pixel);
    }
    this.showZPixel(snake.head);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // Utils objects show()
  showZVector2D(vector) {
    if (vector.isVisible()) {
      push();
      stroke(vector.color);
      fill(vector.color);
      strokeWeight(vector.strokeWeight);
      line(vector.origin.x, vector.origin.y, vector.x, vector.y);
      let direction = new createVector(vector.x - vector.origin.x, vector.y - vector.origin.y);
      let tipSize = 8;
      translate(vector.x, vector.y);
      rotate(direction.heading());
      triangle(-tipSize, tipSize / 2, -tipSize, -tipSize / 2, 0, 0);
      pop();
    }
  }
  showZPixel(pixel) {
    fill(pixel.color);
    stroke(pixel.stroke);
    rectMode(CENTER);
    rect(pixel.position.x, pixel.position.y, pixel.size, pixel.size);
    this.showZVector2D(pixel.position);
    this.showZVector2D(pixel.velocity);
  }
}
