Particle[] particles;
Fluid fluid;

void setup() {
  size(700,700);
  particles=new Particle[2];
  //for(int i=0;i<particles.length;i++) {
  //  particles[i]=new Particle(new PVector(random(width),200),random(1,5));
  //} 
  particles[0]=new Particle(new PVector(150,200),5);
  particles[1]=new Particle(new PVector(450,200),1);
  fluid=new Fluid(0,350,width,width-350,0.05);
  
} 

void draw() {
  background(255);
  fluid.display();
  for(Particle particle:particles) {
    particle.show();
    particle.update();
    particle.checkEdges();
    PVector wind = new PVector(0.01, 0);
    PVector gravity=new PVector(0,0.1*particle.mass);
    //float frictionalCoeff=0.04;
    //PVector friction=particle.vel.get();
    //friction.mult(-1);
    //friction.normalize();
    //friction.mult(frictionalCoeff);
    ////particle.applyForce(friction);
    PVector damping=fluid.calculateDrag(particle);
    if(damping!=null) {
      particle.applyForce(damping);
    } 
    particle.applyForce(gravity);
    //particle.applyForce(wind);
  } 
} 