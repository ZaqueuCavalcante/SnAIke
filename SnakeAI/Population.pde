class Population {

  int size;
  int generation;
  float mutationRate;

  Snake[] snakes;
  int bestSnakeIndex;

  int[] ranking;

  Population() {
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setSize(int size_) {
    size = size_;
  }
  void updateGeneration() {
    generation ++;
  }
  void setMutationRate(float mutationRate_) {
    mutationRate = mutationRate_;
  }

  void setInitialSnakes() {
    snakes = new Snake[size]; 
    for (int i = 0; i < snakes.length; i++) {
      snakes[i] = new Snake();
    }
  }
  void setBestSnakeIndex(int index) {
    bestSnakeIndex = index;
  }

  void setInitialRanking() {
    ranking = new int[size];
    for (int i = 0; i < snakes.length; i++) {
      ranking[i] = i;
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void calculateSnakeFitness(Snake snake) {
    snake.fitness = snake.score*10 + snake.remainingMoves/10;
  }
  float[] calculateAllSnakesFitness() {
    float[] snakesFitness = new float[size];
    for (int i = 0; i < size; i++) {
      calculateSnakeFitness(snakes[i]);
      snakesFitness[i] = snakes[i].fitness;
    }
    return snakesFitness;
  }

  void updateRanking() {
    float[] snakesFitness = calculateAllSnakesFitness();
    float maxFitness;
    for (int i = 0; i < size; i++) {
      maxFitness = max(snakesFitness);
      int j = 0;
      while (snakesFitness[j] != maxFitness) {
        j ++;
      }
      ranking[i] = j;
      snakesFitness[j] = -1.0;
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void parentSelection() {
    // Cada cobra do ranking terá uma probabilidade de ser escolhida para ser mãe ou pai.
    // Esta probabilidade é proporcional à posição da cobra no ranking.
  }

  void crossover() {
    // Recebe uma lista de pares de pais e mães.
    // Realiza o crozamento entre eles.
  }

  void mutation() {
    // Realiza a mutação nas cobras da população, com uma determianda mutationRate.
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  boolean allSnakesIsDead() {
    for (int i = 0; i < snakes.length; i++) {
      if (snakes[i].isNotDead()) {
        return false;
      }
    }
    return true;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show(int snakesAmount) {
    snakes[bestSnakeIndex].brain.show();
    if (snakesAmount > size) {
      snakesAmount = size;
    } 
    for (int i = 0; i < snakesAmount; i++) {
      if (snakes[i].isNotDead()) {
        snakes[i].show();
      }
    }
  }
}
