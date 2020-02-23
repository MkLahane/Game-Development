import processing.sound.*;
float currentSoundVolume = 1;
PImage soundOn;
SoundFile winSound;
SoundFile backgroundMusic;
SoundFile wrongMoveSound;
SoundFile tapSound; 
String winSoundName = "winSound.wav";
String backgroundMusicName = "backgroundMusic.mp3";
String wrongMoveSoundName = "wrongMoveSound.mp3";
String tapSoundName = "tapSound.mp3";
Cell highlighted = null;
Game[][] games;
PImage backgroundImage;
float gameSpacing;
int nextBoardRow;
int nextBoardCol;
char currentPlayer;
char ultimateGameWinner;
boolean gameOver;
PImage restartImage;
char aiChar = 'O';
char playerChar = 'X';
void setup() {
  size(900, 900);
  String winSoundPath = sketchPath(winSoundName);
  String wrongMoveSoundPath = sketchPath(wrongMoveSoundName);
  String backgroundMusicPath = sketchPath(backgroundMusicName);
  String tapSoundPath = sketchPath(tapSoundName);
  winSound = new SoundFile(this, winSoundPath);
  wrongMoveSound = new SoundFile(this, wrongMoveSoundPath);
  backgroundMusic = new SoundFile(this, backgroundMusicPath);
  tapSound = new SoundFile(this, tapSoundPath);
  backgroundImage = loadImage("blackboard.jpg");
  restartImage = loadImage("restart_transparent.png");
  soundOn = loadImage("soundOn.jpg");
  reset();
} 
void reset() {
  nextBoardRow = -1;
  nextBoardCol = -1;
  currentPlayer = 'X';

  ultimateGameWinner = ' ';
  gameOver = false;
  games = new Game[3][3];
  float offset = 50;
  gameSpacing = (width - (offset * 2)) / 3; 
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      float x = offset + j * gameSpacing;
      float y = offset + i * gameSpacing;
      games[i][j] = new Game(x, y, gameSpacing - 20);
    }
  }
  backgroundMusic.play();
} 
void draw() {
  background(255);
  image(backgroundImage, 0, 0, width, height);
  if (!backgroundMusic.isPlaying()) {
    backgroundMusic.stop();
    backgroundMusic.play();
  }
  if (frameCount % (290 * 60) == 0) {
    backgroundMusic.stop();
    backgroundMusic.play();
  } 

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      games[i][j].render();
      //games[i][j].check();
    }
  } 
  if (nextBoardRow != -1 && nextBoardCol != -1) {
    fill(200, 200, 200, 40);
    stroke(255, 40);
    strokeWeight(6);
    //println(nextBoardRow+", "+nextBoardCol);
    rect(nextBoardCol * gameSpacing + 50, nextBoardRow * gameSpacing + 50, gameSpacing - 20, gameSpacing - 20);
  }
  fill(255, 255, 255, 50);
  textSize(width);
  //textAlign(CENTER);
  text(""+ultimateGameWinner, width * 0.6, height - 150);
  if (!gameOver) {
    fill(255, 255, 255);
    textSize(40);
    text(currentPlayer+"'s turn", width * 0.5, height - 30);
  }
  if (gameOver) {
    if (mouseX > 200 && mouseX < 200 + 400 && mouseY > 200 && mouseY < 200 + 400) {
      fill (255, 255, 255, 150);
    } else {
      fill(255, 255, 255, 50);
    }
    stroke(255);
    strokeWeight(2);
    rect(200, 200, 400, 400, 100);
    image(restartImage, 200, 200, 400, 400);
  }
  checkForDraw();
  if (currentPlayer == aiChar) {
    //ArrayList<Move> validMoves = getMoves();
    //Move randomMove = validMoves.get(floor(random(0, validMoves.size())));
    //highlighted = games[randomMove.boardRowNo][randomMove.boardColNo].board[randomMove.rowNo][randomMove.colNo];
    //games[randomMove.boardRowNo][randomMove.boardColNo].board[randomMove.rowNo][randomMove.colNo].value = currentPlayer;
    //nextBoardRow = randomMove.rowNo;
    //nextBoardCol = randomMove.colNo;
    //if (games[nextBoardRow][nextBoardCol].gameWinner != ' ') {
    //  nextBoardRow = -1;
    //  nextBoardCol = -1;
    //}
    //currentPlayer = playerChar; 
  }
} 

void mousePressed() {
  if (gameOver) {
    if (mouseX > 200 && mouseX < 200 + 400 && mouseY > 200 && mouseY < 200 + 400) {
      tapSound.stop();
      tapSound.play();
      reset();
      return;
    }
  }  
  if (!gameOver) {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        games[i][j].check(currentPlayer);
      }
    }
  }
} 
 

void checkForDraw() {
  boolean isDraw = true;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (games[i][j].gameWinner == ' ') {
        isDraw = false;
        break;
      } 
    } 
  } 
  if (isDraw) {
    gameOver = true;
  } 
} 

ArrayList<Move> getMoves() {
  ArrayList<Move> validMoves = new ArrayList<Move>();
  if (nextBoardRow != -1 || nextBoardCol != -1) {
    Cell[][] tempBoard = games[nextBoardRow][nextBoardCol].board;
    //println(nextBoardRow, nextBoardCol);
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (tempBoard[i][j].value == ' ') {
          validMoves.add(new Move(nextBoardRow, nextBoardCol, i, j));
        }
      }
    }
  } else {
    for (int i = 0; i < games.length; i++) {
      for (int j = 0; j < games.length; j++) {
        if (games[i][j].gameWinner == ' ') {
          for (int m = 0; m < 3; m++) {
            for (int n = 0; n < 3; n++) {
              if (games[i][j].board[m][n].value == ' ') {
                validMoves.add(new Move(i, j, m, n));
              }
            }
          }
        }
      }
    }
  } 
  return validMoves;
} 

void keyPressed() {
  if (key == 'm') {
    if (currentSoundVolume == 0) {
      currentSoundVolume = 1;
    } else {
      currentSoundVolume = 0;
    } 
    backgroundMusic.amp(currentSoundVolume);
  } else if (key == ' ') {
    reset();
  } 
} 

class Move {
  int rowNo;
  int colNo;
  int boardRowNo;
  int boardColNo;
  Move(int _boardRowNo, int _boardColNo, int _rowNo, int _colNo) {
    boardRowNo = _boardRowNo;
    boardColNo = _boardColNo;
    rowNo = _rowNo;
    colNo = _colNo;
  }
} 
