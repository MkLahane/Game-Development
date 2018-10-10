class Obstacle {
  PVector center;
  float r;
  float rotation;
  ArrayList<Vertex> circle;
  float speed;
  Obstacle(PVector _center, float _r, float _speed) {
    center = _center.get();
    r = _r;
    rotation = 0;
    circle = new ArrayList<Vertex>();
    for (float a = 0; a < TWO_PI; a += 0.05) {
      float x = cos(rotation + a) * r + center.x;
      float y = sin(rotation + a) * r + center.y;
      color c = getTheColor(a);
      circle.add(new Vertex(new PVector(x, y), c, a));
    } 
    speed = _speed;
  } 
  void show() {
    for (Vertex vertex : circle) {
      vertex.show();
    } 
  } 
  void update() {
    for (Vertex vertex : circle) {
      float newX = cos(rotation + vertex.angle) * r + center.x;
      float newY = sin(rotation + vertex.angle) * r + center.y;
      vertex.pos.set(newX, newY);
    } 
  } 
  void Rotate() {
    rotation += speed;
  } 
  color checkCollision(PVector p) {
    for (Vertex vertex : circle) {
      float d = PVector.dist(p, vertex.pos);
      if (d <= 5 + vertex.r / 2) {
        return vertex.col;
      } 
    } 
    return color(0);
  } 
} 

color getTheColor(float angle) {
  if (angle > 0 && angle < PI / 2) {
    return colorSet[0];
  } else if (angle > PI / 2 && angle < PI) {
    return colorSet[1];
  } else if (angle > PI && angle < 3 * (PI / 2)) {
    return colorSet[2];
  } else {
    return colorSet[3];
  } 
  
} 

class Vertex {
  PVector pos;
  color col;
  float angle;
  float r = 10;
  Vertex(PVector _pos, color _col, float _angle) {
    pos = _pos.get();
    col = _col;
    angle = _angle;
  } 
  void show() {
    fill(col);
    noStroke();
    ellipse(pos.x, pos.y, r, r * 2);
  } 
 
} 
