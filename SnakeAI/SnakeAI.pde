// Duas ou mais cobras competindo no mesmo ambiente.
// Uma pode matar a outra, se comer seu rabo.
// Adicionar obstáculos.

Screen screen;
Rink rink;

boolean humanPlaying = true;

//Neuron neuron;

Layer layer;

Link link;

void setup() {
  size(1200, 800);
  screen = new Screen(width, height);
  screen.setFPS(20);

  rink = new Rink();
  rink.setPosition(420, 20);
  rink.setSideSizes(800-2*20, 800-2*20);
  rink.setPixelSize(20);
  rink.setPixelPositions();

  rink.addFood();
  rink.addSnake();
  
  layer = new Layer();
  layer.setCenterPosition(65, 500);
  layer.setNeuronsNumber(4);
  layer.setVerticalDistance(80);
  layer.setNeuronsPostions();
  layer.neurons.get(0).setInputName("Bias");
  layer.neurons.get(1).setInputName("Dx");
  layer.neurons.get(2).setInputName("Dy");
  layer.neurons.get(3).setInputName("Theta");
  
  layer.neurons.get(0).setOutputValue(42);
  
  link = new Link(layer.neurons.get(0), layer.neurons.get(1));
  print(link.valueCarried);

  //neuron = new Neuron();
  //neuron.setPosition(300, 300);

  //neuron.setInputName("Input");
  //neuron.setOuputName("Output");
}

void draw() {
  screen.setScore(rink.snake.score);
  //screen.setBestScore(population.bestSnake.score);
  screen.setFitness(rink.snake.fitness);
  //screen.setGeneration(population.generation);
  screen.setRemainingMoves(rink.snake.remainingMoves);
  //screen.setMutationRate(population.mutationRate);
  screen.show();

  rink.show();
  rink.showPixelStrokes();

  rink.snake.show();
  rink.food.show();
  rink.snake.move(rink, rink.food);

  if (rink.snake.isDead()) {
    rink.addSnake();
  }
  
  link.show();
  layer.show();
  

  //neuron.show();

  //if (rink.snake.isDead()) {
  //  rink.addSnake();
  //}

  //int index = int(random(0, 4));
  //int[] values = {10, 6, 12, 42};
  //print(random(0, 255));
  //print('\n');
}

void mousePressed() {
  if (screen.saveButton.mouseAbove(mouseX, mouseY)) {
    //selectOutput("Save Snake Model", "fileSelectedOut");
    print("Save Snake Model");
    print("\n");
  }
  if (screen.loadButton.mouseAbove(mouseX, mouseY)) {
    //selectInput("Load Snake Model", "fileSelectedIn");
    print("Load Snake Model");
    print("\n");
  }
  if (screen.graphButton.mouseAbove(mouseX, mouseY)) {
    //graph = new EvolutionGraph();
    print("New graph");
    print("\n");
  }
  if (screen.increaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
    //mutationRate += 0.5;
    print("MR ++");
    print("\n");
  }
  if (screen.decreaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
    //mutationRate -= 0.5;
    print("MR --");
    print("\n");
  }
}

void keyPressed() {
  if (humanPlaying) {
    if (key == CODED) {
      switch(keyCode) {
      case LEFT:
        rink.snake.moveLeft();
        break;
      case RIGHT:
        rink.snake.moveRight();
        break;
      }
    }
  }
}
