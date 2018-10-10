char aiChar = 'x';
char playerChar = 'o';
boolean isBoardFull(char[][] board) {
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j] == '-') {
        return false;
      }
    }
  }
  return true;
} 

int evaluate(char[][] b, char player, char opponent) {
  // Checking for Rows for X or O victory. 
  for (int row = 0; row<3; row++) { 
    if (b[row][0]==b[row][1] && 
      b[row][1]==b[row][2]) { 
      if (b[row][0]==player) 
        return +10; 
      else if (b[row][0]==opponent) 
        return -10;
    }
  } 

  // Checking for Columns for X or O victory. 
  for (int col = 0; col<3; col++) { 
    if (b[0][col]==b[1][col] && 
      b[1][col]==b[2][col]) { 
      if (b[0][col]==player) 
        return +10; 

      else if (b[0][col]==opponent) 
        return -10;
    }
  } 

  // Checking for Diagonals for X or O victory. 
  if (b[0][0]==b[1][1] && b[1][1]==b[2][2]) { 
    if (b[0][0]==player) 
      return +10; 
    else if (b[0][0]==opponent) 
      return -10;
  } 

  if (b[0][2]==b[1][1] && b[1][1]==b[2][0]) { 
    if (b[0][2]==player) 
      return +10; 
    else if (b[0][2]==opponent) 
      return -10;
  } 

  // Else if none of them have won then return 0 
  return 0;
} 

char getOpponent(char player) {
  if (player == aiChar) {
    return playerChar;
  } 
  return aiChar;
} 


//minmax with alpha beta pruning
int[] MinMaxAB(int depth, char[][] board, boolean isMaximizing, int bestRow, int bestCol, int alpha, int beta) {
  int score = evaluate(board, aiChar, playerChar);
  
  //if (score == 10 || score == -10) {
  //  return new int[] {score, bestRow, bestCol};
  //} 
  if (score == 10) {
    return new int[] {10 - depth, -1, -1};
  } else if (score == -10) {
    return new int[] {-10 + depth, -1, -1};
  } 
  if (isBoardFull(board)) {
    return new int[] {0, -1, -1};
  } 
  if (isMaximizing) {
    int best = -1000000;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '-') {
          board[i][j] = aiChar;
          int currentBest = MinMaxAB(depth + 1, board, false, bestRow, bestCol, alpha, beta)[0];
          if (currentBest > best) {
            best = currentBest;
            bestRow = i;
            bestCol = j;
          } 
          alpha = max(best, alpha);
          if (beta <= alpha) {
            return new int[] {best, bestRow, bestCol};
          } 
          board[i][j] = '-';
        }
      }
    }
    return new int[] {best, bestRow, bestCol};
  } else {
    int best = 1000000;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == '-') {
          board[i][j] = playerChar;
          int currentBest = MinMaxAB(depth + 1, board, true, bestRow, bestCol, alpha, beta)[0];
          if (currentBest < best) {
            best = currentBest;
            bestRow = i;
            bestCol = j;
          } 
          beta = min(best, beta);
          if (beta <= alpha) {
            return new int[] {best, bestRow, bestCol};
          } 
          board[i][j] = '-';
        }
      }
    }
    return new int[] {best, bestRow, bestCol};
  }
} 

void setup() {
  char[][] board = { 
    { 'x', 'o', 'x' }, 
    { 'o', 'o', 'x' }, 
    { '-', '-', '-' } 
  };
  //println(evaluate(board, aiChar, playerChar)); 
  printArray(MinMaxAB(0, board, true, -1, -1, MIN_INT, MAX_INT));
} 
