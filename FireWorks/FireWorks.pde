import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

ArrayList<Rocket> rockets=new ArrayList<Rocket>();
ArrayList<Rocket> particles=new ArrayList<Rocket>();
PeasyCam cam;
void setup() {
  size(700,700,P3D);
  rockets=new ArrayList<Rocket>();
  stroke(255);
  strokeWeight(6);
  background(0);
  //cam=new PeasyCam(this,200);
}


void draw() {
  background(0,25);
  if(random(1)<0.1) {
    rockets.add(new Rocket(new PVector(random(width),height,random(50,600)),"rocket"));
  } 
  for(int i=rockets.size()-1;i>=0;i--) {
    rockets.get(i).show();
    rockets.get(i).update();
    rockets.get(i).applyForce(new PVector(0,0.1));
    if(rockets.get(i).vel.y>=1) {
      rockets.remove(i);
      explode(rockets.get(i).loc);
      
    } 
  } 
  
  for(int i=particles.size()-1;i>=0;i--) {
    particles.get(i).show();
    particles.get(i).update();
    
    if(particles.get(i).lifespan<0) {
     particles.remove(i); 
    } 
    
  }
  println(particles.size());
  
} 

void explode(PVector loc) {
  for(int i=0;i<40;i++) {
    particles.add(new Rocket(loc,"particle"));
    
  } 
  
} 

 