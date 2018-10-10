import processing.sound.*;

SoundFile file1;
SoundFile file2;
SoundFile file3;
String name = "ding.wav";
String name2 = "tap.mp3";
String name3 = "background.mp3";
ArrayList<Obstacle> obstacles;
PVector point;
Ball ball;
float spacing = 250;
color[] colorSet = {
  color(153, 0, 204), 
  color(255, 255, 0), 
  color(0, 255, 255), 
  color(255, 0, 102)
};


Obstacle addObstacle(float x, float y, float speed) {
  return new Obstacle(new PVector(x, y), 70, speed);
} 

void setup() {
  size(300, 800);
  obstacles = new ArrayList<Obstacle>();
  String path = sketchPath(name);
  String path2 = sketchPath(name2);
  String path3 = sketchPath(name3);
  file1 = new SoundFile(this, path);
  file2 = new SoundFile(this, path2);
  file3 = new SoundFile(this, path3);

  //obstacles.add(addObstacle());

  //obstacles.add(addObstacle(width / 2, height / 2));
  //obstacles.add(addObstacle(width / 2, height / 2 - height / 2));
  addObstacles();

  int index = floor(random(0, colorSet.length));
  ball = new Ball(width / 2, height - 50, colorSet[index], 20);
  point = new PVector(0, 0);
  file3.play();
} 

void addObstacles() {
  float tempY = 50;
  for (int i = 0; i < 3; i++) {
    float bX = width / 2;
    float bY = tempY;
    obstacles.add(addObstacle(bX, bY, random(0.01, 0.05)));
    tempY += 250;
  }
} 

void draw() {
  background(255);
  if (frameCount % (78 * 60) == 0) {
    //println("asdad");
    file3.stop();
    file3.play();
  } 
  point.set(mouseX, mouseY);
  for (Obstacle obstacle : obstacles) {
    obstacle.show();
    obstacle.update();
  }

  obstacles.get(obstacles.size() - 1).Rotate();
  ball.show();
  ball.update();
  for (Obstacle obstacle : obstacles) {
    obstacle.center.y += 0.1;
  } 
  color result = obstacles.get(obstacles.size() - 1).checkCollision(new PVector(ball.x, ball.y));
  if (result != color(0)) {
    if (result != ball.col) {
      restart();
    }
  }
  if (ball.surpassed(obstacles.get(obstacles.size() - 1))) {
    obstacles.remove(obstacles.size() - 1);
    int index = floor(random(0, colorSet.length));
    ball.col = colorSet[index];
    if (obstacles.size() <= 0) {
      ball.y = height - 100;
      addObstacles();
    }
    ball.score++;

    file1.play();
  } 
  fill(51, 51, 204);
  textSize(40);
  text(ball.score, width - 50, 100);
  //stroke(obstacle.checkCollision(point));
  //strokeWeight(10);
  //point(point.x, point.y);
} 

void restart() {
  obstacles.clear();
  int index = floor(random(0, colorSet.length));
  ball = new Ball(width / 2, height - 50, colorSet[index], 20);
  addObstacles();
} 



void mousePressed() {
  ball.jump();
  file2.play();
} 
