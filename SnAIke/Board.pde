public class Board {

  private boolean checksHeadMatch(float x, float y, Head head) {
    return (x == head.getPosition().x) && (y == head.getPosition().y);
  }
  private boolean checksBodyMatch(float x, float y, Body body) {
    for (Vector2D bodyPosition : body.position) {
      if ((x == bodyPosition.x) && (y == bodyPosition.y)) {
        return true;
      }
    }
    return false;
  }
  public void determineFreePositions(Snake snake) {
    freePositions = new ArrayList<int[]>();
    for (int row = 0; row < verticalPixelNumber; row++) {
      for (int column = 0; column < horizontalPixelNumber; column++) {
        float pixelX = pixelPositions[row][column].x;
        float pixelY = pixelPositions[row][column].y;
        boolean headMatch = checksHeadMatch(pixelX, pixelY, snake.head);
        boolean bodyMatch = checksBodyMatch(pixelX, pixelY, snake.body);
        if (!headMatch && !bodyMatch) {
          int[] freePositonIndexes = new int[2];
          freePositonIndexes[0] = row;
          freePositonIndexes[1] = column;
          freePositions.add(freePositonIndexes);
        }
      }
    }
  }
  public void addFood(Snake snake, Food food) {
    if (food.outside) {
      determineFreePositions(snake);
      int index = int(random(freePositions.size()));
      // int index = 0;
      int[] freePosition = freePositions.get(index);
      int row = freePosition[0];
      int column = freePosition[1];
      food.setPosition(pixelPositions[row][column].x, pixelPositions[row][column].y);
      food.outside = false;
    }
  }
  public void addInitialFoods(Population population, Basket basket) {
    for (int i = 0; i < population.size; i++) {
      this.addFood(population.snakes[i], basket.foods[i]);
    }
  }
}
