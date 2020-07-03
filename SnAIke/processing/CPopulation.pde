public class CPopulation {

  private int size;
  private int generation;
  private int generationLimit;
  private float mutationRate;
  private int bestScore;

  private ArrayList<ASnake> snakes;
  private ASnake bestSnake;
  private int[] ranking;
  private float[] snakesFitness;
  private int liveSnakesNumber;

  private ArrayList<Integer> indexesArray;

  CPopulation(int size) {
    this.size = size;
    this.generation = 0;
    this.generationLimit = 42;
    this.mutationRate = 10.0;
    this.snakes = new ArrayList<ASnake>();
    this.setInitialRanking();
    this.snakesFitness = new float[size];
    this.makeIndexesArray();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public int getSize() {
    return this.size;
  }
  public int getLiveSnakesNumber() {
    this.liveSnakesNumber = 0;
    for (ASnake snake : this.snakes) {
      if (snake.isNotDead()) this.liveSnakesNumber ++;
    }
    return this.liveSnakesNumber;
  }
  public int getGeneration() {
    return this.generation;
  }
  public void updateGeneration() {
    this.generation ++;
  }
  public void setGenerationLimit(int limit) {
    this.generationLimit = limit;
  }
  public int getGenerationLimit() {
    return this.generationLimit;
  }
  public boolean aboveGenerationLimit() {
    return this.generation > this.generationLimit;
  } 
  public float getMutationRate() {
    return this.mutationRate;
  }
  public void updateMutationRate(float inOrDecrement) {
    this.mutationRate += inOrDecrement;
    if (this.mutationRate < 0.0) {
      this.mutationRate = 0.0;
    } else if (this.mutationRate > 100.0) {
      this.mutationRate = 100.0;
    }
  }
  public int getBestScore() {
    return this.bestScore;
  }
  public ArrayList<ASnake> getSnakes() {
    return this.snakes;
  }
  public ASnake getBestSnake() {
    return this.bestSnake;
  }
  public int[] getRanking() {
    return this.ranking;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void setInitialRanking() {
    this.ranking = new int[this.size];
    for (int i = 0; i < this.size; i++) {
      this.ranking[i] = i;
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void calculateAllSnakesFitness() {
    for (int i = 0; i < this.size; i++) {
      snakesFitness[i] = this.snakes.get(i).getScore();
    }
  }
  public void updateRanking() {
    this.calculateAllSnakesFitness();
    float maxFitness;
    for (int i = 0; i < this.size; i++) {
      maxFitness = max(this.snakesFitness);
      int j = 0;
      while (this.snakesFitness[j] != maxFitness) {
        j ++;
      }
      ranking[i] = j;
      snakesFitness[j] = -1.0;
    }
    if (this.snakes.get(this.ranking[0]).getScore() > this.bestScore) {
      this.bestScore = this.snakes.get(ranking[0]).getScore();
    }
    this.bestSnake = this.snakes.get( this.ranking[0] );
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  //private void makeIndexesArray() {
  //  this.indexesArray = new ArrayList<Integer>();
  //  for (int i = 0; i < this.size; i++) {
  //    this.indexesArray.add(i);
  //  }
  //  for (int i = 1; i < int(this.size/2); i++) {
  //    this.indexesArray.add(i);
  //  }
  //}
  private void makeIndexesArray() {
    this.indexesArray = new ArrayList<Integer>();
    int aux = this.size;
    for (int i = 0; i < this.size; i++) {
      for (int j = 0; j < aux; j++) {
        this.indexesArray.add(i);
      }
      aux = int(aux * 0.950);
    }
  }
  public int[] selectCouple() {
    int[] coupleIndexes = new int[2];
    int motherIndexInRankingArray = this.indexesArray.get( int(random(indexesArray.size())) );
    int fatherIndexInRankingArray = this.indexesArray.get( int(random(indexesArray.size())) );
    coupleIndexes[0] = ranking[motherIndexInRankingArray];
    coupleIndexes[1] = ranking[fatherIndexInRankingArray];
    return coupleIndexes;
  }

  public ASnake crossover(int motherIndex, int fatherIndex) {
    ASnake mother = snakes.get(motherIndex).clone();
    ASnake father = snakes.get(fatherIndex).clone();

    int genomeSize = mother.getGenes().size();
    int cutLocation = int(random(1, genomeSize));

    for (int i = cutLocation; i < genomeSize; i++) {
      mother.getGenes().set(i, father.getGenes().get(i));
    }
    return mother;
  }

  public void mutation(ASnake snake) {
    float snakeMutationProbability = random(0, 100);
    if (snakeMutationProbability <= this.mutationRate) {
      //println("XMEN");
      int genomeSize = snake.getGenes().size();
      int genesNumberThatWillMutate = int(random(1, genomeSize*0.20));
      //println("Genes Mutados = ", genesNumberThatWillMutate);
      for (int i = 0; i < genesNumberThatWillMutate; i++) {
        int geneThatWillMutate = int(random(0, genomeSize));
        float newWeight = random(-1.0, 1.0);
        snake.getGenes().set(geneThatWillMutate, newWeight);
      }
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void generateNewPopulation() {
    ArrayList<ASnake> newSnakes = new ArrayList<ASnake>();
    for (int i = 0; i < this.size; i++) {
      int[] coupleIndexes = this.selectCouple();
      int motherIndex = coupleIndexes[0];
      int fatherIndex = coupleIndexes[1];
      ASnake newSnake = this.crossover(motherIndex, fatherIndex);
      this.mutation(newSnake);
      newSnakes.add(newSnake);
    }

    for (int i = 0; i < this.size; i++) {
      snakes.set(i, newSnakes.get(i));
    }
    this.bestScore = 0;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public boolean allSnakesIsDead() {
    for (int i = 0; i < this.snakes.size(); i++) {
      if (snakes.get(i).isNotDead()) {
        return false;
      }
    }
    return true;
  }
}
