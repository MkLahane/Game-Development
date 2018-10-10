
var grid;
var w=20;
var cols;
var rows;
var result;
var totalMines=10;
var over;
var notMines=[];
var checkButton;
var newGameButton;

function create2dArray(cols,rows) {
    var a=new Array(rows);
    for(var i=0;i<rows;i++) {
        a[i]=new Array(cols);
    }
    return a;
}



function setTheCells() {
  for(var i=0;i<rows;i++) {
      for(var j=0;j<cols;j++) {

          grid[i][j]=new Cell(i,j,w);

      }

  }

}
function setTheMines() {
  var mines=[];
  for(var i=0;i<rows;i++) {

      for(var j=0;j<cols;j++) {
          mines.push([i,j]);
      }
  }
  for(var i=0;i<totalMines;i++) {
       var index=floor(random(mines.length));
       var mine=mines[index];
       var a=mine[0];
       var b=mine[1];
       mines.splice(index,1);
       grid[a][b].mine=true;

   }

}
function setNotMines() {
  for(var i=0;i<rows;i++) {

      for(var j=0;j<cols;j++) {

         grid[i][j].countMines();
          if(!grid[i][j].mine)  {
              notMines.push(grid[i][j]);
          }

      }
  }
}
function setup() {
    createCanvas(201,201);
    over=false;
    cols=floor(width/w);
    rows=floor(height/w);
    grid=create2dArray(cols,rows);
    setTheCells();
    setTheMines();
    setNotMines();
    checkButton=createButton("Check");
    newGameButton=createButton("NewGame");

    result=createP('');

}
function gameOver() {
        for(var i=0;i<rows;i++) {
            for(var j=0;j<cols;j++) {
                grid[i][j].revealed=true;
                //noLoop();

            }

        }


 }


function mousePressed() {
   for(var i=0;i<rows;i++) {

        for(var j=0;j<cols;j++) {
            if(grid[i][j].contains(mouseX,mouseY)) {
                grid[i][j].reveal();

                if(grid[i][j].mine) {
                    over=true;
                    gameOver();
                }

            }

        }
    }

}

function reset() {
   setTheCells();
   setTheMines();
   setNotMines();
   over=false;
   result=createP('');

}


function draw() {
    background(255);
     for(var i=0;i<rows;i++) {
            for(var j=0;j<cols;j++) {

                this.grid[i][j].show();


            }

        }

        checkButton.mousePressed(check);
        newGameButton.mousePressed(reset);
        function check() {
            var win=true;
            for(var i=0;i<notMines.length;i++) {
                if(!notMines[i].revealed) {
                    win=false;
                }

            }

            if(win && !over) {
                result.html("You win");
            }
            else {
                result.html("You are missing  something");

            }

        }

        if(over) {
           result.html("Game Over");

        }


}
