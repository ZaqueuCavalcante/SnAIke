public class CMaster {

  CMaster() {
  }
  public void checksSnakeSelfCollide(ASnake snake) {
    if (snake.isNotDead() && snake.selfCollide()) {
      snake.die();
    }
  }
  public void checksSnakeBoardCollide(ASnake snake, ABoard board) {
    if (snake.isNotDead() && snake.collide(board)) {
      snake.die();
    }
  }
  public void checksSnakeRockCollide(ASnake snake, ARock rock) {
    if (snake.isNotDead() && snake.collide(rock)) {
      snake.die();
    }
  }
  public void checksSnakeRemainingMoves(ASnake snake) {
    if (snake.isNotDead() && snake.remainingMovesIsEnded()) {
      snake.die();
    }
  }
  public void checksSnakeFoodCollide(ASnake snake, AFood food, ABoard board) {
    if (snake.isNotDead() && snake.collide(food)) {
      snake.eat();
      this.setFoodPosition(food, board, snake);
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void resetSnake(ASnake snake) {
    snake.body.clear();
    float x = snake.getHead().getPosition().getX();
    float y = snake.getHead().getPosition().getY();
    snake.body.add(new ZPixel(x, y));
    snake.body.get(0).setColor(snake.getColor());
    snake.resetScore();
    snake.resetRemainingMoves();
    snake.live();
  }
  public void setSnakePosition(ASnake snake, ABoard board) {
    snake.getHead().setPosition(board.centerPixel);
  }
  public void setFoodPosition(AFood food, ABoard board, ASnake snake) {
    ArrayList<Integer> freePixelsIndexes = determineFreePixelsIndexes(board, snake);
    //println(freePixelsIndexes.size());
    int pixelIndex;
    if (freePixelsIndexes.size() > 0) {
      pixelIndex = freePixelsIndexes.get( int(random(freePixelsIndexes.size())) );
    } else {
      pixelIndex = 0;
      snake.die();
      println("ZEROU!!!!");
    }
    ZPixel chosenPixel = board.getGrid().get(pixelIndex);
    float x = chosenPixel.getPosition().getX();
    float y = chosenPixel.getPosition().getY();
    food.setPosition(x, y);
  }

  private ArrayList<Integer> determineFreePixelsIndexes(ABoard board, ASnake snake) {
    ArrayList<Integer> freePixelsIndexes = new ArrayList<Integer>();
    int index = 0;
    boolean freePixel;
    for (ZPixel gridPixel : board.getGrid()) {
      freePixel = true;
      if (snake.getHead().isAboveOf(gridPixel)) {
        freePixel = false;
      }
      for (ZPixel bodySnakePixel : snake.getBody()) {
        if (bodySnakePixel.isAboveOf(gridPixel)) {
          freePixel = false;
        }
      }
      if (freePixel) freePixelsIndexes.add(index);
      index ++;
    }
    return freePixelsIndexes;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void populate(CPopulation pop, ABoard board) {
    for (int c = 0; c < pop.getSize(); c++) {
      ASnake snake = new ASnake(-500, -500);
      this.setSnakePosition(snake, board);
      pop.getSnakes().add(snake);
    }
  }
}
