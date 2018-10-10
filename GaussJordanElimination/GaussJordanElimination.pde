int rows = 2;
int cols = 3;
void setup() {
 
  float[][] arr = new float[rows][cols];
  
  Matrix m1 = new Matrix(rows, cols);
  m1.matrix[0][0] = 3;
  m1.matrix[0][1] = 2;
  m1.matrix[0][2] = -5;
  m1.matrix[1][0] = -1;
  m1.matrix[1][1] = 4;
  m1.matrix[1][2] = 4;
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      arr[i][j] = m1.matrix[i][j];
    } 
  } 
  

  println("Original Matrix");
  printArr(arr);
  println("!!!!");
  m1.printTheMatrix();
  //pivotisation
  for (int i = 0; i < rows; i++) {
    for (int k = i + 1; k < rows; k++) {
      if (arr[i][i] < arr[k][i]) {
        //if pivot element is less than the elements below it, swap the rows 
        for (int j = 0; j < cols; j++) {
          float temp = arr[i][j];
          arr[i][j] = arr[k][j];
          arr[k][j] = temp;
        }
      }
    }
  }
  //gauss-elimination
  for (int i = 0; i < rows - 1; i++) {
    for (int k = i; k < rows; k++) {
      if (i != k) {
        float c = arr[k][i] / arr[i][i];
        for (int j = 0; j < cols; j++) {
          arr[k][j] -= c * arr[i][j];
        }
      }
    }
  } 
  
  println("##################");
  println("Matrix after rref");
  printArr(arr);
  m1.rref();
  println("!!!!!");
  m1.printTheMatrix();
  
  println("Unit form");
  //make the matrix unit
  for (int i = 0; i < rows; i++) {
    float c = arr[i][i];
    for (int j = 0; j < cols; j++) { 
      arr[i][j] = floor(arr[i][j] / c);
    } 
  } 
  printArr(arr);
  
  
  
} 

void findUnknown(float[][] arr) {
  float unknown[] = new float[rows]; //is an array of variables 
  for (int i = rows - 1; i >= 0; i--) {
    unknown[i] = arr[i][cols - 1]; // make the variable to be calculated as rhs of the equation
    for (int j = 0; j < rows; j++) {
      if (j != i) { // then subtract all the lhs values(cols) except the variable to be calculated
        unknown[i] = unknown[i] - arr[i][j] * unknown[j]; 
      } 
    } 
  }
  println("##########");
  print("Solutions:");
  for (int i = 0; i < unknown.length; i++) {
    print(unknown[i]+", ");
  } 
} 

void printArr(float[][] arr) {
  for (int i = 0; i < arr.length; i++) {
    for (int j = 0; j < arr[0].length; j++) {
      print(arr[i][j]+", ");
    } 
    println();
  }
} 

void draw() {
} 
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


  void swapRows(int row1, int row2) {
    float[] temp=new float[cols];
    //for(int i=0;i<cols;i++) {
    // temp[i]=matrix[row1][i];
    //} 
    for (int i=0; i<cols; i++) {
      temp[i]=matrix[row1][i];
      matrix[row1][i]=matrix[row2][i];
      matrix[row2][i]=temp[i];
    }
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
