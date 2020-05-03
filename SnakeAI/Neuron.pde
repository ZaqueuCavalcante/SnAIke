class Neuron {

  String inputName;
  float inputValue;
  String outputName;
  float outputValue;

  boolean activated;

  PVector position;
  float radius;

  color Color = color(100);

  Neuron(PVector position_) {
    position  = position_;
    radius = 25.0;
  }

  void show() {
    fill(Color);
    stroke(255);
    ellipseMode(CENTER);
    ellipse(position.x, position.y, radius, radius);
  }

  void connectTo(Neuron otherNeuron) {
    stroke(255);
    line(position.x, position.y, otherNeuron.position.x, otherNeuron.position.y);
  }

  void deactivate() {
    activated = false;
    Color = color(100);
  }
  void activate() {
    activated = true;
    Color = color(0, 255, 0);
  }
}
