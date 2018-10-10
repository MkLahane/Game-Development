import peasy.*;

float rotation[][]={{0,-1,0},{1,0,0},{0,0,1}};
float c[][]=new float[3][3];

PeasyCam cam;
int resolution=20;
float mConst=0;
PVector sphere[][];
void setup() {
  size(700,700,P3D);
  cam=new PeasyCam(this,200);
  sphere=new PVector[resolution+1][resolution+1];
  colorMode(HSB);
} 

void draw() {
  background(0);
  lights();
  float r=200;
  for(int i=0;i<resolution+1;i++) {
    float lat=map(i,0,resolution,-HALF_PI,HALF_PI);
     float r2=superShape(lat,7,0.2,1.7,1.7);
    for(int j=0;j<resolution+1;j++) {
      float lon=map(j,0,resolution,-PI,PI);
      float r1=superShape(lat,7,0.2,1.7,1.7);
      float x=r*r1*cos(lon)*r2*cos(lat);
      float y=r*r1*sin(lon)*r2*cos(lat);
      float z=r*r2*sin(lat);
      sphere[i][j]=new PVector(x,y,z);
      //stroke(255);
      //strokeWeight(2);
      //point(x,y,z);
      
    }
    
    
  } 
  //for(int i=0;i<resolution;i++) {
  //  for(int j=0;j<resolution+1;j++) {
  //    float loc[][]={{sphere[i][j].x},{sphere[i][j].y},{sphere[i][j].z}};
  //    for(int k=0;k<3;k++) {
  //      for(int m=0;m<3;m++) {
  //        c[k][m]=0;
  //        for(int s=0;s<3;s++) {
  //          c[k][m]=c[k][m]+rotation[k][s]*loc[s][m];
            
  //        } 
          
  //      } 
        
  //    }
  //    loc=c;
  //    sphere[i][j].x=loc[0][0];
  //    sphere[i][j].y=loc[1][0];
  //    sphere[i][j].z=loc[2][0];
  //  } 
  //} 
  
   for(int i=0;i<resolution;i++) {
     beginShape(TRIANGLE_STRIP);
    for(int j=0;j<resolution+1;j++) {
      float hu=map(j,0,resolution,0,255*6);
      //fill(hu%255,255,255,255);
      PVector pos=sphere[i][j];
      stroke(255);
      //noStroke();
      strokeWeight(1);
      noFill();
      vertex(pos.x,pos.y,pos.z);
      PVector pos2=sphere[i+1][j];
      vertex(pos2.x,pos2.y,pos2.z);
    }
    endShape();
    
    
  } 
  
  
} 

float a=1,b=1;

float superShape(float angle,float m,float n1,float n2,float n3) {
  
  float t1=abs((1/a)*cos(m*angle/4));
  t1=pow(t1,n2);
  float t2=abs((1/b)*sin(m*angle/4));
  t2=pow(t2,n3);
  float t3=t1+t2;
  float r=pow(t3,-1/n1);
  return r;
  
} 