class Tile {
	constructor(x = 0, y = 0, nv = 2) {
		this.self = new ZPixel(x, y);
    this.self.color = color(255, 0, 0);  // Verde claro = lista aberta e Azul claro = lista fechada;

    this.self.index = 0;
    this.self.row = 0;
    this.self.column = 0;

    this.self.F = 0;
    this.self.G = 0;
    this.self.H = 0;

    this.self.father = null;
    this.self.neighbors = [];
	}
}