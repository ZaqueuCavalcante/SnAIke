class Neuron {
	constructor() {
		this.position = new ZVector2D();
		this.radius = 25.0;
		this.color = color(100);

		this.inputName = "";
		this.inputValues = [];
		this.weights = [];
		this.outputName = "";
		this.outputValue = 0.0;

		this.activationPotential = 0.0;
		this.activated = false;
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	setPosition(x, y) {
		this.position.set(x, y);
	}
	setRadius(radius) {
		this.radius = radius;
	}
	getRadius() {
		return this.radius;
	}
	setColor(color) {
		this.color = color;
	}
	getColor() {
		return this.color;
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	setInputName(inputName) {
		this.inputName = inputName;
	}
	addInputValue(inputValue) {
		this.inputValues.push(inputValue);
	}
	addWeight(weight) {
		this.weights.push(weight);
	}
	setOutputName(outputName) {
		this.outputName = outputName;
	}
	setOutputValue(outputValue) {
		this.outputValue = outputValue;
	}
	getOutputValue() {
		return outputValue;
	}
	clearAllValues() {
		this.inputValues = [];
		this.weights = [];
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	calculateActivationPotential() {
		this.activationPotential = 0.0;
		for (let c = 0; c < this.weights.size(); c++) {
		this.activationPotential += this.weights.get(c) * this.inputValues.get(c);
		}
	}
	ReLUFunction(input) {
		if (input < 0.0) {
		return 0.0;
		} else {
		return input;
		}
	}
	BinaryStepFunction(input) {
		if (input < 0.0) {
		return -1.0;
		} else {
		return 1.0;
		}
	}
	SigmoidFunction(input) {
		return (1.0 / (1.0 + exp(-input)) - 0.5) * 2; // Return between -1.0 and +1.0
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	deactivate() {
		this.activated = false;
		this.color = color(100);
	}
	activate() {
		activated = true;
		this.color = color(0, 255, 0);
	}
	isActivated() {
		return activated;
	}
}
