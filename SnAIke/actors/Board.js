class Board {
	constructor() {
		this.position = new ZVector2D(50, 50);
		this.width = width - 100;
		this.height = height - 100;

		this.grid = [];
		this.centerPixel;

		this.horizontalPixelNumber;
		this.verticalPixelNumber;

		this.setDimensions();
		this.makeAndPositionPixels();
		this.setCenterPixel();
		this.setPixelColors();
	}
	// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	setDimensions() {
		let pixel = new ZPixel();
		this.horizontalPixelNumber = int(this.width / pixel.size);
		this.verticalPixelNumber = int(this.height / pixel.size);
	}
	makeAndPositionPixels() {
		let pixel = new ZPixel();
		let x, y;
		for (let row = 0; row < this.verticalPixelNumber; row++) {
			for (let column = 0; column < this.horizontalPixelNumber; column++) {
				x = this.position.x + pixel.size / 2 + column * pixel.size;
				y = this.position.y + pixel.size / 2 + row * pixel.size;
				let newPixel = new ZPixel(x, y);
				this.grid.push(newPixel);
			}
		}
	}
	setCenterPixel() {
	let h = this.horizontalPixelNumber;
	let v = this.verticalPixelNumber;
	let aux = 0;
		if (v % 2 == 0) aux = 1;
		let centerPixelIndex = int(h*v/2 + aux*h/2);
		this.centerPixel = this.grid[centerPixelIndex];
	}
	setPixelColors() {
		for (let pixel of this.grid) {
			pixel.color = color(50);
			pixel.stroke = color(100);
		}
	}
}
