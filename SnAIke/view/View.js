class View {
	constructor() { }

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// Actors objects show()
	showBoard(board) {
		for (let pixel of board.grid) {
			this.showZPixel(pixel);
		}
		noFill();
		stroke(255);
		rectMode(CORNER);
	}

	showSnake(snake) {
		for (let pixel of snake.body) {
			this.showZPixel(pixel);
		}
		this.showZPixel(snake.head);
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// Controllers objects show()
	showNeuralNetwork(nn) {
		for (let link of nn.links) {
			this.showLink(link);
		}
		this.showLayer(nn.inputLayer);
		this.showLayer(nn.hiddenLayer);
		this.showLayer(nn.outputLayer);
	}

	showLayer(layer) {
		for (let neuron of layer.neurons) {
			this.showNeuron(neuron);
		}
	}

	showLink(link) {
		stroke(link.getColor());
		let source = link.sourceNeuron.position;
		let arrival = link.arrivalNeuron.position;
		line(source.x, source.y, arrival.x, arrival.y);
	}

	showNeuron(neuron) {
		let x = neuron.position.x;
		let y = neuron.position.y;
		let r = neuron.radius;
		fill(neuron.getColor());
		stroke(255);
		ellipseMode(CENTER);
		ellipse(x, y, r, r);
		if (neuron.inputName != "" || neuron.outputName != "") {
			fill(255);
			textSize(15);
			textAlign(RIGHT);
			text(neuron.inputName, x - r, y + 0.3 * r);
			textAlign(LEFT);
			text(neuron.outputName, x + r, y + 0.3 * r);
		}
	}

	showStatus(pop) {
		fill(255);
		textSize(15);
		textAlign(LEFT);
		let bestSnake = pop.bestSnake;
		let dx = 820;
		text("SCORE : " + bestSnake.score, 20+dx, 60);
		text("BEST SCORE : " + pop.bestScore, 180+dx, 60); 
		text("LIVE SNAKES : " + pop.getLiveSnakesNumber() + "  /  " + pop.size, 20+dx, 90);
		text("GENERATION : " + pop.generation + "  /  " + pop.generationLimit, 20+dx, 120);
		text("REMAINING MOVES : " + bestSnake.remainingMoves, 20+dx, 150);
		text("MUTATION RATE : " + pop.mutationRate + " % ", 20+dx, 180);
	  }
	  
	showPopulation(pop, foods, percentageToShow=10) {
		let popLimit = int(pop.size * percentageToShow/100);
		for (let c = 0; c < popLimit; c++) {
			if (pop.snakes[c].isNotDead()) {
				this.showZPixel(foods[c]);
				this.showSnake(pop.snakes[c]);
			}
		}
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// Radars objects show()
	showSnakeRadar(radar) {
		this.showZVector2D(radar.distanceToLeft);
		this.showZVector2D(radar.distanceToFront);
		this.showZVector2D(radar.distanceToRight);
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	// Utils objects show()
	showZVector2D(vector) {
		if (vector.isVisible()) {
			push();
			stroke(vector.color);
			fill(vector.color);
			strokeWeight(vector.strokeWeight);
			line(vector.origin.x, vector.origin.y, vector.x, vector.y);
			let deltaX = vector.x - vector.origin.x;
			let deltaY = vector.y - vector.origin.y;
			let direction = new createVector(deltaX, deltaY);
			let tipSize = 8;
			translate(vector.x, vector.y);
			rotate(direction.heading());
			triangle(-tipSize, tipSize / 2, -tipSize, -tipSize / 2, 0, 0);
			pop();
		}
	}

	showZPixel(pixel) {
		fill(pixel.color);
		stroke(pixel.stroke);
		strokeWeight(1.5);
		rectMode(CENTER);
		rect(pixel.position.x, pixel.position.y, pixel.size, pixel.size, pixel.size * 0.15);
		this.showZVector2D(pixel.position);
		this.showZVector2D(pixel.velocity);
	}

	showTile(tile) {
		this.showZPixel(tile);
		fill(255);
		strokeWeight(1.5);
		textSize(20);
		textAlign(CENTER, CENTER);
		let offset = tile.size / 3.8;
		text(tile.F, tile.position.x - offset, tile.position.y - offset);
		textSize(15);
		text(tile.G, tile.position.x - offset, tile.position.y + offset);
		text(tile.H, tile.position.x + offset, tile.position.y + offset);
	}
}
