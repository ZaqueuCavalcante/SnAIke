class Layer {

  ArrayList<Neuron> neurons;

  PVector centerPosition;
  int neuronsNumber;
  float verticalDistance;

  Layer() {
    neurons = new ArrayList<Neuron>();
    centerPosition = new PVector();
  }

  void setCenterPosition(float x_, float y_) {
    centerPosition.x = x_;
    centerPosition.y = y_;
  }
  void setNeuronsNumber(int neuronsNumber_) {
    neuronsNumber = neuronsNumber_;
  }
  void setVerticalDistance(float verticalDistance_) {
    verticalDistance = verticalDistance_;
  }

  float setFirstNeuronVerticalPosition() {
    float firstNeuronVerticalPosition;
    if (neuronsNumber % 2 == 0) {
      firstNeuronVerticalPosition = verticalDistance/2 + (neuronsNumber/2 - 1)*verticalDistance;
    } else {
      firstNeuronVerticalPosition = (neuronsNumber/2)*verticalDistance;
    }
    return firstNeuronVerticalPosition;
  }

  void setNeuronsPostions() {
    Neuron firstNeuron = new Neuron();
    firstNeuron.setPosition(centerPosition.x, setFirstNeuronVerticalPosition());
    neurons.add(firstNeuron);

    PVector newNeuronPosition = new PVector();
    newNeuronPosition.x = centerPosition.x;
    for (int i = 0; i < neuronsNumber-1; i++) {
      newNeuronPosition.y = neurons.get(i).position.y + verticalDistance;
      Neuron newNeuron = new Neuron();
      newNeuron.setPosition(centerPosition.x, newNeuronPosition.y);
      neurons.add(newNeuron);
    }
  }

  void show() {
    for (int i = 0; i < neurons.size(); i++) {
      neurons.get(i).show();
    }
  }
}
