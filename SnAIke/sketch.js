function setup() {
	createCanvas(1250, 650);
	view = new View();
	board = new Board();

	population = new Population(1);
	population.generationLimit = 100;
	foods = [];

	master = new Master();

	nn = new NeuralNetwork(8);
	radar = new SnakeRadar();

	master.setInitialSnakesAndFoods(board, population, foods);
}

function draw() {
	frameRate(15);
	background(50);
	view.showBoard(board);

	view.showStatus(population);
	view.showPopulation(population, foods);

	view.showNeuralNetwork(nn);

	for (let c = 0; c < population.size; c++) {
		let currentSnake = population.snakes[c];
		let currentFood = foods[c];
		if (currentSnake.isNotDead()) {
		  radar.calculateAndNormalizeDistances(board, currentSnake, currentFood);
		  //nn.processDataAndMakeDecision(radar, currentSnake);
		  master.checkSnakeStatus(board, currentSnake, currentFood);
		}
	}

	if (population.allSnakesIsDead()) {
		population.updateRanking();
		population.generateNewPopulation();
		master.resetPopulation(board, population);
		population.updateGeneration();
	  }
}

function keyPressed() {
	switch (keyCode) {
		case RIGHT_ARROW:
			population.snakes[0].head.pointToRight();
			break;
		case DOWN_ARROW:
			population.snakes[0].head.pointToDown();
			break;
		case LEFT_ARROW:
			population.snakes[0].head.pointToLeft();
			break;
		case UP_ARROW:
			population.snakes[0].head.pointToUp();
			break;
		case CONTROL:
			population.snakes[0].move();
			break;
	}
}
