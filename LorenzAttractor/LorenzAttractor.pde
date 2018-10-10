float x = 0.01;
float y = 0;
float z = 0;

float a = 10;
float b = 28;
float c = 8.0 / 3.0;
float angle = 0;

ArrayList<PVector> points;

void setup() {
  size(700, 700, P3D);
  points = new ArrayList<PVector>();
  colorMode(HSB);
} 

void draw() {
  background(0);
  float dt = 0.01;
  
  float dx = (a * (y - x))*dt;
  float dy = (x * (b - z) - y)*dt;
  float dz = (x * y - c * z)*dt;
  x = x + dx;
  y = y + dy;
  z = z + dz;
  
  
  points.add(new PVector(x, y, z));
  
  translate(width / 2, height / 2);
  rotateY(angle);
  scale(4);
  
  noFill();
  //strokeWeight(10);
  float hu = 0;
  beginShape();
  for (PVector vec : points) {
    stroke(hu, 255, 255);
    vertex(vec.x, vec.y, vec.z);
    hu += 0.1;
    if (hu > 255) {
      hu = 0;
    } 
  }
  endShape();
  angle += 0.01;
} 