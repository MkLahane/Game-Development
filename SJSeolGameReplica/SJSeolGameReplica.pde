import processing.sound.*;
SoundFile pointSound;
SoundFile tapSound;
Ball ball;
Obstacle[] obstacles;
Point point;
int numOfTriangles;
int playerScore = 0;
float triangleR;
String pointSoundName = "Ding.wav";
String tapSoundName = "Tap.mp3";
void setup() {
  size(500, 750); 
  String pointSoundPath = sketchPath(pointSoundName);
  String tapSoundPath = sketchPath(tapSoundName);
  tapSound = new SoundFile(this, tapSoundPath);
  pointSound = new SoundFile(this, pointSoundPath);
  triangleR = 40;
  point = new Point(new PVector(random(triangleR + 20, width - triangleR - 20), -500));
  numOfTriangles = floor(height / triangleR);
  obstacles = new Obstacle[numOfTriangles * 2];
  for (int i = 0; i < numOfTriangles; i++) {
    obstacles[i] = new Obstacle(new PVector(triangleR / 2, triangleR * (i + 1)), triangleR, 0);
  } 
  for (int i = numOfTriangles; i < obstacles.length; i++) {
    obstacles[i] = new Obstacle(new PVector(width - triangleR / 2, triangleR * ((i - numOfTriangles) + 1)), triangleR, PI);
  } 
  ball = new Ball(new PVector(width / 2, height / 2 - 200), 20);

  for (int i = 0; i < obstacles.length; i++) {
    float d = abs(obstacles[i].center.y - ball.pos.y);
    if (d <= 100) {
      for (int j = i; j < i + 5; j++) {
        obstacles[(j + 1) % obstacles.length].active = false;
        //if (random(1) < 0.1) {
        //  obstacles[(j + 1) % obstacles.length].active = true;
        //}
      }
    } else {
      obstacles[i].active = true;
    }
  } 
  //obstacles[0] = new Obstacle(new PVector(triangleR / 2, triangleR), 50, 0);
  //obstacles[1] = new Obstacle(new PVector(triangleR / 2, triangleR * 2 + triangleR * 2), 50, 0);
  //obstacles[2] = new Obstacle(new PVector(triangleR / 2, triangleR * 3 + triangleR * 3), 50, 0);
} 

void draw() {
  background(255);

  point.show();
  point.update();
  point.applyForce(new PVector(0, 0.01));
  ball.show();
  ball.update();
  float ballPointD = PVector.dist(ball.pos, point.pos);
  if (ballPointD <= ball.r + point.r) {
    pointSound.stop();
    pointSound.play();
    point = new Point(new PVector(random(triangleR + 20, width - triangleR - 20), -300));
    playerScore++;
  } 
  String edgeResult = ball.edges();
  if (edgeResult == "left") {
    tapSound.stop();
    tapSound.play();
    //spawnRight();
    for (int i = numOfTriangles; i < obstacles.length; i++) {
      if (random(1) < 0.2) {
        float d = abs(obstacles[i].center.y - ball.pos.y);
        if (d <= 100) {
          if (random(1) < 0.5) {
            obstacles[i].active = false;
            continue;
          }
        } 
        obstacles[i].active = !obstacles[i].active;
      }
    }
  } else if (edgeResult == "right") {
    tapSound.stop();
    tapSound.play();
    //spawnLeft();
    for (int i = 0; i < numOfTriangles; i++) {
      if (random(1) < 0.2) {
        float d = abs(obstacles[i].center.y - ball.pos.y);
        if (d <= 100) {
          if (random(1) < 0.5) {
            obstacles[i].active = false;
            continue;
          }
        } 
        obstacles[i].active = !obstacles[i].active;
      }
    }
  } 
  //apply gravity 
  ball.applyForce(new PVector(0, 0.1));
  for (Obstacle obstacle : obstacles) {
    if (!obstacle.active) {
      continue;
    } 
    obstacle.show();
    obstacle.update();
    if (obstacle.checkCollision(ball)) {
      noLoop();
    }
  }
  if (frameCount % 240 == 0 && point.pos.y > height) {
    point = new Point(new PVector(random(triangleR + 20, width - triangleR - 20), -300));
  } 
  fill(0);
  textSize(40);
  textMode(CENTER);
  text("Score:"+playerScore, width - 300, 50);
} 
void spawnLeft() {
  for (int i = 0; i < numOfTriangles; i++) {
    float d = abs(ball.pos.y - obstacles[i].center.y);
    if (d <= 100 && obstacles[i].center.y <= height - 200) {
      for (int j = i; j < i + 5; j++) {
        obstacles[(j + 1) % numOfTriangles].active = false;
        if (random(1) < 0.04) {
          obstacles[numOfTriangles + (j + 1) % numOfTriangles].active = true;
        }
      }
    } else {
      for (int j = i; j < i + 5; j++) {
        obstacles[(j + 1) % numOfTriangles].active = true;
        if (random(1) < 0.09) {
          obstacles[(j + 1) % numOfTriangles].active = false;
        }
      }
    }
  }
} 

void spawnRight() {
  for (int i = numOfTriangles; i < obstacles.length; i++) {
    float d = abs(ball.pos.y - obstacles[i].center.y);
    if (d <= 100) {
      for (int j = i; j < i + 5; j++) {
        obstacles[numOfTriangles + (j + 1) % numOfTriangles].active = false;
        if (random(1) < 0.04) {
          obstacles[numOfTriangles + (j + 1) % numOfTriangles].active = true;
        }
      }
    } else {
      for (int j = i; j < i + 5; j++) {
        obstacles[numOfTriangles + (j + 1) % numOfTriangles].active = true;
        if (random(1) < 0.09) {
          obstacles[numOfTriangles + (j + 1) % numOfTriangles].active = false;
        }
      }
    }
  }
} 
void mousePressed() {
  tapSound.stop();
  tapSound.play();
  float velAngle = ball.vel.heading();
  float velAngleDiff = PI / 2 - velAngle;
  float newVelAngle = PI / 2 + velAngleDiff;
  //ball.applyForce(new PVector(velx, -15));
  //ball.vel.set(0, -10);
  ball.applyForce(new PVector(ball.vel.x * 2, -10).mult(2));

  //ball.applyForce(PVector.fromAngle(newVelAngle).mult(-4));
} 
