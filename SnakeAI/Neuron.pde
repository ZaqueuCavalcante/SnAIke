class Neuron {

  PVector position;
  float radius;
  color Color;

  String inputName;
  FloatList inputValues;
  FloatList weights;
  String outputName;
  float outputValue;

  float activationPotential;
  boolean activated;

  Neuron() {
    position = new PVector();
    setRadius(25.0);

    inputName = "";
    inputValues = new FloatList();
    weights = new FloatList();
    outputName = "";

    deactivate();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setPosition(float x_, float y_) {
    position.x = x_;
    position.y = y_;
  }
  void setRadius(float radius_) {
    radius = radius_;
  }
  void setColor(color Color_) {
    Color = Color_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setInputName(String inputName_) {
    inputName = inputName_;
  }
  void addInputValue(float inputValue) {
    inputValues.append(inputValue);
  }
  void addWeight(float weight) {
    weights.append(weight);
  }
  void setOutputName(String outputName_) {
    outputName = outputName_;
  }
  void setOutputValue(float outputValue_) {
    outputValue = outputValue_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void calculateActivationPotential() {
    activationPotential = 0.0;
    for (int i = 0; i < weights.size(); i++) {
      activationPotential += weights.get(i)*inputValues.get(i);
    }
  }
  float ReLUFunction(float input) {
    if (input < 0.0) {
      return 0.0;
    } else {
      return input;
    }
  }
  float BinaryStepFunction(float input) {
    if (input < 0.0) {
      return -1.0;
    } else {
      return 1.0;
    }
  }
  float SigmoidFunction(float input) {
    return 1.0 / (1.0 + exp(-input));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void deactivate() {
    activated = false;
    setColor(color(100));
  }
  void activate() {
    activated = true;
    setColor(color(0, 255, 0));
  }
  boolean isActivated() {
    return activated;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
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
