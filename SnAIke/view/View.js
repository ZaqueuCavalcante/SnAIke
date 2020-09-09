class View {
	constructor() {
	}

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
	// Utils objects show()
	showZVector2D(vector) {
		if (vector.isVisible()) {
			push();
			stroke(vector.color);
			fill(vector.color);
			strokeWeight(vector.strokeWeight);
			line(vector.origin.x, vector.origin.y, vector.x, vector.y);
			let direction = new createVector(vector.x - vector.origin.x, vector.y - vector.origin.y);
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
		rect(pixel.position.x, pixel.position.y, pixel.size, pixel.size, pixel.size*0.15);
		this.showZVector2D(pixel.position);
		this.showZVector2D(pixel.velocity);
	}
  
	showTile(tile) {
		this.showZPixel(tile);
		fill(255);
		strokeWeight(1.5);
		textSize(20);
		textAlign(CENTER, CENTER);
		let offset = tile.size/3.8;
		text(tile.F, tile.position.x - offset, tile.position.y - offset);
		textSize(15);
		text(tile.G, tile.position.x - offset, tile.position.y + offset);
		text(tile.H, tile.position.x + offset, tile.position.y + offset);
	}
}
