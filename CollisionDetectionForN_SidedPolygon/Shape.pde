class Shape {
  int numOfVertices;
  PVector[] vertices;
  PVector pos;
  float r = 20;
  float[] offsets;
  ArrayList<Triangle> triangles;
  boolean colliding = false;
  Shape(int _numOfVertices) {
    numOfVertices = _numOfVertices;
    pos = new PVector(random(-100, 100), random(-100, 100));
    vertices = new PVector[numOfVertices];
    offsets = new float[numOfVertices];
    for (int i = 0; i < offsets.length; i++) {
      offsets[i] = random(-r, r);
    } 
    for (int i = 0; i < vertices.length; i++) {
      float angle = map(i, 0, vertices.length, 0, TWO_PI);
      float x = cos(angle) * r + pos.x + offsets[i];
      float y = sin(angle) * r + pos.y + offsets[i];
      vertices[i] = new PVector(x, y);
    } 
    triangles = new ArrayList<Triangle>();
    for (int i = 0; i < vertices.length; i++) {
      PVector a = pos;
      PVector b = vertices[(i + (vertices.length)) % vertices.length];
      PVector c = vertices[(i + 1) % vertices.length];
      Triangle triangle = new Triangle(a, b, c);
      triangles.add(triangle);
    }
  } 
  boolean update(PVector p) {
    for (Triangle triangle : triangles) {
      if (triangle.checkCollision(p)) {
        //println("asdasd");
        return true;
      } 
    }
    return false;
  } 

  void show() {
    if (colliding) {
      stroke(0, 0, 255);
    } else {
      stroke(0);
    } 
    noFill();
    strokeWeight(4);
    int counter = 0;
    beginShape();
    for (PVector vertex : vertices) {
      //fill(0);
      //text("Vertex:"+counter, getX(vertex.x), getY(vertex.y));
      //noFill();
      vertex(getX(vertex.x), getY(vertex.y));
      counter++;
    } 
    endShape(CLOSE);
  }
} 