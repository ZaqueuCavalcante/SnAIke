class Brain {

  Vector firstLayerCenterPosition;

  int inputNeuronsNumber;
  int hiddenNeuronsNumber;
  int outputNeuronsNumber;

  float horizontalDistanceBetweenLayers;
  float verticalDistanceBetweenNeurons;

  Layer inputLayer;
  Layer hiddenLayer;
  Layer outputLayer;

  ArrayList<Link> links;

  Brain() {
    firstLayerCenterPosition = new Vector();

    inputLayer = new Layer();
    hiddenLayer = new Layer();
    outputLayer = new Layer();

    links = new ArrayList<Link>();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setFirstLayerCenterPosition(float x_, float y_) {
    firstLayerCenterPosition.x = x_;
    firstLayerCenterPosition.y = y_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setInputNeuronsNumber(int inputNeuronsNumber_) {
    inputNeuronsNumber = inputNeuronsNumber_;
  }
  void setHiddenNeuronsNumber(int hiddenNeuronsNumber_) {
    hiddenNeuronsNumber = hiddenNeuronsNumber_;
  }
  void setOutputNeuronsNumber(int outputNeuronsNumber_) {
    outputNeuronsNumber = outputNeuronsNumber_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setHorizontalDistanceBetweenLayers(float horizontalDistance) {
    horizontalDistanceBetweenLayers = horizontalDistance;
  }
  void setVerticalDistanceBetweenNeurons(float verticalDistance) {
    verticalDistanceBetweenNeurons = verticalDistance;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setInputLayer() {
    inputLayer.setCenterPosition(firstLayerCenterPosition.x, firstLayerCenterPosition.y);
    inputLayer.setNeuronsNumber(inputNeuronsNumber);
    inputLayer.setVerticalDistance(verticalDistanceBetweenNeurons);
    inputLayer.setNeuronsPostions();
  }
  void setHiddenLayer() {
    hiddenLayer.setCenterPosition(firstLayerCenterPosition.x + horizontalDistanceBetweenLayers, firstLayerCenterPosition.y);
    hiddenLayer.setNeuronsNumber(hiddenNeuronsNumber);
    hiddenLayer.setVerticalDistance(verticalDistanceBetweenNeurons);
    hiddenLayer.setNeuronsPostions();
  }
  void setOutputLayer() {
    outputLayer.setCenterPosition(firstLayerCenterPosition.x + 2*horizontalDistanceBetweenLayers, firstLayerCenterPosition.y);
    outputLayer.setNeuronsNumber(outputNeuronsNumber);
    outputLayer.setVerticalDistance(verticalDistanceBetweenNeurons);
    outputLayer.setNeuronsPostions();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void connectLayers(Layer leftLayer, Layer rightLayer) {
    for (int i = 0; i < leftLayer.neuronsNumber; i++) {
      for (int j = 0; j < rightLayer.neuronsNumber; j++) {
        Link link = new Link(leftLayer.neurons.get(i), rightLayer.neurons.get(j));
        links.add(link);
      }
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    for (Link link : links) {
      link.show();
    }
    inputLayer.show();
    hiddenLayer.show();
    outputLayer.show();
    //firstLayerCenterPosition.show();
  }
}
