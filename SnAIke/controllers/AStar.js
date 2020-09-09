class AStar {
  constructor(originTile, destinyTile, board) {
    this.origin = originTile;
    this.destiny = destinyTile;
    this.openList = [];
    this.closedList = [];

    this.setNeighbors(originTile, board);
    // this.calculateCost(originTile, destinyTile);
    // this.updateLists(originTile);
    // this.ordenateOpenList();
    originTile.color = color(255, 255, 0);
  }

  findPath(destinyTile, board) {
    //while (this.openList.length > 0) {
    let originTile = this.openList.splice(0, 1)[0];

    this.setNeighbors(originTile, board);

    this.calculateCost(originTile, destinyTile);

    this.updateLists(originTile);

    this.ordenateOpenList();
    //}
  }

  ordenateOpenList() {
    this.openList.sort(function (tileA, tileB) {
      if (tileA.F < tileB.F) {
        return -1;
      }
      if (tileA.F > tileB.F) {
        return 1;
      }
      return 0;
    })
  }

  isNotIncludesInLists(tile) {
    return (!this.openList.includes(tile) && !this.closedList.includes(tile));
  }

  updateLists(fatherTile) {
    fatherTile.color = color(0, 0, 255, 50);
    this.closedList.push(fatherTile);
    if (fatherTile.neighbors.length > 0) {
      for (let neighbor of fatherTile.neighbors) {
        neighbor.color = color(0, 255, 0, 50);
        this.openList.push(neighbor);
      }
    }
  }

  calculateCost(fatherTile, food) {
    for (let neighbor of fatherTile.neighbors) {
      if (neighbor) {
        neighbor.G = fatherTile.G + 1;
        neighbor.H = neighbor.manhattanDistance(food);
        neighbor.F = neighbor.G + neighbor.H;
      }
    }
  }

  setNeighbors(fatherTile, board) {
    let grid = board.grid;
    let index = fatherTile.index;
    let rows = board.verticalPixelNumber;
    let columns = board.horizontalPixelNumber;

    fatherTile.neighbors = [];

    if (fatherTile.column < columns - 1) {  // Right
      let tile = grid[index + 1];
      // Checar se a Tile não é um obstáculo ou um pixel já acessado.
      if (tile.free && this.isNotIncludesInLists(tile)) fatherTile.neighbors.push(tile);
    } else { fatherTile.neighbors.push(null) }

    if (fatherTile.row < rows - 1) {  // Down
      let tile = grid[index + columns];
      if (tile.free && this.isNotIncludesInLists(tile)) fatherTile.neighbors.push(tile);
    } else { fatherTile.neighbors.push(null) }

    if (fatherTile.column > 0) {  // Left
      let tile = grid[index - 1];
      if (tile.free && this.isNotIncludesInLists(tile)) fatherTile.neighbors.push(tile);
    } else { fatherTile.neighbors.push(null) }

    if (fatherTile.row > 0) {  // Up
      let tile = grid[index - columns];
      if (tile.free && this.isNotIncludesInLists(tile)) fatherTile.neighbors.push(tile);
    } else { fatherTile.neighbors.push(null) }

  }
}
