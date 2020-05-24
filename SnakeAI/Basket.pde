public class Basket {

  private int size;
  private Food[] foods;

	Basket(int size) {
			this.size = size;
	}
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
	public void setInitialFoods() {
		foods = new Food[size];
		for (int i = 0; i < size; i++) {
			foods[i] = new Food();
		}
	}
}

