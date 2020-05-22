public class Brain {

  private Vector firstLayerCenterPosition;

  private int inputNeuronsNumber;
  private int hiddenNeuronsNumber;
  private int outputNeuronsNumber;

  private float horizontalDistanceBetweenLayers;
  private float verticalDistanceBetweenNeurons;

  private Layer inputLayer;
  private Layer hiddenLayer;
  private Layer outputLayer;

  private ArrayList<Link> links;

  Brain() {
    firstLayerCenterPosition = new Vector();

    inputLayer = new Layer();
    hiddenLayer = new Layer();
    outputLayer = new Layer();

    links = new ArrayList<Link>();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setFirstLayerCenterPosition(float x_, float y_) {
    firstLayerCenterPosition.x = x_;
    firstLayerCenterPosition.y = y_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setInputNeuronsNumber(int inputNeuronsNumber_) {
    inputNeuronsNumber = inputNeuronsNumber_;
  }
  public void setHiddenNeuronsNumber(int hiddenNeuronsNumber_) {
    hiddenNeuronsNumber = hiddenNeuronsNumber_;
  }
  public void setOutputNeuronsNumber(int outputNeuronsNumber_) {
    outputNeuronsNumber = outputNeuronsNumber_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setHorizontalDistanceBetweenLayers(float horizontalDistance) {
    horizontalDistanceBetweenLayers = horizontalDistance;
  }
  public void setVerticalDistanceBetweenNeurons(float verticalDistance) {
    verticalDistanceBetweenNeurons = verticalDistance;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setInputLayer() {
    inputLayer.setCenterPosition(firstLayerCenterPosition.x, firstLayerCenterPosition.y);
    inputLayer.setNeuronsNumber(inputNeuronsNumber);
    inputLayer.setVerticalDistance(verticalDistanceBetweenNeurons);
    inputLayer.setNeuronsPostions();
  }
  public void setHiddenLayer() {
    hiddenLayer.setCenterPosition(firstLayerCenterPosition.x + horizontalDistanceBetweenLayers, firstLayerCenterPosition.y);
    hiddenLayer.setNeuronsNumber(hiddenNeuronsNumber);
    hiddenLayer.setVerticalDistance(verticalDistanceBetweenNeurons);
    hiddenLayer.setNeuronsPostions();
  }
  public void setOutputLayer() {
    outputLayer.setCenterPosition(firstLayerCenterPosition.x + 2*horizontalDistanceBetweenLayers, firstLayerCenterPosition.y);
    outputLayer.setNeuronsNumber(outputNeuronsNumber);
    outputLayer.setVerticalDistance(verticalDistanceBetweenNeurons);
    outputLayer.setNeuronsPostions();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void connectLayers(Layer leftLayer, Layer rightLayer) {
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
    //firstLayerCenterPosition.show();
  }
}
