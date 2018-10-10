float r1=200;
float r2=200;
float m1=20;
float m2=20;
float g=1;
float angle1=PI/2;
float angle2=PI/2;

float angle1Vel=0;
float angle2Vel=0;

float px2=-1;
float py2=-1;

PGraphics tracing;

PVector center;
void setup() {
  fullScreen();
  center=new PVector(width/2,400);
  tracing=createGraphics(width, height);
  tracing.beginDraw();
  tracing.background(0);
  tracing.endDraw();
} 

void draw() {
  //background(255);
  //angle 1 acc
  float num1=-g*(2*m1+m2)*sin(angle1);
  float num2=-m2*g*sin(angle1-2*angle2);
  float num3=-2*sin(angle1-angle2)*m2;
  float num4=(angle2Vel*angle2Vel*r2+angle1Vel*angle1Vel*r1*cos(angle1-angle2));

  float den=r1*(2*m1+m2-m2*cos(2*angle1-2*angle2));

  float angle1Acc=(num1+num2+num3*num4)/den;

  //angle 2 Acc
  num1=2*sin(angle1-angle2);
  num2=angle1Vel*angle1Vel*r1*(m1+m2);
  num3=g*(m1+m2)*cos(angle1);
  num4=angle2Vel*angle2Vel*r2*m2*cos(angle1-angle2);

  den=r2*(2*m1+m2-m2*cos(2*angle1-2*angle2));
  float angle2Acc=(num1*(num2+num3+num4))/den;
  image(tracing, 0, 0);
  stroke(255);
  strokeWeight(2);
  translate(center.x, center.y);
  float x1=r1*sin(angle1);
  float y1=r1*cos(angle1);
  float x2=x1+r2*sin(angle2);
  float y2=y1+r2*cos(angle2);



  line(0, 0, x1, y1);
  fill(255);
  ellipse(x1, y1, m1, m1);
  line(x1, y1, x2, y2);
  ellipse(x2, y2, m2, m2);

  angle1Vel+=angle1Acc;
  angle2Vel+=angle2Acc;

  angle1+=angle1Vel;
  angle2+=angle2Vel;

  //angle1Vel*=0.99;
  //angle2Vel*=0.99;


  tracing.beginDraw();
  tracing.translate(center.x, center.y);
  tracing.colorMode(HSB);
  tracing.stroke(frameCount%360,255,255);
  tracing.strokeWeight(6);
  if (frameCount>1) {
    tracing.line(px2, py2, x2, y2);
  }
  tracing.endDraw();
  px2=x2;
  py2=y2;
} 