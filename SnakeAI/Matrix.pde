class Matrix {

  int rows, columns;
  float[][] body;

  Matrix(int r, int c) {
    rows = r;
    columns = c;
    body = new float[rows][columns];
  }

  Matrix(float[][] m) {
    body = m;
    rows = body.length;
    columns = body[0].length;
  }

  void output() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        print(body[i][j] + " ");
      }
      println();
    }
    println();
  }

  Matrix dot(Matrix otherMatrix) {
    Matrix resultOfProduct = new Matrix(rows, otherMatrix.columns);

    if (columns == otherMatrix.rows) {
      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < otherMatrix.columns; j++) {
          float sum = 0;
          for (int k = 0; k < columns; k++) {
            sum += body[i][k]*otherMatrix.body[k][j];
          }  
          resultOfProduct.body[i][j] = sum;
        }
      }
    };
    return resultOfProduct;
  }

  void randomize() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        body[i][j] = random(-1, 1);
      }
    }
  }

  Matrix singleColumnMatrixFromArray(float[] array) {
    Matrix singleColumnMatrix = new Matrix(array.length, 1);
    for (int i = 0; i < array.length; i++) {
      singleColumnMatrix.body[i][0] = array[i];
    }
    return singleColumnMatrix;
  }

  float[] toArray() {
    float[] array = new float[rows*columns];
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        array[j + i*columns] = body[i][j];
      }
    }
    return array;
  }

  Matrix addBias() {
    Matrix matrixWithBias = new Matrix(rows+1, 1);
    for (int i = 0; i < rows; i++) {
      matrixWithBias.body[i][0] = body[i][0];
    }
    matrixWithBias.body[rows][0] = 1;
    return matrixWithBias;
  }

  Matrix activate() {
    Matrix activatedMatrix = new Matrix(rows, columns);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        activatedMatrix.body[i][j] = relu(body[i][j]);
      }
    }
    return activatedMatrix;
  }

  float relu(float x) {
    return max(0, x);
  }

  void mutate(float mutationRate) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        float rand = random(1);
        if (rand < mutationRate) {
          body[i][j] += randomGaussian()/5;
          if (body[i][j] > 1) {
            body[i][j] = 1;
          }
          if (body[i][j] < -1) {
            body[i][j] = -1;
          }
        }
      }
    }
  }

  Matrix crossover(Matrix partner) {
    Matrix child = new Matrix(rows, columns);

    int randColumns = floor(random(columns));
    int randRows = floor(random(rows));

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        if ((i  < randRows) || (i == randRows && j <= randColumns)) {
          child.body[i][j] = body[i][j];
        } else {
          child.body[i][j] = partner.body[i][j];
        }
      }
    }
    return child;
  }

  Matrix clone() {
    Matrix clone = new Matrix(rows, columns);
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        clone.body[i][j] = body[i][j];
      }
    }
    return clone;
  }
}
