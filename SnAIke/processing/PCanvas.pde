public class PCanvas {

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // C Objects show()
  public void show(CPopulation pop) {
    fill(150);
    textSize(20);
    textAlign(LEFT);
    ASnake bestSnake = pop.bestSnake;
    text("SCORE : " + bestSnake.getScore(), 20, 60);
    text("BEST SCORE : " + pop.getBestScore(), 180, 60); 
    text("LIVE SNAKES : " + pop.getLiveSnakesNumber() + "  /  " + pop.getSize(), 20, 90);
    text("GENERATION : " + pop.getGeneration() + "  /  " + pop.getGenerationLimit(), 20, 120);
    text("REMAINING MOVES : " + bestSnake.getRemainingMoves(), 20, 150);
    text("MUTATION RATE : " + pop.getMutationRate() + " % ", 20, 180);
  }
  
  public void show(CPopulation pop, ArrayList<AFood> foodBasket) {
    for (int c = 0; c < pop.getSize(); c++) {
      if (pop.getSnakes().get( c ).isNotDead()) {
        this.show(foodBasket.get( c ));
        this.show(pop.getSnakes().get( c ));
      }
    }
  }

}
