class Rock {
  constructor(x = 0, y = 0) {
    this.self = new ZPixel(x, y);
    this.self.color = color(255, 255, 0);
  }
}
