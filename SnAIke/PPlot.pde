class PPlot {

  private GPlot self;
  private color fontColor;
  private int fontSize;

  PPlot(SnAIke SnAIke) {
    self = new GPlot(SnAIke);
    fontColor = color(255);
    fontSize = 20;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setPosition(float x, float y) {
    self.setPos(x, y);
  }
  public void setDimensions(float w, float h) {
    self.setDim(w, h);
  }
  public void setMargins(float down, float left, float up, float right) {
    self.setMar(new float[] {down, left, up, right});
  }
  public void setTitle(String title) {
    self.getTitle().setText(title);
    self.getTitle().setFontSize(fontSize);
    self.getTitle().setFontColor(fontColor);
  }
  public void setLabels() {
    self.getXAxis().setFontSize(fontSize-5);
    self.getXAxis().setFontColor(fontColor);
    self.getYAxis().setFontSize(fontSize-5);
    self.getYAxis().setFontColor(fontColor);
  }
  public void setAxisInterval(float deltaX, float deltaY) {
    self.getXAxis().setTicksSeparation(deltaX);
    self.getYAxis().setTicksSeparation(deltaY);
  }
  public void setGrid() {
    self.setBoxBgColor(20);
    self.setBoxLineColor(30);
    self.setGridLineColor(30);
    self.setLineColor(255);
  }
  public void addPoint(float x, float y) {
    self.addPoint(x, y);
  }
  public void setPoints(FloatList genes) {
    GPointsArray points = new GPointsArray();
    for (int c = 0; c < genes.size(); c++) {
      points.add(c, genes.get(c));
    }
    self.setPoints(points);
  }
  public void setAxisLimits(float xInfLimit, float xSupLimit, float yInfLimit, float ySupLimit) {
    self.setXLim(xInfLimit, xSupLimit);
    self.setYLim(yInfLimit, ySupLimit);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    self.beginDraw();
    self.setBgColor(20);
    self.drawBackground();
    self.drawBox();
    self.drawXAxis();
    self.drawYAxis();
    self.drawTitle();
    self.drawGridLines(GPlot.BOTH);
    self.drawLines();
    self.drawPoints();
    self.endDraw();
  }
}
