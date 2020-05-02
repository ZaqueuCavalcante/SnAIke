// Duas ou mais cobras competindo no mesmo ambiente.
// Uma pode matar a outra se comer seu rabo.
// Adicionar obstáculos.


//final int inputNodesNumber = 24;
//final int hiddenNodesNumber = 16;
//final int hiddenLayersNumber = 2;
//final int outputNodesNumber = 4;

//int highscore = 0;

//float mutationRate = 0.05;
//float defaultMutation = mutationRate;

//boolean humanPlaying = false;  // False for AI, true to play yourself.
//boolean replayBest = true;  // Shows only the best of each generation.
//boolean showSnakesVision = true;  // Show snake's vision.
//boolean modelLoaded = false;

//ArrayList<Integer> evolution;



//EvolutionGraph graph;

//Snake snake;
//Snake model;

//Population pop;
//int populationSize = 2000;

public void settings() {
  size(1200, 800);
}

Screen screen;
Rink rink;

Snake snake;

Food food;

boolean humanPlaying = true;

void setup() {
  screen = new Screen(width, height, 20, 400, 30);
  rink = new Rink(420, 20, 760, 760);
  
  snake = new Snake();
  
  food = new Food();
    
  
  //evolution = new ArrayList<Integer>();

  //if (humanPlaying) {
  //  snake = new Snake();
  //} else {
  //  pop = new Population(populationSize); // Adjust size of population;
  //}
}

void draw() {
  screen.setAppearance(0, 255);
  screen.drawVerticalLine();
  screen.showButtons();
  
  rink.show();
  
  snake.show();
  snake.move();
  
  food.show();
  
  
  
  //print(snake.body.positions);
  //print('\n');

  
  //if (humanPlaying) {
  //  snake.move();
  //  snake.show();
  //  fill(150);
  //  textSize(20);
  //  text("SCORE : "+snake.score, 500, 50);
  //  if (snake.dead) {
  //    snake = new Snake();
  //  }
  //} else {
  //  if (!modelLoaded) {
  //    if (pop.allIsDead()) {
  //      highscore = pop.bestSnake.score;
  //      pop.calculateFitness();
  //      pop.naturalSelection();
  //    } else {
  //      pop.update();
  //      pop.show();
  //    }
  
  
  
  //    fill(150);
  //    textSize(25);
  //    textAlign(LEFT);
  //    text("GEN : "+pop.generation, 120, 60);
  //    //text("BEST FITNESS : "+pop.bestFitness, 120, 50);
  //    text("MOVES LEFT : "+pop.bestSnake.lifeLeft, 120, 70);
  //    text("MUTATION RATE : "+mutationRate*100+"%", 120, 90);
  //    text("SCORE : "+pop.bestSnake.score, 120, height-45);
  //    text("HIGHSCORE : "+highscore, 120, height-15);

  
  
  //  } else {
  //    model.look();
  //    model.think();
  //    model.move();
  //    model.show();
  //    model.brain.show(0, 0, 360, 790, model.vision, model.decision);
  //    if (model.dead) {
  //      Snake newmodel = new Snake();
  //      newmodel.brain = model.brain.clone();
  //      model = newmodel;
  //    }
  //    textSize(25);
  //    fill(150);
  //    textAlign(LEFT);
  //    text("SCORE : "+model.score, 120, height-45);
  //  }
  //  textAlign(LEFT);
  //  textSize(18);
  //  fill(255, 0, 0);
  //  text("RED < 0", 120, height-75);
  //  fill(0, 0, 255);
  //  text("BLUE > 0", 200, height-75);
  //  graphButton.show();
  //  loadButton.show();
  //  saveButton.show();
  //}
}

