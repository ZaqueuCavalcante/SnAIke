public class Pixel {

  private Vector2D position;
  private float size;
  private color colour;

  Pixel(float x, float y) {
    position = new Vector2D(x, y);
    size = 20.0;
    colour = color(100);
  }
}
