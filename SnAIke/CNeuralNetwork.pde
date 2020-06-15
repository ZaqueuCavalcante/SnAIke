public class CNeuralNetwork {

  private PVector distances;

  private String[] inputNames = {"Bias", "VelX", "VelY", "FoodX", "FoodY", "Left", "Front", "Right"};
  private String[] outputNames = {"Left", "Right"};

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
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void setDistances(float distanceLayers, float distanceNeurons) {
    this.distances.x = distanceLayers;
    this.distances.y = distanceNeurons;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
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
    connectLayers(inputLayer, hiddenLayer);
    connectLayers(hiddenLayer, outputLayer);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void setInputOutputNames() {
    for (int c = 0; c < inputNames.length; c++) {
      inputLayer.neurons.get(c).setInputName(inputNames[c]);
    }
    for (int c = 0; c < outputNames.length; c++) {
      outputLayer.neurons.get(c).setOutputName(outputNames[c]);
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void connectLayers(CLayer leftLayer, CLayer rightLayer) {
    for (int i = 0; i < leftLayer.neuronsNumber; i++) {
      for (int j = 0; j < rightLayer.neuronsNumber; j++) {
        CLink link = new CLink(leftLayer.neurons.get(i), rightLayer.neurons.get(j));
        links.add(link);
      }
    }
  }

  public void processAndMakeDecision(RSnakeRadar radar, ASnake snake) {
    this.clearValuesHiddenAndOutput();
    FloatList genes = snake.getGenes();
    this.setWeights(genes);
    this.flowInputLayer(radar);
    this.flowValuesAndWeightsInputToHidden();
    this.flowHiddenLayer();
    this.flowValuesAndWeightsHiddenToOutput();
    this.flowOutputLayer();
    this.decideTurn(snake.getHead());
  }

  private void setWeights(FloatList genes) {
    for (int c = 0; c < this.links.size(); c++) {
      this.links.get(c).setWeight( genes.get(c) );
    }
  }

  //// Só gambiarra daqui pra baixo...

  private void flowInputLayer(RSnakeRadar radar) {
    this.inputLayer.neurons.get(0).setOutputValue(this.bias);
    this.inputLayer.neurons.get(1).setOutputValue(0);//radar.getSnakeVx());
    this.inputLayer.neurons.get(2).setOutputValue(0);//radar.getSnakeVy());
    this.inputLayer.neurons.get(3).setOutputValue(radar.getDistanceToFoodX());
    this.inputLayer.neurons.get(4).setOutputValue(radar.getDistanceToFoodY());
    this.inputLayer.neurons.get(5).setOutputValue(radar.getDistanceToLeft());
    this.inputLayer.neurons.get(6).setOutputValue(radar.getDistanceToFront());
    this.inputLayer.neurons.get(7).setOutputValue(radar.getDistanceToRight());
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
      //println("Saida = ", neuron.getOutputValue());}
    }
    // println("----------------");
  }

  public void decideTurn(ZPixel head) {
    this.outputLayer.neurons.get(0).deactivate();
    this.outputLayer.neurons.get(1).deactivate();
    if (this.outputLayer.neurons.get(0).getOutputValue() > 0) {
      head.turnLeft();
      this.outputLayer.neurons.get(0).activate();
    } 
    if (this.outputLayer.neurons.get(1).getOutputValue() > 0) {
      head.turnRight();
      this.outputLayer.neurons.get(1).activate();
    }
  }

  public void clearValuesHiddenAndOutput() {
    for (CNeuron neuron : this.hiddenLayer.neurons) {
      neuron.clearValues();
    }
    for (CNeuron neuron : this.outputLayer.neurons) {
      neuron.clearValues();
    }
  }

  //public void printWeights() {
  //  for (int c = 0; c < links.size(); c++) {
  //    print("|");
  //    print(links.get(c).getWeight());
  //  }
  //  println(" - - - ");
  //}
}
