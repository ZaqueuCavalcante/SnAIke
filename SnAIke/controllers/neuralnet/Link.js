class Link {
    constructor(sourceNeuron, arrivalNeuron) {
      this.sourceNeuron = sourceNeuron;
      this.arrivalNeuron = arrivalNeuron;
      this.weightRange = 10.0;
      this.weight = random(-this.weightRange, this.weightRange);
      this.color = color(80);
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    setWeight(weight) {
      this.weight = weight;
    }
    getWeight() {
      return this.weight;
    }
    setColor(color) {
      this.color = color;
    }
    getColor() {
      return this.color;
    }
}