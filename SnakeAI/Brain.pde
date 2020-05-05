class Brain {

  int numberInputNeurons;
  int numberHiddenNeurons;
  int numberOutputNeurons;

  Layer inputLayer;
  Layer hiddenLayer;
  Layer outputLayer;

  PVector inputLayerFirstNeuronPosition;
  PVector hiddenLayerFirstNeuronPosition;
  PVector outputLayerFirstNeuronPosition;

  float horizontalDistance;
  float verticalDistance;

  ArrayList<Link> links;

  Brain(int numberInputNeurons_, int numberHiddenNeurons_, int numberOutputNeurons_) {
    horizontalDistance = 100.0;
    verticalDistance = 70.0;

    links = new ArrayList<Link>();

    numberInputNeurons = numberInputNeurons_;
    inputLayerFirstNeuronPosition = new PVector();
    inputLayerFirstNeuronPosition.x = 80.0;
    inputLayerFirstNeuronPosition.y = 220.0 + (height-220.0)/2 - numberInputNeurons*verticalDistance/2;
    Neuron inputLayerFirstNeuron = new Neuron(inputLayerFirstNeuronPosition);
    inputLayer = new Layer(inputLayerFirstNeuron, numberInputNeurons, verticalDistance);

    numberHiddenNeurons = numberHiddenNeurons_;
    hiddenLayerFirstNeuronPosition = new PVector();
    hiddenLayerFirstNeuronPosition.x = inputLayerFirstNeuronPosition.x + horizontalDistance;
    hiddenLayerFirstNeuronPosition.y = inputLayerFirstNeuronPosition.y + (numberInputNeurons-numberHiddenNeurons)*verticalDistance/2;
    Neuron hiddenLayerFirstNeuron = new Neuron(hiddenLayerFirstNeuronPosition);
    hiddenLayer = new Layer(hiddenLayerFirstNeuron, numberHiddenNeurons, verticalDistance);

    numberOutputNeurons = numberOutputNeurons_;
    outputLayerFirstNeuronPosition = new PVector();
    outputLayerFirstNeuronPosition.x = inputLayerFirstNeuronPosition.x + 2*horizontalDistance;
    outputLayerFirstNeuronPosition.y = inputLayerFirstNeuronPosition.y + (numberInputNeurons-numberOutputNeurons)*verticalDistance/2;
    Neuron outputLayerFirstNeuron = new Neuron(outputLayerFirstNeuronPosition);
    outputLayer = new Layer(outputLayerFirstNeuron, numberOutputNeurons, verticalDistance);

    connectLayers(inputLayer, hiddenLayer);
    connectLayers(hiddenLayer, outputLayer);
  }

  void show() {
    for (Link link : links) {
      link.show();
    }
    inputLayer.show();
    hiddenLayer.show();
    outputLayer.show();
  }

  void connectLayers(Layer leftLayer, Layer rightLayer) {
    for (int i = 0; i < leftLayer.numberOfNeurons; i++) {
      for (int j = 0; j < rightLayer.numberOfNeurons; j++) {
        Link link = new Link(leftLayer.neurons.get(i), rightLayer.neurons.get(j));
        links.add(link);
      }
    }
  }
}
