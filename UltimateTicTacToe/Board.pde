class Game {
  Cell[][] board;
  float boardSize;
  float startX;
  float startY;
  float spacing;
  char gameWinner;
  Game(float _startX, float _startY, float _spacing) {
    startX = _startX;
    startY = _startY;
    spacing = _spacing;
    gameWinner = ' ';
    float endX = startX + spacing;
    board = new Cell[3][3];
    boardSize = (endX - startX) / 3;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        board[i][j] = new Cell(i, j, startX, startY, boardSize);
      }
    }
  } 
  boolean isBoardFull() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j].value == ' ') {
          return false;
        }
      }
    }
    return true;
  } 
  
  void check(char currP) {
    if (mouseY >= startY && mouseX >= startX) {
      int i = int((mouseY - startY) / boardSize);
      int j = int((mouseX - startX) / boardSize);
      int board_i = int((mouseY - 50) / gameSpacing);
      int board_j = int((mouseX - 50) / gameSpacing);
      //println("Board positions:"+board_i+", "+board_j); 
      if (i >= 0 && j >= 0 && i < 3 && j < 3) {
        if (board[i][j].value != ' ') {
          return;
        } 
        if (((nextBoardRow == -1 && nextBoardCol == -1) || 
          (nextBoardRow == board_i && nextBoardCol == board_j)) && games[board_i][board_j].gameWinner == ' ') {   
          highlighted = board[i][j];
          board[i][j].value = currP;
          nextBoardRow = i;
          nextBoardCol = j;
          checkWinConditions();
          if (games[nextBoardRow][nextBoardCol].gameWinner != ' ' || checkIfTheBoardIsFull(games[nextBoardRow][nextBoardCol])) {
            nextBoardRow = -1;
            nextBoardCol = -1;
          } 
          tapSound.stop();
          tapSound.play();
          
          if (currentPlayer == playerChar) {
            currentPlayer = aiChar;
          } else {
            currentPlayer = playerChar;
          }
          //currentPlayer = aiChar;
        } else {
          wrongMoveSound.stop();
          wrongMoveSound.play();
        } 
        //println("Valid Board Position:"+nextBoardRow+", "+nextBoardCol);
      }
    }
    if (highlighted != null) {
      //fill(0, 200, 0, 100);
      //rect(highlighted.x, highlighted.y, highlighted.w, highlighted.w);
    }
  } 
  void render() {
    //for (int i = 0; i < 3; i++) {
    //  for (int j = 0; j < 3; j++) {
    //    board[i][j].show();
    //  }
    //}
    stroke(255);
    strokeWeight(10);
    line(board[0][1].x, board[0][1].y, board[0][1].x, board[2][1].y + boardSize);
    line(board[0][2].x, board[0][2].y, board[0][2].x, board[2][2].y + boardSize);

    line(board[1][0].x, board[1][0].y, board[1][2].x + boardSize, board[1][0].y);
    line(board[2][0].x, board[2][0].y, board[2][2].x + boardSize, board[2][0].y);
    stroke(0);
    strokeWeight(2);
    line(board[0][1].x, board[0][1].y, board[0][1].x, board[2][1].y + boardSize);
    line(board[0][2].x, board[0][2].y, board[0][2].x, board[2][2].y + boardSize);

    line(board[1][0].x, board[1][0].y, board[1][2].x + boardSize, board[1][0].y);
    line(board[2][0].x, board[2][0].y, board[2][2].x + boardSize, board[2][0].y);

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        board[i][j].showValues();
      }
    } 
    fill(255, 255, 255, 50);
    PFont font = createFont("Forte", gameSpacing * 0.8);
    textFont(font);
    textSize(gameSpacing * 0.8);
    textAlign(CENTER);
    text(""+gameWinner, startX + gameSpacing * 0.45, startY + gameSpacing * 0.75);
  }
  void checkWin() {
    if (gameWinner != ' ') {
      return;
    } 
    for (int i = 0; i < 3; i++) {
      boolean matchFound = true;
      for (int j = 1; j < 3; j++) {
        if (board[i][j].value == ' ') {
          matchFound = false;
          break;
        } 
        if (board[i][j].value != board[i][j - 1].value) {
          matchFound = false;
          break;
        }
      }

      if (matchFound) {
        gameWinner = board[i][1].value;
        winSound.stop();
        winSound.play();
        return;
      }
    }
    for (int j = 0; j < 3; j++) {
      boolean matchFound = true;
      for (int i = 1; i < 3; i++) {
        if (board[i][j].value == ' ') {
          matchFound = false;
          break;
        } 
        if (board[i][j].value != board[i - 1][j].value) {
          matchFound = false;
          break;
        }
      }
      if (matchFound) {
        gameWinner = board[1][j].value;
        winSound.stop();
        winSound.play();
        return;
      }
    }
    boolean matchFound = true;
    for (int i = 1; i < 3; i++) {
      if (board[i][i].value == ' ') {
        matchFound = false;
        break;
      } 
      if (board[i - 1][i - 1].value != board[i][i].value) {
        matchFound = false;
        break;
      }
    }
    if (matchFound) {
      gameWinner = board[1][1].value;
      winSound.stop();
      winSound.play();
      return;
    } 
    matchFound = true;
    for (int i = 1; i < 3; i++) {
      if (board[i][2 - i].value == ' ') {
        matchFound = false;
        break;
      } 
      if (board[i][2 - i].value != board[i - 1][2 - (i - 1)].value) {
        matchFound = false;
        break;
      }
    }
    if (matchFound) {
      gameWinner = board[1][1].value;
      winSound.stop();
      winSound.play();
      return;
    }
  }
  
} 

