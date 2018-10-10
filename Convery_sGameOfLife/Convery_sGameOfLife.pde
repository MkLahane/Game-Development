int[][] grid;
int rows,cols;
int spacing=10;
void setup() {
  size(800,800); 
  rows=height/spacing;
  cols=width/spacing;
  grid=new int[rows][cols];
  for(int i=0;i<rows;i++) {
    for(int j=0;j<cols;j++) {
       grid[i][j]=floor(random(2)); 
    }
  } 
  
}

void mousePressed() {
   for(int i=0;i<rows;i++) {
    for(int j=0;j<cols;j++) {
       grid[i][j]=floor(random(2)); 
    }
  } 
} 

void draw() {
  background(0);
  int[][] next=new int[rows][cols];
  //compute the next generation
  for(int i=0;i<rows;i++) {
    for(int j=0;j<cols;j++) {
      drawSquare(i,j);
    } 
  } 
  
  for(int i=0;i<rows;i++) {
    for(int j=0;j<cols;j++) {
      
      int neighborsCount=countNeighbors(grid,i,j); 
      int state=grid[i][j];
      if(state==0 && neighborsCount==3) {
        next[i][j]=1;
      } else if(state==1 && (neighborsCount<2 || neighborsCount>3)) {
        next[i][j]=0;
      } else {
        next[i][j]=state;
      } 
    } 
  } 
  
  grid=next;
  
}

int countNeighbors(int[][] grid,int i,int j) {
  int sum=0;
  ArrayList<Integer> neighbors;
  for(int y=-1;y<=1;y++) {
    for(int x=-1;x<=1;x++) {
       int checkX=(x+j+cols)%cols;
       int checkY=(i+y+rows)%rows;
       sum+=grid[checkY][checkX];
    } 
  } 
  sum-=grid[i][j];
  return sum;
} 

void drawSquare(int i,int j) {
  if(grid[i][j]==1) {
    fill(0,255,0);
  } else {
    fill(0);
  } 
  stroke(255);
  rect(i*spacing,j*spacing,spacing,spacing);
} 