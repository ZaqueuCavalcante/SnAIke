class Board {
	constructor() {
		this.size = (new ZPixel()).size;
		this.position = new ZVector2D(this.size, this.size);
		this.width = width - this.size * 2;
		this.height = height - this.size * 2;

		this.grid = [];
		this.centerPixel;

		this.horizontalPixelNumber;
		this.verticalPixelNumber;

		this.setDimensions();
		this.makeAndPositionPixels();
		this.setCenterPixel();
		this.setPixelsColor();
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	setDimensions() {
		let pixelSize = (new ZPixel()).size;
		this.horizontalPixelNumber = int(this.width / pixelSize);
		this.verticalPixelNumber = int(this.height / pixelSize);
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	makeAndPositionPixels() {
		let pixelSize = (new ZPixel()).size;
		let x, y;
		for (let row = 0; row < this.verticalPixelNumber; row++) {
			for (let column = 0; column < this.horizontalPixelNumber; column++) {
				x = this.position.x + pixelSize / 2 + column * pixelSize;
				y = this.position.y + pixelSize / 2 + row * pixelSize;
				let newPixel = new ZPixel(x, y);
				this.grid.push(newPixel);
			}
		}
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	setCenterPixel() {
		let h = this.horizontalPixelNumber;
		let v = this.verticalPixelNumber;
		let aux = 0;
		if (v % 2 == 0) aux = 1;
		let centerPixelIndex = int(h * v / 2 + aux * h / 2);
		this.centerPixel = this.grid[centerPixelIndex];
	}

	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	setPixelsColor() {
		for (let pixel of this.grid) {
			pixel.color = color(50);
			pixel.stroke = color(100);
		}
	}
}
