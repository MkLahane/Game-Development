//3 ways of representing planes:-

//Three points not on a straight line (forming a triangle on the plane)
// A normal and a point on the plane
// A normal and a distance from the origin
PVector A;
PVector B;
PVector C;
void setup() {
  //1st
  A = new PVector(0, 1);
  B = new PVector(-1, 0);
  C = new PVector(1, 0);
  //normal Of triangle
  PVector normalOfPlane = PVector.sub(B, A).cross(PVector.sub(C, A));
  println(normalOfPlane);
  //2nd 
  PVector givenNormal = new PVector(0, 0, 1);
  PVector pointOnPlane = new PVector(0, 5);
  PVector arbitaryPoint = new PVector(1, 5);
  //point on plane if and only if (pointOnPlane - arbitaryPoint).dot(normal) = 0 
  float dotProductValue = PVector.sub(pointOnPlane, arbitaryPoint).dot(givenNormal);
  println(dotProductValue);
  //n . (X - P) = 0 --> n.X = d
  //where d = n · P, which is the constant-normal form of the plane. 
  //When n is unit, |d| equals the distance of the plane from the origin.
  //If n is not unit, |d| is still the distance, but now in units of the length of n. 
  println(givenNormal.dot(arbitaryPoint));
  println(pointOnPlane.mag());
} 