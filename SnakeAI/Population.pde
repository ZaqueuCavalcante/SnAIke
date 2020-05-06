class Population {

  int size;
  Snake[] snakes;
  Snake bestSnake;
  int generation = 0;
  int[] rankingIndexes;
  int[] parentIndexes;
  
  float mutationRate;
  
  Population(int size_) {
    size = size_;
    snakes = new Snake[size]; 
    for (int i = 0; i < snakes.length; i++) {
      snakes[i] = new Snake();
    }
    bestSnake = snakes[0];
    rankingIndexes = new int[this.size];
  }

  void toRank() {  
    float[] snakesFitness = new float[this.size];
    for (int i = 0; i < this.size; i++) {
      snakesFitness[i] = snakes[i].fitness;
    }
    float maxFitness;
    for (int i = 0; i < this.size; i++) {
      maxFitness = max(snakesFitness);
      int j = 0;
      while (snakesFitness[j] != maxFitness) {
        j ++;
      }
      rankingIndexes[i] = j;
      snakesFitness[j] = -1.0;
    }
  }
  
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

  boolean allIsDead() {
    for (int i = 0; i < snakes.length; i++) {
      if (snakes[i].isNotDead()) {
        return false;
      }
    }
    return true;
  }

  void show() {
    bestSnake.show();
    bestSnake.brain.show();
    for (int i = 0; i < snakes.length; i++) {
      if (snakes[i].isNotDead()) {
        snakes[i].show();
      }
    }
  }
}
