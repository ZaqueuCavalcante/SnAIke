// Duas ou mais cobras competindo no mesmo ambiente.
// Uma pode matar a outra, se comer seu rabo.
// Adicionar obstáculos.

Population population;
int populationSize = 2000;

public void settings() {
  size(1200, 800);
}

Screen screen;
Rink rink;

Snake snake;

boolean humanPlaying = true;

Brain brain;

void setup() {
  screen = new Screen(width, height, 400, 20);
  rink = new Rink(420, 20, 760, 760, 20);
  

  brain = new Brain(4, 8, 2);

  if (humanPlaying) {
    rink.addFood();
    snake = new Snake();
  } else {
    population = new Population(100);
  }
//evolution = new ArrayList<Integer>();
}

void draw() {
  screen.setAppearance(0, 255);
  screen.drawVerticalLine();
  screen.showButtons();
  screen.showParameters();

  rink.show();
  
  brain.show();

  if (humanPlaying) {
    snake.show();
    snake.move();

    rink.food.show();

    if (snake.isDead()) {
      snake = new Snake();
    }
  }

  //print();
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
    //mutationRate *= 2;
    //defaultMutation = mutationRate;
    print("MR ++");
    print("\n");
  }
  if (screen.decreaseMutationRateButton.mouseAbove(mouseX, mouseY)) {
    //mutationRate /= 2;
    //defaultMutation = mutationRate;
    print("MR --");
    print("\n");
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
