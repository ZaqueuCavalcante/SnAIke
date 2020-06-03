public class Graph extends PApplet {

  private String xAxisName;
  private String yAxisName;

	Graph() {
  	super();
   	PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
 	}
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	public void setAxisNames(String xAxisName, String yAxisName) {
    this.xAxisName = xAxisName;
    this.yAxisName = yAxisName;
  }
  private void showAxisLines() {
    stroke(0);
    strokeWeight(5);
    line(50, 0, 50, height-50);
    line(50, height-50, width, height-50);
  }
  private void showAxisNames() {
    background(150);
    fill(0);
    strokeWeight(1);
    textSize(15);
    textAlign(CENTER, CENTER);
    text(xAxisName, width/2, height-10);
    rotate(PI/2);
    text(yAxisName, width/2, -10);
    rotate(-PI/2);
  }
  private void showGridLines() {
    int xDivisions = int(width/50);
    int yDivisions = int(height/50);
    for (int i = 0; i <= xDivisions; i++) {
      line(50*i, 50, 50*i, height-50);
    }
    for (int j = 0; j <= yDivisions; j++) {
      line(50, 50*j, width-50, 50*j);
    }
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  void setup() {
		size(900, 600);
		background(150);
		frameRate(30);
	}

  void draw() {
    showAxisLines();
    showAxisNames();
    showGridLines();
  }

  //void exit() {
  //  dispose();
  //  graph = null;
  //}
}
