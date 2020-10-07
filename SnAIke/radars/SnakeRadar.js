class SnakeRadar {
    constructor() {
      this.distanceToFoodX;
      this.distanceToFoodY;
  
      this.distanceToLeft = new ZVector2D();
      this.distanceToFront = new ZVector2D();
      this.distanceToRight = new ZVector2D();
  
      this.distanceToLeft.makeVisible();
      this.distanceToFront.makeVisible();
      this.distanceToRight.makeVisible();
    }
  
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    calculateDistanceToFood(snake, food) {
      let head = snake.head;
      this.distanceToFoodX = food.position.x - head.position.x;
      this.distanceToFoodY = food.position.y - head.position.y;
    }
  
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    vectorInsideBoard(vector, board) {
      let leftLimit = board.position.x;
      let rightLimit = board.position.x + board.width;
      let upLimit = board.position.y;
      let downLimit = board.position.y + board.height;
      return vector.tipIsInsideOf(leftLimit, rightLimit, upLimit, downLimit);
    }
  
    vectorOutsideBody(vector, body) {
      for (let pixel of body) {
        let leftLimit = pixel.position.x - pixel.size/2;
        let rightLimit = pixel.position.x + pixel.size/2;
        let upLimit = pixel.position.y - pixel.size/2;
        let downLimit = pixel.position.y + pixel.size/2;
        if (vector.tipIsInsideOf(leftLimit, rightLimit, upLimit, downLimit)) {
          return false;
        }
      }
      return true;
    }
  
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    calculateDistanceTo(direction, rotateAngle, snake, board) {    
      direction.setOrigin(snake.head.position.x, snake.head.position.y);
      let pixelSize = (new ZPixel).size;
      direction.size = pixelSize;
      direction.angle = snake.head.velocity.angle + rotateAngle;
      direction.updateTip();
      while (this.vectorInsideBoard(direction, board) && this.vectorOutsideBody(direction, snake.body)) {
        direction.size = direction.size + pixelSize;
        direction.updateTip();
      }
      direction.size = direction.size - pixelSize;
      direction.updateTip();
    }

    calculateDistanceToLeft(snake, board) {
      this.calculateDistanceTo(this.distanceToLeft, -PI/2, snake, board);
    }
    calculateDistanceToFront(snake, board) {
      this.calculateDistanceTo(this.distanceToFront, 0, snake, board);
    }
    calculateDistanceToRight(snake, board) {
      this.calculateDistanceTo(this.distanceToRight, +PI/2, snake, board);
    }
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    normalizeDistances(snake, board) {
      let pixelSize = (new ZPixel).size;
      let bWidth = board.width - pixelSize;
      let bHeight = board.height - pixelSize;
  
      this.distanceToFoodX /= bWidth;
      this.distanceToFoodY /= bHeight;

      let snakeIsInVertical = int(cos(snake.head.velocity.angle)) == 0;
      if (snakeIsInVertical) {
        this.distanceToLeft.size /= bWidth;
        this.distanceToFront.size /= bHeight;
        this.distanceToRight.size /= bWidth;
      } else {
        this.distanceToLeft.size /= bHeight;
        this.distanceToFront.size /= bWidth;
        this.distanceToRight.size /= bHeight;
      } 
    }
  
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - //
    calculateAndNormalizeDistances(board, snake, food) {
      this.calculateDistanceToFood(snake, food);

      // this.calculateDistanceToLeft(snake, board);
      // this.calculateDistanceToFront(snake, board);
      // this.calculateDistanceToRight(snake, board);

      this.normalizeDistances(snake, board);
    }
  }
  