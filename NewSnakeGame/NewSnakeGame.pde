Game game;
void setup() {
  size(300, 800);
  game = new Game();
} 

void draw() {
  background(255);
  game.run();
} 

void keyReleased() {
  game.move(0);
} 

void keyPressed() {
  if (keyCode == LEFT) {
    game.move(-1);
  } else if (keyCode == RIGHT) {
    game.move(1);
  } 
} 