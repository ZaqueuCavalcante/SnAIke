public class Population {

  private int size;
  private int generation;
  private int generationLimit;
  private float mutationRate;
  private int bestScore;

  private Snake[] snakes;
  private int[] ranking;
  private float[] snakesFitness;

  private int[] indexesArray;

  Population(int size) {
    this.size = size;
    generation = 0;
    generationLimit = 42;
    mutationRate = 1.0;
    runSnakesFactory();
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
  public void setGenerationLimit(int generationLimit) {
    this.generationLimit = generationLimit;
  }
  public int getGenerationLimit() {
    return generationLimit;
  }
  public boolean aboveGenerationLimit() {
    return generation > generationLimit;
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
  private void runSnakesFactory() {
    snakes = new Snake[size];
    for (int i = 0; i < size; i++) {
      snakes[i] = new Snake();
    }
  }
  public void setPositions(Rink rink) {
    for (Snake snake : snakes) {
      snake.setInitialPosition(rink);
    }
  }
  private void setBrains() {
    for (Snake snake : snakes) {
      snake.setBrain();
    }
  }
  public void setInitialRanking() {
    ranking = new int[size];
    for (int i = 0; i < size; i++) {
      ranking[i] = i;
    }
  }
  public void reliveSnakes() {
    for (Snake snake : snakes) {
      snake.live();
    }
  }
  public void resetRemainingMoves() {
    for (Snake snake : snakes) {
      snake.setRemainingMoves(50);
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void calculateAllSnakesFitness() {
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
    if (snakes[ranking[0]].score > bestScore) {
      bestScore = snakes[ranking[0]].score;
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
    int[] coupleIndexes = new int[2];
    int motherIndexInRankingArray = indexesArray[int(random(indexesArray.length))];
    int fatherIndexInRankingArray = indexesArray[int(random(indexesArray.length))];
    coupleIndexes[0] = ranking[motherIndexInRankingArray];
    coupleIndexes[1] = ranking[fatherIndexInRankingArray];
    return coupleIndexes;
  }

  public Snake crossover(int motherIndex, int fatherIndex) {
    Snake mother = snakes[motherIndex].clone();
    Snake father = snakes[fatherIndex].clone();

    int genomeSize = mother.brain.links.size();
    int cutLocation = int(random(1, genomeSize));

    for (int i = cutLocation; i < genomeSize; i++) {
      mother.brain.links.get(i).setWeight( father.brain.links.get(i).getWeight() );
    }

    Snake son = mother.clone();
    return son;
  }

  public void mutation(Snake snake) {
    float snakeMutationProbability = random(0, 100);
    if (snakeMutationProbability <= mutationRate) {
      //println("XMEN");
      int genomeSize = snake.brain.links.size();
      int genesNumberThatWillMutate = int(random(1, genomeSize/12));
      //println("Genes Mutados = ", genesNumberThatWillMutate);
      for (int i = 0; i < genesNumberThatWillMutate; i++) {
        int geneThatWillMutate = int(random(0, genomeSize));
        int newWeight = int(random(0.0, 2.0));
        if (newWeight == 0) {newWeight = -1;}
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
      if (i < int(size/5)) {
        snakes[i] = snakes[ranking[0]]; // Elitismo.
      } else {
        snakes[i] = newSnakes[i];
      }
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
}
