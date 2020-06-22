public class ABoard {

  private ZVector2D position;
  private float widthh;
  private float heightt;

  private ArrayList<ZPixel> grid;
  private ZPixel centerPixel;

  private int horizontalPixelNumber;
  private int verticalPixelNumber;

  ABoard() {
    this.position = new ZVector2D(400, 0);
    this.widthh = width - 400;
    this.heightt = height - 350;

    this.grid = new ArrayList<ZPixel>();

    this.setDimensions();
    this.setPixelPositions();
    this.setPixelColors();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  private void setDimensions() {
    ZPixel pixel = new ZPixel(42, 42);
    this.horizontalPixelNumber = int(this.widthh/pixel.getSize());
    this.verticalPixelNumber = int(this.heightt/pixel.getSize());
  }
  private void setPixelPositions() {
    ZPixel pixel = new ZPixel(42, 42);
    float x, y;
    for (int row = 0; row < this.verticalPixelNumber; row++) {
      for (int column = 0; column < this.horizontalPixelNumber; column++) {
        x = this.position.getX() + pixel.getSize()/2 + column*pixel.getSize();
        y = this.position.getY() + pixel.getSize()/2 + row*pixel.getSize();
        ZPixel newPixel = new ZPixel(x, y);
        this.grid.add(newPixel);
      }
    }
    this.setCenterPixel();
  }
  private setCenterPixel() {
    int h = this.horizontalPixelNumber();
    int v = this.verticalPixelNumber();
    int aux = 0;
    if (v % 2 == 0) aux = 1;
    int centerPixelIndex = int(h * v/2 + aux*h/2);
    this.centerPixel = this.grid.get(centerPixelIndex);
  }
  private void setPixelColors() {
    for (ZPixel pixel : this.grid) {
      pixel.setColor(color(20));
      pixel.setStrokee(color(50));
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public ZVector2D getPosition() {
    return this.position;
  }
  public float getWidth() {
    return this.widthh;
  }
  public float getHeight() {
    return this.heightt;
  }
  public ArrayList<ZPixel> getGrid() {
    return this.grid;
  }
  public int getHorizontalPixelNumber() {
    return this.horizontalPixelNumber;
  }
  public int getVerticalPixelNumber() {
    return this.verticalPixelNumber;
  }
}
