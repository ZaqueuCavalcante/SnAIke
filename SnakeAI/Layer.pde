public class Layer {

  private ArrayList<Neuron> neurons;

  private Vector centerPosition;
  private int neuronsNumber;
  private float verticalDistance;

  Layer() {
    neurons = new ArrayList<Neuron>();
    centerPosition = new Vector();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setCenterPosition(float x_, float y_) {
    centerPosition.x = x_;
    centerPosition.y = y_;
  }
  public void setNeuronsNumber(int neuronsNumber_) {
    neuronsNumber = neuronsNumber_;
  }
  public void setVerticalDistance(float verticalDistance_) {
    verticalDistance = verticalDistance_;
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
    //centerPosition.show();
  }
}
