class Vector {
  float x;
  float y;
  float z;
  float w;

  Vector() {
  } 

  Vector(float _x, float _y, float _z, float _w) {
    x = _x;
    y = _y;
    z = _z;
    w = _w;
  } 
  Vector divide(float n) {
    x/=n;
    y/=n;
    z/=n;
    w/=n;
    return this;
  } 

  float magnitude() {
    float d=sqrt((x*x)+(y*y)+(z*z)+(w*w));
    float mag=d;
    return mag;
  } 

  Vector Normalize() {
    float m=magnitude();
    if (m!=0 && m!=1) {
      divide(m);
    }
    return this;
  }
  
} 

float Dist(Vector v1, Vector v2) {
  float dx = v1.x - v2.x;
  float dy = v1.y - v2.y;
  float dz = v1.z - v2.z;
  float dw = v1.w - v2.w;
  return sqrt(dx * dx + dy * dy + dz * dz + dw * dw);
} 
