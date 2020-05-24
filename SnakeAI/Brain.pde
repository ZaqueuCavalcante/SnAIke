public class Brain {

  private Vector firstLayerCenterPosition;

  private float horizontalDistanceBetweenLayers;
  private float verticalDistanceBetweenNeurons;

  private Layer inputLayer;
  private Layer hiddenLayer;
  private Layer outputLayer;

  private ArrayList<Link> links;

  Brain(int inputNeuronsNumber, int hiddenNeuronsNumber, int outputNeuronsNumber) {
    firstLayerCenterPosition = new Vector();

    inputLayer = new Layer(inputNeuronsNumber);
    hiddenLayer = new Layer(hiddenNeuronsNumber);
    outputLayer = new Layer(outputNeuronsNumber);

    links = new ArrayList<Link>();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setFirstLayerCenterPosition(float x, float y) {
    firstLayerCenterPosition.x = x;
    firstLayerCenterPosition.y = y;
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
    inputLayer.setVerticalDistance(verticalDistanceBetweenNeurons);
    inputLayer.setNeuronsPostions();
  }
  public void setHiddenLayer() {
    hiddenLayer.setCenterPosition(firstLayerCenterPosition.x + horizontalDistanceBetweenLayers, firstLayerCenterPosition.y);
    hiddenLayer.setVerticalDistance(verticalDistanceBetweenNeurons);
    hiddenLayer.setNeuronsPostions();
  }
  public void setOutputLayer() {
    outputLayer.setCenterPosition(firstLayerCenterPosition.x + 2*horizontalDistanceBetweenLayers, firstLayerCenterPosition.y);
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
  }
}