public class Neuron {

  private Vector position;
  private float radius;
  private color Color;

  private String inputName;
  private FloatList inputValues;
  private FloatList weights;
  private String outputName;
  private float outputValue;

  private float activationPotential;
  private boolean activated;

  Neuron() {
    position = new Vector();
    radius = 25.0;

    inputName = "";
    inputValues = new FloatList();
    weights = new FloatList();
    outputName = "";
    outputValue = 0.0;

    activationPotential = 0.0;
    deactivate();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setPosition(float x, float y) {
    position.x = x;
    position.y = y;
  }
  public void setRadius(float radius) {
    this.radius = radius;
  }
  public void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setInputName(String inputName) {
    this.inputName = inputName;
  }
  public void addInputValue(float inputValue) {
    inputValues.append(inputValue);
  }
  public void addWeight(float weight) {
    weights.append(weight);
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
    inputValues.clear();
    weights.clear();
    outputValue = 0.0;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void calculateActivationPotential() {
    activationPotential = 0.0;
    for (int i = 0; i < weights.size(); i++) {
      activationPotential += weights.get(i)*inputValues.get(i);
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
    return 1.0 / (1.0 + exp(-input));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void deactivate() {
    activated = false;
    setColor(color(100));
  }
  private void activate() {
    activated = true;
    setColor(color(0, 255, 0));
  }
  public boolean isActivated() {
    return activated;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    fill(Color);
    stroke(255);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, radius, radius);
    if (inputName != "" || outputName != "") {
      fill(150);
      textSize(20);
      textAlign(RIGHT);
      text(inputName, position.x - radius, position.y + 0.30*radius);
      textAlign(LEFT);
      text(outputName, position.x + radius, position.y + 0.30*radius);
    }
  }
}