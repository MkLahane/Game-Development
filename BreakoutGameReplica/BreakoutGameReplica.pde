import java.util.*;
import processing.sound.*;
String pointSoundName = "Ding.wav";
String tapSoundName = "Tap.mp3";
String backgroundSoundName = "BackgroundIngloriousBasterds.mp3";
SoundFile pointSound;
SoundFile backgroundSound;
SoundFile tapSound;
BlocksData[] pallete = {
  new BlocksData(color(240, 20, 20), 500), 
  new BlocksData(color(200, 20, 200), 100), 
  new BlocksData(color(20, 200, 20), 200), 
  new BlocksData(color(20, 100, 250), 400), 
  new BlocksData(color(240, 200, 0), 300)};

ArrayList<Block> blocks;
PImage healthImg;
PImage startBackgroundImage;
int ROWS;
int COLS;
int DELTAH = 100;
int paddleHealthCount = 3;
Ball ball;
Paddle paddle;
final int ALPHA_VAL = 200;
boolean gameHasStarted = false;
boolean gameIsPaused = false;
boolean gameOver = false;
void setup() {
  size(1300, 800);
  String pointSoundPath = sketchPath(pointSoundName);
  String tapSoundPath = sketchPath(tapSoundName);
  String backgroundSoundPath = sketchPath(backgroundSoundName);
  tapSound = new SoundFile(this, tapSoundPath);
  pointSound = new SoundFile(this, pointSoundPath);
  backgroundSound = new SoundFile(this, backgroundSoundPath);
  healthImg = loadImage("heart.png");
  startBackgroundImage = loadImage("StartBackground.png");
  buildBlocks();
  ball = new Ball(width / 2, height - 100, 20);
  paddle = new Paddle(ball.pos.x, ball.pos.y + 50, 200);
  backgroundSound.play();
} 

void draw() {
  background(0);
  if (gameHasStarted) {
    gameView();
  } else {
    image(startBackgroundImage, 0, 0, width, height);
    LogView(40, height / 2, color(200, 0, 200), 
      "Press any key to begin the game, press q to exit.", 50);
    LogView(width / 2 - 400, height / 2 + 100, color(200, 0, 200), 
      "& Press SPACEBAR to pause the game.", 40);
  }
} 

void LogView(float x, float y, color col, String _msg, float tSize) {
  fill(col, tSize);
  textSize(50);
  String msg = _msg;
  text(msg, x, y);
  for (int i = 0; i < 3; i++) {
    float _tSize = map(i, 0, 3, tSize - 1, tSize);
    float textAlpha = map(i, 0, 3, 0, 200);
    fill(col, textAlpha);
    textSize(_tSize);
    text(msg, x, y);
  }
} 

void gameView() {
  checkPaddleHealth();
  if (frameCount % (242 * 60) == 0) {
    backgroundSound.stop();
    backgroundSound.play();
  }  
  if (!gameIsPaused && !gameOver) {
    paddle.update();
    ball.update();
  } 
  paddle.show();
  paddle.collides(ball);
  ball.show();

  ball.checkEdges();
  for (Block block : blocks) {
    block.show();
  }
  for (int i = blocks.size() - 1; i >= 0; i--) {
    if (blocks.get(i).collides(ball)) {
      tapSound.stop();
      tapSound.play();
      //ball.vel.mult(1.02);
      blocks.get(i).health -= DELTAH;
      if (blocks.get(i).health <= 0) {
        blocks.remove(i);
        paddle.score += 50;
        pointSound.stop();
        pointSound.play();
      }
    }
  } 
  if (paddleHealthCount <= 0) {
    gameOver = true;
    gameIsPaused = false;
    //provide an option for restart or quiting the application
  }
  if (gameOver) {
    LogView(width / 2 - 400, height / 2 + 100, color(0, 200, 200), 
      "Press R to restart the game.", 40);
  } 
  for (int i = paddleHealthCount - 1; i >= 0; i--) {
    image(healthImg, (width - 100) - i * 100, height - 100, 100, 100);
  }
} 
void checkPaddleHealth() {
  if (ball.pos.y >= paddle.rect.pos.y) {
    paddleHealthCount--;
    ball = new Ball(width / 2, height - 100, 20);
    paddle = new Paddle(ball.pos.x, ball.pos.y + 50, 200);
  }
} 
void keyReleased() {
  paddle.setXVelocity(0);
} 
void keyPressed() {
  if (key == 'q') {
    exit();
  } 
  if (key == 'r') {
    if (!gameHasStarted) {
      gameOver = false;
    } else {
      gameOver = false;
      buildBlocks();
      ball = new Ball(width / 2, height - 100, 20);
      paddle = new Paddle(ball.pos.x, ball.pos.y + 50, 200);
      paddleHealthCount = 3;
      backgroundSound.stop();
      backgroundSound.play();
      gameOver = false;
      gameHasStarted = true;
    }
  } 
  if (key == ' ') {
    if (!gameHasStarted) {
      gameIsPaused = false;
    } else {
      gameIsPaused = !gameIsPaused;
    }
  }
  if (!gameHasStarted) {
    gameHasStarted = true;
  } 
  if (keyCode == LEFT) {
    paddle.setXVelocity(-16);
  } else if (keyCode == RIGHT) {
    paddle.setXVelocity(16);
  }
} 

//void keyPressed() {
//  blocks[blocks.length - 1].health -= 50;
//} 
