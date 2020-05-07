// Duas ou mais cobras competindo no mesmo ambiente.
// Uma pode matar a outra, se comer seu rabo.
// Adicionar obstáculos.

public void settings() {
  size(1200, 800);
}

Screen screen;
Rink rink;

boolean humanPlaying = true;

void setup() {
  screen = new Screen(width, height);
  screen.setFPS(10);
  
  rink = new Rink();
  rink.setPosition(500, 100);
  rink.setSideSizes(800-2*100, 800-2*100);
  rink.setPixelSize(100);
  rink.setPixelPositions();
  
  rink.addSnake();
  rink.snake.body.addPixel();
}

void draw() {
  screen.show();
  
  rink.show();
  rink.showPixelStrokes();
  rink.snake.show();
  rink.addFood();
  
  
  
  //int index = int(random(0, 4));
  //int[] values = {10, 6, 12, 42};
  //print(random(0, 255));
  //print('\n');
}
