function setup() {
	createCanvas(1250, 650);
	view = new View();
	board = new Board();

	snake = new Snake();
	food = (new Food()).self;  // Problema em extender a classe ZPixel.

	master = new Master();
	master.setSnakePosition(snake, board);
	master.setFoodPosition(food, board, snake);
}

function draw() {
	frameRate(10);
	background(50);
	view.showBoard(board);
	view.showSnake(snake);
	view.showZPixel(food);

	snake.move()

	master.checkSnakeStatus(board, snake, food);
	if (snake.isDead()) {
		master.setSnakePosition(snake, board);
		master.resetSnake(snake);
	}
}

function keyPressed() {
	switch (keyCode) {
		case RIGHT_ARROW:
			snake.head.pointToRight();
			break;
		case DOWN_ARROW:
			snake.head.pointToDown();
			break;
		case LEFT_ARROW:
			snake.head.pointToLeft();
			break;
		case UP_ARROW:
			snake.head.pointToUp();
			break;
		case CONTROL:
			snake.move();
			break;
	}
}
