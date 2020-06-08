public class Link {

  private Neuron sourceNeuron;
  private Neuron arrivalNeuron;

  private int weight;
  private float valueCarried;

  private color Color;

  Link(Neuron sourceNeuron, Neuron arrivalNeuron) {
    this.sourceNeuron = sourceNeuron;
    this.arrivalNeuron = arrivalNeuron;

    weight = int(random(0.0, 2.0));
    if (weight == 0) {weight = -1;}
    valueCarried = sourceNeuron.getOutputValue();

    Color = color(80);
  }
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
  public void setWeight(int weight) {
    this.weight = weight;
  }
  public int getWeight() {
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
