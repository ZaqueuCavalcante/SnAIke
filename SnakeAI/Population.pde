class Population {

//  Snake[] snakes;
//  Snake bestSnake;

//  int bestSnakeScore = 0;
  int generation = 0;

//  float bestFitness = 0;
//  float fitnessSum = 0;

//  Population(int size) {
//    snakes = new Snake[size]; 
//    for (int i = 0; i < snakes.length; i++) {
//      snakes[i] = new Snake();
//    }
//    bestSnake = snakes[0].clone();
//    bestSnake.replay = true;
//  }

//  boolean allIsDead() {  // Check if all the snakes in the population are dead.
//    for (int i = 0; i < snakes.length; i++) {
//      if (!snakes[i].dead)
//        return false;
//    }
//    if (!bestSnake.dead) {
//      return false;
//    }
//    return true;
//  }

//  void update() {  // Update all the snakes in the generation.
//    if (!bestSnake.dead) {  // If the best snake is not dead update it, this snake is a replay of the best from the past generation
//      bestSnake.look();
//      bestSnake.think();
//      bestSnake.move();
//    }
//    for (int i = 0; i < snakes.length; i++) {
//      if (!snakes[i].dead) {
//        snakes[i].look();
//        snakes[i].think();
//        snakes[i].move();
//      }
//    }
//  }

//  void show() {  // Show either the best snake or all the snakes.
//    if (replayBest) {
//      bestSnake.show();
//      bestSnake.brain.show(0, 0, 360, 790, bestSnake.vision, bestSnake.decision);  // Show the brain of the best snake.
//    } else {
//      for (int i = 0; i < snakes.length; i++) {
//        if (snakes[i].dead == false) {
//            snakes[i].show();
//        }
//      }
//    }
//  }

//  void setBestSnake() {  // Set the best snake of the generation.
//    float maxFitness = 0;
//    int maxFitnessIndex = 0;
//    for (int i = 0; i < snakes.length; i++) {
//      if (snakes[i].fitness > maxFitness) {
//        maxFitness = snakes[i].fitness;
//        maxFitnessIndex = i;
//      }
//    }
//    if (maxFitness > bestFitness) {
//      bestFitness = maxFitness;
//      bestSnake = snakes[maxFitnessIndex].cloneForReplay();
//      bestSnakeScore = snakes[maxFitnessIndex].score;
//    } else {
//      bestSnake = bestSnake.cloneForReplay(); 
//    }
//  }

//  Snake selectParent() {  // Selects a random number in range of the fitnessSum and if a snake falls in that range then select it.
//    float randFitness = random(fitnessSum);
//    float summation = 0;
//    for (int i = 0; i < snakes.length; i++) {
//      summation += snakes[i].fitness;
//      if (summation > randFitness) {
//        return snakes[i];
//      }
//    }
//    return snakes[0];
//  }

//  void naturalSelection() {
//    Snake[] newPopulation = new Snake[snakes.length];
//    setBestSnake();
//    calculateFitnessSum();
//    newPopulation[0] = bestSnake.clone();  // Add the best snake of the prior generation into the new generation.
//    for (int i = 1; i < snakes.length; i++) {
//      Snake child = selectParent().crossover(selectParent());
//      child.mutate();
//      newPopulation[i] = child;
//    }
//    snakes = newPopulation.clone();
//    evolution.add(bestSnakeScore);
//    generation += 1;
//  }

//  void mutate() {
//    for (int i = 1; i < snakes.length; i++) {  // Start from 1 as to not override the best snake placed in index 0.
//      snakes[i].mutate();
//    }
//  }

//  void calculateFitness() {  // Calculate the fitnesses for each snake.
//    for (int i = 0; i < snakes.length; i++) {
//      snakes[i].calculateFitness();
//    }
//  }

//  void calculateFitnessSum() {  // Calculate the sum of all the snakes fitnesses.
//    fitnessSum = 0;
//    for (int i = 0; i < snakes.length; i++) {
//      fitnessSum += snakes[i].fitness;
//    }
//  }
}
