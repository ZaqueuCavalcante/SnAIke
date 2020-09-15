class Layer {
    constructor(neuronsNumber) {
        this.neuronsNumber = neuronsNumber;
        this.neurons = [];
        this.x;
        this.y;
        this.deltaY = 2.25 * (new Neuron()).getRadius();
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    setCenterPosition(x, y) {
      this.x = x;
      this.y = y;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    getFirstNeuronVerticalPosition() {
        let y = this.y;
        let deltaY = this.deltaY;
        let n = this.neuronsNumber;
        if (n % 2 == 0) {
            return (y - (deltaY/2 + (n/2 - 1)*deltaY));
        }
        return (y - (n/2)*deltaY);
    }

    setNeuronsPosition() {
      let firstNeuron = new Neuron();
      firstNeuron.setPosition(this.x, this.getFirstNeuronVerticalPosition());
      this.neurons.push(firstNeuron);
      let newNeuronPositionY;
      for (let c = 0; c < this.neuronsNumber-1; c++) {
        let newNeuron = new Neuron();
        newNeuronPositionY = this.neurons[c].position.y + this.deltaY;
        newNeuron.setPosition(this.x, newNeuronPositionY);
        this.neurons.push(newNeuron);
      }
    }

    deactivateAllNeurons() {
      for (let neuron of this.neurons) {
        neuron.deactivate();
      }
    }

    clear() {
      for (let neuron of this.neurons) {
        neuron.clearAllValues();
      }
    }
}
