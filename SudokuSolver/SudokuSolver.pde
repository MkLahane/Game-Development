int rows = 3;
int cols = 3;
void setup() {
  int[][] board = {{3, 0, 0}, 
  {0, 1, 0}, 
  {0, 0, 0}};
  //int[][] board = new int[rows][cols];
  printBoard(board);
  sudokuSolver(board);
  noLoop();
  println("Solved");
} 

void printBoard(int[][] board) {
   for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      print(board[i][j]+" ");
    }
    println();
  }
  
} 


void sudokuSolver(int[][] board) {
  int currentRow = 0;
  int currentCol = 0;

  if (isBoardFull(board)) {
    println("Sudoku solved");
    printBoard(board);
    return;
  } 
  //get the first vacant spot in the grid
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j] == 0) {
        currentRow = i;
        currentCol = j;
        break;
      }
    }
  }
  ArrayList<Integer> possibleNumbers = getPossibleNumbers(board, currentRow, currentCol);

  for (int i = 0; i < possibleNumbers.size(); i++) {
    int number = possibleNumbers.get(i);
    board[currentRow][currentCol] = number;
    sudokuSolver(board);
  }
  board[currentRow][currentCol] = 0;

} 

boolean isPresent(int[][] board, int number, int rowNo, int colNo) {
  for (int col = 0; col < board[0].length; col++) {
    if (board[rowNo][col] == number) {
      return true;
    }
  }
  for (int row = 0; row < board.length; row++) {
    if (board[row][colNo] == number) {
      return true;
    }
  } 
  return false;
} 

ArrayList<Integer> getPossibleNumbers(int[][] board, int i, int j) {
  if (board[i][j] != 0) {
    return null;
  } 
  ArrayList<Integer> possibleNumbers = new ArrayList<Integer>();
  for (int number = 1; number <= rows; number++) {
    if (!isPresent(board, number, i, j)) {
      possibleNumbers.add(number);
    }
  }
  return possibleNumbers;
} 


boolean isBoardFull(int[][] board) {
  for (int i = 0; i < board.length; i++) {
    for (int j = 0; j < board[0].length; j++) {
      if (board[i][j] == 0) {
        return false;
      }
    }
  } 
  return true;
} 
