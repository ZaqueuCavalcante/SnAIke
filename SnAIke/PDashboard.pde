class PDashboard {

  private PPlot scorePlot;
  private PPlot weightPlot;

  PDashboard(SnAIke SnAIke) {
    scorePlot = new PPlot(SnAIke);
    weightPlot = new PPlot(SnAIke);
    setScorePlot();
    setWeightPlot();
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public PPlot getScorePlot() {
    return this.scorePlot;
  }
  public PPlot getWeightPlot() {
    return this.weightPlot;
  }

  private void setScorePlot() {
    scorePlot.setPosition(0, height-349);
    scorePlot.setDimensions(width/2.7, 280);
    scorePlot.setMargins(0, 40, 35, 0);
    scorePlot.setTitle("Score vs Generation");
    scorePlot.setLabels();
    scorePlot.setGrid();
  }

  private void setWeightPlot() {
    weightPlot.setPosition(width/2.45, height-349);
    weightPlot.setDimensions(width/1.8, 280);
    weightPlot.setMargins(0, 40, 35, 0);
    weightPlot.setTitle("Weight vs Gene");
    weightPlot.setLabels();
    weightPlot.setGrid();
    weightPlot.setAxisInterval(10, 2);
    weightPlot.setAxisLimits(0, 101, -10.1, 10.1);
  }
}
