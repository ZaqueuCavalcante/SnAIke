public class CMaster {

  CMaster() {
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
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
      snake.eat(food);
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
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
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
  public void setInitialSnakesAndFoods(ABoard board, CPopulation pop, ArrayList<AFood> foodBasket, CNeuralNetwork nn) {
    for (int c = 0; c < pop.getSize(); c++) {
      AFood food = new AFood(-420, -420);
      ASnake snake = new ASnake(-420, -420);
      snake.randomGenes(nn.links.size());
      this.setSnakePosition(snake, board);
      this.setFoodPosition(food, board, snake);
      foodBasket.add(food);
      pop.getSnakes().add(snake);
    }
    pop.updateRanking();
  }
  public void checkSnakeStatus(ABoard board, ASnake snake, AFood food) {
    //this.checksSnakeSelfCollide(snake);
    this.checksSnakeBoardCollide(snake, board);
    this.checksSnakeFoodCollide(snake, food, board);
    this.checksSnakeRemainingMoves(snake);
  }

  public void resetPopulation(ABoard board, CPopulation pop) {
    for (int c = 0; c < pop.getSize(); c++) {
      ASnake snake = pop.getSnakes().get(c);
      this.setSnakePosition(snake, board);
      this.resetSnake(snake);
    }
  }

}
