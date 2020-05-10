class Neuron {

  String inputName;
  FloatList inputValues;
  FloatList weights;
  String outputName;
  float outputValue;

  float activationPotential;

  boolean activated;

  PVector position;
  float radius;
  color Color;

  Neuron() {
    position = new PVector();
    radius = 25.0;

    deactivate();

    inputValues = new FloatList();
    weights = new FloatList();

    inputName = "";
    outputName = "";
  }

  void setPosition(float x_, float y_) {
    position.x = x_;
    position.y = y_;
  }

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

  void deactivate() {
    activated = false;
    Color = color(100);
  }
  void activate() {
    activated = true;
    Color = color(0, 255, 0);
  }

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
