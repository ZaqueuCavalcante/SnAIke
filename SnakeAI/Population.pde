class Population {

  int size;
  int generation;
  float mutationRate;

  Snake[] snakes;
  int[] ranking;
  int bestSnakeIndex;

  float[] snakesFitness;

  int[] indexesArray;

  Population(int size) {
    this.size = size;
    makeIndexesArray();
    snakesFitness = new float[size];
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setSize(int size) {
    this.size = size;
  }
  void setGeneration(int generation) {
    this.generation = generation;
  }
  int getGeneration() {
    return generation;
  }
  void updateGeneration() {
    generation ++;
  }
  void setMutationRate(float mutationRate) {
    this.mutationRate = mutationRate;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  //void setInitialSnakes() {
  //  snakes = new Snake[size];
  //  for (int i = 0; i < size; i++) {
  //    snakes[i] = new Snake();
  //    float x = position.x + PIXEL_SIDE_SIZE/2 + int(horizontalPixelNumber/2)*PIXEL_SIDE_SIZE;
  //    float y = position.y + PIXEL_SIDE_SIZE/2 + int(verticalPixelNumber/2)*PIXEL_SIDE_SIZE;
  //    snakes[i].setInitialPosition(x, y);
  //      snakes[i].
  //  }
  //}
  void setInitialRanking() {
    ranking = new int[size];
    for (int i = 0; i < size; i++) {
      ranking[i] = i;
    }
  }
  void setBestSnakeIndex(int index) {
    bestSnakeIndex = index;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void calculateAllSnakesFitness() {
    for (int i = 0; i < size; i++) {
      snakes[i].calculateFitness();
      snakesFitness[i] = snakes[i].fitness;
    }
  }
  void updateRanking() {
    calculateAllSnakesFitness();
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
  void makeIndexesArray() {
    indexesArray = new int[int(size*(size+1)/2)];
    int indexCounter = 0;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size-i; j++) {
        indexesArray[indexCounter] = i;
        indexCounter++;
      }
    }
  }
  int[] selectCouple() {
    // Cada cobra do ranking terá uma probabilidade de ser escolhida para ser mãe ou pai.
    // Esta probabilidade é proporcional à posição da cobra no ranking. 
    // Quanto menor o index, maior a chance de ser escolhido.
    // Cobras nazistas do Rick and Morty.
    // Note que eventualmente mãe e pai podem ser a mesma cobra. Equivaleria a um clone ou elitismo.
    int[] coupleIndexes = new int[2];
    coupleIndexes[0] = indexesArray[int(random(indexesArray.length))];  // Mother index.
    coupleIndexes[1] = indexesArray[int(random(indexesArray.length))];  // Father index.
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
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
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
    //snakes[bestSnakeIndex].brain.show();
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
