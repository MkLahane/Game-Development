class Particle {
  PVector vel;
  PVector pos;
  PVector acc;
  float mass; 
  float r;
  Particle(PVector _pos, float _mass) {
    mass = _mass;
    pos = _pos.get();
    //vel = new PVector(0, 0);
    vel = PVector.random2D().mult(random(3, 6));
    acc = new PVector(0, 0);
    r = mass * 10;
  } 
  void show(color col) {
    fill(col);
    ellipse(pos.x, pos.y, r * 2, r * 2);
  } 
  void update() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  } 

  void checkCollision(Particle other) {
    float d = PVector.dist(other.pos, pos);
    if (d >= other.r + r) {
      return;
    } 
    float massThisValue = 2 * other.mass / (mass + other.mass);
    float massOtherValue = 2 * mass / (mass + other.mass);

    PVector otherToThis = PVector.sub(this.pos, other.pos);
    otherToThis.normalize();
    PVector thisToOther = otherToThis.get().mult(-1);

    PVector velThisDiff = PVector.sub(this.vel, other.vel);

    PVector velOtherDiff = PVector.sub(other.vel, this.vel);

    vel = vel.get().sub(otherToThis.mult(otherToThis.dot(velThisDiff)).mult(massThisValue));
    
    other.vel = other.vel.get().sub(thisToOther.mult(thisToOther.dot(velOtherDiff)).mult(massOtherValue));
  }
  void checkCollision(ArrayList<Particle> others) {
    for (Particle other : others) {
      float d = PVector.dist(other.pos, pos);
      if (other == this || d >= other.r + r) {
        continue;
      } 
      float massThisValue = 2 * other.mass / (mass + other.mass);
      float massOtherValue = 2 * mass / (mass + other.mass);

      PVector otherToThis = PVector.sub(this.pos, other.pos);
      otherToThis.normalize();
      PVector thisToOther = otherToThis.get().mult(-1);

      PVector velThisDiff = PVector.sub(this.vel, other.vel);

      PVector velOtherDiff = PVector.sub(other.vel, this.vel);

      vel = vel.get().sub(otherToThis.mult(otherToThis.dot(velThisDiff)).mult(massThisValue));
    }
  } 
  void checkEdges() {
    if (pos.x <= r) {
      vel.x *= -1;
      pos.x = r;
    } 
    if (pos.x >= width - r) {
      vel.x *= -1;
      pos.x = width - r;
    } 
    if (pos.y <= r) {
      vel.y *= -1;
      pos.y = r;
    } 
    if (pos.y >= height - r) {
      pos.y = height - r;
      vel.y *= -1;
    }
  }
} 
