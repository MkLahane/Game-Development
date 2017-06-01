class System {
  ArrayList<Particle> particles;
  System(PVector l) {
    particles=new ArrayList<Particle>();
    for(int i=0;i<0;i++) {
      particles.add(new Particle(l));
      
    } 
    
  } 
  void addParticle() {
    Particle p=new Particle(new PVector(random(100,width-200),100));
    particles.add(p);
    if(mousePressed) {
      for(int i=0;i<5;i++) {
        Particle ps=new Particle(new PVector(mouseX,mouseY));
        particles.add(ps);
        
      } 
      
    } 
  } 
  void run() {
    for(int i=particles.size()-1;i>=0;i--) {
      Particle p=particles.get(i);
      p.show();
      p.update();
      if(p.lifespan<0) {
        particles.remove(p);
      } 
    } 
    
  } 
} 