import processing.sound.*;
Ball ball;
Obstacle obstacle;
SoundFile file1;
SoundFile file2;
SoundFile file3;
String name = "ding.wav";
String name2 = "tap.mp3";
String name3 = "background.mp3";
color[] colorSet = {
  color(153, 0, 204), 
  color(255, 255, 0), 
  color(0, 255, 255), 
  color(255, 0, 102), 
  color(51, 204, 51), 
  color(0, 0, 255)
};

color getRandomColor() {
  int index = floor(random(0, colorSet.length));
  return colorSet[index];
} 
void setup() {
  size(400, 700);
  String path = sketchPath(name);
  String path2 = sketchPath(name2);
  String path3 = sketchPath(name3);
  file1 = new SoundFile(this, path);
  file2 = new SoundFile(this, path2);
  file3 = new SoundFile(this, path3);
  ball = new Ball(new PVector(width / 2, height - 54), getRandomColor());
  obstacle = new Obstacle(new PVector(width / 2, -100), int(random(3, colorSet.length)), 100);
  file3.play();
} 

void draw() {
  background(0);
  obstacle.show();
  obstacle.collision(ball);
  obstacle.update();
  ball.show();
  ball.update();
  if (ball.pos.y <= height - 50) {
    ball.applyForce(new PVector(0, 0.1));
  } 
  if (obstacle.pos.y - obstacle.r >= ball.pos.y) {
    obstacle = new Obstacle(new PVector(width / 2, -100), int(random(3, colorSet.length)), 100);
    ball.col = getRandomColor();
  } 
  obstacle.pos.y += 1;
} 

void keyPressed() {
  if (key == ' ') {
    ball.vel.mult(0);
    file2.play();
    ball.applyForce(new PVector(0, -4)); 
  }
 } 
