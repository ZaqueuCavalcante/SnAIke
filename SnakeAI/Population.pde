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
    for (int i = 0; i < size; i++) {
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
  int[] selectCouple() {  // REFAZER !!!! Possibilidade de colocar esses métodos dentro da classe Snake????
    // Cada cobra do ranking terá uma probabilidade de ser escolhida para ser mãe ou pai.
    // Esta probabilidade é proporcional à posição da cobra no ranking.
    int[] coupleIndexes = new int[2];
    int motherIndex;
    int fatherIndex;
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //

    motherIndex = int(random(size));
    fatherIndex = int(random(size));

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    coupleIndexes[0] = motherIndex;
    coupleIndexes[1] = fatherIndex;
    return coupleIndexes;
  }

  Snake crossover(int motherIndex, int fatherIndex) {
    Snake mother = snakes[motherIndex].clone();
    Snake father = snakes[fatherIndex].clone();

    int genomeSize = mother.brain.links.size();
    int cutLocation = int(random(1, genomeSize));

    for (int i = cutLocation; i < genomeSize; i++) {
      mother.brain.links.get(i).weight = father.brain.links.get(i).weight;
    }
  
    Snake son = mother.clone();
    return son;
  }

  void mutation(Snake snake) {
    float snakeMutationProbability = random(0, 100);
    if (snakeMutationProbability <= mutationRate) {
      int genomeSize = snake.brain.links.size();
      int genesNumberThatWillMutate = int(random(1, genomeSize));
      for (int i = 0; i < genesNumberThatWillMutate; i++) {
        int geneThatWillMutate = int(random(0, genomeSize));
        float newWeight = random(-1000.0, 1000.0);
        snake.brain.links.get(geneThatWillMutate).weight = newWeight;
      }
    }
  }

  void generateNewPopulation() {
    Snake[] newSnakes = new Snake[size];
    for (int i = 0; i < size; i++) {
      int[] coupleIndexes = selectCouple();
      int motherIndex = coupleIndexes[0];
      int fatherIndex = coupleIndexes[1];
      Snake newSnake = crossover(motherIndex, fatherIndex);
      mutation(newSnake);
      newSnakes[i] =  newSnake;
    }
    for (int i = 0; i < size; i++) {
      snakes[i] =  newSnakes[i];
    }
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
