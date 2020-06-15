public interface IDynamic {

  public void setPosition(float x, float y);
  public ZVector2D getPosition();

  public void turnLeft();
  public void turnRight();

  public void pointToRight();
  public void pointToDown();
  public void pointToLeft();
  public void pointToUp();

  public void move();
}
