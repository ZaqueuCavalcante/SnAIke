class NeuralNetwork {
    constructor() {
        this.distances = new ZVector2D();

        this.inputNames = ["Bias", "FoodX", "FoodY", "LeftD", "FrontD", "RightD"];
        this.outputNames = ["Left", "Front", "Right"];
    
        this.inputLayer = new Layer(6);
        this.hiddenLayer = new Layer(8);
        this.outputLayer = new Layer(3);
    
        this.bias = 1.0;
        this.links = [];
    
        this.setDistances(110, 50);
        this.setLayersPositions(925, 400);
        this.connectLayers(this.inputLayer, this.hiddenLayer);
        this.connectLayers(this.hiddenLayer, this.outputLayer);
    }
  
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    setDistances(distanceLayers, distanceNeurons) {
      this.distances.x = distanceLayers;
      this.distances.y = distanceNeurons;
    }

    setLayer(layer, x, y) {
      layer.setCenterPosition(x, y);
      layer.setNeuronsPosition();
    }

    setLayersPositions(firstLayerX, firstLayerY) {
      this.setLayer(this.inputLayer, firstLayerX, firstLayerY);
      this.setLayer(this.hiddenLayer, firstLayerX + this.distances.x, firstLayerY);
      this.setLayer(this.outputLayer, firstLayerX + 2*this.distances.x, firstLayerY);
      this.setInputOutputNames();
    }

    setInputOutputNames() {
      for (let c = 0; c < this.inputNames.length; c++) {
        this.inputLayer.neurons[c].setInputName(this.inputNames[c]);
      }
      for (let c = 0; c < this.outputNames.length; c++) {
        this.outputLayer.neurons[c].setOutputName(this.outputNames[c]);
      }
    }

    connectLayers(leftLayer, rightLayer) {
      for (let i = 0; i < leftLayer.neuronsNumber; i++) {
        for (let j = 0; j < rightLayer.neuronsNumber; j++) {
          let link = new Link(leftLayer.neurons[i], rightLayer.neurons[j]);
          this.links.push(link);
        }
      }
    }
  
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    processDataAndMakeDecision(radar, snake) {
      this.clearLayers();
      this.setWeights(snake.genes.getAll());

      this.flowInputLayer(radar);
      this.flowValuesAndWeightsInputToHidden();
      this.flowHiddenLayer();
      this.flowValuesAndWeightsHiddenToOutput();
      this.flowOutputLayer();

      this.decideTurn(snake.head);

      snake.move();
    }

    clearLayers() {
      this.inputLayer.clear();
      this.hiddenLayer.clear();
      this.outputLayer.clear();
    }

    setWeights(genes) {
      for (let c = 0; c < this.links.length; c++) {
        this.links[c].setWeight( genes[c] );
      }
    }
  
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    flowInputLayer(radar) {
      this.inputLayer.neurons[0].setOutputValue(this.bias);
      this.inputLayer.neurons[1].setOutputValue(radar.distanceToFoodX);
      this.inputLayer.neurons[2].setOutputValue(radar.distanceToFoodY);
      this.inputLayer.neurons[3].setOutputValue(radar.distanceToLeft.size);
      this.inputLayer.neurons[4].setOutputValue(radar.distanceToFront.size);
      this.inputLayer.neurons[5].setOutputValue(radar.distanceToRight.size);
    }
  
    flowValuesAndWeightsInputToHidden() {
      let pointer = 0;
      let inputValue;
      let weight;
      for (let i = 0; i < this.inputLayer.neuronsNumber; i++) {
        inputValue = this.inputLayer.neurons[i].getOutputValue();
        for (let j = 0; j < this.hiddenLayer.neuronsNumber; j++) {
          this.hiddenLayer.neurons[j].addInputValue(inputValue);
          weight = this.links[pointer].getWeight();
          this.hiddenLayer.neurons[j].addWeight(weight);
          pointer ++;
        }
      }
    }
  
    flowHiddenLayer() {
      let output;
      for (let neuron of this.hiddenLayer.neurons) {
        neuron.calculateActivationPotential();
        output = neuron.SigmoidFunction(neuron.activationPotential);
        neuron.setOutputValue(output);
      }
    }
  
    flowValuesAndWeightsHiddenToOutput() {
      let pointer = this.inputLayer.neuronsNumber * this.hiddenLayer.neuronsNumber;
      let inputValue;
      let weight;
      for (let i = 0; i < this.hiddenLayer.neuronsNumber; i++) {
        inputValue = this.hiddenLayer.neurons[i].getOutputValue();
        for (let j = 0; j < this.outputLayer.neuronsNumber; j++) {
          this.outputLayer.neurons[j].addInputValue(inputValue);
          weight = this.links[pointer].getWeight();
          this.outputLayer.neurons[j].addWeight(weight);
          pointer ++;
        }
      }
    }
  
    flowOutputLayer() {
      for (let neuron of this.outputLayer.neurons) {
        neuron.calculateActivationPotential();
        let output = neuron.ReLUFunction(neuron.activationPotential);
        neuron.setOutputValue(output);
      }
    }

    decideTurn(head) {
      this.outputLayer.deactivateAllNeurons();

      let outputValues = [];  // Index: 0 -> left, 1 - > front, 2 -> right
      for (let c = 0; c < 3; c++) {
        let value = this.outputLayer.neurons[c].getOutputValue();
        outputValues.push(value);
      }
  
      let highestValue = -1000;
      let index = 0;
      for (let c = 0; c < outputValues.length; c++) {
        if (outputValues[c] > highestValue) {
          highestValue = outputValues[c];
          index = c;
        }
      }

      if (index == 0) {
        let angle = head.velocity.angle - PI/2;
        head.pointTo(angle);
        this.outputLayer.neurons[0].activate();
      } else
      if (index == 1) {
        this.outputLayer.neurons[1].activate();
      } else
      if (index == 2) {
        let angle = head.velocity.angle + PI/2;
        head.pointTo(angle);
        this.outputLayer.neurons[2].activate();
      }
    }
  }