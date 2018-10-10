ArrayList<PVector> keyFrames;
boolean draging = false;
int dragingKeyFrameIndex = -1;
void setup() {
  size(700, 700);
  keyFrames = new ArrayList<PVector>();
  for (int i = 0; i < 4; i++) {
    keyFrames.add(new PVector(width / 2 - 200 + i * 150, height / 2));
  }
}

void draw() {
  background(255);
  if (dragingKeyFrameIndex >= 0) {
    keyFrames.get(dragingKeyFrameIndex).set(mouseX, mouseY);
  } 
  beginShape();
  stroke(0, 255, 0);
  strokeWeight(4);
  for (PVector point : interpolate()) {
    vertex(point.x, point.y);
  } 
  endShape();
  for (PVector keyFrame : keyFrames) {
    noStroke();
    fill(0);
    ellipse(keyFrame.x, keyFrame.y, 20, 20);
  }
  beginShape();
  for (PVector keyFrame : keyFrames) {
    noFill();
    stroke(0, 100);
    strokeWeight(2);
    vertex(keyFrame.x, keyFrame.y);
  } 
  endShape();
} 


ArrayList<PVector> interpolate() {
  ArrayList<PVector> interpolatedPoints = new ArrayList<PVector>();
  for (float t = 0; t <= 1; t += 0.01) {
    interpolatedPoints.add(interpolate(keyFrames, t));
  }
  return interpolatedPoints;
} 

PVector interpolate(ArrayList<PVector> vertices, float t) {
  if (vertices.size() <= 1) {
    return vertices.get(0);
  } 
  ArrayList<PVector> newVertices = new ArrayList<PVector>();
  for (int i = 0; i < vertices.size() - 1; i++) {
    newVertices.add(Lerp(vertices.get(i), vertices.get(i + 1), t));
  } 
  return interpolate(newVertices, t);
} 

void mouseReleased() {
  draging = false;
  dragingKeyFrameIndex = -1;
} 

void keyPressed() {
  if (key != ' ') {
    return;
  } 
  boolean addElement = false;
  int prevIndex = -1;
  int nextIndex = -1;
  for (int i = 0; i < keyFrames.size() - 1; i++) {
    if (onLine(keyFrames.get(i), keyFrames.get(i + 1), new PVector(mouseX, mouseY))) {
      addElement = true;
      prevIndex = i;
      nextIndex = i + 1;
    }
  } 
  PVector newKeyFrame = new PVector(mouseX, mouseY);
  if (addElement) {
    keyFrames.add(null);
    for (int i = keyFrames.size() - 1; i > nextIndex; i--) {
      keyFrames.set(i, keyFrames.get(i - 1));
    } 
    keyFrames.add(prevIndex + 1, newKeyFrame);
    return;
  } 
  float startD = PVector.dist(keyFrames.get(0), newKeyFrame);
  float endD = PVector.dist(keyFrames.get(keyFrames.size() - 1), newKeyFrame);
  if (endD <= startD) {
    keyFrames.add(newKeyFrame);
  } else {
    keyFrames.add(null);
    for (int i = keyFrames.size() - 1; i > 1; i--) {
      keyFrames.set(i, keyFrames.get(i - 1));
    } 
    keyFrames.add(0, newKeyFrame);
  } 
  
} 

boolean onLine(PVector start, PVector end, PVector p) {
  PVector startEnd = PVector.sub(end, start);
  PVector startP = PVector.sub(p, start);
  startEnd.normalize();
  startEnd.mult(startP.dot(startEnd));
  PVector perp = PVector.sub(startP, startEnd);
  if (perp.mag() <= 3) {
    return true;
  } else {
    return false;
  }
} 

void mousePressed() {
  draging = true;
  for (int i = 0; i < keyFrames.size(); i++) {
    float d = PVector.dist(keyFrames.get(i), new PVector(mouseX, mouseY));
    if (d < 20) {
      dragingKeyFrameIndex = i;
      break;
    }
  }
} 

PVector Lerp(PVector min, PVector max, float norm) {
  return PVector.sub(max, min).mult(norm).add(min);
} 

float Lerp(float min, float max, float norm) {
  return (max - min) * norm + min;
} 
