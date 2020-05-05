class Neuron {

  String inputName;
  FloatList inputValues;
  FloatList weights;
  String outputName;
  float outputValue;

  boolean activated;

  PVector position;
  float radius;
  color Color;

  Neuron(PVector position_) {
    position  = position_;
    radius = 25.0;
    Color = color(100);

    inputValues = new FloatList();
    weights = new FloatList();
  }

  void setInputValues(FloatList inputValues_) {
    inputValues = inputValues_;
  }

  void setweights(FloatList weights_) {
    weights = weights_;
  }

  void show() {
    fill(Color);
    stroke(255);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, radius, radius);
  }

  void deactivate() {
    activated = false;
    Color = color(100);
  }
  void activate() {
    activated = true;
    Color = color(0, 255, 0);
  }

  float calculateActivationPotential() {
    float activationPotential = 0.0;
    for (int i = 0; i < weights.size(); i++) {
      activationPotential += weights.get(i)*inputValues.get(i);
    }
    return activationPotential;
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
}
