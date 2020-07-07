class AStar {
  constructor(originTile, destinyTile) {
    this.origin = originTile;
    this.destiny = destinyTile;
    this.openList = [];
    this.closeList = [];
  }

  setNeighbors(fatherTile, board) {
    let grid = board.grid;
    let index = fatherTile.index;
    let rows = board.verticalPixelNumber;
    let columns = board.horizontalPixelNumber;

    fatherTile.neighbors = [];

    if (fatherTile.column < columns - 1) {  // Right
      let tile = grid[index + 1];
      fatherTile.neighbors.push(tile);
    } else { fatherTile.neighbors.push(null) }

    if (fatherTile.row < rows - 1) {  // Down
      let tile = grid[index + columns];
      fatherTile.neighbors.push(tile);
    } else { fatherTile.neighbors.push(null) }

    if (fatherTile.column > 0) {  // Left
      let tile = grid[index - 1];
      fatherTile.neighbors.push(tile);
    } else { fatherTile.neighbors.push(null) }

    if (fatherTile.row > 0) {  // Up
      let tile = grid[index - columns];
      fatherTile.neighbors.push(tile);
    } else { fatherTile.neighbors.push(null) }

  }
}
