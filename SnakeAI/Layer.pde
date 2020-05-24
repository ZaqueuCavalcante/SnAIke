public class Layer {

  private int neuronsNumber;
  private ArrayList<Neuron> neurons;

  private Vector centerPosition;
  private float verticalDistance;

  Layer(int neuronsNumber) {
    this.neuronsNumber = neuronsNumber;
    neurons = new ArrayList<Neuron>();
    centerPosition = new Vector();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setCenterPosition(float x, float y) {
    centerPosition.x = x;
    centerPosition.y = y;
  }
  public void setVerticalDistance(float verticalDistance) {
    this.verticalDistance = verticalDistance;
  }
  public void setNeuronInputName(int neuronIndex, String inputName) {
    neurons.get(neuronIndex).setInputName(inputName);
  }
  public void setNeuronOutputName(int neuronIndex, String outputName) {
    neurons.get(neuronIndex).setOutputName(outputName);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public float setFirstNeuronVerticalPosition() {
    float firstNeuronVerticalPosition;
    if (neuronsNumber % 2 == 0) {
      firstNeuronVerticalPosition = centerPosition.y - (verticalDistance/2 + (neuronsNumber/2 - 1)*verticalDistance);
    } else {
      firstNeuronVerticalPosition = centerPosition.y - (neuronsNumber/2)*verticalDistance;
    }
    return firstNeuronVerticalPosition;
  }
  public void setNeuronsPostions() {
    Neuron firstNeuron = new Neuron();
    firstNeuron.setPosition(centerPosition.x, setFirstNeuronVerticalPosition());
    neurons.add(firstNeuron);
    float newNeuronPositionY;
    for (int i = 0; i < neuronsNumber-1; i++) {
      Neuron newNeuron = new Neuron();
      newNeuronPositionY = neurons.get(i).position.y + verticalDistance;
      newNeuron.setPosition(centerPosition.x, newNeuronPositionY);
      neurons.add(newNeuron);
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    for (int i = 0; i < neurons.size(); i++) {
      neurons.get(i).show();
    }
  }
}
