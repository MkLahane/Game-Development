class Triangle {
  PVector a;
  PVector b;
  PVector c;
  PVector normal;

  Triangle(PVector _a, PVector _c, PVector _b) {
    a = _a;
    b = _b;
    c = _c;
    normal = PVector.sub(b, a).cross(PVector.sub(c, a)).normalize();
  } 
  void show() {
    stroke(255, 0, 0);
    strokeWeight(4);
    //beginShape();
    //vertex(getX(a.x), getY(a.y));
    //vertex(getX(b.x), getY(b.y));
    //vertex(getX(c.x), getY(c.y));
    //endShape(CLOSE);

    line(getX(a.x), getY(a.y), getX(b.x), getY(b.y));
    line(getX(a.x), getY(a.y), getX(c.x), getY(c.y));
    line(getX(b.x), getY(b.y), getX(c.x), getY(c.y));
    //strokeWeight(12);
    //stroke(255, 0, 0);
    //point(getX(a.x), getY(a.y));
    //stroke(0, 255, 0);
    //point(getX(b.x), getY(b.y));
    //stroke(0, 0, 255);
    //point(getX(c.x), getY(c.y));
  } 
  float getArea(PVector A, PVector B, PVector C) {
    PVector area = PVector.sub(B, A).cross(PVector.sub(C, A));
    return area.dot(normal);
  } 
  boolean checkCollision(PVector p) {
    float u = getArea(p, b, c) / getArea(a, b, c);
    float v = getArea(a, p, c) / getArea(a, b, c);
    float w = getArea(a, b, p) / getArea(a, b, c);
    //println(u+","+v+","+w);
    return (u >= 0 && v >=0 && w >= 0 && u <=1 && w <= 1 && v <= 1);
  }
} 