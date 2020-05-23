public class Population {

  private int size;
  private int generation;
  private float mutationRate;
  private int bestScore;

  private Snake[] snakes;
  private int[] ranking;

  private float[] snakesFitness;

  private int[] indexesArray;

  Population(int size) {
    this.size = size;
    generation = 0;
    mutationRate = 5.0;
    snakesFitness = new float[size];
    makeIndexesArray();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public int getGeneration() {
    return generation;
  }
  public void updateGeneration() {
    generation ++;
  }
  public float getMutationRate() {
    return mutationRate;
  }
  public void updateMutationRate(float inOrDecrement) {
    mutationRate += inOrDecrement;
    if (mutationRate < 0.0) {
      mutationRate = 0.0;
    } else if (mutationRate > 100.0) {
      mutationRate = 100.0;
    }
  }
  public int getBestScore() {
    return bestScore;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setInitialSnakes(Rink rink) {
    snakes = new Snake[size];
    for (int i = 0; i < size; i++) {
      snakes[i] = new Snake();
      snakes[i].setInitialPosition(rink);
      snakes[i].setBrain();
    }
  }
  public void setPositions(Rink rink) {
    for (Snake snake : snakes) {
      snake.setInitialPosition(rink);
    }
  }
  public void setInitialRanking() {
    ranking = new int[size];
    for (int i = 0; i < size; i++) {
      ranking[i] = i;
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void calculateAllSnakesFitness() {
    for (int i = 0; i < size; i++) {
      snakes[i].calculateFitness();
      snakesFitness[i] = snakes[i].fitness;
    }
  }
  public void updateRanking() {
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
  public void makeIndexesArray() {
    indexesArray = new int[int(size*(size+1)/2)];
    int indexCounter = 0;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size-i; j++) {
        indexesArray[indexCounter] = i;
        indexCounter++;
      }
    }
  }
  public int[] selectCouple() {
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

  public Snake crossover(int motherIndex, int fatherIndex) {
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

  public void mutation(Snake snake) {
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
  public void generateNewPopulation() {
    Snake[] newSnakes = new Snake[size];
    for (int i = 0; i < size; i++) {
      int[] coupleIndexes = selectCouple();
      int motherIndex = coupleIndexes[0];
      int fatherIndex = coupleIndexes[1];
      Snake newSnake = crossover(motherIndex, fatherIndex);
      mutation(newSnake);
      newSnakes[i] = newSnake;
    }
    for (int i = 0; i < size; i++) {
      snakes[i] = newSnakes[i];
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public boolean allSnakesIsDead() {
    for (int i = 0; i < snakes.length; i++) {
      if (snakes[i].isNotDead()) {
        return false;
      }
    }
    return true;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show(int snakesAmount) {
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
