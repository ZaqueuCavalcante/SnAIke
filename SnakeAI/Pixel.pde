public class Pixel {

    private Vector position;
    private float size;
    private color Color;

    Pixel(float x, float y) {
        position = new Vector(x, y);
        size = 20.0;
        Color = color(100);
    }
}
