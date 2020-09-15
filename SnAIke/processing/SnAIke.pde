  for (int c = 0; c < pop.size; c++) {
    let currentSnake = pop.snakes[c];
    let currentFood = foods[c];
    if (currentSnake.isNotDead()) {
      radar.calculateAndNormalizeDistances(board, currentSnake, currentFood);
      nn.processDataAndMakeDecision(radar, currentSnake);
      master.checkSnakeStatus(board, currentSnake, currentFood);
    }
  }

  if (pop.allSnakesIsDead()) {
    pop.updateRanking();
    pop.generateNewPopulation();
    master.resetPopulation(board, pop);
    pop.updateGeneration();
  }
}
