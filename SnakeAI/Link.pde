class Link {

  Neuron sourceNeuron;
  Neuron arrivalNeuron;

  float weight;
  float valueCarried;

  color Color;

  Link(Neuron sourceNeuron_, Neuron arrivalNeuron_) {
    sourceNeuron = sourceNeuron_;
    arrivalNeuron = arrivalNeuron_;
    
    weight = random(-1000.0, 1000.0);
    valueCarried = sourceNeuron.outputValue;
    
    Color = color(80);
  }
  
  void setWeight(float weight_) {
    weight = weight_;
  }

  void show() {
    stroke(Color);
    line(sourceNeuron.position.x, sourceNeuron.position.y, arrivalNeuron.position.x, arrivalNeuron.position.y);
  }
}
