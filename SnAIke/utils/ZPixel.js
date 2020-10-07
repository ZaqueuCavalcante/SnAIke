class ZPixel {
	constructor(x = 0, y = 0) {
		this.position = new ZVector2D(x, y);
		this.size = 25;
		this.velocity = new ZVector2D();
		this.velocity.setOrigin(x, y);
		this.velocity.size = this.size;
		this.velocity.updateTip();

		this.color = color(100);
		this.stroke = color(255);
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	setPosition(x, y) {
		this.position.set(x, y);
		this.velocity.setOrigin(x, y);
		this.velocity.updateTip();
	}
	translateTo(pixel) {
		this.setPosition(pixel.position.x, pixel.position.y);
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	pointTo(angle) {
		this.velocity.angle = angle;
		this.velocity.updateTip();
	}
	pointToRight() {
		this.pointTo(0.0);
	}
	pointToDown() {
		this.pointTo(PI/2);
	}
	pointToLeft() {
		this.pointTo(PI);
	}
	pointToUp() {
		this.pointTo(3*PI/2);
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	move() {
		this.position.x += this.velocity.size * int(cos(this.velocity.angle));
		this.position.y += this.velocity.size * int(sin(this.velocity.angle));
		this.velocity.setOrigin(this.position.x, this.position.y);
		this.velocity.updateTip();
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	isAboveOf(pixel) {
		let leftLimit = pixel.position.x - pixel.size / 2;
		let rightLimit = pixel.position.x + pixel.size / 2;
		let upLimit = pixel.position.y - pixel.size / 2;
		let downLimit = pixel.position.y + pixel.size / 2;
		return this.isInsideOf(leftLimit, rightLimit, upLimit, downLimit);
	}

	isInsideOf(leftLimit, rightLimit, upLimit, downLimit) {
		let x = this.position.x;
		let y = this.position.y;
		let insideWidth = (x > leftLimit) && (x < rightLimit);
		let insideHeight = (y > upLimit) && (y < downLimit);
		return (insideWidth && insideHeight);
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	manhattanDistance(pixel) {
		let xDistance = abs(this.position.x - pixel.position.x);
		let yDistance = abs(this.position.y - pixel.position.y);
		return (xDistance + yDistance) / this.size;
	}
}
