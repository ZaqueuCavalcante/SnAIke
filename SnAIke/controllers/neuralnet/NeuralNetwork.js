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
      this.setWeights(snake.getGenes());
      this.flowInputLayer(radar);
      this.flowValuesAndWeightsInputToHidden();
      this.flowHiddenLayer();
      this.flowValuesAndWeightsHiddenToOutput();
      this.flowOutputLayer();
      this.decideTurn(snake.getHead());
      snake.move();
    }

    clearLayers() {
      this.inputLayer = [];
      this.hiddenLayer = [];
      this.outputLayer = [];
    }

    setWeights(genes) {
      for (let c = 0; c < this.links.length; c++) {
        this.links[c].setWeight( genes[c] );
      }
    }
  
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    //// Só gambiarra daqui pra baixo...
    // flowInputLayer(radar) {
    //   this.inputLayer.neurons[0].setOutputValue(this.bias);
    //   this.inputLayer.neurons[1].setOutputValue(radar.getDistanceToFoodX());
    //   this.inputLayer.neurons[2].setOutputValue(radar.getDistanceToFoodY());
    //   this.inputLayer.neurons[3].setOutputValue(radar.getDistanceToRight());
    //   this.inputLayer.neurons[4].setOutputValue(radar.getDistanceToDown());
    //   this.inputLayer.neurons[5].setOutputValue(radar.getDistanceToLeft());
    //   this.inputLayer.neurons[6].setOutputValue(radar.getDistanceToUp());
    // }
  
    // flowValuesAndWeightsInputToHidden() {
    //   let pointer = 0;
    //   inputValue;
    //   weight;
    //   for (int i = 0; i < this.inputLayer.neuronsNumber; i++) {
    //     inputValue = this.inputLayer.neurons.get(i).getOutputValue();
    //     for (int j = 0; j < this.hiddenLayer.neuronsNumber; j++) {
    //       this.hiddenLayer.neurons.get(j).addInputValue(inputValue);
    //       weight = this.links.get(pointer).getWeight();
    //       this.hiddenLayer.neurons.get(j).addWeight(weight);
    //       pointer ++;
    //     }
    //   }
    // }
  
    // flowHiddenLayer() {
    //   output;
    //   for (CNeuron neuron : this.hiddenLayer.neurons) {
    //     neuron.calculateActivationPotential();
    //     output = neuron.ReLUFunction(neuron.activationPotential);
    //     neuron.setOutputValue(output);
    //   }
    // }
  
    // flowValuesAndWeightsHiddenToOutput() {
    //   int pointer = this.inputLayer.neuronsNumber * this.hiddenLayer.neuronsNumber;
    //   inputValue;
    //   weight;
    //   for (int i = 0; i < this.hiddenLayer.neuronsNumber; i++) {
    //     inputValue = this.hiddenLayer.neurons.get(i).getOutputValue();
    //     for (int j = 0; j < outputLayer.neuronsNumber; j++) {
    //       this.outputLayer.neurons.get(j).addInputValue(inputValue);
    //       weight = links.get(pointer).getWeight();
    //       this.outputLayer.neurons.get(j).addWeight(weight);
    //       pointer ++;
    //     }
    //   }
    // }
  
    // flowOutputLayer() {
    //   output;
    //   for (CNeuron neuron : this.outputLayer.neurons) {
    //     neuron.calculateActivationPotential();
    //     output = neuron.ReLUFunction(neuron.activationPotential);
    //     neuron.setOutputValue(output);
    //     //if (neuron.getOutputValue() > 0.99) {
    //     //  println("Saida = ", neuron.getOutputValue());
    //     //}
    //   }
    //   //println("- - - -");
    // }
  
    // public void decideTurn(ZPixel head) {
    //   for (CNeuron neuron : this.outputLayer.neurons) {
    //     neuron.deactivate();
    //   }
    //   float[] decision = new float[this.outputLayer.neuronsNumber];  // 0 -> right, 1 - > down, 2 -> left, 3 -> up
    //   for (int c = 0; c < decision.length; c++) {
    //     decision[c] = this.outputLayer.neurons.get(c).getOutputValue();
    //     //println(decision[c]);
    //   }
    //   //println(" - - - ");
  
    //   maiorValor = Integer.MIN_VALUE;
    //   int indiceMaior = 0;
    //   for (int c = 0; c < decision.length; c++) {
    //     if (decision[c] > maiorValor) {
    //       maiorValor = decision[c];
    //       indiceMaior = c;
    //     }
    //   }
    //   //println(indiceMaior);
    //   if (indiceMaior == 0) {// && head.getVelocity().getAngle() != PI) {//
    //     head.pointToRight();
    //     this.outputLayer.neurons.get(0).activate();
    //   }
    //   if (indiceMaior == 1) {// && head.getVelocity().getAngle() != 3*PI/2) {
    //     head.pointToDown();
    //     this.outputLayer.neurons.get(1).activate();
    //   }
    //   if (indiceMaior == 2) {// && head.getVelocity().getAngle() != 0) {
    //     head.pointToLeft();
    //     this.outputLayer.neurons.get(2).activate();
    //   }
    //   if (indiceMaior == 3) {// && head.getVelocity().getAngle() != PI/2) {
    //     head.pointToUp();
    //     this.outputLayer.neurons.get(3).activate();
    //   }
    // }
  }