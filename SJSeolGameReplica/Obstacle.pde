class Obstacle {
  PVector center;
  float r;
  PVector[] vertices;
  float angle;
  boolean active;
  boolean collided = false;
  Obstacle(PVector _center, float _r, float _angle) {
    center = _center.get();
    r = _r;
    active = false;
    angle = _angle;
    vertices = new PVector[3];
    generateVertices();
  } 
  void generateVertices() {
    for (int i = 0; i < vertices.length; i++) {
      float a = map(i, 0, vertices.length, 0, TWO_PI);
      float x = cos(angle + a) * r + center.x;
      float y = sin(angle + a) * r + center.y;
      vertices[i] = new PVector(x, y);
    }
  } 
  void show() {
    stroke(0);
    //if (collided) {
    //  noFill();
    //} 
    fill(150);
    strokeWeight(4);
    beginShape();
    for (int i = 0; i < vertices.length; i++) {
      vertex(vertices[i].x, vertices[i].y);
    } 
    endShape(CLOSE);
  } 
  void update() {
    generateVertices();
  } 
  boolean checkCollision(Ball ball) {
    for (PVector v : vertices) {
      float d = PVector.dist(v, ball.pos);
      if (d <= ball.r) {
        return true;
      }
    } 
    for (int i = 0; i < vertices.length - 1; i++) {
      int ai = i;
      int bi = (i + 1) % vertices.length;
      PVector a = vertices[ai];
      PVector b = vertices[bi];
      if (lineToCircleCollision(a, b, ball)) {
        return true;
      } 
    }
    return false;
  }
  boolean  lineToCircleCollision(PVector a, PVector b, Ball ball) {
    PVector aToBall = PVector.sub(ball.pos, a);
    PVector aToB = PVector.sub(b, a);
    float originalMag = aToB.mag();
    aToB.normalize();
    float dotP = aToB.dot(aToBall);
    aToB.mult(dotP);

    PVector normal = PVector.sub(aToBall, aToB);
    
    return (normal.mag() <= ball.r && aToB.mag() <= originalMag && dotP >= 0);
  }
} 
