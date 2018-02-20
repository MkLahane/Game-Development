
//defines the space between the cells of the grid and also defines the no of rows and cols
var spacing=7;
var cols;
var rows;
var grid;

//for generating the maze,stores the visited cells,also for backtracking them.
var stack=[];


var current;

//for tracking the no of unvisited cells
var unvisited;

//generate button
var generate;

var currentCell;

var path=[];

//solve button
var solve;


function setup() {
  createCanvas(500,500);

  frameRate(5);
  rows=floor(height/spacing);
  cols=floor(width/spacing);

  grid=new Array(rows);
  generate=createButton("Generate Maze");
  solve=createButton("Solve Maze");
  for(var i=0;i<grid.length;i++) {
    grid[i]=new Array(cols);
  }

  generateTheMaze();


}

function draw() {
  background(255);

   //displays the maze
   for(var i=0;i<rows;i++) {
     for(var j=0;j<cols;j++) {
       grid[i][j].show();
     }
  }
  //displays the path or the solution of the maze
  for(var i=0;i<path.length;i++) {
    fill(0,0,255);
    noStroke();
    rect(4+path[i].x,4+path[i].y,spacing/2,spacing/2);
  }

  //solves the maze
  solve.mousePressed(solveMaze);

  //generates the maze
  generate.mousePressed(generateTheMaze);
}


function generateTheMaze() {
  //generates the maze using depth first search and recursive backtracker
  path=[];
  for(var i=0;i<rows;i++) {
    for(var j=0;j<cols;j++) {
      grid[i][j]=new Cell(i,j);
    }
  }
  current=grid[0][0];
  currentCell=current;
  grid[0][0].left=false;
  grid[rows-1][cols-1].right=false;
  unvisited=rows*cols-1;
  while(unvisited) {
    var next=current.checkNeighbors();
    if(next) {
      //step2
      stack.push(current);
      //step3
      removeWalls(current,next);
      current=next;
      if(!current.visited) {
        current.visited=true;
        unvisited--;
      }
    } else if(stack.length>0) {
      var back=stack.pop();
      current=back;
    }
  }
}




//for removing the walls between the current and the next cell,for the generation of the maze
function removeWalls(curr,next) {
  var i=curr.i-next.i;
  var j=curr.j-next.j;
  if(j===1) {
    curr.left=false;
    next.right=false;
  }else if(j===-1) {
    curr.right=false;
    next.left=false;
  }
  if(i===1) {
      curr.top=false;
      next.bottom=false;
    }else if(i===-1) {
      curr.bottom=false;
      next.top=false;
    }
}


//for tracking the position of the current cell and the neighbors  position,for checking if valid?
function getTheSide(curr,nxt) {
  var i=curr.i-nxt.i;
  var j=curr.j-nxt.j;

  if(j==1) {
    return "left";
  }else if(j==-1) {
    return "right";
  }
  if(i==1) {
    return "above";
  }else if(i==-1) {
    return "below";
  }

  return "null";


}




function solveMaze() {

  //path finding
  //depth first search and recursive backtracker
  var end=grid[rows-1][cols-1]
   while(currentCell!=grid[rows-1][cols-1]) {
   currentCell.highlight();

   var neighbors=currentCell.getTheNeighbors();

   var best=findTheCorrectNeighbor(neighbors,currentCell);

   if(currentCell==end) {
     noLoop();
     console.log("DONE");
   }

   if(best) {


     path.push(currentCell);


     currentCell=best;
     if(!currentCell.explored) {
       currentCell.explored=true;
     }
   }else if(path.length>0) {
     currentCell=path.pop();
   }
 }

}


//getting the correct neighbor from all neighbors
function findTheCorrectNeighbor(neighbors,curr) {
  var bestCell=undefined;
  if(neighbors!=undefined) {
  for(var i=0;i<neighbors.length;i++) {
    var side=getTheSide(curr,neighbors[i]);
    if(isCorrectPic(side,neighbors[i],curr)) {
      bestCell=neighbors[i];
      return bestCell;
    }
  }
  }
}


//checking if the choosen neighboring cell  is the correct one
function isCorrectPic(side,neighbor,curr) {
  var correctPic=true;
  if(side==="right") {
    if(neighbor.left  && curr.right) {
      correctPic=false;
    }
  }
  if(side==="left") {
    if(neighbor.right && curr.left) {
      correctPic=false;
    }
  }
  if(side==="above") {
    if(neighbor.bottom && curr.top ) {
      correctPic=false;
    }
  }
  if(side==="below") {
    if(neighbor.top && curr.bottom) {
      correctPic=false;
    }
  }
  return correctPic;
}
