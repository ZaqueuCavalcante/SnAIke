import grafica.*;

public class Graph extends PApplet {
  
  GPlot plot;

  public void settings() {
    size(600, 400);
  }

  public void setup() {
    int nPoints = 100;
    GPointsArray points = new GPointsArray(nPoints);

    for (int i = 0; i < nPoints; i++) {
      points.add(i, 10*noise(0.1*i));
    }

    plot = new GPlot(this);

    // Set the plot title and the axis labels
    plot.setTitleText("My Plot");
    plot.getXAxis().setAxisLabelText("x axis");
    plot.getYAxis().setAxisLabelText("y axis");

    // Add the points
    plot.setPoints(points);

    // Activate the zooming and panning
    plot.activateZooming();
    plot.activatePanning();
  }

  public void draw() {
    // Draw the second plot
    background(255);
    plot.defaultDraw();
  }
}
