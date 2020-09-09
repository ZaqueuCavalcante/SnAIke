class Food {
	constructor(x = 0, y = 0, nv = 2) {
		this.self = new ZPixel(x, y);
		this.self.color = color(255, 0, 0);
		this.self.nutritionalValue = nv;
	}
}
