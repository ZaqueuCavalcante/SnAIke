class Link {

  Neuron sourceNeuron;
  Neuron arrivalNeuron;

  float weight;
  float valueCarried;

  color Color;

  Link(Neuron sourceNeuron_, Neuron arrivalNeuron_) {
    sourceNeuron = sourceNeuron_;
    arrivalNeuron = arrivalNeuron_;

    setWeight(random(-1000.0, 1000.0));
    setValueCarried(sourceNeuron.outputValue);

    setColor(color(80));
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setWeight(float weight_) {
    weight = weight_;
  }
  void setValueCarried(float valueCarried_) {
    valueCarried = valueCarried_;
  }
  void setColor(color Color_) {
    Color = Color_;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void show() {
    stroke(Color);
    line(sourceNeuron.position.x, sourceNeuron.position.y, arrivalNeuron.position.x, arrivalNeuron.position.y);
  }
}