//void fileSelectedIn(File selection) {
//  if (selection == null) {
//    println("Window was closed or the user hit cancel.");
//  } else {
//    String path = selection.getAbsolutePath();
//    Table modelTable = loadTable(path, "header");
//    Matrix[] weights = new Matrix[modelTable.getColumnCount()-1];
//    float[][] in = new float[hidden_nodes][25];
//    for (int i=0; i< hidden_nodes; i++) {
//      for (int j=0; j< 25; j++) {
//        in[i][j] = modelTable.getFloat(j+i*25, "L0");
//      }
//    }
//    weights[0] = new Matrix(in);

//    for (int h=1; h<weights.length-1; h++) {
//      float[][] hid = new float[hidden_nodes][hidden_nodes+1];
//      for (int i=0; i< hidden_nodes; i++) {
//        for (int j=0; j< hidden_nodes+1; j++) {
//          hid[i][j] = modelTable.getFloat(j+i*(hidden_nodes+1), "L"+h);
//        }
//      }
//      weights[h] = new Matrix(hid);
//    }

//    float[][] out = new float[4][hidden_nodes+1];
//    for (int i=0; i< 4; i++) {
//      for (int j=0; j< hidden_nodes+1; j++) {
//        out[i][j] = modelTable.getFloat(j+i*(hidden_nodes+1), "L"+(weights.length-1));
//      }
//    }
//    weights[weights.length-1] = new Matrix(out);

//    evolution = new ArrayList<Integer>();
//    int g = 0;
//    int genscore = modelTable.getInt(g, "Graph");
//    while (genscore != 0) {
//      evolution.add(genscore);
//      g++;
//      genscore = modelTable.getInt(g, "Graph");
//    }
//    modelLoaded = true;
//    humanPlaying = false;
//    model = new Snake(weights.length-1);
//    model.brain.load(weights);
//  }
//}

//void fileSelectedOut(File selection) {
//  if (selection == null) {
//    println("Window was closed or the user hit cancel.");
//  } else {
//    String path = selection.getAbsolutePath();
//    Table modelTable = new Table();
//    Snake modelToSave = pop.bestSnake.clone();
//    Matrix[] modelWeights = modelToSave.brain.pull();
//    float[][] weights = new float[modelWeights.length][];
//    for (int i=0; i<weights.length; i++) {
//      weights[i] = modelWeights[i].toArray();
//    }
//    for (int i=0; i<weights.length; i++) {
//      modelTable.addColumn("L"+i);
//    }
//    modelTable.addColumn("Graph");
//    int maxLen = weights[0].length;
//    for (int i=1; i<weights.length; i++) {
//      if (weights[i].length > maxLen) {
//        maxLen = weights[i].length;
//      }
//    }
//    int g = 0;
//    for (int i=0; i<maxLen; i++) {
//      TableRow newRow = modelTable.addRow();
//      for (int j=0; j<weights.length+1; j++) {
//        if (j == weights.length) {
//          if (g < evolution.size()) {
//            newRow.setInt("Graph", evolution.get(g));
//            g++;
//          }
//        } else if (i < weights[j].length) {
//          newRow.setFloat("L"+j, weights[j][i]);
//        }
//      }
//    }
//    saveTable(modelTable, path);
//  }
//}

void mousePressed() {
  if (graphButton.collide(mouseX, mouseY)) {
    graph = new EvolutionGraph();
  }
  if (loadButton.collide(mouseX, mouseY)) {
    selectInput("Load Snake Model", "fileSelectedIn");
  }
  if (saveButton.collide(mouseX, mouseY)) {
    selectOutput("Save Snake Model", "fileSelectedOut");
  }
  if (increaseMut.collide(mouseX, mouseY)) {
    mutationRate *= 2;
    defaultMutation = mutationRate;
  }
  if (decreaseMut.collide(mouseX, mouseY)) {
    mutationRate /= 2;
    defaultMutation = mutationRate;
  }
}


void keyPressed() {
  if (humanPlaying) {
    if (key == CODED) {
      switch(keyCode) {
      case LEFT:
        snake.moveLeft();
        break;
      case RIGHT:
        snake.moveRight();
        break;
      }
    }
  }
}
