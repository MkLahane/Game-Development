//Barycentric co - ordinates for triangle 
//In general, a point with barycentric coordinates (u, v, w) is inside (or on) the triangle 
//if and only if 0 ≤ u, v, w ≤ 1, or alternatively if and only if 0 ≤ v ≤ 1, 0 ≤ w ≤ 1, 
//and v + w ≤ 1

boolean colliding = false;
Particle[] particles;
void setup() {
  particles = new Particle[20];
  //Barycentric(a, b, c, p);
  size(700, 700);
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(new PVector(random(width), random(height)));
  }
} 

void draw() {
  background(0);
  PVector a = new PVector(0, 3);
  PVector b = new PVector(-3, 0);
  PVector c = new PVector(3, 0);

  if (colliding) {
    stroke(0, 255, 0);
  } else {
    stroke(255);
  }
  //stroke(0, 255, 0);
  strokeWeight(4);

  line(getX(a.x), getY(a.y), getX(b.x), getY(b.y));
  line(getX(a.x), getY(a.y), getX(c.x), getY(c.y));
  line(getX(b.x), getY(b.y), getX(c.x), getY(c.y));

  //PVector p = new PVector(mouseX, mouseY);
  //stroke(255, 0, 0);
  //strokeWeight(12);
  //point(p.x, p.y);

  for (Particle particle : particles) {
    particle.show();
    particle.edge();
    particle.update();
    PVector p = particle.pos;
    float x = map(p.x, 0, width, -5, 5);
    float y = map(p.y, height, 0, -5, 5);
    particle.inZone = Barycentric(a, b, c, new PVector(x, y));
  }
  boolean tempColliding = false;
  for (Particle particle : particles) {
    if(particle.inZone) {
      tempColliding = true;
      break;
    } 
  } 
  colliding = tempColliding;
} 

float getX(float x) {
  return map(x, -5, 5, 0, width);
} 
float getY(float y) {
  return map(y, -5, 5, height, 0);
} 

boolean Barycentric(PVector a, PVector b, PVector c, PVector p) {
  PVector v0 = PVector.sub(b, a);
  PVector v1 = PVector.sub(c, a);
  PVector v2 = PVector.sub(p, a);
  float d00 = v0.dot(v0);
  float d01 = v0.dot(v1);
  float d11 = v1.dot(v1);
  float d20 = v2.dot(v0);
  float d21 = v2.dot(v1);
  float denom = d00 * d11 - d01 * d01;
  float v = (d11 * d20 - d01 * d21) / denom;
  float w = (d00 * d21 - d01 * d20) / denom;
  float u = 1 - v - w;

  boolean col = false;
  if (u >= 0 && u <= 1 && v >= 0 && v <= 1 && w >= 0 && w <= 1) {
    col = true;
  } 
  return col;
  //println("("+u+", "+v+", "+w+")");
} 