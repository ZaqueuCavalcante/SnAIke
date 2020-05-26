public class Brain {

  private PVector distances;

  private String[] inputNames = {"Bias", "Velocity X", "Velocity Y", "Food X", "Food Y", 
                                 "Left Wall", "Front Wall", "Right Wall"};
  private String[] outputNames = {"Left", "Right"};

  private Layer inputLayer;
  private Layer hiddenLayer;
  private Layer outputLayer;

  private ArrayList<Link> links;

  Brain(int hiddenNeuronsNumber) {
    distances = new PVector();

    inputLayer = new Layer(inputNames.length);
    hiddenLayer = new Layer(hiddenNeuronsNumber);
    outputLayer = new Layer(outputNames.length);

    links = new ArrayList<Link>();
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
    connectLayers(hiddenLayer, outputLayer);
    connectLayers(inputLayer, hiddenLayer);
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
}