boolean checkIfTheBoardIsFull(Game game) {
  for (Cell[] cells : game.board) {
    for (Cell cell : cells) {
      if (cell.value == ' ') {
        return false;
      } 
    } 
  } 
  return true; 
} 

void checkWinConditions() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      games[i][j].checkWin();
    }
  }
  for (int i = 0; i < 3; i++) {
    boolean matchFound = true;
    for (int j = 1; j < 3; j++) {
      if (games[i][j].gameWinner == ' ') {
        matchFound = false;
        break;
      } 
      if (games[i][j].gameWinner != games[i][j - 1].gameWinner) {
        matchFound = false;
        break;
      }
    }

    if (matchFound) {
      ultimateGameWinner = games[i][1].gameWinner;
      gameOver = true;
      return;
    }
  }

  for (int j = 0; j < 3; j++) {
    boolean matchFound = true;
    for (int i = 1; i < 3; i++) {
      if (games[i][j].gameWinner == ' ') {
        matchFound = false;
        break;
      } 
      if (games[i][j].gameWinner != games[i - 1][j].gameWinner) {
        matchFound = false;
        break;
      }
    }
    if (matchFound) {
      ultimateGameWinner = games[1][j].gameWinner;
      gameOver = true;
      return;
    }
  }
  boolean matchFound = true;
  for (int i = 1; i < 3; i++) {
    if (games[i][i].gameWinner == ' ') {
      matchFound = false;
      break;
    } 
    if (games[i - 1][i - 1].gameWinner != games[i][i].gameWinner) {
      matchFound = false;
      break;
    }
  }
  if (matchFound) {
    ultimateGameWinner = games[1][1].gameWinner;
    gameOver = true;
    return;
  } 
  matchFound = true;
  for (int i = 1; i < 3; i++) {
    if (games[i][2 - i].gameWinner == ' ') {
      matchFound = false;
      break;
    } 
    if (games[i][2 - i].gameWinner != games[i - 1][2 - (i - 1)].gameWinner) {
      matchFound = false;
      break;
    }
  }
  if (matchFound) {
    ultimateGameWinner = games[1][1].gameWinner;
    gameOver = true;
    return;
  }
} 
