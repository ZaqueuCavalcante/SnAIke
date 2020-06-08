public class Brain {

  private PVector distances;

  private String[] inputNames = {"Bias", "Velocity X", "Velocity Y", "Food X", "Food Y", 
                                 "Left Wall", "Front Wall", "Right Wall"};
  private String[] outputNames = {"Left"};//, "Right"};

  private Layer inputLayer;
  private Layer hiddenLayer;
  private Layer outputLayer;

  private float bias;
  private ArrayList<Link> links;

  Brain(int hiddenNeuronsNumber) {
    distances = new PVector();

    inputLayer = new Layer(inputNames.length);
    hiddenLayer = new Layer(hiddenNeuronsNumber);
    outputLayer = new Layer(outputNames.length);

    links = new ArrayList<Link>();
    bias = 1.0;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setDistances(float distanceLayers, float distanceNeurons) {
    distances.x = distanceLayers;
    distances.y = distanceNeurons;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void setLayer(Layer layer, float x, float y) {
    layer.setCenterPosition(x, y);
    layer.setVerticalDistance(distances.y);
    layer.setNeuronsPostions();
  }
  public void setLayersPositions(float firstLayerX, float firstLayerY) {
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
  private void connectLayers(Layer leftLayer, Layer rightLayer) {
    for (int i = 0; i < leftLayer.neuronsNumber; i++) {
      for (int j = 0; j < rightLayer.neuronsNumber; j++) {
        Link link = new Link(leftLayer.neurons.get(i), rightLayer.neurons.get(j));
        links.add(link);
      }
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    for (Link link : links) {
      link.show();
    }
    inputLayer.show();
    hiddenLayer.show();
    outputLayer.show();
  }

  // Só gambiarra daqui pra baixo...

  private void flowInputLayer(Head head, Radar radar, Rink rink) {
    float perimetroMedio = (rink.Width + rink.Height) / 2;
    inputLayer.neurons.get(0).setOutputValue(bias);
    inputLayer.neurons.get(1).setOutputValue(int(cos(head.velocity.getTheta())));
    inputLayer.neurons.get(2).setOutputValue(int(sin(head.velocity.getTheta())));
    inputLayer.neurons.get(3).setOutputValue(radar.distanceToFood.x / perimetroMedio);
    inputLayer.neurons.get(4).setOutputValue(radar.distanceToFood.y / perimetroMedio);
    inputLayer.neurons.get(5).setOutputValue(radar.distanceToLeft.size / perimetroMedio);
    inputLayer.neurons.get(6).setOutputValue(radar.distanceToFront.size / perimetroMedio);
    inputLayer.neurons.get(7).setOutputValue(radar.distanceToRight.size / perimetroMedio);

    // println("perimetroMedio = ", perimetroMedio);
    // println("Bias = ", bias);
    // println("Vx = ", int(cos(head.velocity.getTheta())));
    // println("Vy = ", int(sin(head.velocity.getTheta())));
    // println("Foodx = ", radar.distanceToFood.x);// / perimetroMedio);
    // println("Foody = ", radar.distanceToFood.y);// / perimetroMedio);
    // println("Left = ", radar.distanceToLeft.size / perimetroMedio);
    // println("Front = ", radar.distanceToFront.size);// / perimetroMedio);
    // println("Right = ", radar.distanceToRight.size / perimetroMedio);
    // println("- - - - - - - - - - - - - - - - - - -");
  }

  private void flowValuesInputToHidden() {
    int pointer = 0;
    for (int i = 0; i < inputLayer.neuronsNumber; i++) {
      float inputValue = inputLayer.neurons.get(i).getOutputValue();
      for (int j = 0; j < hiddenLayer.neuronsNumber; j++) {
        hiddenLayer.neurons.get(j).addInputValue(inputValue);
        float weight = links.get(pointer).getWeight();
        hiddenLayer.neurons.get(j).addWeight(weight);
        pointer ++;
      }
    }
  }

  private void flowHiddenLayer() {
    for (Neuron neuron : hiddenLayer.neurons) {
      neuron.calculateActivationPotential();
      float output = neuron.BinaryStepFunction(neuron.activationPotential);
      neuron.setOutputValue(output);
    }
  }

  private void flowValuesHiddenToOutput() {
    int pointer = inputLayer.neuronsNumber * hiddenLayer.neuronsNumber;
    for (int i = 0; i < hiddenLayer.neuronsNumber; i++) {
      float inputValue = hiddenLayer.neurons.get(i).getOutputValue();
      for (int j = 0; j < outputLayer.neuronsNumber; j++) {
        outputLayer.neurons.get(j).addInputValue(inputValue);
        float weight = links.get(pointer).getWeight();
        outputLayer.neurons.get(j).addWeight(weight);
        pointer ++;
      }
    }
  }

  private void flowOutputLayer() {
    for (Neuron neuron : outputLayer.neurons) {
      neuron.calculateActivationPotential();
      float output = neuron.BinaryStepFunction(neuron.activationPotential);
      neuron.setOutputValue(output);
      // println("Saida final = ", neuron.getOutputValue());
    }
    // println("----------------");
  }

  public void decideTurn(Head head) {
    if (outputLayer.neurons.get(0).getOutputValue() > 0.0) {
      head.turnLeft();
    } else {
      head.turnRight();
    }
    // if (outputLayer.neurons.get(1).getOutputValue() > 0.0) {
    //   head.turnRight();
    // }
  }

  public void clearValuesHiddenAndOutput() {
    for (Neuron neuron : hiddenLayer.neurons) {
      neuron.clearValues();
    }
    for (Neuron neuron : outputLayer.neurons) {
      neuron.clearValues();
    }
  }

}
