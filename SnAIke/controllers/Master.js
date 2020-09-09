class Master {
	constructor() {}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	checksSnakeSelfCollide(snake) {
		if (snake.isNotDead() && snake.selfCollide()) {	snake.die(); }
	}

	checksSnakeBoardCollide(snake, board) {
		if (snake.isNotDead() && snake.boardCollide(board)) { snake.die(); }
	}

	checksSnakeRockCollide(snake, rock) {
		if (snake.isNotDead() && snake.rockCollide(rock)) { snake.die(); }
	}

	checksSnakeRemainingMoves(snake) {
		if (snake.isNotDead() && snake.remainingMovesIsEnded()) { snake.die(); }
	}

	checksSnakeFoodCollide(snake, food, board) {
		if (snake.isNotDead() && snake.foodCollide(food)) {
			snake.eat(food);
			this.setFoodPosition(food, board, snake);
		}
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	resetSnake(snake) {
		snake.body = [];
		let pixel = new ZPixel(snake.head.position.x, snake.head.position.y);
		pixel.color = snake.color;
		snake.body.push(pixel);
		snake.resetScore();
		snake.resetRemainingMoves();
		snake.live();
	}

	setSnakePosition(snake, board) {
		snake.head.translateTo(board.centerPixel);
	}

	setFoodPosition(food, board, snake) {
		let freePixelsIndexes = this.determineFreePixelsIndexes(board, snake);
		let range = int(freePixelsIndexes.length);
		let pixelIndex;
		if (range > 0) {
			let index = int(random(range));
			pixelIndex = freePixelsIndexes[index];
		} else {
			pixelIndex = 0;
			snake.die();
			console.log("END GAME!");
		}
		let chosenPixel = board.grid[pixelIndex];
		food.translateTo(chosenPixel);
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	determineFreePixelsIndexes(board, snake) {
		let freePixelsIndexes = [];
		let index = 0;
		let freePixel;
		for (let gridPixel of board.grid) {
			freePixel = true;
			if (snake.head.isAboveOf(gridPixel)) {
				freePixel = false;
			}
			for (let pixel of snake.body) {
				if (pixel.isAboveOf(gridPixel)) {
					freePixel = false;
				}
			}
			if (freePixel) freePixelsIndexes.push(index);
			gridPixel.free = freePixel;
			index++;
		}
		return freePixelsIndexes;
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	checkSnakeStatus(board, snake, food) {
		this.checksSnakeSelfCollide(snake);
		this.checksSnakeBoardCollide(snake, board);
		this.checksSnakeFoodCollide(snake, food, board);
	}
}
