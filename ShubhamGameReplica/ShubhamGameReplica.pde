Player player;
ArrayList<Obstacle> obstacles; 
ArrayList<BulletsPack> bulletpacks;
void setup() {
  size(900, 700);
  player = new Player(width / 2, height - 50, 50);
  obstacles = new ArrayList<Obstacle>();
  bulletpacks = new ArrayList<BulletsPack>();
} 

void draw() {
  background(255);
  if (frameCount % 240 == 0) {
    bulletpacks.add(new BulletsPack());
  } 
  if (frameCount % 60 == 0) {
    obstacles.add(new Obstacle());
  } 
  player.show();
  player.update();
  player.x = mouseX;
  for (Obstacle obstacle : obstacles) {
    obstacle.show();
    obstacle.update();
    obstacle.applyForce(new PVector(0, 0.2));
  } 
  for (BulletsPack bpack : bulletpacks) {
    bpack.show();
    bpack.update();
    bpack.applyForce(new PVector(0, 0.2));
  } 
  //collision with player 
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    float d = PVector.dist(obstacles.get(i).pos, new PVector(player.x, player.y));
    if (d <= obstacles.get(i).r + player.r) {
      obstacles.remove(i);  
      println("Game over!!!!!!!!");
      noLoop();
      break;
    }
  }
  
  //collision with player 
  for (int i = bulletpacks.size() - 1; i >= 0; i--) {
    float d = PVector.dist(bulletpacks.get(i).pos, new PVector(player.x, player.y));
    if (d <= bulletpacks.get(i).r + player.r) {
      player.bulletsLeft += bulletpacks.get(i).bulletAmount;
      bulletpacks.remove(i);
    }
  }
  
  //collision with bullets 
  for (int i = obstacles.size() - 1; i >= 0; i--) {
    obstacles.get(i).checkCollision(player);
  } 
  
} 


void mousePressed() {
  //if (key == ' ') {
    player.shoot();
  //}
} 
