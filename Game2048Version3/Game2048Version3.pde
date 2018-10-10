int[][] board;

boolean moved=false;
void setup() {
  size(400,400);
  board=new int[4][4];
  addRandomSpots(2);

} 

void addRandomSpots(int numDig) {
  int counter=0;
  while(counter<numDig) {
    int x=int(random(0,4));
    int y=int(random(0,4));
    if(board[x][y]==0) {
      if(random(1)<0.5) {
        board[x][y]=2;
      }else {
        board[x][y]=4;
      } 
      counter++;
    } 
  } 
}

void draw() {
  background(255);
  for(int i=0;i<4;i++) {
    for(int j=0;j<4;j++) {
      float x=j*100;
      float y=i*100;
      noFill();
      strokeWeight(2);
      stroke(0);
      rect(x,y,100,100);
      fill(0);
      textAlign(CENTER);
      textSize(50);
      text(board[i][j],x+50,y+60);
    } 
  } 
}

int[][] copyGrid(int[][] grid) {
  int[][] newGrid=new int[4][4];
  for(int i=0;i<4;i++) {
    for(int j=0;j<4;j++) {
      newGrid[i][j]=grid[i][j];
    } 
  } 
  return newGrid;
} 

boolean compare(int[][] a,int[][] b) {
  for(int i=0;i<4;i++) {
    for(int j=0;j<4;j++) {
      if(a[i][j]!=b[i][j]) {
        return true;
      } 
    } 
  }
  return false;
} 

void keyPressed() {
  int[][] pastGrid=copyGrid(board);
  switch(keyCode) {
    case UP: {
      swipeUp();
      boolean changed=compare(pastGrid,board);
      if(changed) {
        addRandomSpots(1);
      } 
      break;
    } 
    case DOWN: {
      swipeDown();
      boolean changed=compare(pastGrid,board);
      if(changed) {
        addRandomSpots(1);
      } 
      break;
    } 
    case LEFT: {
      swipeLeft();
      boolean changed=compare(pastGrid,board);
      if(changed) {
        addRandomSpots(1);
      } 
      break;
    } 
    case RIGHT: {
      swipeRight();
      boolean changed=compare(pastGrid,board);
      if(changed) {
        addRandomSpots(1);
      } 
      break;
    } 
  } 
} 

void shiftRight(int[] row) {
  int[] newRow=new int[4];
  int index=3;
  for(int j=3;j>=0;j--) {
    if(row[j]!=0) { 
      newRow[index]=row[j];
      index--;
    } 
  }
  for(int i=0;i<row.length;i++) {
    if(row[i]!=newRow[i]) {
      moved=true;
    } 
    row[i]=newRow[i];
  } 
  
} 

void shiftLeft(int[] row) {
  int[] newRow=new int[4];
  int index=3;
  for(int j=0;j<4;j++) {
    if(row[j]!=0) { 
      newRow[index]=row[j];
      index--;
    } 
  }
  index=0;
  for(int i=row.length-1;i>=0;i--,index++) {
    if(row[index]!=newRow[i]) {
      moved=true;
    } 
    row[index]=newRow[i];
  } 
} 


void combineRight(int[] row) {
  if(row[3]==0) {
   return; 
  }
  for(int i=3;i>0;i--) {
    int a=row[i];
    int b=row[i-1];
    if(a==b) {
      row[i]=a*2;
      row[i-1]=0;
      moved=true;
    } 
  }
 
} 

void combineLeft(int[] row) {
  if(row[0]==0) {
    return;
  } 
  for(int i=0;i<3;i++) {
    int a=row[i];
    int b=row[i+1];
    if(a==b) {
      row[i]=a*2;
      row[i+1]=0;
      moved=true;
    } 
  } 
} 

void swipeLeft() {
  moved=false;
  for(int i=0;i<4;i++) {
    int[] row=board[i];
    shiftLeft(row);
    combineLeft(row);
    shiftLeft(row);
  }
  //if(moved) {
  //  addRandomSpots(1);
  //} 
} 
 

void swipeRight() {
  moved=false;
  for(int i=0;i<4;i++) {
    int[] row=board[i];
    shiftRight(row);
    combineRight(row);
    shiftRight(row);
  }
  //if(moved) {
  //  addRandomSpots(1); 
  //}
} 

int[] getColumn(int colNo) {
  int[] newArr=new int[4];
  for(int i=0;i<4;i++) {
    newArr[i]=board[i][colNo];
  } 
  return newArr;
} 

void copyIntoBoard(int[] col,int colNo) {
  for(int i=0;i<col.length;i++) {
    board[i][colNo]=col[i];
  } 
} 

void swipeUp() {
  moved=false;
  for(int i=0;i<4;i++) {
    int[] col=getColumn(i);
    shiftLeft(col);
    combineLeft(col);
    shiftLeft(col);
    copyIntoBoard(col,i);
  } 
  //if(moved) {
  //  addRandomSpots(1);
  //} 
} 

void swipeDown() {
  moved=false;
  for(int i=0;i<4;i++) {
    int[] col=getColumn(i);
    shiftRight(col);
    combineRight(col);
    shiftRight(col);
    copyIntoBoard(col,i);
  } 
  //if(moved) {
  //  addRandomSpots(1);
  //} 
} 