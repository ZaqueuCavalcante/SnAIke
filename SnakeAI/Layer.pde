class Layer {

  ArrayList<Neuron> neurons;
  Neuron firstNeuron;
  int numberOfNeurons;
  float verticalDistance;

  Layer(Neuron firstNeuron_, int numberOfNeurons_, float verticalDistance_) {
    firstNeuron = firstNeuron_;
    numberOfNeurons = numberOfNeurons_;
    neurons = new ArrayList<Neuron>();
    neurons.add(firstNeuron);
    verticalDistance = verticalDistance_;
    makeRestLayer(numberOfNeurons);
  }

  void addNewNeuron() {
    PVector newNeuronPosition = new PVector();
    newNeuronPosition.x = firstNeuron.position.x;
    newNeuronPosition.y = neurons.get(neurons.size()-1).position.y + verticalDistance;
    Neuron newNeuron = new Neuron(newNeuronPosition);
    neurons.add(newNeuron);
  }

  void makeRestLayer(int numberOfNeurons) {
    for (int i = 0; i < numberOfNeurons-1; i++) {
      addNewNeuron();
    }
  }

  void show() {
    for (int i = 0; i < neurons.size(); i++) {
      neurons.get(i).show();
    }
  }
  
}
