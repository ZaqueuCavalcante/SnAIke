class Layer {

  ArrayList<Neuron> neurons;
  Neuron firstNeuron;
  PVector distanceBetweenNeurons;

  Layer(Neuron firstNeuron_, int numberOfNeurons) {
    firstNeuron = firstNeuron_;
    neurons = new ArrayList<Neuron>();
    neurons.add(firstNeuron);
    distanceBetweenNeurons = new PVector(30, 50);
    makeRestLayer(numberOfNeurons);
  }

  void addNewNeuron() {
    PVector newNeuronPosition = new PVector();
    newNeuronPosition.x = firstNeuron.position.x;
    newNeuronPosition.y = neurons.get(neurons.size()-1).position.y + distanceBetweenNeurons.y;
    Neuron newNeuron = new Neuron(newNeuronPosition);
    neurons.add(newNeuron);
  }

  void makeRestLayer(int numberOfNeurons) {
    for (int i = 0; i < numberOfNeurons; i++) {
      addNewNeuron();
    }
  }

  void show() {
    for (int i = 0; i < neurons.size(); i++) {
      neurons.get(i).show();
    }
  }
}
