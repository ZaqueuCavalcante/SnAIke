public class Link {

  private Neuron sourceNeuron;
  private Neuron arrivalNeuron;

  private float weight;

  private color Color;

  Link(Neuron sourceNeuron, Neuron arrivalNeuron) {
    this.sourceNeuron = sourceNeuron;
    this.arrivalNeuron = arrivalNeuron;

    weight = random(-1.0, 1.0);

    Color = color(80);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setWeight(float weight) {
    this.weight = weight;
  }
  public float getWeight() {
    return weight;
  }
  public void setColor(color Color) {
    this.Color = Color;
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void show() {
    stroke(Color);
    line(sourceNeuron.position.x, sourceNeuron.position.y, arrivalNeuron.position.x, arrivalNeuron.position.y);
  }
}
