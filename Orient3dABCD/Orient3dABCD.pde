PVector a;
PVector b;
PVector c;
void setup() {
  size(700, 700, P3D);

  a=new PVector(-20, 0, 0);
  b=new PVector(20, 0, 0);
  c=new PVector(0, 5, -20);
}

String  checkOrient(PVector d) {
  Matrix m1=new Matrix(4, 4);
  for (int i=0; i<m1.rows; i++) {
    m1.matrix[i][3]=1;
  } 
  m1.matrix[0][0]=a.x;
  m1.matrix[0][1]=a.y;
  m1.matrix[0][2]=a.z;

  m1.matrix[1][0]=b.x;
  m1.matrix[1][1]=b.y;
  m1.matrix[1][2]=b.z;

  m1.matrix[2][0]=c.x;
  m1.matrix[2][1]=c.y;
  m1.matrix[2][2]=c.z;

  m1.matrix[3][0]=d.x;
  m1.matrix[3][1]=d.y;
  m1.matrix[3][2]=d.z;

  float det=m1.Determinant(m1);
  if (det>0) {
    return "down";
  } else if (det<0) {
    return "up";
  } else {
   return "coplanar";
  }
} 
float getX(float x) {
  return map(x,-100,100,0,width);
} 
float getY(float y) {
  return map(y,-100,100,height,0);
} 
float getZ(float z) {
  return map(z,-100,100,0,height);
} 
void draw() {
  background(0);
  stroke(255);
  strokeWeight(6);
  line(getX(a.x), getY(a.y), getZ(a.z), getX(b.x), getY(b.y), getZ(b.z));
  line(getX(a.x), getY(a.y), getZ(a.z), getX(c.x), getY(c.y), getZ(c.z));
  line(getX(b.x), getY(b.y), getZ(b.z), getX(c.x), getY(c.y), getZ(c.z));

  //String str=checkOrient(new PVector(map(mouseX,0,width,-100,100),map(mouseY,0,height,100,-100),2.5));
  fill(0, 255, 0);
  textSize(40);
  String str=checkOrient(new PVector(0,0,-2.5));
  println(str);
  //point(mouseX,mouseY,getZ(2.5));
  //text(str, mouseX, mouseY);
} 