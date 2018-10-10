Shape b1;
Matrix rotationMatrix;
PVector area;
float getX(float x) {
  return map(x, -100, 100, 0, width);
} 
float getY(float y) {
  return map(y, -100, 100, height, 0);
} 
void setup() {
  size(700, 700);
  area = new PVector(50, -50);
  rotationMatrix = new Matrix(2, 2);
  b1 = new Shape(new PVector(4, 4), 10, 10);
} 

void Rotate(float angle) {
  b1.a = PVector.sub(b1.a, b1.origin);
  b1.b = PVector.sub(b1.b, b1.origin);
  b1.c = PVector.sub(b1.c, b1.origin);
  b1.d = PVector.sub(b1.d, b1.origin);
  
  rotationMatrix.matrix[0][0] = cos(angle);
  rotationMatrix.matrix[1][0] = sin(angle);

  rotationMatrix.matrix[0][1] = -sin(angle);
  rotationMatrix.matrix[1][1] = cos(angle);
  Matrix verticesMatrix = new Matrix(4, 2);
  
  verticesMatrix.matrix[0][0] = b1.a.x;
  verticesMatrix.matrix[0][1] = b1.a.y;
  
  verticesMatrix.matrix[1][0] = b1.b.x;
  verticesMatrix.matrix[1][1] = b1.b.y;
  
  verticesMatrix.matrix[2][0] = b1.c.x;
  verticesMatrix.matrix[2][1] = b1.c.y;
   
  verticesMatrix.matrix[3][0] = b1.d.x;
  verticesMatrix.matrix[3][1] = b1.d.y;
  Matrix centerMatrix = new Matrix(2, 1);
  centerMatrix.matrix[0][0] = b1.origin.x;
  centerMatrix.matrix[1][0] = b1.origin.y;
  Matrix newCenterMatrix = rotationMatrix.matrixMultiplication(centerMatrix);
    
  b1.origin.x = newCenterMatrix.matrix[0][0];  
  b1.origin.y = newCenterMatrix.matrix[1][0];
  
  Matrix newVerticesMatrix = verticesMatrix.matrixMultiplication(rotationMatrix);
  b1.a.x = newVerticesMatrix.matrix[0][0];
  b1.a.y = newVerticesMatrix.matrix[0][1];
  
  b1.b.x = newVerticesMatrix.matrix[1][0];
  b1.b.y = newVerticesMatrix.matrix[1][1];
  
  b1.c.x = newVerticesMatrix.matrix[2][0];
  b1.c.y = newVerticesMatrix.matrix[2][1];
  
  b1.d.x = newVerticesMatrix.matrix[3][0];
  b1.d.y = newVerticesMatrix.matrix[3][1];
  
  b1.a = PVector.add(b1.a, b1.origin);
  b1.b = PVector.add(b1.b, b1.origin);
  b1.c = PVector.add(b1.c, b1.origin);
  b1.d = PVector.add(b1.d, b1.origin);
} 

void draw() {
  background(255);
  b1.show();
  fill(0, 255, 0, 60);
  rect(getX(area.x), getY(area.y), 100, 100);
}

void keyPressed() {
  if (key == ' ') {
    Rotate(PI / 8);
  } else if (key == 'a') {
    area.set(map(mouseX, 0, width, -100, 100), map(mouseY, 0, height, 100, -100));
  } 
  
} 

//void mousePressed() {
//  b1.origin.set(map(mouseX, 0, width, -100, 100), map(mouseY, 0, height, 100, -100));
//} 

class Matrix {
  int rows;
  int cols;
  float[][] matrix;
  
  Matrix(int r,int c) {
   rows=r;
   cols=c;
   matrix=new float[rows][cols];
   
  }
  void initRandom() {
    for(int i=0;i<rows;i++) {
      for(int j=0;j<cols;j++) {
        matrix[i][j]=floor(random(0,7));
      } 
    } 
    
  } 
  
  void printTheMatrix() {
    for(int i=0;i<rows;i++) {
      print("[");
      for(int j=0;j<cols;j++) {
        print(matrix[i][j]+",");
      } 
      println("]");
    } 
    
    println();
  } 
  
  Matrix matrixMultiplication(Matrix temp) {
    Matrix newMatrix;
    //println(this.cols+" "+temp.rows);
    if(this.cols==temp.rows) {
      newMatrix=new Matrix(this.rows,temp.cols);
      for(int i=0;i<newMatrix.rows;i++) {
        for(int j=0;j<newMatrix.cols;j++) {
          for(int k=0;k<this.cols;k++) {
            newMatrix.matrix[i][j]+=this.matrix[i][k]*temp.matrix[k][j];
          } 
        } 
      } 
    }else {
      newMatrix=null;
      println("Matrices cannot be multiplide");
    } 
    return newMatrix;
  }
  
  boolean isSquare() {
    return (this.rows==this.cols);
  } 
  
