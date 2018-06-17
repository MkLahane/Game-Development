let snake;
let cols;
let spacingCol = 60;
let panelLogic;


function setup() {
  createCanvas(300, windowHeight);
  cols = width / spacingCol;
  snake = new Snake();
  panelLogic = new PanelLogic();
}

function draw() {

  background(255);
  snake.show();
  snake.update();
  if (snake.checkOffscreen()) {
    noLoop();
  }
  for (let i = 0; i < cols + 1; i++) {
    stroke(0);
    strokeWeight(2);
    line(i * spacingCol, 0, i * spacingCol, height);
  }
  panelLogic.show();
  panelLogic.update();
  panelLogic.check(snake);
}

function mousePressed() {
  let dir = 0;
  if (mouseX < snake.snakes[0].x) {
    dir = -1;
  } else {
    dir = 1;
  }
  if (snake.snakes[0]) {
    let j = floor(snake.snakes[0].x / spacingCol);
    j += dir;
    if (j >= 0 && j <= cols - 1) {
      let pX = j * spacingCol + spacingCol / 2;
      let pY = snake.snakes[0].y - 20;
      //console.log(pX);
      snake.snakes[0].parent = new SnakeBodyPart(pX, pY, null);
    }
  }
}

function keyPressed() {
  let dir = 0;
  if (keyCode === LEFT_ARROW) {
    dir = -1;
  } else if (keyCode === RIGHT_ARROW) {
    dir = 1;
  }
  // if (snake.snakes[0]) {
  //   let j = floor(snake.snakes[0].x / spacingCol);
  //   j += dir;
  //   if (j >= 0 && j <= cols - 1) {
  //     let pX = j * spacingCol + spacingCol / 2;
  //     let pY = snake.snakes[0].y - 20;
  //     //console.log(pX);
  //     snake.snakes[0].parent = new SnakeBodyPart(pX, pY, null);
  //   }
  // }
}
