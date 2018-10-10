class Matrix {
  int rows;
  int cols;
  float[][] matrix;

  Matrix(int r, int c) {
    rows=r;
    cols=c;
    matrix=new float[rows][cols];
  }
  void initRandom() {
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {
        matrix[i][j]=floor(random(0, 7));
      }
    }
  } 

  void printTheMatrix() {
    for (int i=0; i<rows; i++) {
      print("[");
      for (int j=0; j<cols; j++) {
        print(matrix[i][j]+",");
      } 
      println("]");
    } 

    println();
  } 

  Matrix matrixMultiplication(Matrix temp) {
    Matrix newMatrix;
    //println(this.cols+" "+temp.rows);
    if (this.cols==temp.rows) {
      newMatrix=new Matrix(this.rows, temp.cols);
      for (int i=0; i<newMatrix.rows; i++) {
        for (int j=0; j<newMatrix.cols; j++) {
          for (int k=0; k<this.cols; k++) {
            newMatrix.matrix[i][j]+=this.matrix[i][k]*temp.matrix[k][j];
          }
        }
      }
    } else {
      newMatrix=null;
      println("Matrices cannot be multiplide");
    } 
    return newMatrix;
  }

  boolean isSquare() {
    return (this.rows==this.cols);
  } 

  float Determinant(Matrix m) {
    if (isSquare()==false) {
      println("Matrix need to be square");
      return -1;
    } 
    if (m.rows==1 && m.cols==1) {
      return m.matrix[0][0];
    }
    if (m.rows==2 && m.cols==2) {
      return ((m.matrix[0][0]*m.matrix[1][1])-(m.matrix[1][0]*m.matrix[0][1]));
    } 
    float  sum=0;
    for (int i=0; i<m.cols; i++) {
      sum+=getSign(i)*m.matrix[0][i]*Determinant(createSubMatrix(m, 0, i));
    }

    return sum;
  } 

  Matrix createSubMatrix(Matrix m, int excludingRow, int excludingCol) {
    Matrix detMat=new Matrix(m.rows-1, m.cols-1);
    int r=-1;
    for (int i=0; i<m.rows; i++) {
      if (i==excludingRow)
        continue;
      r++;
      int c=-1;
      for (int j=0; j<m.cols; j++) {
        if (j==excludingCol) 
          continue;
        detMat.matrix[r][++c]=m.matrix[i][j];
      }
    }
    return detMat;
  } 

  int getSign(int i) {
    if (i%2==0) {
      return 1;
    } else {
      return -1;
    }
  } 

  void multiply(float value) {
    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {
        matrix[i][j]*=value;
      }
    }
  } 

  Matrix cofactor(Matrix mat) {
    Matrix m=new Matrix(mat.rows, mat.cols);
    for (int i=0; i<m.rows; i++) {
      for (int j=0; j<m.cols; j++) {
        m.matrix[i][j]=getSign(i)*getSign(j)*Determinant(createSubMatrix(mat, i, j));
      }
    }
    return m;
  } 

  Matrix Transpose(Matrix matrix) {
    Matrix transposeM=new Matrix(matrix.cols, matrix.rows);
    for (int i=0; i<transposeM.rows; i++) {
      for (int j=0; j<transposeM.cols; j++) {
        transposeM.matrix[i][j]=matrix.matrix[j][i];
      }
    } 
    return transposeM;
  } 

  Matrix Inverse(Matrix m) {
    Matrix inverse=Transpose(cofactor(m));
    inverse.multiply(1.0/Determinant(m));
    return inverse;
  }

  Matrix Identity() {
    Matrix ide=new Matrix(rows, cols);

    for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {
        if (i==j) {
          ide.matrix[i][j]=1;
        } else {
          ide.matrix[i][j]=0;
        }
      }
    } 
    return ide;
  }

  Matrix vecToCol(float x, float y) {
    Matrix vecCol=new Matrix(2, 1);
    vecCol.matrix[0][0]=x;
    vecCol.matrix[1][0]=y;
    return vecCol;
  } 

  Matrix vecToCol(float x, float y, float z) {
    Matrix vecCol=new Matrix(3, 1);
    vecCol.matrix[0][0]=x;
    vecCol.matrix[1][0]=y;
    vecCol.matrix[2][0]=z;
    return vecCol;
  } 

  void multiplyRow(int row, float value) {
    for (int i=0; i<cols; i++) {
      matrix[row][i]*=value;
    }
  } 

  void subtractRows(float value, int rowTimesValue, int subtractFromThisRow) {
    for (int i=0; i<cols; i++) {
      matrix[subtractFromThisRow][i]-=value*matrix[rowTimesValue][i];
    }
  } 
  void addRows(float value, int rowTimesValue, int addToThisRow) {
    for (int i = 0; i < cols; i++) {
      matrix[addToThisRow][i] += value * matrix[rowTimesValue][i];
    }
  }

  void rref() {
    int lead=0;//pivot
    int i;
    boolean quit=false;

    for (int row=0; row<rows && !quit; row++) {
      if (cols<=lead) {
        quit=true;
        break;
      } 
      i=row;
      while (!quit && matrix[i][lead]==0) {
        i++;
        if (rows==i) {
          i=row;
          lead++;
          if (cols==lead) {
            quit=true;
            break;
          }
        }
      }
      if (!quit) {
        swapRows(i, row);
        if (matrix[row][lead]!=0) {
          multiplyRow(row, 1.0f/matrix[row][lead]);
        }
        for (int j=0; j<rows; j++) {
          if (j!=row) {
            subtractRows(matrix[j][lead], row, j);
          }
        }
      }
    }
  } 

  void swapRows(int r1, int r2) {
    float[] temp = matrix[r1];
    matrix[r1] = matrix[r2];
    matrix[r2] = temp;
  } 

  Matrix addMatrix(Matrix m2) {
    Matrix sumMatrix=new Matrix(this.rows, this.cols);
    ;
    if (m2.rows==this.rows && m2.cols==this.cols) {
      for (int i=0; i<sumMatrix.rows; i++) {
        for (int j=0; j<sumMatrix.cols; j++) {
          sumMatrix.matrix[i][j]+=m2.matrix[i][j]+matrix[i][j];
        }
      }
    }
    return sumMatrix;
  }
} 
