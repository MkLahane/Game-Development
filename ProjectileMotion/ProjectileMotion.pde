Game game;
void setup() {
  size(1400,700);
  game=new Game();
  
} 

void draw() {
  background(0);
  game.runGame();
  
} 

void keyPressed() {
  game.Shoot();
} 
void mouseDragged() {
  game.SetAngle();
} 