public class CLayer {

  private int neuronsNumber;
  private ArrayList<CNeuron> neurons;

  private ZVector2D centerPosition;
  private float verticalDistance;

  CLayer(int neuronsNumber) {
    this.neuronsNumber = neuronsNumber;
    this.neurons = new ArrayList<CNeuron>();
    this.centerPosition = new ZVector2D();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setCenterPosition(float x, float y) {
    this.centerPosition.setTip(x, y);
  }
  public void setVerticalDistance(float verticalDistance) {
    this.verticalDistance = verticalDistance;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private float setFirstNeuronVerticalPosition() {
    float firstNeuronVerticalPosition;
    if (neuronsNumber % 2 == 0) {
      firstNeuronVerticalPosition = centerPosition.y - (verticalDistance/2 + (neuronsNumber/2 - 1)*verticalDistance);
    } else {
      firstNeuronVerticalPosition = centerPosition.y - (neuronsNumber/2)*verticalDistance;
    }
    return firstNeuronVerticalPosition;
  }
  public void setNeuronsPostions() {
    CNeuron firstNeuron = new CNeuron();
    firstNeuron.setPosition(this.centerPosition.x, this.setFirstNeuronVerticalPosition());
    this.neurons.add(firstNeuron);
    float newNeuronPositionY;
    for (int c = 0; c < neuronsNumber-1; c++) {
      CNeuron newNeuron = new CNeuron();
      newNeuronPositionY = this.neurons.get(c).position.y + this.verticalDistance;
      newNeuron.setPosition(this.centerPosition.x, newNeuronPositionY);
      this.neurons.add(newNeuron);
    }
  }
  public void clear() {
    for (CNeuron neuron : this.neurons) {
      neuron.clearValues();
    }
  }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
public class CLink {

  private CNeuron sourceNeuron;
  private CNeuron arrivalNeuron;
  private float weight;
  private color colorr;

  CLink(CNeuron sourceNeuron, CNeuron arrivalNeuron) {
    this.sourceNeuron = sourceNeuron;
    this.arrivalNeuron = arrivalNeuron;
    this.weight = random(-10.0, 10.0);
    this.colorr = color(80);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setWeight(float weight) {
    this.weight = weight;
  }
  public float getWeight() {
    return this.weight;
  }
  public void setColor(color colorr) {
    this.colorr = colorr;
  }
  public color getColor() {
    return this.colorr;
  }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
public class CNeuron {

  private ZVector2D position;
  private float radius;
  private color colorr;

  private String inputName;
  private FloatList inputValues;
  private FloatList weights;
  private String outputName;
  private float outputValue;

  private float activationPotential;
  private boolean activated;

  CNeuron() {
    this.position = new ZVector2D();
    this.radius = 25.0;

    this.inputName = "";
    this.inputValues = new FloatList();
    this.weights = new FloatList();
    this.outputName = "";
    this.outputValue = 0.0;

    this.colorr = color(100);
    this.activationPotential = 0.0;
    this.activated = false;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setPosition(float x, float y) {
    this.position.setTip(x, y);
  }
  public void setRadius(float radius) {
    this.radius = radius;
  }
  public void setColor(color colorr) {
    this.colorr = colorr;
  }
  public color getColor() {
    return this.colorr;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setInputName(String inputName) {
    this.inputName = inputName;
  }
  public void addInputValue(float inputValue) {
    this.inputValues.append(inputValue);
  }
  public void addWeight(float weight) {
    this.weights.append(weight);
  }
  public void setOutputName(String outputName) {
    this.outputName = outputName;
  }
  public void setOutputValue(float outputValue) {
    this.outputValue = outputValue;
  }
  public float getOutputValue() {
    return outputValue;
  }
  public void clearValues() {
    this.inputValues.clear();
    this.weights.clear();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void calculateActivationPotential() {
    this.activationPotential = 0.0;
    for (int i = 0; i < this.weights.size(); i++) {
      this.activationPotential += this.weights.get(i) * this.inputValues.get(i);
    }
  }
  public float ReLUFunction(float input) {
    if (input < 0.0) {
      return 0.0;
    } else {
      return input;
    }
  }
  public float BinaryStepFunction(float input) {
    if (input < 0.0) {
      return -1.0;
    } else {
      return 1.0;
    }
  }
  public float SigmoidFunction(float input) {
    return (1.0 / (1.0 + exp(-input * 0.10)) - 0.5) * 2;  // Return between -1.0 and +1.0
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void deactivate() {
    this.activated = false;
    this.colorr = color(100);
  }
  private void activate() {
    activated = true;
    this.colorr = color(0, 255, 0);
  }
  public boolean isActivated() {
    return activated;
  }
}
