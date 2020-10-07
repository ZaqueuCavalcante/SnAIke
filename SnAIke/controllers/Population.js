class Population {
    constructor(size=1) {
      this.size = size;
      this.generation = 0;
      this.generationLimit = 42;
      this.mutationRate = 10.0;
      this.bestScore = 0;
      this.bestSnake;

      this.snakes = [];
      this.ranking = [];
      this.setInitialRanking();
      this.snakesFitness = [];
      this.liveSnakesNumber = 0;
      this.makeIndexesArray();
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    getLiveSnakesNumber() {
      this.liveSnakesNumber = 0;
      for (let snake of this.snakes) {
        if (snake.isNotDead()) this.liveSnakesNumber ++;
      }
      return this.liveSnakesNumber;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    updateGeneration() {
      this.generation ++;
    }
    setGenerationLimit(limit) {
      this.generationLimit = limit;
    }
    aboveGenerationLimit() {
      return this.generation > this.generationLimit;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    updateMutationRate(inOrDecrement) {
      this.mutationRate += inOrDecrement;
      if (this.mutationRate < 0.0) {
        this.mutationRate = 0.0;
      } else if (this.mutationRate > 100.0) {
        this.mutationRate = 100.0;
      }
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    setInitialRanking() {
      for (let c = 0; c < this.size; c++) {
        this.ranking[c] = c;
      }
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    calculateAllSnakesFitness() {
      for (let c = 0; c < this.size; c++) {
        this.snakesFitness[c] = this.snakes[c].score;
      }
    }
    updateRanking() {
      this.calculateAllSnakesFitness();
      let maxFitness;
      for (let i = 0; i < this.size; i++) {
        maxFitness = max(this.snakesFitness);
        let j = 0;
        while (this.snakesFitness[j] != maxFitness) {
          j ++;
        }
        this.ranking[i] = j;
        this.snakesFitness[j] = -1.0;
      }
      let currentBestSnake = this.snakes[ this.ranking[0] ];
      if (currentBestSnake.score > this.bestScore) {
        this.bestScore = currentBestSnake.score;
      }
      this.bestSnake = currentBestSnake;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    makeIndexesArray() {
      this.indexesArray = [];
      let aux = this.size;
      for (let i = 0; i < this.size; i++) {
        for (let j = 0; j < aux; j++) {
          this.indexesArray.push(i);
        }
        aux = int(aux * 0.950);
      }
    }

    selectCouple() {
      let coupleIndexes = [];
      let motherIndexInRankingArray = this.indexesArray[ int(random(this.indexesArray.length)) ];
      let fatherIndexInRankingArray = this.indexesArray[ int(random(this.indexesArray.length)) ];
      coupleIndexes[0] = this.ranking[motherIndexInRankingArray];
      coupleIndexes[1] = this.ranking[fatherIndexInRankingArray];
      return coupleIndexes;
    }
  
    crossover(motherIndex, fatherIndex) {
      let mother = this.snakes[motherIndex].clone();
      let father = this.snakes[fatherIndex].clone();
  
      let genomeSize = mother.genes.size();
      let cutLocation = int(random(1, genomeSize));
  
      for (let c = cutLocation; c < genomeSize; c++) {
        mother.genes.getAll().splice(c, 1, father.genes.getOne(c));
      }
      return mother;
    }
  
    mutation(snake) {
      let snakeMutationProbability = random(0, 100);
      if (snakeMutationProbability <= this.mutationRate) {
        let genomeSize = snake.genes.size();
        let genesNumberThatWillMutate = int(random(1, genomeSize*0.20));
        let linkWeightRange = (new Link()).weightRange;
        for (let c = 0; c < genesNumberThatWillMutate; c++) {
          let geneThatWillMutate = int(random(0, genomeSize));
          let newWeight = random(-linkWeightRange, linkWeightRange);
          snake.genes.getAll().splice(geneThatWillMutate, 1, newWeight);
        }
      }
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    generateNewPopulation() {
      let newSnakes = [];
      for (let c = 0; c < this.size; c++) {
        let coupleIndexes = this.selectCouple();
        let motherIndex = coupleIndexes[0];
        let fatherIndex = coupleIndexes[1];
        let newSnake = this.crossover(motherIndex, fatherIndex);
        this.mutation(newSnake);
        newSnakes.push(newSnake);
      }
      for (let c = 0; c < this.size; c++) {
        this.snakes.splice(c, 1, newSnakes[c]);
      }
      this.bestScore = 0;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    allSnakesIsDead() {
      for (let c = 0; c < this.snakes.length; c++) {
        if (this.snakes[c].isNotDead()) {
          return false;
        }
      }
      return true;
    }
  }
  