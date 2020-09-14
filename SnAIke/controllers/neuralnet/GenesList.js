class GenesList {
    constructor() {
        this.genes = [];
        this.randomGenes();
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    randomGenes() {
        let neuralNetworkLinksNumber = (new NeuralNetwork()).links.length;
        let linkWeightRange = (new Link()).weightRange;
        for (let c = 0; c < neuralNetworkLinksNumber; c++) {
          this.genes.push(random(-linkWeightRange, linkWeightRange));
        }
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    size() {
        return this.genes.length;
    }

    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    getOne(index) {
        return this.genes[index];
    }
    getAll() {
    return this.genes;
    }
}
