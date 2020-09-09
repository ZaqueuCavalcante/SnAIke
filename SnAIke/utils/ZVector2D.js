class ZVector2D {
	constructor(x = 0, y = 0) {
		this.origin = new createVector();
		this.size = 0;
		this.angle = 0;
		this.x = x;
		this.y = y;

		this.visible = false;
		this.color = color(255);
		this.strokeWeight = 1;
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	setOrigin(x, y) {
		this.origin.set(x, y);
	}
	set(x, y) {
		this.x = x;
		this.y = y;
	}
	updateTip() {
		this.x = this.origin.x + this.size * cos(this.angle);
		this.y = this.origin.y + this.size * sin(this.angle);
	}
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	makeVisible() {
		this.visible = true;
	}
	makeInvisible() {
		this.visible = false;
	}
	isVisible() {
		return this.visible;
	}
	
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	tipIsInsideOf(leftLimit, rightLimit, upLimit, downLimit) {
		let insideWidth = (this.x > leftLimit) && (this.x < rightLimit);
		let insideHeight = (this.y > upLimit) && (this.y < downLimit);
		return (insideWidth && insideHeight);
	}
}
