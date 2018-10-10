
ArrayList<Armature> armatures=new ArrayList<Armature>();
Particle particle=new Particle(new PVector(0,0));
void setup() {
  size(800,800);
  //fullScreen();
  //armatures[0]=new Armature(3,width/2,height,100);
  float da=TWO_PI/2;
  for(float a=0;a<TWO_PI;a+=da) {
    float x=width/2+cos(a)*300;
    float y=height/2+sin(a)*300;
    armatures.add(new Armature(5,x,y,50));
  } 
} 

void draw() {
  background(0);
  for(Armature armature:armatures) {
    armature.show();
    armature.update();
  }
  particle.show();
  particle.update();
  particle.checkEdges();
 
} 