  float Determinant(Matrix m) {
    if(isSquare()==false) {
      println("Matrix need to be square");
      return -1;
    } 
    if(m.rows==1 && m.cols==1) {
      return m.matrix[0][0];
    }
    if(m.rows==2 && m.cols==2) {
      return ((m.matrix[0][0]*m.matrix[1][1])-(m.matrix[1][0]*m.matrix[0][1]));
    } 
    float  sum=0;
    for(int i=0;i<m.cols;i++) {
      sum+=getSign(i)*m.matrix[0][i]*Determinant(createSubMatrix(m,0,i)); 
    }
    
    return sum;
    
  } 
  
  Matrix createSubMatrix(Matrix m,int excludingRow,int excludingCol) {
    Matrix detMat=new Matrix(m.rows-1,m.cols-1);
    int r=-1;
    for(int i=0;i<m.rows;i++) {
      if(i==excludingRow)
        continue;
      r++;
      int c=-1;
      for(int j=0;j<m.cols;j++) {
        if(j==excludingCol) 
          continue;
        detMat.matrix[r][++c]=m.matrix[i][j];
      }
    }
    return detMat;
  } 
  
  int getSign(int i) {
    if(i%2==0) {
       return 1; 
    } else  {
      return -1;
    } 
  } 
  
  void multiply(float value) {
    for(int i=0;i<rows;i++) {
      for(int j=0;j<cols;j++) {
        matrix[i][j]*=value;
      } 
    } 
    
  } 
  
  Matrix cofactor(Matrix mat) {
    Matrix m=new Matrix(mat.rows,mat.cols);
    for(int i=0;i<m.rows;i++) {
      for(int j=0;j<m.cols;j++) {
        m.matrix[i][j]=getSign(i)*getSign(j)*Determinant(createSubMatrix(mat,i,j));
      } 
    }
    return m;
  } 
  
  Matrix Transpose(Matrix matrix) {
    Matrix transposeM=new Matrix(matrix.cols,matrix.rows);
    for(int i=0;i<transposeM.rows;i++) {
      for(int j=0;j<transposeM.cols;j++) {
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
    Matrix ide=new Matrix(rows,cols);
    
    for(int i=0;i<rows;i++) {
      for(int j=0;j<cols;j++) {
        if(i==j) {
          ide.matrix[i][j]=1;
        }
        else {
          ide.matrix[i][j]=0;
        } 
      } 
      
    } 
    return ide;
    
  }
  
  Matrix vecToCol(float x,float y) {
    Matrix vecCol=new Matrix(2,1);
    vecCol.matrix[0][0]=x;
    vecCol.matrix[1][0]=y;
    return vecCol;
  } 
  
   Matrix vecToCol(float x,float y,float z) {
    Matrix vecCol=new Matrix(3,1);
    vecCol.matrix[0][0]=x;
    vecCol.matrix[1][0]=y;
    vecCol.matrix[2][0]=z;
    return vecCol;
  } 
  
  
  void swapRows(int row1,int row2) {
    float[] temp=new float[cols];
    //for(int i=0;i<cols;i++) {
     // temp[i]=matrix[row1][i];
    //} 
    for(int i=0;i<cols;i++) {
      temp[i]=matrix[row1][i];
      matrix[row1][i]=matrix[row2][i];
      matrix[row2][i]=temp[i];
    } 
  } 
  
  void multiplyRow(int row,float value) {
    for(int i=0;i<cols;i++) {
      matrix[row][i]*=value;
    } 
  } 
  
  void subtractRows(float value,int rowTimesValue,int subtractFromThisRow) {
    for(int i=0;i<cols;i++) {
      matrix[subtractFromThisRow][i]-=value*matrix[rowTimesValue][i];
    } 
  } 
  
  void rref() {
    int lead=0;//pivot
    int i;
    boolean quit=false;
    
    for(int row=0;row<rows && !quit;row++) {
      if(cols<=lead) {
        quit=true;
        break;
      } 
      i=row;
      while(!quit && matrix[i][lead]==0) {
        i++;
        if(rows==i) {
          i=row;
          lead++;
          if(cols==lead) {
            quit=true;
            break;
          } 
        } 
      }
      if(!quit) {
        swapRows(i,row);
        if(matrix[row][lead]!=0) {
          multiplyRow(row,1.0f/matrix[row][lead]);
          
        }
        for(int j=0;j<rows;j++) {
          if(j!=row) {
            subtractRows(matrix[j][lead],row,j);
          } 
        } 
      } 
    } 
  } 
  
  Matrix addMatrix(Matrix m2) {
    Matrix sumMatrix=new Matrix(this.rows,this.cols);;
    if(m2.rows==this.rows && m2.cols==this.cols) {
      for(int i=0;i<sumMatrix.rows;i++) {
        for(int j=0;j<sumMatrix.cols;j++) {
          sumMatrix.matrix[i][j]+=m2.matrix[i][j]+matrix[i][j];
        } 
      } 
    }
    return sumMatrix;
  }
  
} 