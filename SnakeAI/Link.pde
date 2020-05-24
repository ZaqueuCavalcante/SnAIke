public class Link {

  private Neuron sourceNeuron;
  private Neuron arrivalNeuron;

  private float weight;
  private float valueCarried;

  private color Color;

  Link(Neuron sourceNeuron, Neuron arrivalNeuron) {
    this.sourceNeuron = sourceNeuron;
    this.arrivalNeuron = arrivalNeuron;

    weight = random(-1000.0, 1000.0);
    valueCarried = sourceNeuron.getOutputValue();

    Color = color(80);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setWeight(float weight) {
    this.weight = weight;
  }
  public float getWeight() {
    return weight;
  }
  public void setValueCarried(float valueCarried) {
    this.valueCarried = valueCarried;
  }
  public float getValueCarried() {
    return valueCarried;
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