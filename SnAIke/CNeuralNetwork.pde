public class CNeuralNetwork {

  private PVector distances;

  private String[] inputNames = {"Bias", "FoodX", "FoodY", "RightD", "DownD", "LeftD", "UpD", "D0", "D1", "D2", "D3"};
  private String[] outputNames = {"R", "D", "L", "U"};

  private CLayer inputLayer;
  private CLayer hiddenLayer;
  private CLayer outputLayer;

  private float bias;
  private ArrayList<CLink> links;

  CNeuralNetwork(int hiddenNeuronsNumber) {
    this.distances = new PVector();

    this.inputLayer = new CLayer(inputNames.length);
    this.hiddenLayer = new CLayer(hiddenNeuronsNumber);
    this.outputLayer = new CLayer(outputNames.length);

    this.bias = 1.0;
    this.links = new ArrayList<CLink>();

    this.setDistances(110, 50);
    this.setLayersPositions(100, 450);
    this.connectLayers(inputLayer, hiddenLayer);
    this.connectLayers(hiddenLayer, outputLayer);
    println(links.size());
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void setDistances(float distanceLayers, float distanceNeurons) {
    this.distances.x = distanceLayers;
    this.distances.y = distanceNeurons;
  }
  private void setLayer(CLayer layer, float x, float y) {
    layer.setCenterPosition(x, y);
    layer.setVerticalDistance(distances.y);
    layer.setNeuronsPostions();
  }
  private void setLayersPositions(float firstLayerX, float firstLayerY) {
    setLayer(inputLayer, firstLayerX, firstLayerY);
    setLayer(hiddenLayer, firstLayerX + distances.x, firstLayerY);
    setLayer(outputLayer, firstLayerX + 2*distances.x, firstLayerY);
    setInputOutputNames();
  }
  private void setInputOutputNames() {
    for (int c = 0; c < inputNames.length; c++) {
      inputLayer.neurons.get(c).setInputName(inputNames[c]);
    }
    for (int c = 0; c < outputNames.length; c++) {
      outputLayer.neurons.get(c).setOutputName(outputNames[c]);
    }
  }
  private void connectLayers(CLayer leftLayer, CLayer rightLayer) {
    for (int i = 0; i < leftLayer.neuronsNumber; i++) {
      for (int j = 0; j < rightLayer.neuronsNumber; j++) {
        CLink link = new CLink(leftLayer.neurons.get(i), rightLayer.neurons.get(j));
        links.add(link);
      }
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  // Os neurônios de entrada devem tratar os inputs antes de passar pra frente;
  // Cada tipo de informação recebe um tratamento diferente;
  // Encontrar um meio termo;
  // Usar duas funções lineares?
  // 
  public void processDataAndMakeDecision(RSnakeRadar radar, ASnake snake) {
    this.clearLayers();
    this.setWeights(snake.getGenes());
    this.flowInputLayer(radar);
    this.flowValuesAndWeightsInputToHidden();
    this.flowHiddenLayer();
    this.flowValuesAndWeightsHiddenToOutput();
    this.flowOutputLayer();
    this.decideTurn(snake.getHead());
    snake.move();
  }
  public void clearLayers() {
    this.inputLayer.clear();
    this.hiddenLayer.clear();
    this.outputLayer.clear();
  }
  private void setWeights(FloatList genes) {
    for (int c = 0; c < this.links.size(); c++) {
      this.links.get(c).setWeight( genes.get(c) );
    }
  }

  //// Só gambiarra daqui pra baixo...

  private void flowInputLayer(RSnakeRadar radar) {
    this.inputLayer.neurons.get(0).setOutputValue(this.bias);
    this.inputLayer.neurons.get(1).setOutputValue(radar.getDistanceToFoodX());
    this.inputLayer.neurons.get(2).setOutputValue(radar.getDistanceToFoodY());
    this.inputLayer.neurons.get(3).setOutputValue(radar.getDistanceToRight());
    this.inputLayer.neurons.get(4).setOutputValue(radar.getDistanceToDown());
    this.inputLayer.neurons.get(5).setOutputValue(radar.getDistanceToLeft());
    this.inputLayer.neurons.get(6).setOutputValue(radar.getDistanceToUp());
    
    this.inputLayer.neurons.get(7).setOutputValue(radar.getD0());
    this.inputLayer.neurons.get(8).setOutputValue(radar.getD1());
    this.inputLayer.neurons.get(9).setOutputValue(radar.getD2());
    this.inputLayer.neurons.get(10).setOutputValue(radar.getD3());
  }

  private void flowValuesAndWeightsInputToHidden() {
    int pointer = 0;
    float inputValue;
    float weight;
    for (int i = 0; i < this.inputLayer.neuronsNumber; i++) {
      inputValue = this.inputLayer.neurons.get(i).getOutputValue();
      for (int j = 0; j < this.hiddenLayer.neuronsNumber; j++) {
        this.hiddenLayer.neurons.get(j).addInputValue(inputValue);
        weight = this.links.get(pointer).getWeight();
        this.hiddenLayer.neurons.get(j).addWeight(weight);
        pointer ++;
      }
    }
  }

  private void flowHiddenLayer() {
    float output;
    for (CNeuron neuron : this.hiddenLayer.neurons) {
      neuron.calculateActivationPotential();
      output = neuron.ReLUFunction(neuron.activationPotential);
      neuron.setOutputValue(output);
    }
  }

  private void flowValuesAndWeightsHiddenToOutput() {
    int pointer = this.inputLayer.neuronsNumber * this.hiddenLayer.neuronsNumber;
    float inputValue;
    float weight;
    for (int i = 0; i < this.hiddenLayer.neuronsNumber; i++) {
      inputValue = this.hiddenLayer.neurons.get(i).getOutputValue();
      for (int j = 0; j < outputLayer.neuronsNumber; j++) {
        this.outputLayer.neurons.get(j).addInputValue(inputValue);
        weight = links.get(pointer).getWeight();
        this.outputLayer.neurons.get(j).addWeight(weight);
        pointer ++;
      }
    }
  }

  private void flowOutputLayer() {
    float output;
    for (CNeuron neuron : this.outputLayer.neurons) {
      neuron.calculateActivationPotential();
      output = neuron.ReLUFunction(neuron.activationPotential);
      neuron.setOutputValue(output);
      //if (neuron.getOutputValue() > 0.99) {
      //  println("Saida = ", neuron.getOutputValue());
      //}
    }
    //println("- - - -");
  }



  public void decideTurn(ZPixel head) {
    for (CNeuron neuron : this.outputLayer.neurons) {
      neuron.deactivate();
    }
    float[] decision = new float[this.outputLayer.neuronsNumber];  // 0 -> right, 1 - > down, 2 -> left, 3 -> up
    for (int c = 0; c < decision.length; c++) {
      decision[c] = this.outputLayer.neurons.get(c).getOutputValue();
      //println(decision[c]);
    }
    //println(" - - - ");

    float maiorValor = Integer.MIN_VALUE;
    int indiceMaior = 0;
    for (int c = 0; c < decision.length; c++) {
      if (decision[c] > maiorValor) {
        maiorValor = decision[c];
        indiceMaior = c;
      }
    }
    //println(indiceMaior);
    if (indiceMaior == 0) {// && head.getVelocity().getAngle() != PI) {//
      head.pointToRight();
      this.outputLayer.neurons.get(0).activate();
    }
    if (indiceMaior == 1) {// && head.getVelocity().getAngle() != 3*PI/2) {
      head.pointToDown();
      this.outputLayer.neurons.get(1).activate();
    }
    if (indiceMaior == 2) {// && head.getVelocity().getAngle() != 0) {
      head.pointToLeft();
      this.outputLayer.neurons.get(2).activate();
    }
    if (indiceMaior == 3) {// && head.getVelocity().getAngle() != PI/2) {
      head.pointToUp();
      this.outputLayer.neurons.get(3).activate();
    }
  }
}
