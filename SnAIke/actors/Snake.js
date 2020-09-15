class Snake {
	constructor(x = 0, y = 0) {
		this.head = new ZPixel(x, y);
		this.setHeadVelocity();

		this.color = color(random(255), random(255), random(255));

		this.body = [];
		this.body.push(new ZPixel(x, y));
		this.body[0].color = this.color;

		this.score = 0;
		this.defaultMoves = 50;
		this.remainingMoves = this.defaultMoves;
		this.dead = false;

		this.genes = new GenesList();
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	setHeadVelocity() {
		this.head.velocity.color = color(255, 255, 0);
		this.head.velocity.strokeWeight = 5;
		// this.head.velocity.makeVisible();
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	bodyAddPixel() {
		let newPixel = new ZPixel(this.body[0].position.x, this.body[0].position.y);
		newPixel.color = this.color;
		this.body.push(newPixel);
	}
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	move() {
		let frontPixelX = this.head.position.x;
		let frontPixelY = this.head.position.y;
		this.head.move();
		let backPixelX;
		let backPixelY;
		for (let pixel of this.body) {
			backPixelX = pixel.position.x;
			backPixelY = pixel.position.y;
			pixel.setPosition(frontPixelX, frontPixelY);
			frontPixelX = backPixelX;
			frontPixelY = backPixelY;
		}
		this.decrementRemainingMoves();
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	eat(food) {
		for (let c = 0; c < food.nutritionalValue; c++) {
			this.bodyAddPixel();
			this.increaseScore();
		}
		this.incrementRemainingMoves();
	}
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	resetScore() { this.score = 0; }
	increaseScore() { this.score ++; }

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	resetRemainingMoves() {	this.remainingMoves = this.defaultMoves; }
	incrementRemainingMoves() {	this.remainingMoves += this.defaultMoves; }
	decrementRemainingMoves() {	this.remainingMoves --;	}
	remainingMovesIsEnded() { return (this.remainingMoves <= 0); }

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	live() { this.dead = false;	}
	die() {	this.dead = true; }
	isDead() { return this.dead; }
	isNotDead() { return !this.dead; }

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	selfCollide() {
		for (let pixel of this.body) {
			if (this.head.isAboveOf(pixel)) {
				return true;
			}
		}
		return false;
	}

	boardCollide(board) {
		let leftLimit = board.position.x;
		let rightLimit = board.position.x + board.width;
		let upLimit = board.position.y;
		let downLimit = board.position.y + board.height;
		if (this.head.isInsideOf(leftLimit, rightLimit, upLimit, downLimit)) {
			return false;
		}
		return true;
	}

	rockCollide(rock) {	return (this.head.isAboveOf(rock));	}

	foodCollide(food) {	return (this.head.isAboveOf(food)); }

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	clone() {
		let clonedSnake = new Snake();
		return Object.assign(clonedSnake, this);
	}
}
