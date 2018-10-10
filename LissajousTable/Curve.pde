class Curve {
  ArrayList<PVector> points;
  Curve() {
    points = new ArrayList<PVector>();
  } 
  void addPoint(float x, float y) {
    //if (points.size() < 2000) {
      points.add(new PVector(x, y));
    //}
  } 
  void show() {
    noFill();
    beginShape();
    for (PVector p : points) {
      stroke(map(p.x, 0, width, 0, 255), 0, 200);
      strokeWeight(2);
      vertex(p.x, p.y);
    } 
    endShape();
    stroke(255, 0, 0);
    strokeWeight(spacing * 0.09);
    point(points.get(points.size() - 1).x, points.get(points.size() - 1).y);
  }
} 
