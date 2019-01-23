import java.util.*;
class Obstacle {
  int size;
  ArrayList<Vertex> vertices;
  float r;
  PVector pos;
  float rotation = 0;
  float rotationSpeed;
  Obstacle(PVector _pos, int _size, int _r) {
    rotationSpeed = random(0.02, 0.04);
    pos = _pos.get();
    r = _r;
    size = _size;
    vertices = new ArrayList<Vertex>();
    color[] colors = new color[100];
    int index = floor(random(0, vertices.size()));
    //if (random(1) < 0.5) {
    for (int i = 0; i < size; i++) {
      float a = map(i, 0, size, 0, TWO_PI);
      float x = pos.x + r * cos(a);
      float y = pos.y + r * sin(a);
      if (i == index) {
        vertices.add(new Vertex(new PVector(x, y), a, ball.col));
        colors[i] = ball.col;
      } else { 
        color tempCol = getRandomColor();
        while (contains(colors, tempCol, size)) {
          tempCol = getRandomColor();
        } 
        vertices.add(new Vertex(new PVector(x, y), a, tempCol));
        colors[i] = tempCol;
      }
    } 
    generateVertices();
  }  
  void generateVertices() {
    for (Vertex vertex : vertices) {
      float x = pos.x + r * cos(rotation + vertex.angle);
      float y = pos.y + r * sin(rotation + vertex.angle);
      vertex.pos.set(x, y);
    }
  } 
  void update() {
    rotation += rotationSpeed;
    generateVertices();
  } 
  void show() {
    for (Vertex vertex : vertices) {
      vertex.show();
    } 
    noFill();
    //stroke(255);
    strokeWeight(10);
    //beginShape();
    for (int i = 0; i < vertices.size(); i++) {
      stroke(vertices.get(i).col);
      int neighbor = (i + 1) % vertices.size();
      line(vertices.get(i).pos.x, vertices.get(i).pos.y, 
        vertices.get(neighbor).pos.x, vertices.get(neighbor).pos.y);
    } 
    //endShape(CLOSE);
  }
  boolean checkLineCollision(Ball ball, PVector a, PVector b) {
    PVector aTocenter = PVector.sub(ball.pos, a);
    PVector aToB = PVector.sub(b, a);
    float originalMag = aToB.mag();
    aToB.normalize();
    float dotP = aToB.dot(aTocenter);
    aToB.mult(dotP);
    PVector normal = PVector.sub(aTocenter, aToB);
    float aDist = PVector.dist(ball.pos, a);
    float bDist = PVector.dist(ball.pos, b);
    println(normal.mag());
    if (aDist <= ball.r || bDist <= ball.r) {
      return true;
    } 
    if (normal.mag() <= ball.r  && aToB.mag() <= originalMag && dotP >= 0) {
      return true;
    }
    return false;
  } 
  void collision(Ball ball) {
    for (int i = 0; i < vertices.size(); i++) {
      int neighbor = (i + 1) % vertices.size();
      if (checkLineCollision(ball, vertices.get(i).pos, vertices.get(neighbor).pos)) {
        if (vertices.get(i).col != ball.col) {
          noLoop();
          return;
        }
      }
    }
  }
} 

boolean contains(color[] colors, color tempCol, int size) {
  for (int i = 0; i < size; i++) {
    if (tempCol == colors[i]) {
      return true;
    }
  } 
  return false;
} 


class Vertex { 
  PVector pos;
  color col;
  float angle;
  float r = 10; 
  Vertex(PVector _pos, float _angle, color _col) {
    angle = _angle;
    pos = _pos.get();
    col = _col;
  } 
  void show() {
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, r * 2, r * 2);
  }
} 
 
