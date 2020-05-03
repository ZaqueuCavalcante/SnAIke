class Brain {

  int numberInputNeurons;
  int numberHiddenNeurons;
  int numberOutputNeurons;
  
  Layer inputLayer;

  ArrayList<Neuron> hiddenLayer;
  ArrayList<Neuron> outputLayer;

  Brain(int numberInputNeurons_) {
    numberInputNeurons = numberInputNeurons_;
    Neuron firstNeuron = new Neuron(new PVector(50, 250));
    inputLayer = new Layer(firstNeuron, numberInputNeurons);
  }
  
  void show() {
    inputLayer.show();
  }

}
